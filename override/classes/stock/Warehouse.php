<?php
/**
 * NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from CREATYM
 * Use, copy, modification or distribution of this source file without written
 * license agreement from CREATYM is strictly forbidden.
 * In order to obtain a license, please contact us: info@creatym.fr
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe CREATYM
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de CREATYM est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter CREATYM a l'adresse: info@creatym.fr
 * ...........................................................................
 *
 * @author    Benjamin L.
 * @copyright 2017 Créatym <http://modules.creatym.fr>
 * @license   Commercial license
 * Support by mail  :  info@creatym.fr
 * Support on forum :  advanceddateofdelivery
 * Phone : +33.87230110
 */
class Warehouse extends WarehouseCore
{
	/*
    * module: advanceddateofdelivery
    * date: 2022-03-18 15:00:40
    * version: 3.0.30
    */
    public static function getProductWarehouseList($id_product, $id_product_attribute = 0, $id_shop = null)
    {
        $share_stock = false;
        if ($id_shop === null) {
            if (Shop::getContext() == Shop::CONTEXT_GROUP) {
                $shop_group = Shop::getContextShopGroup();
            } else {
                $shop_group = Context::getContext()->shop->getGroup();
                $id_shop = (int)Context::getContext()->shop->id;
            }
            $share_stock = $shop_group->share_stock;
        } else {
            $shop_group = Shop::getGroupFromShop($id_shop);
            $share_stock = $shop_group['share_stock'];
        }
        if ($share_stock) {
            $ids_shop = Shop::getShops(true, (int)$shop_group->id, true);
        } else {
            $ids_shop = array((int)$id_shop);
        }
        $query = new DbQuery();
        $query->select('wpl.id_warehouse, CONCAT(w.reference, " - ", w.name) as name');
        $query->from('warehouse_product_location', 'wpl');
        $query->innerJoin('warehouse_shop', 'ws', 'ws.id_warehouse = wpl.id_warehouse AND id_shop IN ('.implode(',', array_map('intval', $ids_shop)).')');
        $query->innerJoin('warehouse', 'w', 'ws.id_warehouse = w.id_warehouse');
        $query->where('id_product = '.(int)$id_product);
		
		if ($id_product_attribute) {
            $query->where('id_product_attribute = '.(int)$id_product_attribute);
        }
        $query->where('w.deleted = 0');
        $query->groupBy('wpl.id_warehouse');
		
        return (Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($query));
    }
}
