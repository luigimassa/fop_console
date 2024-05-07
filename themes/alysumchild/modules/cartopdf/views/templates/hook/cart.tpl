{*
* 2007-2022 PrestaShop
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
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2022 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div id="cartopdf" style="margin:auto auto 20px auto;;display:block;text-align:right;">
	<a href="{if isset($printpdf_url) && $printpdf_url}{$printpdf_url}{else}#{/if}" target="_blank" class="" style="display:inline-block; padding:10px; background-color:#f0ad4e; color:#FFF; border:1px solid #ededed;" title="{l s='Print Cart' mod='cartopdf'}">&#9654; &nbsp; 
		{if Configuration::get('CtoPDF_doc') == 1}
			{l s='Print Cart to DOC' mod='cartopdf'}
		{else}
			{l s='Print Cart to PDF' mod='cartopdf'}
		{/if}		
	</a>
</div>