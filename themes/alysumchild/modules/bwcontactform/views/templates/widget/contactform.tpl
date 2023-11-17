{*
* 2007-2021 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2021 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{function name=select label="" field="" options="" }
		<div class="form-group col-xs-12">
				<label>{$label}</label>
				<select name="{$field->getName()}" class="form-control input-txt"
            {if $field->isRequired()}required="required"{/if}>
        {foreach from=$field->getAvailableValues() key=key_name item=item_name}
										<option value="{$key_name|escape:'htmlall':'UTF-8'}">{$item_name}</option>
        {/foreach}
				</select>
		</div>
{/function}
{function name=input label="" field="" icon="" col="6" }
    {if label}
						<div class="form-group col-md-{$col}">
								<div class="icon-true relative">
										<input class="form-control input-txt" type="{$field->getType()}" name="{$field->getName()}" value=""
                 {if $field->isRequired()}required="required"{/if} placeholder="{$label}"/>
										<svg class="svgic input-icon">
												<use xlink:href="#si-{$icon}"></use>
										</svg>
								</div>
						</div>
    {else}
						<input type="{$field->getType()}" name="{$field->getName()}"
													value="{$field->getValue()|escape:'htmlall':'UTF-8'}"/>
    {/if}
{/function}

{function name=textarea label="" field="" icon=""}
		<div class="form-group col-xs-12">
				<div class="icon-true relative">
						<textarea class="form-control input-txt ac-message" {if $field->isRequired()}required="required"{/if} cols="67" rows="3" name="{$field->getName()}" placeholder="{$label}"></textarea>
						<svg class="svgic input-icon">
								<use xlink:href="#si-{$icon}"></use>
						</svg>
				</div>
		</div>
{/function}

<div class="block-contactinfo contact-form-widget">
		<form name="bwcontactform" action="{$urls.pages.contact}" method="post">

				<div class="form-fields">
        {select label={l s='Support type' d='Modules.Contactform.Shop'} field=$form['contact_support'] }
        {if true == isset($form['firstname'])}
            {input label={l s='First name' d='Modules.Contactform.Shop'} field=$form['firstname'] icon="account"}
            {input label={l s='Last name' d='Modules.Contactform.Shop'} field=$form['lastname'] icon="account"}
            {input label={l s='Company' d='Modules.Contactform.Shop'} field=$form['company'] icon="rocket"}
            {input label={l s='Phone name' d='Modules.Contactform.Shop'} field=$form['phone'] icon="phone"}
        {/if}
        {input label={l s='Email address' d='Modules.Contactform.Shop'} field=$form['from'] icon="email"}
        {if true == isset($form['id_order'])}
            {select label={l s='Order reference' d='Modules.Contactform.Shop'} field=$form['id_order'] }
        {/if}
        {if true == isset($form['settore'])}
            {select label={l s='Settore' d='Modules.Contactform.Shop'} field=$form['settore'] }
        {/if}
        {if true ==  isset($form['fileUpload'])}
            {input label={l s='Attach File' d='Modules.Contactform.Shop'} field=$form['fileUpload'] col="12"}
        {/if}

        {textarea label={l s='Message' d='Modules.Contactform.Shop'} field=$form['message']}
						<div class="form-group">
          {hook h='displayGDPRConsent' id_module=$id_module}
						</div>
				</div>
				<footer class="form-footer">
						<input type="hidden" name="url" value=""/>
						<input type="hidden" name="{$form['token']->getName()}" value="{$form['token']->getValue()}"/>

						<button type="submit" name="submitSupportMessage" class="btn submitSupportMessage">
          {l s='Send' d='Modules.Contactform.Shop'}
						</button>
				</footer>
		</form>
</div>
