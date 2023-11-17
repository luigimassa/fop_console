<?php

class Ps_ShoppingcartOverride extends Ps_Shoppingcart
{

    public function getWidgetVariables($hookName, array $params)
    {
        $data = parent::getWidgetVariables($hookName, $params);
        $data['authentication_page'] = $this->context->link->getPageLink('authentication');
        return $data;
    }


    public function hookHeader()
    {
        parent::hookHeader();
        $jsDef = ['ps_page' => ($this->context->controller->php_self === 'order') ? 'order' : ''];
        Media::addJsDef($jsDef);
    }
    
    public function hookDisplayHeader(){
        parent::hookDisplayHeader();
        $jsDef = ['ps_page' => ($this->context->controller->php_self === 'order') ? 'order' : ''];
        Media::addJsDef($jsDef);
    }
    
    public function renderWidget($hookName, array $params)
    {
        $result = parent::renderWidget($hookName, $params);
        if (Tools::getValue('ps_page', false) === 'order') {
            return $this->fetch('module:ps_shoppingcart/ps_shoppingcart_alysum.tpl');
        }

        return $this->fetch('module:ps_shoppingcart/ps_shoppingcart.tpl');
    }

}