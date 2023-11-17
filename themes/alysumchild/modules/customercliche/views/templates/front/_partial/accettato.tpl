<h2>{l s='Perfetto, abbiamo ricevuto le approvazioni grafiche per questo prodotto' d='Modules.Customercliche.Shop'}</h2>

{include file="module:customercliche/views/templates/front/_partial/actual_state.tpl"  file_data_view=$file_data_view}

<div class="op_accettato">
    <div class="op_col_data">
        <a href="{$upload_folder}{$file_data_view->file_name_pk}" class="btn btn-primary mb10" target="_blank">{l s='Vedi elaborato' d='Modules.Customercliche.Shop'}</a>

        <p>
            <strong>{l s='Data caricamento elaborato' d='Modules.Customercliche.Shop'}:</strong>
            {$file_data_view->date_elab_pk|date_format:"d-m-Y H:i:s"}
        </p>

        <p>
            <strong>{l s='Data approvazione elaborato' d='Modules.Customercliche.Shop'}: </strong>
            {$file_data_view->date_answer|date_format:"d-m-Y H:i:s"}
        </p>

        <h2>{l s='E adesso?' d='Modules.Customercliche.Shop'}:</h2>

        <p>
            {l s='Devi soltanto monitorare il tuo ordine.' d='Modules.Customercliche.Shop'}:
            <a class="file-accettato-ordine" href="/index.php?controller=order-detail&id_order={$file_data_view->id_order}">
                {l s='Ordine' d='Modules.Customercliche.Shop'}
            </a><br/>
            {l s='Ti manderemo un avviso via e-mail quando verrà messo in produzione e verrà spedito insieme al numero di tracking.' d='Modules.Customercliche.Shop'}:
        </p>
    </div>

    <div class="op_col_img">
        <img src="/img/cms/pack-guru-01.png">
    </div>
</div>