<?php

class freeliveryOverride extends freelivery
{

    public function getPackageShippingCost($cart, $id_carrier, $id_zone, $use_tax = true)
    {
        static $shipping_cost = array();

        // Check if module is activated and that we have an id carrier available
        if (!Module::isEnabled('freelivery') || !$id_carrier) {
            return false;
        }

        // Check if we have an id zone and gets one if not
        if (!$id_zone) {
            $id_zone = $this->getIdZone($cart);
            if (!$id_zone) {
                return false;
            }
        }

        $cache_key = (int)$cart->id.'-'.(int)$id_carrier.'-'.(int)$id_zone;

        // Check if static cache exists
        if (isset($shipping_cost[$cache_key])) {
            return $shipping_cost[$cache_key];
        }

        $shipping_cost[$cache_key] = false;
        $products = $cart->getProducts(false, false, null, false);
        $total_weight = $cart->getTotalWeight($products, $id_carrier);

        if (!count($products)) {
            return $shipping_cost[$cache_key];
        }

        $ids_products = array();
        foreach ($products as $product) {
            $ids_products[] = (int)$product['id_product'];
        }

        $dbquery = new DbQuery();
        $dbquery->select('id_category');
        $dbquery->from('category_product');
        $dbquery->where('id_product IN('.implode(',', array_map('intval', $ids_products)).')');
        $dbquery->groupBy('id_category');
        $cart_categories = Db::getInstance()
            ->ExecuteS($dbquery->build())
        ;

        $ids_cart_categories = array();
        foreach ($cart_categories as $cart_category) {
            $ids_cart_categories[] = (int)$cart_category['id_category'];
        }

        $dbquery = new DbQuery();
        $dbquery->select('f.*, GROUP_CONCAT(ec.id_category) AS excluded_categories');
        $dbquery->from(pSQL($this->table_name), 'f');
        $dbquery->leftJoin(pSQL($this->table_name_groups), 'fg', 'fg.id_condition = f.id');
        $dbquery->leftJoin(pSQL($this->table_name_excluded_categories), 'ec', 'ec.id_condition = f.id');
        $dbquery->where('f.id_zone = 0 OR f.id_zone = '.(int)$id_zone);
        $dbquery->where('f.id_carrier = 0 OR f.id_carrier = '.(int)$id_carrier);
        $dbquery->where('max_weight = 0 OR '.(float)$total_weight.' < max_weight');
        $dbquery->where('min_weight = 0 OR '.(float)$total_weight.' >= min_weight');
        $dbquery->where(
            '(NOW() BETWEEN date_start AND date_end) OR (date_start IS NULL AND date_end > NOW()) OR (date_end IS NULL AND date_start <= NOW()) OR (date_end IS NULL AND date_start IS NULL)'
        );

        $groups = $cart->id_customer ? Customer::getGroupsStatic($cart->id_customer) : array(1);
        if (!empty($groups)) {
            $dbquery->where('fg.id_group IN('.implode(',', array_map('intval', $groups)).') OR fg.id_group IS NULL');
        }

        $dbquery->groupBy('f.id');

        $conditions = Db::getInstance()
            ->ExecuteS($dbquery->build())
        ;

        if ($conditions) {
            $without_taxes = (int)Configuration::get('FREELIVERY_WITHOUT_TAXES');

            // Get Order total
            $order_total = $cart->getOrderTotal(!$without_taxes, Cart::ONLY_PRODUCTS);
            if ((int)Configuration::get('FREELIVERY_CALCULATION_RULE')) {
                $order_total -= $cart->getOrderTotal(!$without_taxes, Cart::ONLY_DISCOUNTS);
            }

            foreach ($conditions as $condition) {
                if (count(array_intersect(explode(',', $condition['excluded_categories']), $ids_cart_categories))) {
                    continue;
                }

                // Convert price with current currency
                $currency = Currency::getCurrencyInstance((int)($cart->id_currency));
                $max_price = Tools::convertPrice($condition['max_price'], $currency);
                $min_price = Tools::convertPrice($condition['min_price'], $currency);

                $is_free = true;
                if ($min_price > 0 && $order_total < $min_price) {
                    $is_free = false;
                }
                if ($max_price > 0 && $order_total >= $max_price) {
                    $is_free = false;
                }

                // Calculate if this order is eligible to free shipping with this carrier
                if ($is_free) {
                    $shipping_cost[$cache_key] = 0;
                    if ($condition['shipping_handling']) {
                        $shipping_cost[$cache_key] += Configuration::get('PS_SHIPPING_HANDLING');
                    }
                    if ((int)Configuration::get('FREELIVERY_ADDITIONAL_SHIPPING_COST')) {
                        foreach ($products as $product) {
                            $shipping_cost[$cache_key] += (float)$product['additional_shipping_cost'] *
                                $product['quantity'];
                        }
                    }
                    break; // We don't need to check the other rules
                }

                // Calculate remaining amount to get free shipping
                if ($min_price > 0) {
                    if (!isset($this->remaining['freelivery_remaining_'.$cache_key]) ||
                        $min_price - $order_total < $this->remaining['freelivery_remaining_'.$cache_key]) {
                        $this->remaining['freelivery_remaining_'.$cache_key] = $min_price - $order_total;
                        if (!isset($this->remaining['freelivery_remaining_default']) ||
                            $this->remaining['freelivery_remaining_'.$cache_key] <
                            $this->remaining['freelivery_remaining_default']) {
                            $this->remaining['freelivery_remaining_default'] =
                                $this->remaining['freelivery_remaining_'.$cache_key];
                        }
                    }
                }
            }
        }

        if ($shipping_cost[$cache_key]) {
            $address = Address::initialize($cart->id_address_delivery);
            $carrier = new Carrier($id_carrier);
            $carrier_tax = (float)$carrier->getTaxesRate($address);
            if ($use_tax && $carrier_tax) {
                $shipping_cost[$cache_key] *= 1 + ($carrier_tax / 100);
                $shipping_cost[$cache_key] = (float)Tools::ps_round(
                    (float)$shipping_cost[$cache_key],
                    (Currency::getCurrencyInstance((int)$cart->id_currency)->decimals * _PS_PRICE_DISPLAY_PRECISION_)
                );
            }
        }

        return $shipping_cost[$cache_key];
    }
}

