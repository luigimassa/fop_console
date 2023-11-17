{if $options|count > 0 }
		<div id="customer-cliche-container-{$id_product}-{$id_attribute}" style="display: flex;align-items: center; margin:
    1rem 0">
				<div>
						<span class="control-label">Selezione file</span>
						<select class="form-control form-control-select" name="file"
														data-id-product="{$id_product}"
														data-id-attribute="{$id_attribute}"
														onchange="cartSelectFile(this)">
								<option value=""> seleziona un file ...</option>
          {foreach $options as $option}
												<option value="{$option.key}" {if in_array($option.key, $defaults) == true}selected{/if}>{$option.name}
												</option>
          {/foreach}
						</select>
				</div>
				<div style="display: flex; align-items: center">
						<button name="reset-file"
														data-id-product="{$id_product}"
														data-id-attribute="{$id_attribute}"
														onclick="onCLickResetFile(this)">
								reset
						</button>
				</div>
		</div>
{/if}