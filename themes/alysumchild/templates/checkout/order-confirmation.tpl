{extends file='page.tpl'}

{block name='page_content_container' prepend}
    <section id="content-hook_order_confirmation" class="card">
      <div class="card-block">
        <div class="row">
          <div class="col-md-12">
            <div class="success-box">
              {block name='order_confirmation_header'}
              <h3 class="h1 card-title">{l s='Your order is <span>confirmed<span>' d='Shop.Theme.Checkout'}</h3>
              {/block}
            </div>
          </div>

          <div class="col-md-7">
            <p>
              {l s='An email has been sent to your mail address <strong>%email%</strong>.' d='Shop.Theme.Checkout' sprintf=['%email%' => $customer.email]}
              {if $order.details.invoice_url}
                {* [1][/1] is for a HTML tag. *}
                {l
                  s='You can also [1]download your invoice[/1]'
                  d='Shop.Theme.Checkout'
                  sprintf=[
                    '[1]' => "<a href='{$order.details.invoice_url}'>",
                    '[/1]' => "</a>"
                  ]
                }
              {/if}
            </p>
          </div>

          <div class="col-md-5 text-right">
            <a href="{$order.details.invoice_url}" class="btn btn-primary">{l s='Download order confirmation' d='Shop.Theme.Checkout'}</a>
            <a href="{$urls.pages.history}" class="btn btn-primary">{l s='My orders' d='Shop.Theme.Checkout'}</a>
          </div>
            
          <div class="col-md-12">
            {block name='hook_order_confirmation'}
              {$HOOK_ORDER_CONFIRMATION nofilter}
            {/block}
          </div>
        </div>
      </div>
    </section>
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-order-confirmation card">
    <div class="card-block">
      <div class="row">

        {block name='order_details'}
        <div id="payment-details" class="col-md-5">
          {block name='hook_payment_return'}
          {if ! empty($HOOK_PAYMENT_RETURN)}
          <section id="content-hook_payment_return" class="card definition-list">
            <div class="card-block">
              <div class="row">
                <div class="col-md-12">
                  {$HOOK_PAYMENT_RETURN nofilter}
                </div>
              </div>
            </div>
          </section>
          {/if}
          {/block}
        </div>
        {/block}

        {block name='order_confirmation_table'}
          {include
            file='checkout/_partials/order-confirmation-table.tpl'
            products=$order.products
            subtotals=$order.subtotals
            totals=$order.totals
            labels=$order.labels
            add_product_link=false
          }
        {/block}


      </div>
    </div>
  </section>



  {block name='customer_registration_form'}
  {if $customer.is_guest}
    <div id="registration-form" class="card">
      <div class="card-block">
        <h4 class="h4">{l s='Save time on your next order, sign up now' d='Shop.Theme.Checkout'}</h4>
        {render file='customer/_partials/customer-form.tpl' ui=$register_form}
      </div>
    </div>
  {/if}
  {/block}

  {block name='hook_order_confirmation_1'}
    {hook h='displayOrderConfirmation1'}
  {/block}

  {block name='hook_order_confirmation_2'}
  <section id="content-hook-order-confirmation-footer">
    {hook h='displayOrderConfirmation2'}
  </section>
  {/block}
{/block}
