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

{if isset($product.product_settings)}
    {assign var="pp" value=$product.product_settings}
{/if}
{assign var="pkconf" value=unserialize(Configuration::get('PKTHEME_CONFIG')|html_entity_decode)}
{assign var="pka_manufacturer" value=Manufacturer::getNameById($product.id_manufacturer)}

{assign var="type" value='home_default'}
{assign var="hover_num" value='3'}
{if isset($image_size)}
    {assign var="type" value=$image_size}
{else}
    {if isset($pkconf.pm_image_type)}
        {assign var="type" value=$pkconf.pm_image_type}
    {/if}
    {if isset($pkconf.pm_hover_image)}
        {assign var="hover_num" value=3}
        {if isset($pkconf.pm_hover_image_number)}
            {assign var="hover_num" value=$pkconf.pm_hover_image_number}
        {/if}
    {/if}
{/if}

{block name='product_miniature_item'}
    <article
            class="product-miniature js-product-miniature{if $product.quantity == 0} out-of-stock{/if}{if (isset($product.new) && $product.new == 1)} new{/if}{if (isset($product.bestseller) && ($product.bestseller == 1))} bestsellers{/if}{if (isset($product.featured) && $product.featured == 1)} featured{/if}{if (isset($product.reduction) && $product.reduction > 0)} discount{/if}{if isset($product.all_cats)} {$product.all_cats}{else}{if isset($product.category)} {$product.category}{/if}{/if}"
            data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">

        <div class="thumbnail-container relative">
            <div class="thumbnail product-thumbnail relative flex-container">
                {block name='product_thumbnail'}
                    {if $product.cover}
                        <a href="{$product.url}"
                           class="relative oh{if $pkconf.pm_hover_image}{foreach from=$product.images item=image}{if (($image.cover != 1) && ($product.cover.id_image != $image.id_image))} subimage-true{break}{/if}{/foreach}{/if}">
                            {if $product.cover}
                                {include file='catalog/_partials/product-image.tpl' image=$product.cover type=$type}
                                {if $pkconf.pm_hover_image}
                                    {assign var=counter value=1}
                                    {foreach from=$product.images item=image name=images}
                                        {if ($image.cover != 1) && ($counter < $hover_num)}
                                            {include file='catalog/_partials/product-image.tpl' image=$image type=$type}
                                            {assign var=counter value=$counter+1}
                                        {/if}
                                    {/foreach}
                                    <span class="pmimage-switcher flex-container">
                    <span></span>
                    {assign var=counter value=1}
                                        {foreach from=$product.images item=image name=images}
                                            {if ($image.cover != 1) && ($counter < $hover_num)}
                                                <span></span>
                                                {assign var=counter value=$counter+1}
                                            {/if}
                                        {/foreach}
                  </span>
                                {/if}
                            {/if}
                            <span></span>
                        </a>
                    {else}
                        <a href="{$product.url}" class="relative">
                            <img src="{$urls.no_picture_image.bySize.home_default.url}" class="w100" width="300"
                                 height="300"/>
                        </a>
                    {/if}
                {/block}

                {block name='product_buy'}
                    <div class="product-actions">

                        {if $pkconf.pm_qw_button}
                            <a href="#" class="quick-view btn btn-primary smooth05" data-link-action="quickview"
                               title="{l s='Quick view' d='Shop.Theme.Actions'}"
                               aria-label="{l s='Quick view' d='Shop.Theme.Actions'}"
                               role="button">
                                <svg class="svgic svgic-search">
                                    <use xlink:href="#si-search"></use>
                                </svg>
                            </a>
                        {/if}

                        {if $pkconf.pm_atc_button && (isset($page.page_name) && $page.page_name != 'product')}
                            {if (($product.quantity > 0) && ($product.available_for_order == 1) && ($product.customizable == 0) && !$configuration.is_catalog) || $product.add_to_cart_url}

                                {if ( ((Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY') == 1) && (!empty($product.main_variants))) || (Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY') == 1 || empty($product.main_variants)) )}
                                    <form action="{$urls.pages.cart}" method="post" class="add-to-cart-or-refresh">
                                        <input type="hidden" name="token"
                                               value="{if (isset($static_token))}{$static_token}{/if}">
                                        <input type="hidden" name="id_product" value="{$product.id}"
                                               class="product_page_product_id">
                                        <input type="hidden" name="id_product_attribute"
                                               class="product_page_product_attribute_id"
                                               value="{$product.id_product_attribute}">
                                        <input type="hidden" name="qty"
                                               value="{if (isset($product.minimal_quantity) && $product.minimal_quantity > 0)}{$product.minimal_quantity}{else}1{/if}">
                                        {* <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id"> *}
                                        {block name='product_add_to_cart'}
                                            {include file='catalog/_partials/product-add-to-cart-mini.tpl'}
                                        {/block}
                                    </form>
                                {/if}
                            {else}
                                <a href="{$product.url}" class="btn smooth05"
                                   title="{l s='View Product' d='Shop.Theme.Actions'}"
                                   aria-label="{l s='View Product' d='Shop.Theme.Actions'}" role="button">
                                    <svg class="svgic svgic-button-cart">
                                        <use xlink:href="#si-eye2"></use>
                                    </svg>
                                </a>
                            {/if}
                        {/if}

                        {hook h='displayProductButton' product_id=$product.id}

                    </div>
                {/block}

                {if $pkconf.pm_countdown}
                    {include file='catalog/_partials/miniatures/countdown.tpl'}
                {/if}

            </div>

            <div class="product-desc-wrap">

                <div class="product-description relative clearfix">

                    {if $pkconf.pm_brand}
                        {if $pka_manufacturer && isset($link)}
                            {block name='product_manufacturer'}
                                <span class="product-brand ellipsis text-left">
                  <a href="{$link->getManufacturerLink($product.id_manufacturer)}">{$pka_manufacturer}</a>
                </span>
                            {/block}
                        {/if}
                    {/if}

                    {if $pkconf.pm_title}
                        {block name='product_name'}
                            <h2 class="product-title text-left{if !$pkconf.pm_title_multiline} ellipsis{/if}">
                                <a href="{$product.url}">{if (is_array($product.name))}{$product.name.1}{else}{$product.name}{/if}</a>
                            </h2>
                        {/block}
                    {/if}

                    {if $pkconf.pm_price && Configuration::showPrices() == true}
                        {block name='product_price_and_shipping'}

                            {if $product.show_price}
                                <div class="product-price-and-shipping">
                                    {* @bwlab --> Ticket #588 -mostrare quantità minima *}
                                    {* richiesta ggiuntiva per nascondere                                    *}
{*                                    {if $product.has_discount}*}

{*                                        {hook h='displayProductPriceBlock' product=$product type="old_price"}*}
{*                                        <span class="regular-price">{$product.regular_price}</span>*}
{*                                        {if $product.discount_type === 'percentage'}*}
{*                                            {if (isset($product.discount_percentage))}*}
{*                                                <span class="discount-percentage discount-product">{$product.discount_percentage}</span>*}
{*                                            {/if}*}
{*                                        {elseif $product.discount_type === 'amount'}*}
{*                                            {if (isset($product.discount_amount_to_display))}*}
{*                                                <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>*}
{*                                            {/if}*}
{*                                        {/if}*}

{*                                    {/if}*}
                                    {* @bwlab --> Ticket #588 -mostrare quantità minima *}
                                    {*  {hook h='displayProductPriceBlock' product=$product type="before_price"}*}
                                    {* @bwlab <----- *}
                                    {* @bwlab -----> *}
                                    {* richiesta chat del 07.03.24 disattivato Ticket #588*}
                                    {* modifica per mostrare il prezzo più basso - vedi modulo oleafquantityprices - override del modulo e template *}
                                    {* <span class="price" content="{$product.price_amount}">{$product.price}</span> *}
                                    {* {hook h='displayProductPriceBlock' product=$product type='unit_price'} *}
                                    {* {hook h='displayProductPriceBlock' product=$product type='unit_price' product=$product}*}

                                    {* Ticket #588 -mostrare quantità minima *}
                                    {*                                    <span class="packaging-row-minimal-quantity">&nbsp;{l s='Minimal quantity' d='Shop.Theme.Packaging'}&nbsp; <span class="packaging-minimal-quantity">{$product.minimal_quantity}</span></span>*}
                                    {l s="Quantità minima" d="Shop.Theme.Packaging"}
                                    {widget name='bwdisplaydata' hook="prodottoQtaMinima"
                                    caratteristiche_prodotto=$product.features
                                    id_feature=7
                                    quantita_minima=$product.minimal_quantity
                                    }
                                    &nbsp;
                                    {assign var=unita_di_misura value=Bwdisplaydata::getCaratteristica($product.id, 37)}
                                    {if null !== $unita_di_misura}
                                        {$unita_di_misura.value}
                                    {/if}
                                    {* richiesta chat del 07.03.24 disattivato*}
                                    {* bwlab <-------- *}

                                    {hook h='displayProductPriceBlock' product=$product type='weight'}

                                </div>
                            {/if}
                        {/block}
                    {/if}

                    {block name='product_description_short'}
                        <div
                                class="short-desc product-description-short{if !$pkconf.pm_desc} pm_desk_false{/if}{if $pkconf.pm_desc || $pktheme.cp_listing_view == 'list'} shown{else} hidden{/if}">
                            {$product.description_short nofilter}
                        </div>
                    {/block}

                    {capture name='displayProductListReviews'}{hook h='displayProductListReviews' product=$product}{/capture}
                    {if $smarty.capture.displayProductListReviews}
                        <div class="hook-reviews{if !$pkconf.pm_stars} hide-reviews{/if}">
                            {hook h='displayProductListReviews' product=$product scheme='1'}
                        </div>
                    {/if}

                </div>

                {if $pkconf.pm_labels}
                    {block name='product_flags'}
                        <ul class="product-flags">
                            {foreach from=$product.flags item=flag}
                                <li class="{$flag.type}">{$flag.label}</li>
                            {/foreach}
                            {if $product.has_discount}
                                {if $product.discount_type === 'percentage'}
                                    {if !empty($product.discount_percentage)}
                                        <li class="discount-perc">{$product.discount_percentage}</li>
                                    {/if}
                                {else}
                                    {if !empty($product.discount_amount_to_display)}
                                        <li class="discount-perc">{$product.discount_amount_to_display}</li>
                                    {/if}
                                {/if}
                            {/if}
                        </ul>
                    {/block}
                {/if}

                {if $pkconf.pm_colors}
                    <div class="highlighted-informations{if !$product.main_variants} no-variants{/if}">
                        {block name='product_variants'}
                            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                        {/block}
                    </div>
                {/if}

            </div>

            <div class="displayProductButtonFixed hide-empty">{strip}
                    {hook h='displayProductButtonFixed' product_id=$product.id}
                {/strip}</div>

        </div>

    </article>
{/block}