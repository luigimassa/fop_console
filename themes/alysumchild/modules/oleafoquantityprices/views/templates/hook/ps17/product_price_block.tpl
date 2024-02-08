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
<div class="oleafoqty">
    <span class="fromlabel">
        {l s='from' d='Shop.Modules.Oleafoquantityprices'}
    </span>
    <span class="price" content="{$product.price_amount}">
        {if isset($display_fromprice) && $display_fromprice && isset($oleafoqty_bestprice) && count($oleafoqty_bestprice)}
            {$oleafoqty_bestprice.price_displayed|escape:'htmlall':'UTF-8'}
                &nbsp;{l s='for' d='Shop.Modules.Oleafoquantityprices'}&nbsp;
            {$oleafoqty_bestprice.quantity|escape:'htmlall':'UTF-8'} &nbsp;{l s='box' d='Shop.Modules.Oleafoquantityprices'}&nbsp;
        {else}
            {$product.price}
        {/if}
    </span>
    <br>
    <span class="pezzi-per-cartone">
        {foreach from=$product.features item=record}
            {if $record.id_feature == 7}{$record.value} {$record.name}{/if}
        {/foreach}
    </span>
</div>
