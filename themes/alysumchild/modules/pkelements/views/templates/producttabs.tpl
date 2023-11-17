{block name='product_tabs'}
     {block name='product_attachments'}
       {if $product.attachments}
        <div class="tab-pane fade in" id="attachments">
           <section class="product-attachments">
             <h3 class="h5 text-uppercase">{l s='Download' d='Shop.Theme.Actions'}</h3>
             {foreach from=$product.attachments item=attachment}
               <div class="attachment">
                <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}" class="btn btn-primary">
                   {$attachment.file_name}
                 </a>
               </div>
             {/foreach}
           </section>
         </div>
       {/if}
     {/block}
{/block}