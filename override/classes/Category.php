<?php
defined('_PS_VERSION_') or die;
class Category extends CategoryCore
{
    /*
    * module: creativeelements
    * date: 2022-04-17 13:59:24
    * version: 2.5.7
    */
    const CE_OVERRIDE = true;
    /*
    * module: creativeelements
    * date: 2022-04-17 13:59:24
    * version: 2.5.7
    */
    public function __construct($idCategory = null, $idLang = null, $idShop = null)
    {
        parent::__construct($idCategory, $idLang, $idShop);
        $ctrl = Context::getContext()->controller;
        if ($ctrl instanceof CategoryController && !CategoryController::$initialized && !$this->active && Tools::getIsset('id_employee') && Tools::getIsset('adtoken')) {
            $tab = 'AdminCategories';
            if (Tools::getAdminToken($tab . (int) Tab::getIdFromClassName($tab) . (int) Tools::getValue('id_employee')) == Tools::getValue('adtoken')) {
                $this->active = 1;
            }
        }
    }
}
