<article>

		<div class="thumbnail product-thumbnail relative flex-container">
      {if $product.cover}
								<img
																src="{$product.cover.bySize['home_default'].url}"
																loading="lazy"
																width="200"
																height="200"
																class="smooth05 cover-image"
																data-full-size-image-url="{$product.cover.large.url}">
      {else}
								<img src="{$urls.no_picture_image.bySize.home_default.url}" class="w100" width="300" height="300"/>
      {/if}
		</div>
		<h2 class="product-title text-left">
      {if (is_array($product.name))}{$product.name.1}{else}{$product.name}{/if}
		</h2>

</article>