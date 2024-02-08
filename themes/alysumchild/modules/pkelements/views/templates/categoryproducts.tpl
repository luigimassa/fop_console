{block name='content'}
  <section id="main">

    <div id="products" class="{if isset($pktheme.cp_listing_view) && $pktheme.cp_listing_view == 0}view_list{else}view_grid view_grid{if isset($pktheme.cp_listing_view)}{$pktheme.cp_listing_view}{/if}{/if}">
      {if $listing.products|count}

        <div class="product_list_top">
          {block name='product_list_top'}
            {include file='catalog/_partials/products-top.tpl' listing=$listing}
          {/block}
        </div>

        <div class="product_list">
          {block name='product_list'}
            {include file='catalog/_partials/products.tpl' listing=$listing}
          {/block}
        </div>

        <div id="js-product-list-bottom">
          {block name='product_list_bottom'}
            {include file='catalog/_partials/products-bottom.tpl' listing=$listing}
          {/block}
        </div>

      {else}

        {include file='errors/no-products.tpl'}

      {/if}
    </div>

  </section>
{/block}