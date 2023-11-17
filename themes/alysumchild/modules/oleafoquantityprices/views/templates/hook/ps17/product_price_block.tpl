{**
  * ---------------------------------------------------------------------------------
  *
  * This file is part of the 'oleafoquantityprices' module feature
  * Developped for Prestashop  platform.
  * You are not allowed to use it on several site
  * You are not allowed to sell or redistribute this module
  * This header must not be removed
  *
  * @category XXX
  * @author OleaCorner <contact@oleacorner.com> <www.oleacorner.com>
  * @copyright OleaCorner
  * @version 1.0
  * {$oleafoqty_bestprice.quantity|intval}
  * ---------------------------------------------------------------------------------
  *}
<span class="oleafoqty_fromlabel">
								{l s='From' mod='oleafoquantityprices'}
				</span>&nbsp;
<span class="price" content="{$product.price_amount}">
{if isset($display_fromprice) && $display_fromprice && isset($oleafoqty_bestprice) && count($oleafoqty_bestprice)}
    {$oleafoqty_bestprice.price_displayed|escape:'htmlall':'UTF-8'}
{else}
    {$product.price}
{/if}

</span>
&nbsp;
<span class="oleafoqty-pezzi-per-cartone">
{foreach from=$product.features item=record}
    {if $record.id_feature == 7}{$record.name}: {$record.value}{/if}
{/foreach}
</span>