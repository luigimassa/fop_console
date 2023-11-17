<h2>
    {l s='lista dei files caricati' d='Modules.Customercliche.Shop'}
</h2>
		<ul class="file-list">
      {foreach $file_data_view->file_path as $customer_file}
								<li>
            {$customer_file->title}
								</li>
      {/foreach}
		</ul>