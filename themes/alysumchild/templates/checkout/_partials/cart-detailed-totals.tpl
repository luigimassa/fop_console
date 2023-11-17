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
{block name='cart_detailed_totals'}
  <div class="cart-detailed-totals">

    <div class="card-block card-separator">
      {foreach from=$cart.subtotals item="subtotal"}
        {if $subtotal == null}{continue}{/if}
        {if $subtotal.value && $subtotal.type !== 'tax'}
          <div class="cart-summary-line" id="cart-subtotal-{$subtotal.type}">
            <div class="cart-icon">
              <svg class="svgic svgic-down">
                <use xlink:href="#op-{$subtotal.type}"></use>
              </svg>
            </div>

            <div class="cart-values">
              <div class="label{if 'products' === $subtotal.type} js-subtotal{/if}">
                {if 'products' == $subtotal.type}
                  {$cart.summary_string}
                {else}
                  {$subtotal.label}
                {/if}
              </div>

              <div class="value">
                {if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}
              </div>

              {if $subtotal.type === 'shipping'}
                <div><small class="value">{hook h='displayCheckoutSubtotalDetails' subtotal=$subtotal}</small></div>
              {/if}
            </div>
          </div>
        {/if}
      {/foreach}

      <!--div class="cart-summary-line id="cart-shipping">
      <div class="cart-icon">
        <svg class="svgic svgic-down">
          <use xlink:href="#op-utente"></use>
        </svg>
      </div>

      <div class="cart-values">
        <div class="label sub">{$cart.subtotals.shipping.label}</div>
        <div class="value sub">{$cart.subtotals.shipping.value}</div>
      </div>
    </div-->
    </div>

    {block name='cart_summary_totals'}
      {include file='checkout/_partials/cart-summary-totals.tpl' cart=$cart}
    {/block}

    {block name='cart_voucher'}
      {include file='checkout/_partials/cart-voucher.tpl'}
    {/block}

  </div>
{/block}