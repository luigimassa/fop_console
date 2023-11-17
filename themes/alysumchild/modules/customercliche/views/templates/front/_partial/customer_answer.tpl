{include file="module:customercliche/views/templates/front/_partial/actual_state.tpl" file_data_view=$file_data_view}

<a href="{$upload_folder}{$file_data_view->file_name_pk}" class="btn btn-primary mb10" target="_blank">{l s='Vedi elaborato' d='Modules.Customercliche.Shop'}</a>

<p>
    <strong>{l s='Data caricamento' d='Modules.Customercliche.Shop'}</strong>
    {$file_data_view->date_elab_pk|date_format:"d-m-Y H:i:s"}
</p>

<div class="m-t-1">
    <span class="custom-checkbox color-red">
        <label>{l s='Spunta qui per mostrare i pulsanti di approvazione' d='Modules.Customercliche.Shop'}</label >
        <input data-id="{$file_data_view->id_file}" name="enable_bnt" class="enable_btn" onclick="showButtons(this)" type="checkbox">
        <span><svg class="svgic svgic-done"><use xlink:href="#si-done"></use></svg></span>
    </span>
</div>

<div
        class="m-t-1 button_answer hidden-important"
        id="buttons_answer-{$file_data_view->id_file}">

    <a
            href="javascript:void(0);"
            class="btn btn-primary do-accept"
            data-id="{$file_data_view->id_file}"
            data-id-order="{$file_data_view->id_order}"
            onclick="sendAnswer(this, true)"
    >
        {l s='Accetto' d='Modules.Customercliche.Shop'}
    </a>

    <a
            href="javascript:void(0);"
            class="btn btn-primary do-no-accept"
            data-id="{$file_data_view->id_file}"
            data-id-order="{$file_data_view->id_order}"
            onclick="sendAnswer(this, false)">
        {l s='Rifiuto' d='Modules.Customercliche.Shop'}
    </a>
</div>
