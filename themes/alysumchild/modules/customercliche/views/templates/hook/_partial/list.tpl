<div class="files-block-right col-md-12 col-sm-12 col-lg-12">
    <div class="card h-100">
        <div class="files-wrapper">
            <ul class="list-unstyled p-2 d-flex flex-column col" id="files">
                {if isset($Files) AND $Files}
                    {foreach from=$Files item=file}
                        {include file="module:customercliche/views/templates/hook/_partial/detail.tpl" }
                    {/foreach}
                {/if}
            </ul>
        </div>
    </div>
</div>