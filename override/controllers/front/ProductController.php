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
class ProductController extends ProductControllerCore {
    
    /*
    * module: oleafoquantityprices
    * date: 2022-04-17 14:47:16
    * version: 2.3.1
    */
    protected function assignCategory_oleafoqty()
    {
        $this->assignAttributesGroups();
        parent::assignCategory();
    }
    
}