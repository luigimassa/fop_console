<div>
	<div class="cart-content">
		<div id="prezzo-netto">

			<div class="col-xs-12">
				<ul class="media-list">
					<li style="">
						<div>
							<div class="cart-icon">
								<svg class="svgic svgic-down">
									<use xlink:href="#op-totale-parziale"></use>
								</svg>
							</div>
						</div>
						<div>
							<span class="label">{l s='Subtotal' d='Shop.Theme.Checkout'}</span>
							<span class="value">
											{$cart.subtotals.products.value}<br/>
           {widget name="bwdisplaydata" hook="costoUnitario" product=$cart.products[0]}

							</span>
						</div>
					</li>

					{*---->  conai  *}
					<li>
						<div>
							<div class="cart-icon">
								<svg class="svgic svgic-down">
									<use xlink:href="#op-conai"></use>
								</svg>
							</div>
						</div>
						<div>
							<span class="label">{$cart.subtotals.conai.label}</span>
							<span class="value">{$cart.subtotals.conai.value}</span>
						</div>
					</li>
					{*---->  ccliche  *}
					<li>
						<div>
							<div class="cart-icon">
								<svg class="svgic svgic-down">
									<use xlink:href="#op-cliche"></use>
								</svg>
							</div>
						</div>
						<div>
							<span class="label">{$cart.subtotals.cliche.label}</span>
							<span class="value">{$cart.subtotals.cliche.value}</span>
						</div>
					</li>

					{*---->  voucher  *}
					{*<li>*}
					{*	<span class="label">{$cart.subtotals.discounts.label}</span>*}
					{*	<span class="value">{$cart.subtotals.discounts.value}</span>*}
					{*</li>*}

					{*---->  spedizione  *}
					<li>
						<div>
							<div class="cart-icon">
								<svg class="svgic svgic-down">
									<use xlink:href="#op-shipping"></use>
								</svg>
							</div>
						</div>
						<div>
							<span class="label">{l s='Shipping	' d='Shop.Theme.Checkout'}</span>
							<span
								class="value">{l s='Traduzione cart simulate shipping	' d='Shop.Theme.Checkout'}</span>
						</div>
					</li>

					{if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
						{*---->  totale tasse escluse*}
						<li>
							<div>
								<div class="cart-icon">
									<svg class="svgic svgic-down">
										<use xlink:href="#op-products"></use>
									</svg>
								</div>
							</div>
							<div>
								<span class="label">{$cart.totals.total.label}&nbsp;{$cart.labels.tax_short}:</span>
								<span class="value">{$cart.totals.total.value}</span>
							</div>
						</li>
						{if $cart.subtotals.tax}
							{*---->  totale tasse   *}
							<li>
								<div>
									<div class="cart-icon">
										<svg class="svgic svgic-down">
											<use xlink:href="#op-tasse"></use>
										</svg>
									</div>
								</div>
								<div>
									<span class="label">
										{l s='%label%:' sprintf=['%label%' => $cart.subtotals.tax.label] d='Shop.Theme.Global'}
									</span>
									<span class="value">{$cart.subtotals.tax.value}</span>
								</div>
							</li>
						{/if}
					{/if}


					{if $configuration.display_prices_tax_incl && !$configuration.taxes_enabled}
						<li>
							<div>
								<div class="cart-icon">
									<svg class="svgic svgic-down">
										<use xlink:href="#op-tasse"></use>
									</svg>
								</div>
							</div>
							<div>
								<span class="label">
									{$cart.totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$cart.labels.tax_short}{/if}
								</span>
								<span class="value">{$cart.totals.total.value}</span>
						</li>
				</div>
			{/if}
			</ul>
		</div> {* end col-md-9 *}

		<div class="clearfix"></div>
	</div> {* end prezzo netto *}
</div>

{*---->  totale generale*}
<p id="prezzo-totale">
	<span class="label">{l s='Totale' d='Shop.Theme.Checkout'}</span>
	<span class="value">{$cart.totals.total_including_tax.value}</span>
</p>
<div class="clearfix labelmini">{l s='Conai e IVA incluso' d='Shop.Theme.Checkout'}</div>
</div>