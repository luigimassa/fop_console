<?php

if (!defined('_PS_VERSION_')) {
    exit;
}
use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class CartopdfOverride extends Cartopdf implements WidgetInterface
{
    public function renderWidget($hookName, array $configuration)
    {
       return $this->hookdisplayShoppingCartFooter([]);
    }

    public function getWidgetVariables($hookName, array $configuration)
    {
        // TODO: Implement getWidgetVariables() method.
    }


}

