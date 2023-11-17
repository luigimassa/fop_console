<h2>{l s='Ci dispiace che il nostro elaborato non sia di tuo gradimento.' d='Modules.Customercliche.Shop'}</h2>

{include file="module:customercliche/views/templates/front/_partial/actual_state.tpl"  file_data_view=$file_data_view}

<div class="op_rifiutato">
    <div class="op_col_data">
        <a href="{$upload_folder}{$file_data_view->file_name_pk}" class="btn btn-primary mb10" target="_blank">{l s='Vedi elaborato' d='Modules.Customercliche.Shop'}</a>
        
        <p>
            <strong>{l s='Data caricamento elaborato' d='Modules.Customercliche.Shop'}:</strong>
            {$file_data_view->date_elab_pk|date_format:"%d-%m-%Y %H:%i:%s"}
        </p>

        <p>
            <strong>{l s='Data rifiuto dell\'elaborato:' d='Modules.Customercliche.Shop'}: </strong>
            {$file_data_view->date_answer|date_format:"%d-%m-%Y %H:%i:%s"}
        </p>

        <h2>{l s='E adesso?' d='Modules.Customercliche.Shop'}:</h2>

        <p>
            {l s='Inserisci un messaggio nel box sottostante indicando le correzioni da apportare al tuo elaborato..' d='Modules.Customercliche.Shop'}: "todo id ordine da
        </p>

        {include file="module:customercliche/views/templates/front/_partial/message_textarea.tpl" id_file=$file_data_view->id_file callback="sendMessageRifiutato"}
    </div>

    <div class="op_col_img">
        <img src="/img/cms/ordine-rifiutato-bg.png">
    </div>
</divs>