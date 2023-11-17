{**
 * 2007-2017 PrestaShop
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
 * @copyright 2007-2017 PrestaShop SA
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
      <h1>
        {* @bwlab ---> modificato reference in ID ordine *}
        {l s='Dettagli ordine n. %reference%' d='Shop.Theme.Customeraccount' sprintf=['%reference%' => $order.details.id]}
      </h1>
    </header>
  {/block}
{/block}

{block name='page_content'}
  {block name='order_infos'}
    <div class="order-infos">
      <div class="box">
        <div class="row">
          <div class="col-xs-12 col-md-9 infos">
            {l s='Order date <strong>%date%</strong>' d='Shop.Theme.Customeraccount' sprintf=['%date%' => $order.details.order_date]},
            {l s='Carrier' d='Shop.Theme.Checkout'} <strong>{$order.carrier.name}</strong>,
            {l s='Payment method' d='Shop.Theme.Checkout'} <strong>{$order.details.payment}</strong>
          </div>

          <div class="col-xs-12 col-md-3 text-xs-right buttons">
            {if $order.details.invoice_url}
              <a href="{$order.details.invoice_url}"
                class="btn btn-primary">{l s='Invoice' d='Shop.Theme.Customeraccount'}</a>
            {/if}
            {* @Bwlab --> eliminato riordina *}
            {* <a href="{$order.details.reorder_url}" class="btn btn-primary">
              {l s='Reorder' d='Shop.Theme.Actions'}
            </a> *}
            {* <-- @Bwlab *}
          </div>
          <div class="clearfix"></div>
        </div>
      </div>

      <div class="box">
        <ul>
          {if $order.details.recyclable}
            <li>
              {l s='You have given permission to receive your order in recycled packaging.' d='Shop.Theme.Customeraccount'}
            </li>
          {/if}

          {if $order.details.gift_message}
            <li>{l s='You have requested gift wrapping for this order.' d='Shop.Theme.Customeraccount'}</li>
            <li>{l s='Message' d='Shop.Theme.Customeraccount'} {$order.details.gift_message nofilter}</li>
          {/if}
        </ul>
      </div>
    </div>
  {/block}


  {block name='addresses'}
    <div class="row addresses">
      <div class="col-lg-6 col-md-6 col-sm-6">
        <article id="invoice-address" class="box">
          <h4>{l s='Invoice address' d='Shop.Theme.Checkout'}</h4>
          <address>{$order.addresses.invoice.formatted nofilter}</address>
        </article>
      </div>

      {if $order.addresses.delivery}
        <div class="col-lg-6 col-md-6 col-sm-6">
          <article id="delivery-address" class="box">
            <h4>{l s='Delivery address' d='Shop.Theme.Checkout'}</h4>
            <address>{$order.addresses.delivery.formatted nofilter}</address>
          </article>
        </div>
      {/if}

      <div class="clearfix"></div>
    </div>
  {/block}

  <div class="row">
    <div class="col-md-6">
      {block name='order_history'}
        <section id="order-history" class="box">
          <table class="table table-history-order hidden-xs-down">
            <thead class="thead-default">
              <tr>
                <th>{l s='Date' d='Shop.Theme.Global'}</th>
                <th>{l s='Status' d='Shop.Theme.Global'}</th>
              </tr>
            </thead>
            <tbody>
              {foreach from=$order.history item=state}
                <tr>
                  <td>{$state.history_date}</td>
                  <td>
                    <span class="label label-pill {$state.contrast}" style="background-color:{$state.color}">
                      {$state.ostate_name}
                    </span>
                  </td>
                </tr>
              {/foreach}
            </tbody>
          </table>
          <div class="hidden-sm-up history-lines">
            {foreach from=$order.history item=state}
              <div class="history-line">
                <div class="date">{$state.history_date}</div>
                <div class="state">
                  <span class="label label-pill {$state.contrast}" style="background-color:{$state.color}">
                    {$state.ostate_name}
                  </span>
                </div>
              </div>
            {/foreach}
          </div>
        </section>
      {/block}
    </div>

    <div class="col-md-6">
      {block name='order_carriers'}
        {if $order.shipping}
          <div class="box" id="order-shipping">
            <table class="table table-shipping hidden-sm-down">
              <thead class="thead-default">
                <tr>
                  <th>{l s='Date' d='Shop.Theme.Global'}</th>
                  <th>{l s='Carrier' d='Shop.Theme.Checkout'}</th>
                  <th>{l s='Shipping cost' d='Shop.Theme.Checkout'}</th>
                  <th>{l s='Tracking number' d='Shop.Theme.Checkout'}</th>
                </tr>
              </thead>
              <tbody>
                {foreach from=$order.shipping item=line}
                  <tr>
                    <td>{$line.shipping_date}</td>
                    <td>{$line.carrier_name}</td>
                    <td>{$line.shipping_cost}</td>
                    <td>{$line.tracking nofilter}</td>
                  </tr>
                {/foreach}
              </tbody>
            </table>
            <div class="hidden-md-up shipping-lines">
              {foreach from=$order.shipping item=line}
                <div class="shipping-line">
                  <ul>
                    <li>
                      <strong>{l s='Date' d='Shop.Theme.Global'}</strong> {$line.shipping_date}
                    </li>
                    <li>
                      <strong>{l s='Carrier' d='Shop.Theme.Checkout'}</strong> {$line.carrier_name}
                    </li>
                    <li>
                      <strong>{l s='Shipping cost' d='Shop.Theme.Checkout'}</strong> {$line.shipping_cost}
                    </li>
                    <li>
                      <strong>{l s='Tracking number' d='Shop.Theme.Checkout'}</strong> {$line.tracking nofilter}
                    </li>
                  </ul>
                </div>
              {/foreach}
            </div>
          </div>
        {/if}
      {/block}
    </div>
  </div>



  {if $order.follow_up}
    <div class="box" id="shipping">
      <p>{l s='Click the following link to track the delivery of your order' d='Shop.Theme.Customeraccount'}</p>
      <a href="{$order.follow_up}">{$order.follow_up}</a>
    </div>
  {/if}

  <div class="row" id="file-list">
    <div class="col-xs-12">
      {$HOOK_DISPLAYORDERDETAIL nofilter}
    </div>
  </div>

  {block name='order_detail'}
    {if $order.details.is_returnable}
      {include file='customer/_partials/order-detail-return.tpl'}
    {else}
      {include file='customer/_partials/order-detail-no-return.tpl'}
    {/if}
  {/block}



  {block name='order_messages'}
    {include file='customer/_partials/order-messages.tpl'}
  {/block}
{/block}