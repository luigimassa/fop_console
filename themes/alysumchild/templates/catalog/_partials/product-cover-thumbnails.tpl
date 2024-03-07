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

<div class="images-container flex-container" id="product-images-cont">
  {assign var="pkconf" value=unserialize(Configuration::get('PKTHEME_CONFIG')|html_entity_decode)}

  {if (isset(Configuration::get('pp_builder_thumbs')) && (Configuration::get('pp_builder_thumbs') != 1) && !isset($isQuickView) )}

    {if (count($product.images)) >= 1}

      <div class="pk-carousel relative pp-img-carousel" data-desktopnum="1" data-tabletnum="1" data-phonenum="1" data-loop="1" data-autoplay="0" data-navwrap="0">
        {foreach from=$product.images item=image}
          <div class="thumb-container">
            <img data-image-medium-src="{$image.bySize.large_default.url}"
                 data-image-large-src="{$image.bySize.large_default.url}"
                 src="{$image.bySize.large_default.url}"
                 alt="{$image.legend}"
                 title="{$image.legend}"
                 width="100%">
          </div>
        {/foreach}
      </div>

    {/if}

  {else}

    {if (count($product.images)) > 1}
      {block name='product_images'}
        <div class="js-qv-mask js-vCarousel mask relative thumb-carousel scroll-box-arrows">
          <ul class="product-images js-qv-product-images js-vCarousel-list flex-container">
            {foreach from=$product.images item=image}
              <li class="thumb-container">
                <img
                        class="thumb js-thumb smooth02{if $image.id_image == $product.default_image.id_image} selected{/if}"
                        data-image-medium-src="{$image.bySize.large_default.url}"
                        data-image-large-src="{$image.bySize.large_default.url}"
                        src="{$image.bySize.home_default.url}"
                        alt="{$image.legend}"
                        title="{$image.legend}"
                        width="100"
                >
              </li>
            {/foreach}
          </ul>

          <i class="up"><svg class="svgic"><use xlink:href="#si-top-arrow-thin"></use></svg></i>
          <i class="down"><svg class="svgic"><use xlink:href="#si-bottom-arrow-thin"></use></svg></i>

        </div>
      {/block}
    {/if}

    {block name='product_cover'}
      {hook h="displayProductPageCss" product=$product}
      {if $product.default_image}
        <div class="product-cover{if (count($product.images)) <= 1} thumbs-exist{/if}">
          <div class="prod-image-zoom smooth500" data-width="{$product.default_image.bySize.large_default.width/2}" data-height="{$product.default_image.bySize.large_default.height/2}">
            <img class="js-qv-product-cover" src="{$product.default_image.bySize.large_default.url}" alt="{$product.default_image.legend}" title="{$product.default_image.legend}">
          </div>
          {if (isset($pkconf.pp_innnerzoom) && $pkconf.pp_innnerzoom == false) || !isset($pkconf.pp_innnerzoom)}
            <div class="layer smooth05 hidden-sm-down" data-toggle="modal" data-target="#product-modal">
              <svg class="svgic svgic-search"><use xlink:href="#si-search"></use></svg>
            </div>
          {/if}
          {if (isset($pkconf.pp_countdown) && $pkconf.pp_countdown == true) || !isset($pkconf.pp_countdown)}
            {include file='catalog/_partials/miniatures/countdown.tpl'}
          {/if}
        </div>
      {else}
        <div class="pkimg"><img src="{$urls.no_picture_image.bySize.home_default.url}" class="pkimg" width="300" height="300" /></div>
      {/if}
    {/block}

  {/if}

</div>
{hook h='displayAfterProductThumbs'}
