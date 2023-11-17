<div class="row">
		<div class="container menucontainer" style="text-align:center; padding: 10px;">
				<div class="col-xs-12">
        {include file='customer/my-account-menu.tpl'}
				</div>
		</div>
</div>
<header class="page-header">
		<h1>{l s='Invio file' d='Shop.Theme.Customeraccount'}</h1>
</header>

<div class="accordion-wrapper-open">
    {foreach item=order from=$orders}
						<div class="accordion-item open">

								<h2 class="accordion-item-heading"><strong>Ordine: {$order->id_order}</strong> - del {$order->date}
										<span>+</span><span class="op_stato_ordine accettato">
                    {$order->order_state}
                </span></h2>
								<div class="accordion-item-content">
										<div class="tabs">
              {*tabs*}
              {include
              file="module:customercliche/views/templates/hook/_partial/product_tabs.tpl"}
              {include
              file="module:customercliche/views/templates/hook/_partial/product_tab_content.tpl"}
										</div>
								</div>
						</div>
    {/foreach}

</div>
