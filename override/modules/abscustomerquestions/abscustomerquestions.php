<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;

class AbsCustomerQuestionsOverride extends AbsCustomerQuestions implements WidgetInterface
{
    public function getWidgetVariables($hookName, array $configuration)
    {
        return array('product' => ['id' => Tools::getValue('id_product')]);
    }

    public function hookdisplayFooterProduct($params, $others = false)
    {
        if (!isset($this->context->controller->php_self) || $this->context->controller->php_self != 'product') {
            return;
        }
        $product = $params['product'];
        if ($product instanceof Product) {
            $product = (array)$product;
        }
        $idproduct = (int)$product['id'];
        $product = new Product($idproduct, false, $this->context->language->id);
        $version = (version_compare(_PS_VERSION_, '1.7', '<')) ? '' : '_17';
        $nqp = (int)Configuration::get('ABS_CUSTOMER_QUESTIONS_NQP');
        $crearlista = AbsCustomerQuestion::listCustomerQuestions($idproduct, 1, $nqp, '');
        $totales = ($crearlista ? $crearlista[0]['totales'] : 0);
        $enlaceproducto = urlencode($this->context->link->getProductLink($product));
        $friend = Configuration::get('PS_REWRITING_SETTINGS');
        $enlace1 = '<a href="'.$this->context->link->getPageLink('authentication').($friend ? '?' : '&').'back='.
            $enlaceproducto.'">';
        $enlace2 = '<a href="'.$this->context->link->getPageLink('authentication').($friend ? '?' : '&').
            'create_account=1&back='.$enlaceproducto.'">';
        $blacklist =
            array_unique(explode(' ', Configuration::get('ABS_CUSTOMER_Q_BLACK_LIST_'.$this->context->language->id)));
        foreach ($blacklist as &$black) {
            if ($black != end($blacklist)) {
                $black = '"'.$black.'",';
            } else {
                $black = '"'.$black.'"';
            }
        }
        $blacklist = '['.implode(',', $blacklist).']';
        $resto = $totales % $nqp;
        $is_logged = false;
        if($this->context->customer instanceof \Customer){
            $is_logged = $this->context->customer->isLogged();
        }
        $this->smarty->assign(array(
                'abscustomerquestions_controller_url' => $this->_frontcontroller,
                'abs_customerq_title'                 => $this->l('Customer questions & answers'),
                'secure_key'                          => Configuration::get('ABS_CUSTOMER_QUESTIONS_TOKEN'),
                'abs_customerq_input'                 => $this->l('Have a question? Search for answers'),
                'abs_id_product'                      => $idproduct,
                'abs_id_lang'                         => $this->context->language->id,
                'questions'                           => $crearlista,
                'logged'                              => $is_logged,
                'userid'                              => $this->context->customer->id,
                'enlace1'                             => $enlace1,
                'enlace2'                             => $enlace2,
                'blacklist'                           => $blacklist,
                'nqp'                                 => $nqp,
                'totales'                             => $totales,
                'resto'                               => $resto,
                'color1'                              => Configuration::get('ABS_CUSTOMER_Q_COLOR_LINK'),
                'color2'                              => Configuration::get('ABS_CUSTOMER_Q_COLOR_LINKACT'),
                'color3'                              => Configuration::get('ABS_CUSTOMER_Q_COLOR_BUT1'),
                'color4'                              => Configuration::get('ABS_CUSTOMER_Q_COLOR_BUT2'),
                'color5'                              => Configuration::get('ABS_CUSTOMER_Q_COLOR_BUTACT1'),
                'color6'                              => Configuration::get('ABS_CUSTOMER_Q_COLOR_BUTACT2'),
            ));

        return $this->display(__FILE__, 'abscustomerquestions'.$version.'.tpl');
    }

    public function renderWidget($hookName, array $configuration)
    {
        $params = $this->getWidgetVariables($hookName, $configuration);
        return $this->hookdisplayFooterProduct($params);
    }

}

