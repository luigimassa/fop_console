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

{block name='page_title'}
  {l s='Your account' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="row row-eq-height">

    <div class="col-lg-9 col-xs-12 col-sx">
      <div class="row">
          <div class="links">
            {include file='customer/my-account-menu.tpl'}
          </div>
      </div>
    </div>

    <div class="col-lg-3 col-xs-12 col-dx">
      <div class="packguru packguru-desktop">
        <h2>Hai difficoltà?</h2>
        <p>Rivolgiti ai nostri packGURU!</p>

        <p>
          Whatsapp <a href="tel:+393713169591"><strong>+39 371 3169 591</strong></a><br>
          Customer Service <a href="tel:+390230451996"><strong>+39 02 3045 1996</strong></a><br>
          E-mail <a href="mailto:info@packaging-online.it"><strong>info@packaging-online.it</strong></a>
        </p>

        <p>
          Chat attiva<br>
          dal Lunedì al Venerdì<br>
          8:00/13:00<br>
          14:00/17:00
        </p>
      </div>

      <div class="packguru packguru-mobile">
        <h2>Hai difficoltà?</h2>
        <p>Rivolgiti ai nostri packGURU!</p>

        <p>
          <a href="tel:+393713169591" class="btn">Whatsapp</a><br>
          <a href="tel:+390230451996" class="btn">Telefono</a><br>
          <a href="mailto:info@packaging-online.it" class="btn">E-mail</a>
        </p>

        <p>
          Chat attiva dal Lunedì al Venerdì<br>
          8:00/13:00 - 14:00/17:00
        </p>
      </div>
    </div>
  </div>
{/block}


{block name='page_footer'}
  {block name='my_account_links'}
    <div class="text-xs-center">
      <a href="{$logout_url}" class="btn">
        {l s='Sign out' d='Shop.Theme.Actions'}
      </a>
    </div>
  {/block}
{/block}
