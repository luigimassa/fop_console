{if $file_data_view->state == 'inviato'}
    {include file="module:customercliche/views/templates/front/_partial/inviato.tpl" file_data_view=$file_data_view}
{/if}

{if $file_data_view->state == 'accettato'}
    {include file="module:customercliche/views/templates/front/_partial/accettato.tpl"  file_data_view=$file_data_view}
{/if}

{if $file_data_view->state == 'non accettato'}
    {include file="module:customercliche/views/templates/front/_partial/non_accettato.tpl"
    file_data_view=$file_data_view}
{/if}

{*dati generici*}

{*visualizzazione dei messaggi *}
{if $file_data_view->state == "caricato" or $file_data_view->state == "ricaricare" or $file_data_view->state ==
"in caricamento" }
    {include file="module:customercliche/views/templates/front/_partial/customer_file_list.tpl"
    file_data_view=$file_data_view}
    {include file="module:customercliche/views/templates/front/_partial/messages.tpl" file_data_view=$file_data_view}
{/if}

