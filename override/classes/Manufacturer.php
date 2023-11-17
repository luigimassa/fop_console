<?php
defined('_PS_VERSION_') or die;
class Manufacturer extends ManufacturerCore
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
    public function __construct($id = null, $idLang = null)
    {
        parent::__construct($id, $idLang);
        $ctrl = Context::getContext()->controller;
        if ($ctrl instanceof ManufacturerController && !ManufacturerController::$initialized && !$this->active && Tools::getIsset('id_employee') && Tools::getIsset('adtoken')) {
            $tab = 'AdminManufacturers';
            if (Tools::getAdminToken($tab . (int) Tab::getIdFromClassName($tab) . (int) Tools::getValue('id_employee')) == Tools::getValue('adtoken')) {
                $this->active = 1;
            }
        }
    }
}
