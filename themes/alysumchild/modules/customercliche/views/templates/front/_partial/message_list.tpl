<ul>
    {foreach $messages as $message}
        {foreach $message as $message_detail}
            <li>
                <strong>
                    {$message_detail@key}
                </strong>:
                {if $message_detail@key == 'date'}
                    {$message_detail|date_format:"%d-%m-%Y"}
                {else}
                    {$message_detail}
                {/if}
            </li>
        {/foreach}
        <hr/>
    {/foreach}
</ul>