<?php
/**
 * 2007-2023 PayPal
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 *  versions in the future. If you wish to customize PrestaShop for your
 *  needs please refer to http://www.prestashop.com for more information.
 *
 *  @author 2007-2023 PayPal
 *  @author 202 ecommerce <tech@202-ecommerce.com>
 *  @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *  @copyright PayPal
 */

use PaypalPPBTlib\Extensions\ProcessLogger\ProcessLoggerHandler;

class PayPalOverride extends PayPal
{
    public function validateOrder(
        $id_cart, $id_order_state,
        $amount_paid,
        $payment_method = 'Unknown',
        $message = null,
        $transaction = [],
        $currency_special = null,
        $dont_touch_amount = false,
        $secure_key = false,
        Shop $shop = null,
        $order_reference = null
    ) {
        try {
            if ($this->needConvert()) {
                $amount_paid_curr = Tools::ps_round(Tools::convertPrice($amount_paid, new Currency($currency_special), true), 2);
            } else {
                $amount_paid_curr = Tools::ps_round($amount_paid, 2);
            }
            $amount_paid = Tools::ps_round($amount_paid, 2);
            $message = 'Validate order with state number ' . $id_order_state . "\n";
            $message .= json_encode([
                'need convert' => $this->needConvert(),
                'amount_paid_curr' => $amount_paid_curr,
                'amount_paid' => $amount_paid,
                'cart' => \Context::getContext()->cart,
            ]);
            ProcessLoggerHandler::openLogger();
            ProcessLoggerHandler::logInfo(
                $message,
                isset($transaction['transaction_id']) ? $transaction['transaction_id'] : null,
                null,
                (int) $id_cart,
                $this->context->shop->id,
                isset($transaction['payment_tool']) && $transaction['payment_tool'] ? $transaction['payment_tool'] : 'PayPal',
                (int) Configuration::get('PAYPAL_SANDBOX'),
                isset($transaction['date_transaction']) ? $transaction['date_transaction'] : null
            );
            ProcessLoggerHandler::closeLogger();
        } catch (Exception $ex) {
            
        }

        parent::validateOrder(
            $id_cart, 
            $id_order_state,
            $amount_paid,
            $payment_method,
            $message,
            $transaction,
            $currency_special,
            $dont_touch_amount,
            $secure_key,
            $shop,
            $order_reference
        );
    }
}
