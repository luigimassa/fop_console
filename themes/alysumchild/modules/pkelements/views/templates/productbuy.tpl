<div class="product-information">
    {* ---> @bwlab stampa caratteristiche *}
    {$features = []}
    {foreach from=$product.features item=feature}
        {if $feature.id_feature == "7" or $feature.id_feature == "4" or $feature.id_feature == "1" or $feature.id_feature == "29" or $feature.id_feature == "33"}
            {if $feature.id_feature == "7"}
                {$features[0] = $feature}
            {/if}
            {if $feature.id_feature == "1"}
                {$features[1] = $feature}
            {/if}
            {if $feature.id_feature == "4"}
                {$features[2] = $feature}
            {/if}
            {if $feature.id_feature == "29"}
                {$features[3] = $feature}
            {/if}
             {if $feature.id_feature == "33"}
                {$features[4] = $feature}
            {/if}


        {/if}
    {/foreach}
    {if count($features) > 0}
        <h4 class="product-fetures-title">{l s='Features' d='Shop.Theme.Catalog'}</h4>
        <dl class="product-features">

            {foreach from=$features item=feature}

                {if $feature.id_feature == "7" or $feature.id_feature == "4" or $feature.id_feature == "1" or $feature.id_feature == "29" or $feature.id_feature == "33"}
                    <dt> {$feature.name}</dt>
                    <dd>{$feature.value}</dd>
                {/if}
            {/foreach}
        </dl>
    {/if}
    {* <-- @bwlab *}
    {if $product.is_customizable && count($product.customizations.fields)}
        {block name='product_customization'}
            {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
        {/block}
    {/if}
    <div class="product-actions">
        {block name='product_buy'}
            <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                <input type="hidden" name="token" value="{$static_token}">
                <input type="hidden" name="id_product" value="{$product.id}" class="product_page_product_id">
                <input type="hidden" name="id_customization" value="{$product.id_customization}"
                    class="product_customization_id">

                {block name='product_variants'}
                    {include file='catalog/_partials/product-variants.tpl'}
                {/block}

                {block name='product_pack'}
                    {if $packItems}
                        <section class="product-pack">
                            <h3 class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</h3>
                            {foreach from=$packItems item="product_pack"}
                                {block name='product_miniature'}
                                    {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack}
                                {/block}
                            {/foreach}
                        </section>
                    {/if}
                {/block}

                {block name='product_discounts'}
                    {include file='catalog/_partials/product-discounts.tpl'}
                {/block}


                {block name='product_add_to_cart'}
                    {include file='catalog/_partials/product-add-to-cart.tpl'}
                {/block}

                <div class="productButtons flex-container align-items-center">
                    {hook h='displayProductButtons' product=$product}
                </div>

                {block name='product_refresh'}
                    <input class="product-refresh ps-hidden-by-js" name="refresh" type="submit"
                        value="{l s='Refresh' d='Shop.Theme.Actions'}">
                {/block}

            </form>
        {/block}
    </div>
    <div class="productButtons flex-container align-items-center">
        {hook h='displayMoreButtons' product_id=$product.id}
    </div>
    {block name='product_additional_info'}
        {include file='catalog/_partials/product-additional-info.tpl'}
    {/block}
    {hook h='displayReassurance'}
</div>