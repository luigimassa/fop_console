<?php

use PrestaShop\PrestaShop\Adapter\AddressFactory;
use PrestaShop\PrestaShop\Adapter\Cache\CacheAdapter;
use PrestaShop\PrestaShop\Adapter\Customer\CustomerDataProvider;
use PrestaShop\PrestaShop\Adapter\Database;
use PrestaShop\PrestaShop\Adapter\Group\GroupDataProvider;
use PrestaShop\PrestaShop\Adapter\Product\PriceCalculator;
use PrestaShop\PrestaShop\Adapter\ServiceLocator;
use PrestaShop\PrestaShop\Core\Cart\CartRow;
use PrestaShop\PrestaShop\Core\Cart\CartRuleData;

class Cart extends CartCore
{
    /*
    * module: bwconai
    * date: 2021-12-01 12:15:40
    * version: 1.0.0
    */
    public function newCalculator(
        $products,
        $cartRules,
        $id_carrier,
        $computePrecision = null,
        bool $keepOrderPrices = false
    ) {
        $orderId = null;
        if ($keepOrderPrices) {
            $orderId = Order::getIdByCartId($this->id);
            $orderId = (int)$orderId ?: null;
        }
        $context = Context::getContext();
        $calculator = $this->getCalculator($this, $id_carrier, $computePrecision, $orderId);
        $priceCalculator = ServiceLocator::get(PriceCalculator::class);
        $useEcotax = $this->configuration->get('PS_USE_ECOTAX');
        $precision = $context->getComputingPrecision();
        $configRoundType = $this->configuration->get('PS_ROUND_TYPE');
        $roundTypes = [
            Order::ROUND_TOTAL => CartRow::ROUND_MODE_TOTAL,
            Order::ROUND_LINE => CartRow::ROUND_MODE_LINE,
            Order::ROUND_ITEM => CartRow::ROUND_MODE_ITEM,
        ];
        if (isset($roundTypes[$configRoundType])) {
            $roundType = $roundTypes[$configRoundType];
        } else {
            $roundType = CartRow::ROUND_MODE_ITEM;
        }
        foreach ($products as $product) {
            $cartRow = new CartRow(
                $product,
                $priceCalculator,
                new AddressFactory(),
                new CustomerDataProvider(),
                new CacheAdapter(),
                new GroupDataProvider(),
                new Database(),
                $useEcotax,
                $precision,
                $roundType,
                $orderId
            );
            $calculator->addCartRow($cartRow);
        }
        foreach ($cartRules as $cartRule) {
            $calculator->addCartRule(new CartRuleData($cartRule));
        }
        return $calculator;
    }

    /*
    * module: dimensionalweight
    * date: 2022-04-08
    * version: 2.1.3
    */


    public function getPackageShippingCost(
        $id_carrier = null,
        $use_tax = true,
        Country $default_country = null,
        $product_list = null,
        $id_zone = null,
        bool $keepOrderPrices = false
    ) {
        if ($this->isVirtualCart()) {
            return 0;
        }
        $freelivery = Module::getInstanceByName('freelivery');
        if ($freelivery) {
            $shipping_cost = $freelivery->getPackageShippingCost($this, $id_carrier, $id_zone, $use_tax);
            if ($shipping_cost !== false) {
                return $shipping_cost;
            }
        }

        if (Module::isEnabled("dimensionalweight")) {
            return $this->getPackageShippingCost_DimensionalWeight(
                $id_carrier,
                $use_tax,
                $default_country,
                $product_list,
                $id_zone,
                $keepOrderPrices
            );
        }

        return parent::getPackageShippingCost(
            $id_carrier,
            $use_tax,
            $default_country,
            $product_list,
            $id_zone,
            $keepOrderPrices
        );
    }

    protected function getCalculator(Cart $cart,?int $id_carrier, $computePrecision, ?int $orderId): Calculator
    {
        return new Calculator($cart, $id_carrier, $computePrecision, $orderId);
    }

