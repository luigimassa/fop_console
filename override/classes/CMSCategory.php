<?php
defined('_PS_VERSION_') or die;
class CMSCategory extends CMSCategoryCore
{
    /*
    * module: creativeelements
    * date: 2023-09-11 12:02:39
    * version: 2.9.14
    */
    const CE_OVERRIDE = true;
    /*
    * module: creativeelements
    * date: 2023-09-11 12:02:39
    * version: 2.9.14
    */
    public function __construct($id = null, $idLang = null)
    {
        parent::__construct($id, $idLang);
        $ctrl = Context::getContext()->controller;
        if ($ctrl instanceof CmsController && !CmsController::$initialized && !$this->active && Tools::getIsset('id_employee') && Tools::getIsset('adtoken')) {
            $tab = 'AdminCmsContent';
            if (Tools::getAdminToken($tab . (int) Tab::getIdFromClassName($tab) . (int) Tools::getValue('id_employee')) == Tools::getValue('adtoken')) {
                $this->active = 1;
            }
        }
    }
}
