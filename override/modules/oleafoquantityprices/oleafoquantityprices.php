<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class oleafoquantitypricesOverride extends oleafoquantityprices
{

    public function hookDisplayProductPriceBlock($params)
    {
        $type = $params['type'];
        if ($type !== 'unit_price') {
            return;
        }
        $product = $params['product'];


        /* Computation of best prices in categories page or inproduct page */
        /* *************************************************************** */
        static $_bestprices = array();
        $id_product = (is_array($params['product'])) ? $params['product']['id_product'] : $params['product']->id;
        $id_product_attribute = (array_key_exists(
            'id_product_attribute',
            $params['product']
        )) ? $params['product']['id_product_attribute'] : null;

        if (!isset($_bestprices[$id_product][$id_product_attribute])) {
            $id_address_vat = Context::getContext()->cookie->id_address_delivery;

            if (Product::getTaxCalculationMethod(Context::getContext()->customer->id) == PS_TAX_EXC) {
                $withTaxes = false;
            } else {
                $withTaxes = (Tax::excludeTaxeOption() ? false : true);
            }
            $specific_price_output = null;
            $price_wt = Product::getPriceStatic(
                $id_product,
                true,
                $id_product_attribute,
                $this->nb_decimal_for_getprice,
                null,
                false,
                true,
                10000000,
                false,
                Context::getContext()->customer->id,
                0/*$id_cart*/,
                $id_address_vat,
                $specific_price_output
            );
            $price_wot = Product::getPriceStatic(
                $id_product,
                false,
                $id_product_attribute,
                $this->nb_decimal_for_getprice,
                null,
                false,
                true,
                10000000,
                false,
                Context::getContext()->customer->id,
                0/*$id_cart*/,
                $id_address_vat,
                $specific_price_output
            );

            if (
                $specific_price_output == null ||
                (isset($specific_price_output['from_quantity']) && $specific_price_output['from_quantity'] == 1)
            ) {
                $_bestprices[$id_product] = array();
            } else {
                $colissage = $this->getALGColissage($params['product']);
                $price_wt = $price_wt / (($colissage) ? $colissage : 1);
                $price_wot = $price_wot / (($colissage) ? $colissage : 1);
                $price = ($withTaxes) ? $price_wt : $price_wot;

                $_bestprices[$id_product][$id_product_attribute] = array(
                    'price' => $price,
                    'price_displayed' => Tools::displayPrice($price),
                    'price_with_taxe' => $price_wt,
                    'price_with_taxes_displayed' => Tools::displayPrice($price_wt),
                    'price_without_taxe' => $price_wot,
                    'price_without_taxes_displayed' => Tools::displayPrice($price_wot),
                    'quantity' => $specific_price_output['from_quantity'],
                );
            }
        }
        $oleafoqty_bestprice = 0;
        if (isset($_bestprices[$id_product][$id_product_attribute]) && count(
                $_bestprices[$id_product][$id_product_attribute])) {

            $oleafoqty_bestprice = $_bestprices[$id_product][$id_product_attribute];

        }
        $this->smarty->assign(array(
            'oleafoqty_bestprice' => $oleafoqty_bestprice,
            'display_fromprice' => $this->is_active_display_best_prices(),
            'olea_isalg' => $this->isALG,
        ));

        $this->smarty->assign('current_blockprice_type', $params['type']);
        $this->smarty->assign('product', $product);

        return $this->display(__FILE__, 'ps17/product_price_block.tpl');
    }

    private function getALGColissage($product)
    {
        $colissage = 1;
        if ($this->isALG) {
            if (is_array($product)) {
                if (isset($product['specific_references']['ean13'])) {
                    $colissage = (int)($product['specific_references']['ean13']);
                } elseif (array_key_exists('ean13', $product)) {
                    $colissage = (int)($product['ean13']);
                } else {
                    $colissage = 1;
                }
            } else {
                $colissage = (isset($product->ean13)) ? (int)($product->ean13) : 1;
            }
        }

        return ((int)$colissage) ? (int)$colissage : 1;
    }

    private function _common_computation_and_assign()
    {
        $qty_prices = self::_getDiscountedPrices($this->_cached_front_product->id, $this->context->cookie);

        $this->_common_smarty_assign(
            $this->_cached_front_product->id,
            $qty_prices['product_qty_prices'],
            $qty_prices['combinations_qty_prices'],
            $qty_prices
        );
    }

    private function _common_smarty_assign($id_product, $products_prices, $combinations_prices, $qty_prices)
    {
        $combination_has_minimal_qty = false;
        foreach ($combinations_prices as $info) { //die('<pre>'.print_r($info, true));
            $combination_has_minimal_qty = $combination_has_minimal_qty || ($info['minimal_quantity'] > 1);
        }

        // La dispo de la colonne stock reprend les conditions de l'affiche de la quantite en fiche produit
        $this->smarty->assign(array(
            'olea_product' => $this->_cached_front_product,
            'oleaqty_defaultcombi' => (int)$this->_cached_front_product->getDefaultIdProductAttribute(),
            'olea_product_qty_prices' => $products_prices,
            'olea_combinations_qty_prices' => $combinations_prices,
            'olea_product_qty_prices_of_group' => $qty_prices['product_qty_prices_of_group'],
            'oleafoqty_cols_config' => Oleafoqtable::convert_col_config($this->_get_responsive_config()),
            'oleafoqty_change_price_display' => (int)Configuration::get('OLEA_FOQTY_CHANGE_PRICE_DISPLAY'),
            'oleafoqty_multi_of_minimal' => $this->productHasMultiOfMinimal($id_product),
            'olea_ps_qty_on_combination' => (int)Configuration::get('PS_QTY_DISCOUNT_ON_COMBINATION'),
            'link_multiaddtocart' => $this->context->link->getModuleLink(
                'oleafoquantityprices',
                'cartajax'
            ),
            'col_img_dir' => _PS_COL_IMG_DIR_,
            'current_blockprice_type' => null,
            'config_blockprice_type' => Configuration::get('OLEA_FOQTY_PRICEBLOCK_TYPE'),
            'ignore_minimalqty_pricescolumns' => Configuration::get('OLEA_FOQTY_IGNORE_MINI_COLS'),
        ));
    }

    private function smartyAssignFOQ()
    {
        static $foqTables = null;

        if ($foqTables == null) {
            $foqTables = array();

            if (!Configuration::get('PS_CATALOG_MODE') || !$this->_cached_front_product) {
                $foqTableConfigs = Oleafoqtable::filterFoqTables(
                    null,
                    ($this->_cached_front_product->hasAttributes()) ? 1 : 0,
                    $this->_cached_front_product->getCategories(),
                    true,
                    Oleafoqtable::retrieveIdsAttributesGroupsOfProduct($this->_cached_front_product->id),
                    $this->getCurrentCustomerGroups()
                );

                if (count($foqTableConfigs)) {
                    foreach ($foqTableConfigs as $foqTableConfig) {
                        $default_collapsed_group = ($foqTableConfig) ? $foqTableConfig['id_collapsed_attribute'] : 0;
                        $combinations_prices_collapsed = $this->combinations_prices_collapsed(
                            self::$_cacheGetDiscountedPrices['combinations_qty_prices'],
                            $default_collapsed_group,
                            $reductions_best,
                            $reductions_minimal,
                            $attributes_group_infos
                        );
                        $products_prices_collapsed = $this->product_prices_collapsed(
                            self::$_cacheGetDiscountedPrices['product_qty_prices'],
                            $this->_cached_front_product,
                            $foq_product_reductions
                        );

                        if ($foqTableConfig) {
                            $foqTableConfig['options'] = explode(',', $foqTableConfig['options_imploded']);
                            $foqTableConfig['hooks_names'] = explode(',', $foqTableConfig['hooks_names_imploded']);
                            $foqTableConfig['informations'] = explode(',', $foqTableConfig['informations_imploded']);
                            $foqTableConfig['name_for_html'] =
                                preg_replace('/[^a-zA-Z0-9]/', '_', $foqTableConfig['name']);
                            $foqTableConfig['responsive_columns'] = Oleafoqtable::convert_col_config(
                                Oleafoqtable::do_unserialize_responsive(
                                    $foqTableConfig['responsive_columns_serialized']
                                )
                            );
                        }

                        $foqTables[] = array(
                            'foqTableConfig' => $foqTableConfig,
                            'foq_display_allowed' => true,
                            'olea_product_qty_prices_collapsed' => $products_prices_collapsed,
                            'olea_combinations_qty_prices_collapsed' => $combinations_prices_collapsed,
                            'foq_product_reductions' => $foq_product_reductions,
                            'reductions_best' => $reductions_best,
                            'reductions_minimal' => $reductions_minimal,
                            'attributes_groups_infos' => $attributes_group_infos,
                        );
                    }
                }
            }
        }

        $this->smarty->assign('foqTables', $foqTables);
    }

    private function combinations_prices_collapsed(
        $combinations_prices,
        $id_attribute_group_excluded = 0,
        &$reductions_best,
        &$reductions_minimal,
        &$attributes_group_infos
    )
    {
        $reductions_best = array();
        $reductions_minimal = array();
        $attributes_group_infos = array();
        if (!count($combinations_prices)) {
            return array();
        }

        $attributes_infos = $this->_get_attributes_infos();

        foreach ($attributes_infos as $attribute_infos) {
            if (!array_key_exists($attribute_infos['id_attribute_group'], $attributes_group_infos)) {
                $attributes_group_infos[$attribute_infos['id_attribute_group']] = array(
                    'id_attribute_group' => $attribute_infos['id_attribute_group'],
                    'name' => $attribute_infos['group_name'],
                    'is_collapsed' => ($attribute_infos['id_attribute_group'] == $id_attribute_group_excluded),
                    'group_type' => $attribute_infos['group_type'],
                    'attributes' => array(),
                );
            }
            $attributes_group_infos[$attribute_infos['id_attribute_group']]['attributes'][$attribute_infos['id_attribute']] =
                array();
        }
        $retour = array();

        foreach ($combinations_prices as &$info_combi) {
            $collapsed_attributes = array();
            foreach ($info_combi['attributes_ids'] as $id_attribute) {
                if (
                    $id_attribute_group_excluded == 0 ||
                    $attributes_infos[$id_attribute]['id_attribute_group'] != $id_attribute_group_excluded
                ) {
                    $collapsed_attributes[] = $id_attribute;
                }
            }
            $info_combi['collapsed_attributes'] = array_unique($collapsed_attributes);
            $info_combi['is_collapsed_by_attributes'] = ($id_attribute_group_excluded != 0);

            $key = implode('#', $info_combi['collapsed_attributes']);
            if (!isset($retour[$key])) {
                $retour[$key] = array();
            }
            $retour[$key][] = $info_combi;

            foreach ($info_combi['attributes'] as $info_attribute) {
                //	            if (! array_key_exists('attributes', $attributes_group_infos[ $info_attribute['id_attribute_group'] ]) ) {
                //                   $attributes_group_infos[ $info_attribute['id_attribute_group'] ] ['attributes'] = array();
                //               }
                $attributes_group_infos[$info_attribute['id_attribute_group']]['attributes'][$info_attribute['id_attribute']] =
                    $info_attribute;
            }

            foreach ($info_combi['reduction_percent'] as $qty => $reduction) {
                if (!array_key_exists($qty, $reductions_minimal)) {
                    $reductions_minimal[$qty] = 100.0;
                }
                $reductions_minimal[$qty] = min($reductions_minimal[$qty], $reduction);

                if (!array_key_exists($qty, $reductions_best)) {
                    $reductions_best[$qty] = 0.0;
                }
                $reductions_best[$qty] = max($reductions_best[$qty], $reduction);
            }
        }

        return $retour;
    }

    private static function _get_attributes_infos($all_attributes_ids = null)
    {
        static $_cached = array();

        if (is_array($all_attributes_ids) && count($all_attributes_ids) > 0) {
            $sqlReq = 'SELECT a.id_attribute, CONCAT(LPAD(ag.position,6,"0"), "_", LPAD(a.position,6,"0")) as position_key, a.color as color, ag.id_attribute_group, ag.position as group_position, agl.name group_name, ag.group_type as group_type, al.name as attribute_name 
    	               FROM `' . _DB_PREFIX_ . 'attribute` a
    	               LEFT JOIN `' . _DB_PREFIX_ . 'attribute_group` ag ON (a.id_attribute_group = ag.id_attribute_group)
    	               LEFT JOIN `' . _DB_PREFIX_ . 'attribute_lang` al ON (a.id_attribute = al.id_attribute)
    	               LEFT JOIN `' . _DB_PREFIX_ . 'attribute_group_lang` agl ON (ag.id_attribute_group = agl.id_attribute_group)
    	               WHERE a.id_attribute IN (' . implode(',', $all_attributes_ids) . ')
                       ORDER BY position_key';
            $res = Db::getInstance()
                ->ExecuteS($sqlReq);

            $retour = array();
            foreach ($res as $info) {
                $retour[$info['id_attribute']] = $info;
            }
            $_cached = $retour;
        }

        return $_cached;
    }

    private function product_prices_collapsed($product_prices, $product, &$foq_product_reduction)
    {
        $foq_product_reduction = self::$_cacheGetDiscountedPrices['product_qty_reductions'];

        return array(
            0 => array(
                'id_product_attribute' => 0,
                'prices' => $product_prices,
                'minimal_quantity' => $product->minimal_quantity,
            ),
        );
    }
}