    private function getPackageShippingCost_DimensionalWeight($id_carrier = null, $use_tax = true, Country $default_country = null, $product_list = null, $id_zone = null, bool $keepOrderPrices = false){
        if ($this->isVirtualCart()) {
            return 0;
        }

        if (!$default_country) {
            $default_country = Context::getContext()->country;
        }

        if (null !== $product_list) {
            foreach ($product_list as $key => $value) {
                if ($value['is_virtual'] == 1) {
                    unset($product_list[$key]);
                }
            }
        }

        if (null === $product_list) {
            $products = $this->getProducts(false, false, null, true);
        } else {
            $products = $product_list;
        }

        if (Configuration::get('PS_TAX_ADDRESS_TYPE') == 'id_address_invoice') {
            $address_id = (int) $this->id_address_invoice;
        } elseif (is_array($product_list) && count($product_list)) {
            $prod = current($product_list);
            $address_id = (int) $prod['id_address_delivery'];
        } else {
            $address_id = null;
        }
        if (!Address::addressExists($address_id)) {
            $address_id = null;
        }

        if (null === $id_carrier && !empty($this->id_carrier)) {
            $id_carrier = (int) $this->id_carrier;
        }

        $cache_id = 'getPackageShippingCost_' . (int) $this->id . '_' . (int) $address_id . '_' . (int) $id_carrier . '_' . (int) $use_tax . '_' . (int) $default_country->id . '_' . (int) $id_zone;
        if ($products) {
            foreach ($products as $product) {
                $cache_id .= '_' . (int) $product['id_product'] . '_' . (int) $product['id_product_attribute'];
            }
        }

        if (Cache::isStored($cache_id)) {
            return Cache::retrieve($cache_id);
        }

        $order_total = $this->getOrderTotal(true, Cart::BOTH_WITHOUT_SHIPPING, $product_list);

        $shipping_cost = 0;
        if (!count($products)) {
            Cache::store($cache_id, $shipping_cost);

            return $shipping_cost;
        }

        if (!isset($id_zone)) {
            if (
                !$this->isMultiAddressDelivery()
                && isset($this->id_address_delivery) // Be carefull, id_address_delivery is not usefull one 1.5
                && $this->id_address_delivery
                && Customer::customerHasAddress($this->id_customer, $this->id_address_delivery)
            ) {
                $id_zone = Address::getZoneById((int) $this->id_address_delivery);
            } else {
                if (!Validate::isLoadedObject($default_country)) {
                    $default_country = new Country(Configuration::get('PS_COUNTRY_DEFAULT'), Configuration::get('PS_LANG_DEFAULT'));
                }

                $id_zone = (int) $default_country->id_zone;
            }
        }

        if ($id_carrier && !$this->isCarrierInRange((int) $id_carrier, (int) $id_zone)) {
            $id_carrier = '';
        }

        if (empty($id_carrier) && $this->isCarrierInRange((int) Configuration::get('PS_CARRIER_DEFAULT'), (int) $id_zone)) {
            $id_carrier = (int) Configuration::get('PS_CARRIER_DEFAULT');
        }

        $total_package_without_shipping_tax_inc = $this->getOrderTotal(true, Cart::BOTH_WITHOUT_SHIPPING, $product_list);
        if (empty($id_carrier)) {
            if ((int) $this->id_customer) {
                $customer = new Customer((int) $this->id_customer);
                $result = Carrier::getCarriers((int) Configuration::get('PS_LANG_DEFAULT'), true, false, (int) $id_zone, $customer->getGroups());
                unset($customer);
            } else {
                $result = Carrier::getCarriers((int) Configuration::get('PS_LANG_DEFAULT'), true, false, (int) $id_zone);
            }

            foreach ($result as $k => $row) {
                if ($row['id_carrier'] == Configuration::get('PS_CARRIER_DEFAULT')) {
                    continue;
                }

                if (!isset(self::$_carriers[$row['id_carrier']])) {
                    self::$_carriers[$row['id_carrier']] = new Carrier((int) $row['id_carrier']);
                }

                $carrier = self::$_carriers[$row['id_carrier']];

                $shipping_method = $carrier->getShippingMethod();
                if (($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT && $carrier->getMaxDeliveryPriceByWeight((int) $id_zone) === false)
                    || ($shipping_method == Carrier::SHIPPING_METHOD_PRICE && $carrier->getMaxDeliveryPriceByPrice((int) $id_zone) === false)
                ) {
                    unset($result[$k]);

                    continue;
                }

                if ($row['range_behavior']) {
                    $check_delivery_price_by_weight = Carrier::checkDeliveryPriceByWeight($row['id_carrier'], $this->getTotalWeight(null, $row['id_carrier']), (int) $id_zone);

                    $total_order = $total_package_without_shipping_tax_inc;
                    $check_delivery_price_by_price = Carrier::checkDeliveryPriceByPrice($row['id_carrier'], $total_order, (int) $id_zone, (int) $this->id_currency);

                    if (($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT && !$check_delivery_price_by_weight)
                        || ($shipping_method == Carrier::SHIPPING_METHOD_PRICE && !$check_delivery_price_by_price)
                    ) {
                        unset($result[$k]);

                        continue;
                    }
                }

                if ($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT) {
                    $shipping = $carrier->getDeliveryPriceByWeight($this->getTotalWeight($product_list, $row['id_carrier']), (int) $id_zone);
                } else {
                    $shipping = $carrier->getDeliveryPriceByPrice($order_total, (int) $id_zone, (int) $this->id_currency);
                }

                if (!isset($min_shipping_price)) {
                    $min_shipping_price = $shipping;
                }

                if ($shipping <= $min_shipping_price) {
                    $id_carrier = (int) $row['id_carrier'];
                    $min_shipping_price = $shipping;
                }
            }
        }

        if (empty($id_carrier)) {
            $id_carrier = Configuration::get('PS_CARRIER_DEFAULT');
        }

        if (!isset(self::$_carriers[$id_carrier])) {
            self::$_carriers[$id_carrier] = new Carrier((int) $id_carrier, Configuration::get('PS_LANG_DEFAULT'));
        }

        $carrier = self::$_carriers[$id_carrier];

        if (!Validate::isLoadedObject($carrier)) {
            Cache::store($cache_id, 0);

            return 0;
        }
        $shipping_method = $carrier->getShippingMethod();

        if (!$carrier->active) {
            Cache::store($cache_id, $shipping_cost);

            return $shipping_cost;
        }

        if ($carrier->is_free == 1) {
            Cache::store($cache_id, 0);

            return 0;
        }

        if ($use_tax && !Tax::excludeTaxeOption()) {
            $address = Address::initialize((int) $address_id);

            if (Configuration::get('PS_ATCP_SHIPWRAP')) {
                $carrier_tax = 0;
            } else {
                $carrier_tax = $carrier->getTaxesRate($address);
            }
        }

        $configuration = Configuration::getMultiple(array(
            'PS_SHIPPING_FREE_PRICE',
            'PS_SHIPPING_HANDLING',
            'PS_SHIPPING_METHOD',
            'PS_SHIPPING_FREE_WEIGHT',
        ));

        $free_fees_price = 0;
        if (isset($configuration['PS_SHIPPING_FREE_PRICE'])) {
            $free_fees_price = Tools::convertPrice((float) $configuration['PS_SHIPPING_FREE_PRICE'], Currency::getCurrencyInstance((int) $this->id_currency));
        }
        $orderTotalwithDiscounts = $this->getOrderTotal(true, Cart::BOTH_WITHOUT_SHIPPING, null, null, false);
        if ($orderTotalwithDiscounts >= (float) ($free_fees_price) && (float) ($free_fees_price) > 0) {
            $shipping_cost = $this->getPackageShippingCostFromModule($carrier, $shipping_cost, $products);
            Cache::store($cache_id, $shipping_cost);

            return $shipping_cost;
        }

        if (
            isset($configuration['PS_SHIPPING_FREE_WEIGHT'])
            && $this->getTotalWeight(null, $carrier->id) >= (float) $configuration['PS_SHIPPING_FREE_WEIGHT']
            && (float) $configuration['PS_SHIPPING_FREE_WEIGHT'] > 0
        ) {
            $shipping_cost = $this->getPackageShippingCostFromModule($carrier, $shipping_cost, $products);
            Cache::store($cache_id, $shipping_cost);

            return $shipping_cost;
        }

        if ($carrier->range_behavior) {
            if (!isset($id_zone)) {
                if (
                    isset($this->id_address_delivery)
                    && $this->id_address_delivery
                    && Customer::customerHasAddress($this->id_customer, $this->id_address_delivery)
                ) {
                    $id_zone = Address::getZoneById((int) $this->id_address_delivery);
                } else {
                    $id_zone = (int) $default_country->id_zone;
                }
            }

            if (($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT && !Carrier::checkDeliveryPriceByWeight($carrier->id, $this->getTotalWeight(null, (int) $carrier->id), (int) $id_zone))
                || ($shipping_method == Carrier::SHIPPING_METHOD_PRICE && !Carrier::checkDeliveryPriceByPrice($carrier->id, $total_package_without_shipping_tax_inc, $id_zone, (int) $this->id_currency)
                )
            ) {
                $shipping_cost += 0;
            } else {
                if ($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT) {
                    $shipping_cost += $carrier->getDeliveryPriceByWeight($this->getTotalWeight($product_list, $carrier->id), $id_zone);
                } else { // by price
                    $shipping_cost += $carrier->getDeliveryPriceByPrice($order_total, $id_zone, (int) $this->id_currency);
                }
            }
        } else {
            if ($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT) {
                $shipping_cost += $carrier->getDeliveryPriceByWeight($this->getTotalWeight($product_list, $carrier->id), $id_zone);
            } else {
                $shipping_cost += $carrier->getDeliveryPriceByPrice($order_total, $id_zone, (int) $this->id_currency);
            }
        }
        if (isset($configuration['PS_SHIPPING_HANDLING']) && $carrier->shipping_handling) {
            $shipping_cost += (float) $configuration['PS_SHIPPING_HANDLING'];
        }

        foreach ($products as $product) {
            if (!$product['is_virtual']) {
                $shipping_cost += $product['additional_shipping_cost'] * $product['cart_quantity'];
            }
        }

        $shipping_cost = Tools::convertPrice($shipping_cost, Currency::getCurrencyInstance((int) $this->id_currency));

        $shipping_cost = $this->getPackageShippingCostFromModule($carrier, $shipping_cost, $products);
        if ($shipping_cost === false) {
            Cache::store($cache_id, false);

            return false;
        }

        if (Configuration::get('PS_ATCP_SHIPWRAP')) {
            if (!$use_tax) {
                $shipping_cost /= (1 + $this->getAverageProductsTaxRate());
            }
        } else {
            if ($use_tax && isset($carrier_tax)) {
                $shipping_cost *= 1 + ($carrier_tax / 100);
            }
        }

        $shipping_cost = (float) Tools::ps_round((float) $shipping_cost, 2);
        Cache::store($cache_id, $shipping_cost);

        return $shipping_cost;
    }
    /*
    * module: dimensionalweight
    * date: 2022-04-08
    * version: 2.1.3
    */


