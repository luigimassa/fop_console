<article>
	<p class="lead product-title text-left{if !$pkconf.pm_title_multiline} ellipsis{/if}">
		<span class="nomecombo">
			<a href="{$product.url}">{if (is_array($product.name))}{$product.name.1}{else}{$product.name}{/if}</a>
			<span class="risparmio" content="{$product.price_amount}">{$risparmio}</span>
		</span>
		con il <strong>pacchetto prodotti</strong>
	</p>

	<p class="oldprice">
		<span class="sum_price_single_items" content="{$product}">{$prezzo_complessivo}</span>
	</p>

	<p class="newprice">
		<span class="price" content="{$product.price_amount}">{$product.price}</span>
	</p>

	<a href="{$product.url}" class="btn" title="{l s='View Product' d='Shop.Theme.Actions'}"
		aria-label="{l s='View Product' d='Shop.Theme.Actions'}" role="button">
		{l s='View Product' d='Shop.Theme.Actions'}
	</a>
</article>