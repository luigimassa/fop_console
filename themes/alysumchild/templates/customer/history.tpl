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
{extends file='customer/page.tpl'}

{block name='page_header_container'}
  {block name='page_title'}
    <div class="row">
      <div class="container menucontainer" style="text-align:center; padding: 10px;">
        <div class="col-xs-12">
          {include file='customer/my-account-menu.tpl'}
        </div>
      </div>
    </div>

    <header class="page-header">
      <h1>{l s='Order history' d='Shop.Theme.Customeraccount'}</h1>
    </header>
  {/block}
{/block}

{block name='page_content'}
  <p>{l s='Here are the orders you\'ve placed since your account was created.' d='Shop.Theme.Customeraccount'}</p>
  <div class="container op_orders_wrapper">
    {if $orders}
      <table class="table op_table_orders hidden-sm-down">
        <thead class="thead-default">
          <tr>
            {* @bwlab --> modiricato da reference a ID *}
            <th>{l s='Order ID' d='Shop.Theme.Checkout'}</th>
            <th>{l s='Date' d='Shop.Theme.Global'}</th>
            <th>{l s='Total price' d='Shop.Theme.Checkout'}</th>
            <th class="hidden-md-down">{l s='Payment' d='Shop.Theme.Checkout'}</th>
            <th class="hidden-md-down">{l s='Status' d='Shop.Theme.Global'}</th>
            <th>{l s='Invoice' d='Shop.Theme.Checkout'}</th>
            <th>&nbsp;</th>
          </tr>
        </thead>
        <tbody>
          {foreach from=$orders item=order}
            <tr>
              {* Bwlab ---> modificato da reference a ID *}
              <th scope="row">{$order.details.id}</th>
              <td>{$order.details.order_date}</td>
              <td class="">{$order.totals.total_including_tax.value}</td>
              <td class="hidden-md-down">{$order.details.payment}</td>
              <td class="order-state">
                <span class="label label-pill {$order.history.current.contrast}"
                  style="background-color:{$order.history.current.color}">
                  {$order.history.current.ostate_name}
                </span>
              </td>
              <td class="text-xs-center hidden-md-down">
                {if $order.details.invoice_url}
                  <a class="db" href="{$order.details.invoice_url}"><svg class="svgic">
                      <use xlink:href="#si-file"></use>
                    </svg></a>
                {else}
                  -
                {/if}
              </td>
              <td class="text-xs-center order-actions">
                <a href="{$order.details.details_url}" data-link-action="view-order-details">
                  {l s='Details' d='Shop.Theme.Customeraccount'}
                </a>
              </td>
            </tr>
          {/foreach}
        </tbody>
      </table>

      <div class="orders hidden-md-up">
        {foreach from=$orders item=order}
          <div class="order">
            <div class="row">
              <div class="col-xs-10">
                <a href="{$order.details.details_url}">
                  <h3>{$order.details.reference}</h3>
                </a>
                <div class="date">{$order.details.order_date}</div>
                <div class="total">{$order.totals.total.value}</div>
                <div class="status">
                  <span class="label label-pill {$order.history.current.contrast}"
                    style="background-color:{$order.history.current.color}">
                    {$order.history.current.ostate_name}
                  </span>
                </div>
              </div>
              <div class="col-xs-2 text-xs-right">
                <div>
                  <a href="{$order.details.details_url}" data-link-action="view-order-details"
                    title="{l s='Details' d='Shop.Theme.Customeraccount'}">
                    <svg class="svgic">
                      <use xlink:href="#si-file3"></use>
                    </svg>
                  </a>
                </div>
                {* @Bwlab --> riordina eliminato come da richiesta *}
                {* {if $order.details.reorder_url}
                  <div>
                    <a href="{$order.details.reorder_url}" title="{l s='Reorder' d='Shop.Theme.Actions'}">
                      <svg class="svgic">
                        <use xlink:href="#si-compare"></use>
                      </svg>
                    </a>
                  </div>
                {/if} *}
                {* <---- @bwlb *}
              </div>
            </div>
          </div>
        {/foreach}
      </div>

    {/if}
  </div>
{/block}