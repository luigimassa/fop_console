{**
 * 2007-2016 PrestaShop
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
 * @copyright 2007-2016 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{assign var="type" value='cart_default'}
{if isset($image_size)}
    {assign var="type" value=$image_size}
{/if}

<article class="mini-product" data-id-product="{$product.id_product}"
         data-id-product-attribute="{$product.id_product_attribute}">

    <div class="thumbnail-container relative">

        <div class="thumbnail product-thumbnail relative">

            {block name='product_thumbnail'}
                <a href="{$product.url}" class="relative">
                    {if $product.default_image}
                        {include file='catalog/_partials/product-image.tpl' image=$product.default_image type=$type}
                    {else}
                        <img src="{$urls.no_picture_image.bySize.medium_default.url}" class="w100" width="300"
                             height="300"/>
                    {/if}
                </a>
            {/block}

        </div>

        <div class="product-description">

            {if isset($product.id_manufacturer)}
                {block name='product_manufacturer'}
                    <span class="product-brand ellipsis">{Manufacturer::getNameById($product.id_manufacturer)}</span>
                {/block}
            {/if}

            {block name='product_name'}
                <h2 class="product-title"><a class="ellipsis" href="{$product.url}">{$product.name}</a></h2>
            {/block}

            {if $product.show_price}
                {block name='product_price_and_shipping'}
                    <div class="product-price-and-shipping">
                        {if $product.has_discount}

                            {hook h='displayProductPriceBlock' product=$product type="old_price"}
                            <span class="regular-price">{$product.regular_price}</span>
                            {if $product.discount_type === 'percentage'}
                                {if (isset($product.discount_percentage))}
                                    <span class="discount-percentage">{$product.discount_percentage}</span>
                                {/if}
                            {elseif $product.discount_type === 'amount'}
                                {if (isset($product.discount_amount_to_display))}
                                    <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                                {/if}
                            {/if}

                        {/if}

                        <span class="price">
              {if $product.price_amount != 0}
                  {if isset($product.cart_quantity) && isset($product.total)}
                      {if $product.cart_quantity > 1}
                          <span>({$product.cart_quantity} &#215; {$product.price})</span>
                          {$product.total}

                      {else}
                          {$product.total}
                      {/if}
                {else}



                      <span>
                    {$product.price}
                  </span>
                  {/if}

              {else}
                {hook h='displayProductPriceBlock' product=$product type="before_price"}

                  <span>{$product.price}</span>
                  {hook h='displayProductPriceBlock' product=$product type='unit_price'}
                  {hook h='displayProductPriceBlock' product=$product type='weight'}

              {/if}
            </span>
                        {*--> ticket #506*}
                        <span class="caratteristica">
                {widget name="bwdisplaydata" hook="costoUnitario" product=$product}
                  </span>
                        {* #506 <---  *}
                        {*--> ticket #589              *}
                        <span class="caratteristica">
              {widget name='bwdisplaydata' hook="fetchCaratteristica" id_product=$product.id_product id_feature=33}
                  </span>
                        {* #589 <---  *}
                    </div>
                {/block}
            {/if}

            {if !isset($product.light_list) && isset($product.remove_from_cart_url) && (isset($page.page_name) && $page.page_name != 'checkout')}
                <a class="remove-from-cart remove-product" rel="nofollow" href="{$product.remove_from_cart_url}"
                   data-link-action="delete-from-cart" data-id-product="1" data-id-product-attribute="1"
                   data-id-customization=""
                   title="{l s='Remove from cart' d='Shop.Theme.Actions'}">
                    <svg class="svgic svgic-down">
                        <use xlink:href="#si-cross-thin"></use>
                    </svg>
                </a>
            {/if}

        </div>

    </div>

</article>