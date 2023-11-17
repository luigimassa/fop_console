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
{block name='address_block_item'}
  <article id="address-{$address.id}" class="address" data-id-address="{$address.id}">
    <div class="address-body">

      {block name='address_block_item_actions'}
        <div class="address-header">
          {*@bwlab ---->*}
          {*          <h4>{$address.alias}</h4>*}
          <h4>
            {if $address.vat_number}
              {l s='Indirizzo di fatturazione' d='Shop.Theme.Customeraccount'}</h1>
            {else}
              {l s='Indirizzo di spedizione' d='Shop.Theme.Customeraccount'}</h1>

            {/if}
          </h4>
          {*<---- @bwlab *}
          <a href="{url entity=address id=$address.id params=['delete' => 1, 'token' => $token]}"
            data-link-action="delete-address" class="btn">
            <svg class="svgic">
              <use xlink:href="#si-cross"></use>
            </svg>
          </a>
          <a href="{url entity=address id=$address.id}" class="btn" data-link-action="edit-address">
            <svg class="svgic">
              <use xlink:href="#si-pencil"></use>
            </svg>
          </a>
        </div>
      {/block}
      <address>{$address.formatted nofilter}</address>
    </div>


  </article>
{/block}