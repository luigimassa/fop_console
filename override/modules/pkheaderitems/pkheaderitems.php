<?php
/**
 * Promokit Header Items
 *
 * @package   Promokit
 * @version   1.2.1
 * @author    https://promokit.eu
 * @copyright Copyright Ⓒ Since 2011 promokit.eu <@email:support@promokit.eu>
 * @license   You only can use the module, nothing more!
 */

if (!defined('_PS_VERSION_')) {
    exit;
}


class PkheaderitemsOverride extends Pkheaderitems
{
    public function getTemplateData($setting = false)
    {
        $data = parent::getTemplateData($setting);

        // @bwlab-----------
        $data['pkhiconfig']['default_group_name'] = '';

        if ($this->context->customer instanceof \Customer && $this->context->customer->isLogged() === true) {
            $group = new Group($this->context->customer->id_default_group);
            $data['pkhiconfig']['default_group_name'] = $group->getFieldByLang('name');
        }
        //-----------------

        return $data;
    }

}