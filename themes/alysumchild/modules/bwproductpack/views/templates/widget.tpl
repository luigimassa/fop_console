<div class="combo-row" style="display: flex; flex-direction: row; width: 100%">
	    {foreach from=$pack_items_data item=product_data}
						<div class="combo-col" style="padding:1rem; display: flex; flex-direction: row">
          {include
          file="module:bwproductpack/views/templates/_partials/product_miniature.tpl"  product=$product_data.product}

						</div>
    {/foreach}
		<div class="combo-col">
      {include
      file="module:bwproductpack/views/templates/_partials/product_pack_miniature.tpl"  product=$pack_data}

		</div>
</div>