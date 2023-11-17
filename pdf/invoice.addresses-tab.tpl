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
<table id="addresses-tab" cellspacing="0" cellpadding="0">
		<tr >
				<td class="fatturazione" width="38%">
						<span class="bold">
								{l s='Billing Address' d='Shop.Pdf' pdf='true'}
						</span>
						<br/>
        {l s='Codice cliente' d='Shop.Pdf' pdf='true'}: {if $erpcode}{$erpcode}{else}-{/if}
						<br/><br/>
        {$addresses.invoice->company}<br/>
        {$addresses.invoice->address1} {$addresses.invoice->address2}<br/>
						<span class="bold">{l s='Citta' d='Shop.Pdf' pdf='true'}:</span> {$addresses.invoice->city}
						- {$addresses.invoice->postcode}
						<br/>
						<span class="bold">{l s='P.iva' d='Shop.Pdf' pdf='true'}:</span> {$addresses.invoice->vat_number}<br/>
						<span class="bold">{l s='C.F.' d='Shop.Pdf' pdf='true'}:</span> {$addresses.invoice->dni}<br/>
						<span class="bold">{l s='PEC' d='Shop.Pdf' pdf='true'}:</span> {$pec_sdi.pec}<br/>
						<span class="bold">{l s='SDI' d='Shop.Pdf' pdf='true'}:</span> {$pec_sdi.codice_sdi}<br/>

				</td>
				<td class="spedizone" width="38%">
						<span class="bold">{l s='Delivery Address' d='Shop.Pdf' pdf='true'}</span>
						<br/><br/>
        {$addresses.delivery->company}<br/>
        {$addresses.delivery->address1} {$addresses.delivery->address2}<br/>
        {$addresses.delivery->city} - {$addresses.delivery->postcode} <br/>
						<span class="bold">{l s='Contatti' d='Shop.Pdf' pdf='true'}:</span> {$addresses.delivery->phone} <br/><br/><br/>
						<span class="bold">{l s='Persona di riferimento' d='Shop.Pdf' pdf='true'}</span>:<br/>
        {$addresses.delivery->firstname} {$addresses.delivery->lastname} <br/>
				</td>
				<td class="dati-ordine" width="22%">
						<span class="bold green-text">{l s='Ordine' d='Shop.Pdf' pdf='true'}</span>
						<br/>
						<span class="bold">{l s='N° ordine' d='Shop.Pdf' pdf='true'}</span>: {$order->id}
						<br/>
						<span class="bold">{l s='Metodo di pagamento' d='Shop.Pdf' pdf='true'}</span>: {$order->payment}
						<br/>
						<span class="bold">{l s='Data ordine' d='Shop.Pdf' pdf='true'}</span>: {$order->date_add}
						<br/>
						<br/>
						<span class="bold">{l s='Cliente' d='Shop.Pdf' pdf='true'}</span>:
						<br/>
        {$customer->firstname} {$customer->lastname}<br/>
						<span class="bold">{l s='Email' d='Shop.Pdf' pdf='true'}</span>: {$customer->email}
				</td>
		</tr>
</table>
