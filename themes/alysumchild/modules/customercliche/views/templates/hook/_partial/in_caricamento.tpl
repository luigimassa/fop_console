<div class="row">
    <div class="col-md-12">
        {include file="module:customercliche/views/templates/hook/_partial/uploader.tpl"
        id_product=$product->id_product
        id_attribute=$product->id_product_attribute
        id_order=$order->id_order}
    </div>
</div>
{*{include file="module:customercliche/views/templates/front/_partial/actual_state.tpl" file_data_view=$file_data_view}*}
{*<h2>{l s='File caricati' d='Modules.Customercliche.Shop'}</h2>*}
{*<ul>*}
{*    {foreach $file_data_view->file_path as $detail_file }*}
{*        <ol>*}
{*            <strong>{$detail_file->title}</strong>*}
{*            <a*}
{*                    target="_blank"*}
{*                    href="{$upload_folder}{$detail_file->file_name}">*}
{*                <span>{$detail_file->file_name}</span>*}
{*            </a>*}
{*            <strong>Note:</strong> {$detail_file->note}*}
{*        </ol>*}
{*    {/foreach}*}
{*</ul>*}