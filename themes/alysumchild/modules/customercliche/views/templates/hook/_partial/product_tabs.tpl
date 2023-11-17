
<nav>
    {foreach $products[$order->id_order] as $product}
        {* la classe active deve essere attiva solo per il primo prodotto*}
        <a
                data-content="content-{$order->id_order}-{$product->id_product}-{$product->id_product_attribute}"
                class="{if $product@first}selected{/if}
                content-{$order->id_order}-{$product->id_product}-{$product->id_product_attribute}">
                                    <span class="tab-label">
                                        {$product->name}
                                    </span>
        </a>
    {/foreach}
</nav>