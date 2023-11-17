<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

class Product extends ProductCore
{
    const TOT_SWITCH_MODE = 'TOT_SWITCH_MODE';

    public static function getAttributesColorList(array $products, $have_stock = true)
    {
        if (Module::isEnabled('totswitchattribute')) {
            include_once _PS_MODULE_DIR_ . 'totswitchattribute/totswitchattribute.php';

            // if (TotSwitchAttribute::MODE_HIDE == Configuration::get(self::TOT_SWITCH_MODE)) {
                // select with a join to tot_switch_attribute_disabled
                if (!count($products)) {
                    return [];
                }
                $id_lang = Context::getContext()->language->id;
                $check_stock = !Configuration::get('PS_DISP_UNAVAILABLE_ATTR');
                $sql = '
			SELECT pa.`id_product`, a.`color`, pac.`id_product_attribute`, ' . ($check_stock ? 'SUM(IF(stock.`quantity` > 0, 1, 0))' : '0') . ' qty, a.`id_attribute`, al.`name`, IF(color = "", a.id_attribute, color) group_by
			FROM `' . _DB_PREFIX_ . 'product_attribute` pa
			' . Shop::addSqlAssociation('product_attribute', 'pa') .
                    ($check_stock ? Product::sqlStock('pa', 'pa') : '') . '
			JOIN `' . _DB_PREFIX_ . 'product_attribute_combination` pac ON (pac.`id_product_attribute` = product_attribute_shop.`id_product_attribute`)
			JOIN `' . _DB_PREFIX_ . 'attribute` a ON (a.`id_attribute` = pac.`id_attribute`)
			JOIN `' . _DB_PREFIX_ . 'attribute_lang` al ON (a.`id_attribute` = al.`id_attribute` AND al.`id_lang` = ' . (int)$id_lang . ')
			JOIN `' . _DB_PREFIX_ . 'attribute_group` ag ON (a.id_attribute_group = ag.`id_attribute_group`)
			LEFT JOIN `' . _DB_PREFIX_ . 'tot_switch_attribute_disabled` sad ON (sad.`id_product_attribute` = pa.`id_product_attribute`)
				' . Shop::addSqlRestriction(false, 'sad') . '
			WHERE pa.`id_product` IN (' . implode(',', array_map('intval', $products)) . ') AND ag.`is_color_group` = 1
			AND sad.`id_tot_switch_attribute_disabled` IS NULL
			GROUP BY pa.`id_product`, a.`id_attribute`, `group_by`
			' . ($check_stock ? 'HAVING qty > 0' : '') . '
			ORDER BY a.`position` ASC;';
                if (!$res = Db::getInstance()->executeS($sql)) {
                    return false;
                }
                if (version_compare(_PS_VERSION_, '1.7', '>=')) {
                    $colors = [];
                    foreach ($res as $row) {
                        $row['texture'] = '';
                        if (Tools::isEmpty($row['color'])
                            && !@filemtime(_PS_COL_IMG_DIR_ . $row['id_attribute'] . '.jpg')) {
                            continue;
                        } elseif (Tools::isEmpty($row['color'])
                            && @filemtime(_PS_COL_IMG_DIR_ . $row['id_attribute'] . '.jpg')) {
                            $row['texture'] = _THEME_COL_DIR_ . $row['id_attribute'] . '.jpg';
                        }
                        $colors[(int)$row['id_product']][] = [
                            'id_product_attribute' => (int)$row['id_product_attribute'],
                            'color' => $row['color'],
                            'texture' => $row['texture'],
                            'id_product' => $row['id_product'],
                            'name' => $row['name'],
                            'id_attribute' => $row['id_attribute'],
                        ];
                    }
                } else {
                    $colors = [];
                    foreach ($res as $row) {
                        if (Tools::isEmpty($row['color'])
                            && !@filemtime(_PS_COL_IMG_DIR_ . $row['id_attribute'] . '.jpg')) {
                            continue;
                        }
                        $colors[(int)$row['id_product']][] = [
                            'id_product_attribute' => (int)$row['id_product_attribute'],
                            'color' => $row['color'],
                            'id_product' => $row['id_product'],
                            'name' => $row['name'],
                            'id_attribute' => $row['id_attribute'],
                        ];
                    }
                }

                return $colors;
            // }
        }

        return parent::getAttributesColorList($products, $have_stock);
    }

