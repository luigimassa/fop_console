{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 *}
{$style_tab}
<table width="100%" id="body" border="0" cellpadding="0" cellspacing="0" style="margin:0;">
    <!-- Invoicing -->
    <tr>
        <td colspan="12">
            {$addresses_tab}
        </td>
    </tr>
    <tr>
        <td colspan="12" height="20">&nbsp;</td>
    </tr>

    <!-- Product -->
    <tr>
        <td colspan="12">

            {$product_tab}

        </td>
    </tr>

    <tr>
        <td colspan="12" height="10">&nbsp;</td>
    </tr>

    <!-- TVA -->
    <tr>
        <!-- Code TVA -->
        <td colspan="6">
            <table id="free-text-box">
                <tr>
                    <td>
                        <p class="metodo-spedizione">
                            <span class="label">{l s='Metodo di spedizione' d='Shop.Pdf' pdf='true'}</span>: {$carrier->name}
                        </p>
                        <p class="primo-testo">
                            {l s="Nel caso di articoli personalizzati caricare il
														file direttamente nell'area invio file"
                            d='Shop.Pdf' pdf='true'}
                        </p>
                        <p class="secondo-testo">
                            {l s="Di seguito le nostre coordinate bancarie" d='Shop.Pdf' pdf='true'}: </p>
                        <p class="secondo-testo bold">
                            {l s="BANCA SELLA SPA
															IT82W0326804606052553646300 - BIC / SWIFT : SELBIT2BXXX
															Intestato a : P&F PACKAGING & FOOD SRL"
                            d='Shop.Pdf' pdf='true'}
                        </p>
                        <p class="bold big left thanks">
                            {l s="Grazie per il tuo acquisto !" d='Shop.Pdf'
                            pdf='true'}</p>
                    </td>
                </tr>
            </table>
        </td>
        <td colspan="1">&nbsp;</td>
        <!-- Calcule TVA -->
        <td colspan="6" rowspan="5" class="right">

            {$total_tab}

        </td>
    </tr>


{*    <tr>*}
{*        <td colspan="12" height="10">&nbsp;</td>*}
{*    </tr>*}

{*    <tr>*}
{*        <td colspan="6" class="left">*}

{*            *}{*        {$payment_tab}*}

{*        </td>*}
{*        <td colspan="1">&nbsp;</td>*}
{*    </tr>*}

{*    <tr>*}
{*        <td colspan="6" class="left">*}
{*            *}{*        {$shipping_tab}*}

{*        </td>*}
{*        <td colspan="1">&nbsp;</td>*}
{*    </tr>*}

    <tr>
        <td colspan="7">
            <h3>{l s="Note d'ordine" d='Shop.Pdf' pdf='true'}:</h3>
            {$note}
            {*            {$note_tab}&nbsp;*}
        </td>
    </tr>

    <tr>
        <td colspan="7" class="left small">

            <table>
                <tr>
                    <td>
                        <p>{$legal_free_text|escape:'html':'UTF-8'|nl2br}</p>
                    </td>
                </tr>
            </table>

        </td>
    </tr>

    <!-- Hook -->
    {if isset($HOOK_DISPLAY_PDF)}
        <tr>
            <td colspan="12" >&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
            <td colspan="10">
                {$HOOK_DISPLAY_PDF}
            </td>
        </tr>
    {/if}

</table>

