<h1>{l s='File caricati o selezionai per questo ordine.' d='Modules.Customercliche.Shop'}</h1>
<div id="file_list_wrapper">
    <table>
        <thead>
        <tr>
            <th> {l s='Prodotto' d='Modules.Customercliche.Shop'}</th>
            <th> {l s='File' d='Modules.Customercliche.Shop'}</th>
            <th> {l s='Download' d='Modules.Customercliche.Shop'}</th>
        </tr>
        </thead>
        <tbody>
        {foreach $files as $file}
            <tr>
                <td>{$file->product_name}</td>
                <td>
                    {foreach $file->file_path as $file_detail}
                        {$file_detail->title}<br/>
                    {/foreach}

                </td>
                <td><a target="_blank" href="{$base_dir}/{$file->file_name_pk}">{$file->file_name_pk}</a></td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>