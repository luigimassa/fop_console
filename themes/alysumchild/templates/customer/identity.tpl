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
{extends 'customer/page.tpl'}

  {include file='_partials/notifications.tpl'}

  {block name='page_header_container'}
    {block name='page_title'}
      <div class="row">
        <div class="container menucontainer" style="text-align:center; padding: 10px;">
          <div class="row row-eq-height">
            {include file='customer/my-account-menu.tpl'}
          </div>
        </div>
      </div>
      
      <header class="page-header">
        <h1>{l s='Your personal information' d='Shop.Theme.Customeraccount'}</h1>
      </header>
    {/block}
  {/block}

{block name='page_content'}
<div class="container">
  {render file='customer/_partials/customer-form.tpl' ui=$customer_form}
</div>
{/block}