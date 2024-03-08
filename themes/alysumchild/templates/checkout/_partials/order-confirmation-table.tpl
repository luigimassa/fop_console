{**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
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
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<div id="order-items" class="col-md-7">
    <div class="order-items-inner">
        {block name='order_details'}
            {if isset($order) and $order}
                <div id="order-details">
                    <div class="order-details-wrapper">
                        <div class="order-details-space">
                            <h3 class="h3 card-title">
                                {l s='<span>Order reference</span> %reference%' d='Shop.Theme.Checkout' sprintf=['%reference%' => $order.details.reference]}
                            </h3>
                            <p>{l s='Payment method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.details.payment]}
                            </p>
                            {if !$order.details.is_virtual}
                                <p>{l s='Shipping method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.carrier.name]}
                                </p>
                            {/if}
                            <p>{l s='%method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.carrier.delay]}</p>
                        </div>
                    </div>
                </div>
            {/if}
        {/block}

        {block name='order_items_table_head'}
            <h3 class="card-title h3">{l s='Order items' d='Shop.Theme.Checkout'}</h3>
        {/block}

        <div class="order-confirmation-table">
            {block name='order_confirmation_table'}
                {foreach from=$products item=product}

                    <div class="order-line row">
                        <div class="col-sm-2 col-xs-3">
                            <span class="image">
                                {if $product.cover}
                                    <img src="{$product.cover.medium.url}" />
                                {else}
                                    <img src="{$urls.no_picture_image.bySize.medium_default.url}" />
                                {/if}
                            </span>
                        </div>
                        <div class="col-sm-4 col-xs-9 details">
                            {if $add_product_link}<a href="{$product.url}" target="_blank">{/if}
                                <span>{$product.name}</span>
                                {* @bwlab Ticket #589 - aggiunta tolleranza di produzione *}
                                <br>
                                {widget name="bwdisplaydata" hook="fetchCaratteristica" id_feature="2000" id_product=$product["id_product"]}
                                {* <---- @bwlab *}
                                {if $add_product_link}</a>{/if}
                            {if $product.customizations|count}
                                {foreach from=$product.customizations item="customization"}
                                    <div class="customizations">
                                        <a href="#" data-toggle="modal"
                                            data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                                    </div>

                                    <div class="modal fade customization-modal"
                                        id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog"
                                        aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                    <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                                                </div>
                                                <div class="modal-body">
                                                    {foreach from=$customization.fields item="field"}
                                                        <div class="product-customization-line row">
                                                            <div class="col-sm-3 col-xs-4 label">
                                                                {$field.label}
                                                            </div>
                                                            <div class="col-sm-9 col-xs-8 value">
                                                                {if $field.type == 'text'}
                                                                    {if (int)$field.id_module}
                                                                        {$field.text nofilter}
                                                                    {else}
                                                                        {$field.text}
                                                                    {/if}
                                                                {elseif $field.type == 'image'}
                                                                    <img src="{$field.image.small.url}">
                                                                {/if}
                                                            </div>
                                                        </div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}
                            {hook h='displayProductPriceBlock' product=$product type="unit_price"}
                        </div>
                        <div class="col-sm-6 col-xs-12 qty">
                            <div class="row">
                                <div class="col-xs-5 text-sm-right text-xs-left">{$product.price}</div>
                                <div class="col-xs-2">{$product.quantity}</div>
                                <div class="col-xs-5 text-xs-right bold">{$product.total}</div>
                            </div>
                        </div>
                    </div>
                {/foreach}

                <hr>

                <table>
                    {foreach $subtotals as $subtotal}
                        {if $subtotal !== null && $subtotal.type !== 'tax' && $subtotal.label !== null}
                            <tr>
                                <td>{$subtotal.label}</td>
                                <td>{if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}</td>
                            </tr>
                        {/if}
                    {/foreach}
                    {widget name='bwconai' products=$products}
                    {widget name='bwcliche' products=$products}
                    {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
                        <tr>
                            <td>{$totals.total.label}&nbsp;{$labels.tax_short}</td>
                            <td>{$totals.total.value}</td>
                        </tr>
                        <tr class="total-value font-weight-bold">
                            <td>{$totals.total_including_tax.label}</td>
                            <td>{$totals.total_including_tax.value}</td>
                        </tr>
                    {else}
                        <tr class="total-value font-weight-bold">
                            <td><span
                                    class="text-uppercase">{$totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$labels.tax_short}{/if}</span>
                            </td>
                            <td>{$totals.total.value}</td>
                        </tr>
                    {/if}
                    {if $subtotals.tax !== null && $subtotals.tax.label !== null}
                        <tr class="sub taxes">
                            <td colspan="2"><span
                                    class="label">{l s='%label%:' sprintf=['%label%' => $subtotals.tax.label] d='Shop.Theme.Global'}</span>&nbsp;<span
                                    class="value">{$subtotals.tax.value}</span></td>
                        </tr>
                    {/if}
                </table>
            {/block}
        </div>
    </div>
</div>