    /**
     * Get all available attribute groups
     *
     * @param int $id_lang Language id
     * @param int $id_product_attribute Product attribute id
     *
     * @return array Attribute groups
     */
    public function getAttributesGroups($id_lang, $id_product_attribute = null)
    {
        if (Module::isEnabled('totswitchattribute')) {
            include_once _PS_MODULE_DIR_ . 'totswitchattribute/totswitchattribute.php';
            // select with a join to tot_switch_attribute_disabled
            if (!Combination::isFeatureActive()) {
                return [];
            }
            // in Prestashop version 1.6 these fields are not exist
            $mpnAndIsbn = 'pa.`mpn`, pa.`isbn`,';

            if (version_compare(_PS_VERSION_, '1.7.7', '<') && version_compare(_PS_VERSION_, '1.7.0.5', '>')) {
                $mpnAndIsbn = 'pa.`isbn`,';
            } elseif (version_compare(_PS_VERSION_, '1.7', '<')) {
                $mpnAndIsbn = '';
            }
            $sql = 'SELECT ag.`id_attribute_group`, ag.`is_color_group`, agl.`name` AS group_name, agl.`public_name` AS public_group_name,
                a.`id_attribute`, al.`name` AS attribute_name, a.`color` AS attribute_color, product_attribute_shop.`id_product_attribute`, IFNULL(stock.quantity, 0) AS quantity,
                IF(sad.`id_tot_switch_attribute_disabled` IS NOT NULL, 0, 1) AS enabled_attribute, product_attribute_shop.`price`, product_attribute_shop.`ecotax`, product_attribute_shop.`weight`,
                product_attribute_shop.`default_on`, pa.`reference`, pa.`ean13`, pa.`upc`, ' . $mpnAndIsbn . '  product_attribute_shop.`unit_price_impact`,
                product_attribute_shop.`minimal_quantity`, product_attribute_shop.`available_date`, ag.`group_type`
            FROM `' . _DB_PREFIX_ . 'product_attribute` pa
            ' . Shop::addSqlAssociation('product_attribute', 'pa') . '
            ' . Product::sqlStock('pa', 'pa') . '
            LEFT JOIN `' . _DB_PREFIX_ . 'product_attribute_combination` pac ON (pac.`id_product_attribute` = pa.`id_product_attribute`)
            LEFT JOIN `' . _DB_PREFIX_ . 'attribute` a ON (a.`id_attribute` = pac.`id_attribute`)
            LEFT JOIN `' . _DB_PREFIX_ . 'attribute_group` ag ON (ag.`id_attribute_group` = a.`id_attribute_group`)
            LEFT JOIN `' . _DB_PREFIX_ . 'attribute_lang` al ON (a.`id_attribute` = al.`id_attribute`)
            LEFT JOIN `' . _DB_PREFIX_ . 'attribute_group_lang` agl ON (ag.`id_attribute_group` = agl.`id_attribute_group`)
            ' . Shop::addSqlAssociation('attribute', 'a') . '
            LEFT JOIN `' . _DB_PREFIX_ . 'tot_switch_attribute_disabled` sad ON (sad.`id_product_attribute` = pa.`id_product_attribute`)
                ' . Shop::addSqlRestriction(false, 'sad') . '
            WHERE pa.`id_product` = ' . (int)$this->id . '
                AND al.`id_lang` = ' . (int)$id_lang . '
                AND agl.`id_lang` = ' . (int)$id_lang;
                // -->@bwlab  there is not configuration name  (???) ---> This is the configuration TOT_SWITCH_MODE
                // Use for backward compatibiility with old versions, in new versions there was a 'DISABLE' mode instead of hide
            // if (version_compare(_PS_VERSION_, '1.7', '<') && TotSwitchAttribute::MODE_HIDE == Configuration::get('TOT_SWITCH_MODE')) {
                $sql .= ' AND sad.`id_tot_switch_attribute_disabled` IS NULL';
            // }
            // <-- @bwlab
            $sql .= ' GROUP BY id_attribute_group, id_product_attribute
            ORDER BY ag.`position` ASC, a.`position` ASC, agl.`name` ASC';
            $result = Db::getInstance()->executeS($sql);
             PrestaShopLogger::addLog('Results : ' . count($result));
             PrestaShopLogger::addLog(json_encode(array_map(function($item) {
                 return $item['id_product_attribute']; //
             }, $result)));
            // For the product 26647 i don't have from data the configurations disabled
            // So there is an other process (hook / module) that inject them in the product template
            // Try to uncomment above and see the results of id product attributes on the results.

            // We call needDefaultAttribute to be sure there is a default attribute, to be selected in product page
            return $this->needDefaultAttribute($result, 'default_on', true, 'group_name');
          
        }

        return parent::getAttributesGroups($id_lang, $id_product_attribute);
    }

