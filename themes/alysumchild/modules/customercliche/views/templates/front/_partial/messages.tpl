<div
        style="display: flex; flex-direction: row; align-content: center"
        class="p-a-1 load-messages">
    {include
    file="module:customercliche/views/templates/front/_partial/message_textarea.tpl"
    id_file=$file_data_view->id_file   callback="sendMessage"}
    <div class="m-a-1">

        <div
                style="display: flex; flex-direction: column; align-content: center"
                class="p-a-1 message-list">
            {$only_for_sort_no_print = $file_data_view->messages|krsort}
            {include
            file="module:customercliche/views/templates/front/_partial/message_list.tpl"
            messages=$file_data_view->messages}

        </div>

    </div>
</div>