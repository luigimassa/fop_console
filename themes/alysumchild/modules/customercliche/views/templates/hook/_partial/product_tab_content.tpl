{foreach $products[$order->id_order] as $product}
    <div
            class="content content-{$order->id_order}-{$product->id_product}-{$product->id_product_attribute} {if
            $product@first}visible{/if}">
        {* l s='Prodotto' d='Modules.Customercliche.Shop' *}
        {* $product->name *}
        {if $product->state_file == 'in caricamento' or $product->state_file ==
        'ricaricare' or $product->state_file == 'caricato'}
            {include
            file="module:customercliche/views/templates/hook/_partial/in_caricamento.tpl"}

        {else}
            {include
            file="module:customercliche/views/templates/hook/_partial/detail_container.tpl"}
        {/if}
    </div>
{/foreach}