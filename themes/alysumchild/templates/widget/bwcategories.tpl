{foreach from=$categories item=category key=p name=category}
		<article class="category">
				<div class="thumbnail-container relative">
						<div class="thumbnail product-thumbnail relative">
								<a class="ellipsis" href="{$category.url}">
            {**}
										<img class="category-image-slider"
															src="{$category.image["medium"].url}"
															loading="lazy"
															alt="{$category.image.legend}"
										/>
								</a>
						</div>
        {**}
						<h2><a href="{$category.url}">{$category.name}</a></h2>
        {if $category.description}
										<div id="category-description">{$category.description nofilter}</div>
        {/if}
				</div>
		</article>
{/foreach}