    # necessario per un errore in modifica indirizzo dentro ordine da bo
    public function getCartRules($filter = CartRule::FILTER_ACTION_ALL, $autoAdd = true, $useOrderPrices = false)
    {
        $virtual_context = Context::getContext()
            ->cloneContext()
        ;
        $virtual_context->cart = $this;

        if (!CartRule::isFeatureActive() || !$this->id) {
            return [];
        }
        if ($autoAdd) {
            CartRule::autoAddToCart($virtual_context, $useOrderPrices);
        }

        $cache_key = 'Cart::getCartRules_'.$this->id.'-'.$filter;
        if (!Cache::isStored($cache_key)) {
            $result = Db::getInstance()
                ->executeS(
                    'SELECT cr.*, crl.`id_lang`, crl.`name`, cd.`id_cart`
                FROM `'._DB_PREFIX_.'cart_cart_rule` cd
                LEFT JOIN `'._DB_PREFIX_.'cart_rule` cr ON cd.`id_cart_rule` = cr.`id_cart_rule`
                LEFT JOIN `'._DB_PREFIX_.'cart_rule_lang` crl ON (
                    cd.`id_cart_rule` = crl.`id_cart_rule`
                    AND crl.id_lang = '.(int)$this->getAssociatedLanguage()
                        ->getId().'
                )
                WHERE `id_cart` = '.(int)$this->id
                    #senza questo alcuni record possono avere un record null che da errore
                    # in OrderAmountUpdater (438)
                    .' and cr.id_cart_rule is not null'
                    .($filter == CartRule::FILTER_ACTION_SHIPPING ? ' AND free_shipping = 1' : '').'
                '.($filter == CartRule::FILTER_ACTION_GIFT ? ' AND gift_product != 0' : '').'
                '.($filter ==
                    CartRule::FILTER_ACTION_REDUCTION ? ' AND (reduction_percent != 0 OR reduction_amount != 0)' : '').
                    ' ORDER by cr.priority ASC, cr.gift_product DESC'
                )
            ;
            Cache::store($cache_key, $result);
        } else {
            $result = Cache::retrieve($cache_key);
        }

        $virtual_context = Context::getContext()
            ->cloneContext()
        ;
        $virtual_context->cart = $this;

        $virtual_context->virtualTotalTaxExcluded = $virtual_context->cart->getOrderTotal(false, self::ONLY_PRODUCTS);
        if (Tax::excludeTaxeOption()) {
            $virtual_context->virtualTotalTaxIncluded = $virtual_context->virtualTotalTaxExcluded;
        } else {
            $virtual_context->virtualTotalTaxIncluded =
                $virtual_context->cart->getOrderTotal(true, self::ONLY_PRODUCTS);
        }

        foreach ($result as &$row) {
            $row['obj'] = new CartRule($row['id_cart_rule'], (int)$this->id_lang);
            $row['value_real'] = $row['obj']->getContextualValue(true, $virtual_context, $filter);
            $row['value_tax_exc'] = $row['obj']->getContextualValue(false, $virtual_context, $filter);
            $row['id_discount'] = $row['id_cart_rule'];
            $row['description'] = $row['name'];
        }

        return $result;
    }

}