    /**
     * If we cannot find any default value, we set one.
     *
     * @return array Attribute groups
     */
    public function needDefaultAttribute($array, $defaultField, $defaultValue, $groupAttributeField)
    {
        if (version_compare(_PS_VERSION_, '1.7', '>=') && version_compare(_PS_VERSION_, '1.7.8', '<')) {
            $switch_attr_groups = [];
            foreach ($array as $key => $attribute) {
                $switch_attr_groups[$attribute['id_attribute']]['enabled_attribute'][] = $attribute['enabled_attribute'];
                $switch_attr_groups[$attribute['id_attribute']]['key'][] = $key;
            }
            foreach ($switch_attr_groups as $key => $attribute) {
                if (array_unique($attribute['enabled_attribute']) == ['0']) {
                    foreach ($attribute['key'] as $key_attr => $value_attr_key) {
                        unset($array[$value_attr_key]);
                    }
                }
            }
        }
        if (version_compare(_PS_VERSION_, '1.7', '<')
            && TotSwitchAttribute::MODE_HIDE != Configuration::get('TOT_SWITCH_MODE')) {
            $switch_attr_groups = [];
            foreach ($array as $key => $attribute) {
                $switch_attr_groups[$attribute['id_attribute']]['enabled_attribute'][$key] = $attribute['enabled_attribute'];
                $switch_attr_groups[$attribute['id_attribute']]['key'][$key] = $key;
            }

            foreach ($switch_attr_groups as $key => $attribute) {
                if (array_unique($attribute['enabled_attribute']) != ['0']
                    && array_unique($attribute['enabled_attribute']) != ['1']) {
                    foreach ($attribute['key'] as $key_attr => $value_attr_key) {
                        if ($attribute['enabled_attribute'][$key_attr] == 0) {
                            unset($array[$key_attr]);
                        }
                    }
                }
            }
        }
        foreach ($array as $attribute) {
            if ($attribute[$defaultField] == $defaultValue) {
                return $array;
            }
        }
        $groupAttributeFields = [];
        foreach ($array as $key => $attribute) {
            if (!in_array($attribute[$groupAttributeField], $groupAttributeFields)) {
                $groupAttributeFields[] = $attribute[$groupAttributeField];
                $array[$key][$defaultField] = $defaultValue;
            }
        }

        return $array;
    }

    public function getImages($id_lang, Context $context = null)
    {
        if (Module::isInstalled('totswitchattribute')
            && Module::isEnabled('totswitchattribute')
            && $this->hasAttributes()) {
            $enabledImages = $this->getEnabledImages();
            if (empty($enabledImages)) {
                return parent::getImages($id_lang, $context);
            }

            $select = '
            SELECT image_shop.`cover`, i.`id_image`, il.`legend`, i.`position`
            FROM `' . _DB_PREFIX_ . 'image` i
            ' . Shop::addSqlAssociation('image', 'i') . '
            LEFT JOIN `' . _DB_PREFIX_ . 'image_lang` il ON (i.`id_image` = il.`id_image` AND il.`id_lang` = ' . (int)$id_lang . ')
            WHERE i.`id_product` = ' . (int)$this->id . '
            AND i.`id_image` IN (' . implode(',', $enabledImages) . ')';
            $select .= ' ORDER BY `position`';

            return Db::getInstance()->executeS($select);
        }

        return parent::getImages($id_lang, $context);
    }

    public function getEnabledImages()
    {
        $return = [];
        $q = new DbQuery();

        $q->select('pai.id_image');
        $q->from('product_attribute', 'pa');
        $q->innerJoin('product_attribute_image', 'pai', 'pai.id_product_attribute = pa.id_product_attribute');
        $q->leftJoin('tot_switch_attribute_disabled', 't', 't.id_product_attribute = pa.id_product_attribute');
        $q->where('pa.id_product = ' . (int)$this->id);
        $q->where('t.id_tot_switch_attribute_disabled IS NULL');
        $result = Db::getInstance()->executeS($q);

        if ($result) {
            foreach ($result as $row) {
                $return[] = $row['id_image'];
            }
            $return = array_unique($return);
        }

        return $return;
    }
}