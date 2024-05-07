{*
* 2007-2022 PrestaShop
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
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2022 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<table width="100%">
    <tr>
        <td>
            <table width="100%;float:right" border="0" style="font-size:10pt;">
                <tr>
                    <td scope="col"><img align="left" src="{$logoImagen|escape:'htmlall':'UTF-8'}"/></td>
                    <td>
                        <table style="text-align:right;">
                            <tr>
                                <td scope="col" style="font-size:16pt;">
                                    {if isset($CtoPDF_titulo) && $CtoPDF_titulo != ''}
                                        <b>{$CtoPDF_titulo|escape:'quotes':'UTF-8'}</b>{/if}
                                </td>
                            </tr>
                            <tr>
                                <td scope="col">
                                    {l s='Date' mod='cartopdf'}
                                    : {$cart->date_add|date_format:"%d/%m/%Y"|escape:'quotes':'UTF-8'}
                                </td>
                            </tr>
                            {if isset($order) && isset($refPedido) && $refPedido != ''}
                                <tr>
                                    <td scope="col">
                                        {l s='Ref.' mod='cartopdf'}: <b>{$refPedido|escape:'htmlall':'UTF-8'}</b>
                                    </td>
                                </tr>
                            {/if}
                            {if $numeracion}
                                <tr>
                                    <td scope="col">
                                        {l s='ID' mod='cartopdf'}: <b>{$numeracion|escape:'htmlall':'UTF-8'}</b>
                                    </td>
                                </tr>
                            {/if}
                        </table>
                    </td>
                </tr>
            </table>
            <div>&nbsp;</div>
            {if isset($order) || isset($cartaddres)}
                {if $htmlText}
                    <table width="100%" border="0">
                        <tr>
                            <td>{$htmlText nofilter}</td>{* VARIABLE $htmlText INCLUDES HTML TAGS *}
                        </tr>
                    </table>
                    <div>&nbsp;</div>
                {/if}
                {if $hideAddress == false}
                    {* ADDRESSES *}
                    <table style="width: 100%;">
                        <tr>
                            <td style="width:100%">
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="width: 48%">
                                            <table cellpadding="7" style="width: 100%">
                                                <tr style="background-color:#999999;color:#ffffff;font-size:12pt;">
                                                    <td>{l s='Shipping address' mod='cartopdf'}</td>
                                                </tr>
                                                <tr style="width: 50%; background-color: #F2F2F2; font-size:10pt;">
                                                    <td>{if !empty($delivery_address)}{$delivery_address nofilter}{else}{$invoice_address nofilter}{/if}</td>{* VARIABLES $delivery_address AND $invoice_address INCLUDE HTML TAGS *}
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 4%"></td>
                                        <td style="width: 48%">
                                            <table cellpadding="7" style="width: 100%">
                                                <tr style="background-color:#999999;color:#ffffff;font-size:12pt;">
                                                    <td>{l s='Address' mod='cartopdf'}</td>
                                                </tr>
                                                <tr style="width: 50%; background-color: #F2F2F2; font-size:10pt;">
                                                    <td>{$invoice_address nofilter}</td>{* VARIABLE $invoice_address INCLUDES HTML TAGS *}
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br><br>
                            </td>
                        </tr>
                    </table>
                {/if}
            {/if}
            <table width="100%" border="0" cellpadding="3">
                <tr>
                    <td colspan="5" scope="col"
                        style="background-color:#F2F2F2;;color:#444;font-size:14pt;padding:5">{l s='Products' mod='cartopdf'}</td>
                </tr>
            </table>
            <table width="100%" border="1" cellpadding="3" style="border-color:#444;">
                <tr>
                    <td width="10%" style="background-color:#999999;color:#ffffff;font-size:10pt">
                        <b> {l s='Ref.' mod='cartopdf'}</b></td>
                    <td width="25%" style="background-color:#999999;color:#ffffff;font-size:10pt"><b> {l s='Name'
                            mod='cartopdf'}</b></td>
                    {*---------->  @BWLAB*}
                    <td width="10%" style="background-color:#999999;color:#ffffff;font-size:10pt">
                        <b> {l s='Pezzi per cartone' mod='cartopdf'}</b></td>
                    {*<----------  @BWLAB*}
                    <td width="10%" style="background-color:#999999;color:#ffffff;font-size:10pt">
                        <b> {l s='Price' mod='cartopdf'}</b></td>
                    <td width="10%" style="background-color:#999999;color:#ffffff;font-size:10pt">
                        <b> {l s='Items' mod='cartopdf'}</b></td>
                    <td width="15%" style="background-color:#999999;color:#ffffff;font-size:10pt">
                        <b> {l s='Total' mod='cartopdf'}</b></td>
                    {*---------->  @BWLAB*}
                    <td width="10%" style="background-color:#999999;color:#ffffff;font-size:10pt"><b>
                            {l s='Conai' mod='cartopdf'}</b></td>
                    <td width="10%" style="background-color:#999999;color:#ffffff;font-size:10pt">
                        <b> {l s='Cliche' mod='cartopdf'}</b></td>
                    {*<----------  @BWLAB*}

                </tr>

                {if isset($products) && $products|@count > 0}
                    {foreach from=$products item=product}
                        {cycle values='#FFF,#d7d9d7' assign=bgcolor}
                        <tr style="background-color:{$bgcolor|escape:'htmlall':'UTF-8'}">
                            <td style="font-size:7pt;text-align: center"> {$product.reference|escape:'htmlall':'UTF-8'}</td>
                            <td style="font-size:9pt">
                                {if isset($product.name) && $product.name}
                                    {$product.name|escape:'htmlall':'UTF-8'}
                                {elseif isset($product.product_name) && $product.product_name}
                                    {$product.product_name|escape:'htmlall':'UTF-8'}

                                {/if}
                                {if isset($product.attributes_small) && $product.attributes_small}
                                    <br/>
                                    {$product.attributes_small}
                                {/if}
                        {*--> ticket #580  *}
                                <br>{widget name='bwdisplaydata' hook="fetchCaratteristica" id_product=$product.id_product id_feature=33}
                                {*<-- ticket #580  *}
                            </td>
                            {*---------->  @BWLAB*}
                            <td style="font-size:9pt;text-align: center">{if $product.pezzi_per_cartone}{$product.pezzi_per_cartone}{else}0{/if}</td>
                            {*<----------  @BWLAB*}
                            <td style="font-size:9pt;text-align: center"> {round($product.price_with_reduction_without_tax,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                            <td style="font-size:9pt;text-align: center"> {$product.product_quantity|escape:'htmlall':'UTF-8'}</td>
                            <td style="font-size:9pt;text-align: center"> {round($product.total,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                            {*---------->  @BWLAB*}
                            <td style="font-size:9pt;text-align: center">
                                {round($additional_cost_prducts_by_reference[$product.reference]['subtotals']['conai']['amount'],2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'}
                                {$sign|escape:'htmlall':'UTF-8'}
                            </td>
                            <td style="font-size:9pt;text-align: center">
                                {round($additional_cost_prducts_by_reference[$product.reference]['subtotals']['cliche']['amount'],2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'}
                                {$sign|escape:'htmlall':'UTF-8'}
                            </td>
                            {*<----------  @BWLAB*}

                        </tr>
                    {/foreach}
                {/if}
            </table>
            <div>&nbsp;</div>
            {if $total_dto > 0 }
                <div style="width:100%;float:right;">
                    <table style="width:100%">
                        <tr>
                            <td width="50%">&nbsp;</td>
                            <td>
                                <table border="1" style="border-color:#444; width:100%;">
                                    <tr>
                                        <td colspan="2"
                                            style="background-color:#999999;color:#ffffff;font-size:12pt;padding:5;text-align:center">
                                            <b>{l s='Discounts' mod='cartopdf'}</b></td>
                                    </tr>
                                    {foreach from=$dtos item=d}
                                        <tr>
                                            <td width="70%"
                                                style="font-size:9pt"> {$d.name|escape:'htmlall':'UTF-8'}</td>
                                            <td width="30%"
                                                style="font-size:9pt"> {round($d.value,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        </tr>
                                    {/foreach}
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            {/if}
            <div>
                <table style="width:100%">
                    <tr>
                        <td width="40%">&nbsp;</td>
                        <td width="60%">
                            <table width="100%" cellpadding="7" border="0">
                                <tr>
                                    <td style="background-color:#F2F2F2;;color:#444;font-size:14pt;padding:5;">{l s='Summary' mod='cartopdf'}</td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="7" border="1" style="border-color:#444444;">
                                {if isset($CtoPDF_no_show_taxes) && $CtoPDF_no_show_taxes}
                                    <tr>
                                        <td width="70%"
                                            style="font-size:9pt"> {l s='Products (taxes excl.)' mod='cartopdf'}</td>
                                        {if isset($order) && isset($order->total_products)}
                                            <td width="30%"
                                                style="font-size:9pt"> {round($order->total_products,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {else}
                                            <td width="30%"
                                                style="font-size:9pt"> {round($cart->getOrderTotal(false,Cart::ONLY_PRODUCTS),2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {/if}
                                    </tr>
                                {/if}
                                {*                                <tr>*}
                                {*                                    <td width="70%" style="font-size:9pt"> {lv s='Products (taxes incl.)'
                                                                                      mod='cartopdf'}</td>*}
                                {*                                    {if isset($order) && isset($order->total_products_wt)}*}
                                {*                                        <td width="30%" style="font-size:9pt"> {round($order->total_products_wt,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>*}
                                {*                                    {else}*}
                                {*                                        <td width="30%" style="font-size:9pt"> {round($cart->getOrderTotal(true,Cart::ONLY_PRODUCTS),2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>*}
                                {*                                    {/if}*}
                                {*                                </tr>*}
                                {*----------> @BWLAB*}
                                <tr>
                                    <td width="70%" style="font-size:9pt"> {l s='Cliche'
                                        mod='cartopdf'}</td>
                                    <td width="30%" style="font-size:9pt">
                                        {round($additional_cost_totals['cliche']['amount'],2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'}
                                        {$sign|escape:'htmlall':'UTF-8'}
                                    </td>
                                </tr>
                                <tr>
                                    <td width="70%" style="font-size:9pt"> {l s='Conai'
                                        mod='cartopdf'}</td>
                                    <td width="30%" style="font-size:9pt"> {round
                                        ($additional_cost_totals['conai']['amount'],2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                </tr>
                                {*<---------- @BWLAB*}
                                {if isset($CtoPDF_no_show_taxes) && $CtoPDF_no_show_taxes}
                                    <tr>
                                        <td width="70%"
                                            style="font-size:9pt"> {l s='Shipping (taxes excl.)' mod='cartopdf'}</td>
                                        {if isset($order) && isset($order->total_shipping_tax_excl)}
                                            <td width="30%"
                                                style="font-size:9pt"> {round($order->total_shipping_tax_excl,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {else}
                                            <td width="30%"
                                                style="font-size:9pt"> {round($cart->getOrderTotal(false,Cart::ONLY_SHIPPING),2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {/if}
                                    </tr>
                                {/if}
                                {*                                <tr>*}
                                {*                                    <td width="70%" style="font-size:9pt"> {l s='Shipping (taxes incl.)' mod='cartopdf'}</td>*}
                                {*                                    {if isset($order) && isset($order->total_shipping_tax_incl)}*}
                                {*                                        <td width="30%" style="font-size:9pt"> {round($order->total_shipping_tax_incl,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>*}
                                {*                                    {else}*}
                                {*                                        <td width="30%" style="font-size:9pt"> {round($cart->getOrderTotal(true,Cart::ONLY_SHIPPING),2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>*}
                                {*                                    {/if}*}
                                {*                                </tr>*}

                                <tr>
                                    <td width="70%"
                                        style="font-size:9pt"> {l s='Discounts' mod='cartopdf'} {if isset($order) && isset($order->total_paid_tax_excl)}{l s='(taxes excl.)' mod='cartopdf'}{/if}</td>
                                    {if isset($order) && isset($order->total_discounts_tax_excl)}
                                        <td width="30%" style="font-size:9pt">
                                            -{round($order->total_discounts_tax_excl,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                    {else}
                                        <td width="30%" style="font-size:9pt">
                                            -{round($total_dto,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                    {/if}
                                </tr>
                                {if isset($CtoPDF_no_show_taxes) && $CtoPDF_no_show_taxes}
                                    <tr>
                                        <td width="70%" style="font-size:9pt"> {l s='Subtotale' mod='cartopdf'}</td>
                                        {if isset($order) && isset($order->total_paid_tax_excl)}
                                            <td width="30%"
                                                style="font-size:9pt"> {round($order->total_paid_tax_excl,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {else}
                                            {*                                            <td width="30%" style="font-size:9pt"> {round($cart->getTotalPrice(false,*}
                                            {*                                                Cart::ONLY_PRODUCTS) + $cart->getOrderTotal(false,Cart::ONLY_SHIPPING) - $total_dto,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>*}
                                            <td width="30%"
                                                style="font-size:9pt"> {round($cart->getCartTotalPrice(),2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {/if}
                                    </tr>
                                    <tr>
                                        <td width="70%" style="font-size:9pt"> {l s='Taxes' mod='cartopdf'}</td>
                                        {if isset($order) && isset($order->total_paid_tax_incl) && isset($order->total_paid_tax_excl)}
                                            <td width="30%"
                                                style="font-size:9pt"> {round($order->total_paid_tax_incl - $order->total_paid_tax_excl,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {else}
                                            <td width="30%"
                                                style="font-size:9pt"> {round(($cart->getOrderTotal() - $cart->getCartTotalPrice()),2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</td>
                                        {/if}
                                    </tr>
                                {/if}
                                <tr>
                                    <td width="70%"
                                        style="background-color:#444;color:#ffffff;font-size:14pt;padding:7pt;">
                                        <b>{l s='TOTAL' mod='cartopdf'} {if isset($CtoPDF_no_show_taxes) && $CtoPDF_no_show_taxes}{l s='(taxes incl.)' mod='cartopdf'}{else}{l s='(taxes excl.)' mod='cartopdf'}{/if}</b>
                                    </td>
                                    {if isset($order) && isset($order->total_paid) && isset($order->total_paid_tax_excl)}
                                        {if isset($CtoPDF_no_show_taxes) && $CtoPDF_no_show_taxes}
                                            <td width="30%"
                                                style="background-color:#444;color:#ffffff;font-size:14pt;padding:7;">
                                                <b>{round($order->total_paid,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</b>
                                            </td>
                                        {else}
                                            <td width="30%"
                                                style="background-color:#444;color:#ffffff;font-size:14pt;padding:7;">
                                                <b>{round($order->total_paid_tax_excl,2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</b>
                                            </td>
                                        {/if}
                                    {else}
                                        <td width="30%"
                                            style="background-color:#444;color:#ffffff;font-size:14pt;padding:7;">
                                            <b>{round($cart->getOrderTotal() - $total_dto + $cart->getOrderTotal(true,Cart::ONLY_DISCOUNTS),2)|string_format:"%.2f"|escape:'htmlall':'UTF-8'} {$sign|escape:'htmlall':'UTF-8'}</b>
                                        </td>
                                    {/if}
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <h1 align="left">&nbsp;</h1>
            {if isset($CtoPDF_pie) && $CtoPDF_pie != ''}
                <p align="center">{$CtoPDF_pie|escape:'htmlall':'UTF-8'}</p>
            {/if}
        </td>
    </tr>
</table>