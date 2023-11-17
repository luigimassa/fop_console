<?php
/**
 * ---------------------------------------------------------------------------------
 *
 * This file is part of the 'OleaFOQuantityPrice' module feature
 * Developped for Prestashop  platform.
 * You are not allowed to use it on several site
 * You are not allowed to sell or redistribute this module
 * This header must not be removed
 *
 * @author OleaCorner <contact@oleacorner.com> <www.oleacorner.com>
 * @copyright OleaCorner
 * @license XXX
 * @version 1.0
 *
 * ---------------------------------------------------------------------------------
 */
class OrderDetail extends OrderDetailCore
{
	/*
    * module: oleafoquantityprices
    * date: 2022-04-17 14:47:17
    * version: 2.3.1
    */
    public $oleafoqty_minimal_qty;
	/*
    * module: oleafoquantityprices
    * date: 2022-04-17 14:47:17
    * version: 2.3.1
    */
    public function __construct($id = null, $id_lang = null, $context = null) {
		self::$definition['fields']['oleafoqty_minimal_qty'] = array('type' => self::TYPE_INT, 'validate' => 'isInt');
		parent::__construct($id, $id_lang, $context);
	}
	/*
    * module: oleafoquantityprices
    * date: 2022-04-17 14:47:17
    * version: 2.3.1
    */
    protected function create(Order $order, Cart $cart, $product, $id_order_state, $id_order_invoice, $use_taxes = true, $id_warehouse = 0)
	{
		parent::create($order, $cart, $product, $id_order_state, $id_order_invoice, $use_taxes, $id_warehouse);
        $foqty_module = Module::getInstanceByName('oleafoquantityprices');
        if ($foqty_module) {
            if ($foqty_module->productHasMultiOfMinimal($product['id_product'])) {
                $this->oleafoqty_minimal_qty = $product['minimal_quantity'];
            } else {
                $this->oleafoqty_minimal_qty = 1;
                }
            $this->save();
        }
	}
}