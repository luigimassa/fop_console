<?php

class Carrier extends CarrierCore
{

    public static function getCarriersForOrder($id_zone, $groups = null, $cart = null, &$error = array())
    {
        if (! Module::isEnabled("dimensionalweight")) {
            return parent::getCarriersForOrder($id_zone, $groups, $cart);
        }
        
        $context = Context::getContext();
        $id_lang = $context->language->id;
        if (null === $cart) {
            $cart = $context->cart;
        }
        if (isset($context->currency)) {
            $id_currency = $context->currency->id;
        }

        if (is_array($groups) && !empty($groups)) {
            $result = Carrier::getCarriers($id_lang, true, false, (int) $id_zone, $groups, self::PS_CARRIERS_AND_CARRIER_MODULES_NEED_RANGE);
        } else {
            $result = Carrier::getCarriers($id_lang, true, false, (int) $id_zone, array(Configuration::get('PS_UNIDENTIFIED_GROUP')), self::PS_CARRIERS_AND_CARRIER_MODULES_NEED_RANGE);
        }
        $results_array = array();

        foreach ($result as $k => $row) {
            $carrier = new Carrier((int) $row['id_carrier']);
            $shipping_method = $carrier->getShippingMethod();
            if ($shipping_method != Carrier::SHIPPING_METHOD_FREE) {
                if (($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT && $carrier->getMaxDeliveryPriceByWeight($id_zone) === false)) {
                    $error[$carrier->id] = Carrier::SHIPPING_WEIGHT_EXCEPTION;
                    unset($result[$k]);

                    continue;
                }
                if (($shipping_method == Carrier::SHIPPING_METHOD_PRICE && $carrier->getMaxDeliveryPriceByPrice($id_zone) === false)) {
                    $error[$carrier->id] = Carrier::SHIPPING_PRICE_EXCEPTION;
                    unset($result[$k]);

                    continue;
                }

                if ($row['range_behavior']) {
                    if (!$id_zone) {
                        $id_zone = (int) Country::getIdZone(Country::getDefaultCountryId());
                    }

                    if ($shipping_method == Carrier::SHIPPING_METHOD_WEIGHT
                        && (!Carrier::checkDeliveryPriceByWeight($row['id_carrier'], $cart->getTotalWeight(null, $row['id_carrier']), $id_zone))) {
                        $error[$carrier->id] = Carrier::SHIPPING_WEIGHT_EXCEPTION;
                        unset($result[$k]);

                        continue;
                    }

                    if ($shipping_method == Carrier::SHIPPING_METHOD_PRICE
                        && (!Carrier::checkDeliveryPriceByPrice($row['id_carrier'], $cart->getOrderTotal(true, Cart::BOTH_WITHOUT_SHIPPING), $id_zone, $id_currency))) {
                        $error[$carrier->id] = Carrier::SHIPPING_PRICE_EXCEPTION;
                        unset($result[$k]);

                        continue;
                    }
                }
            }

            $row['name'] = ((string) ($row['name']) != '0' ? $row['name'] : Carrier::getCarrierNameFromShopName());
            $row['price'] = (($shipping_method == Carrier::SHIPPING_METHOD_FREE) ? 0 : $cart->getPackageShippingCost((int) $row['id_carrier'], true, null, null, $id_zone));
            $row['price_tax_exc'] = (($shipping_method == Carrier::SHIPPING_METHOD_FREE) ? 0 : $cart->getPackageShippingCost((int) $row['id_carrier'], false, null, null, $id_zone));
            $row['img'] = file_exists(_PS_SHIP_IMG_DIR_ . (int) $row['id_carrier'] . '.jpg') ? _THEME_SHIP_DIR_ . (int) $row['id_carrier'] . '.jpg' : '';

            if ($row['price'] === false) {
                unset($result[$k]);

                continue;
            }
            $results_array[] = $row;
        }

        $prices = array();
        if (Configuration::get('PS_CARRIER_DEFAULT_SORT') == Carrier::SORT_BY_PRICE) {
            foreach ($results_array as $r) {
                $prices[] = $r['price'];
            }
            if (Configuration::get('PS_CARRIER_DEFAULT_ORDER') == Carrier::SORT_BY_ASC) {
                array_multisort($prices, SORT_ASC, SORT_NUMERIC, $results_array);
            } else {
                array_multisort($prices, SORT_DESC, SORT_NUMERIC, $results_array);
            }
        }

        return $results_array;
    }
}
