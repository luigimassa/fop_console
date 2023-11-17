<div class="langs">

	{foreach from=$languages item=lang}
		{if ($language.id != $lang.id_lang)}
			<div class="lang">
				<a href="{url entity='language' id=$lang.id_lang}" data-iso-code="{$lang.iso_code}" title="{$lang.name}">
					<img src="{$urls.img_lang_url}{$lang.id_lang}.jpg" width="16" height="11" alt="{$lang.name_simple}" />
				</a>
			</div>
		{/if}
	{/foreach}
</div>

