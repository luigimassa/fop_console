            <a class="col-xs-3" id="identity-link" href="{$urls.pages.identity}">
              <span class="link-item">
                <svg class="svgic smooth05"><use xlink:href="#op-utente"></use></svg>
                <span>{l s='Information' d='Shop.Theme.Customeraccount'}</span>
              </span>
            </a>

            {if $customer.addresses|count}
              <a class="col-xs-3" id="addresses-link" href="{$urls.pages.addresses}">
                <span class="link-item">
                  <svg class="svgic smooth05"><use xlink:href="#op-localizzazione"></use></svg>
                  <span>{l s='Addresses' d='Shop.Theme.Customeraccount'}</span>
                </span>
              </a>
            {else}
              <a class="col-xs-3" id="address-link" href="{$urls.pages.address}">
                <span class="link-item">
                  <svg class="svgic smooth05"><use xlink:href="#op-localizzazione"></use></svg>
                  <span>{l s='Add first address' d='Shop.Theme.Customeraccount'}</span>
                </span>
              </a>
            {/if}

            <a class="col-xs-3" id="file-link" href="/index.php?fc=module&module=customercliche&controller=uploadfiles&id_lang=1">
              <span class="link-item">
                <svg class="svgic smooth05"><use xlink:href="#op-invio-file"></use></svg>
                <span>{l s='File upload' d='Shop.Theme.Customeraccount'}</span>
              </span>
            </a>

            {if !$configuration.is_catalog}
              <a class="col-xs-3" id="history-link" href="{$urls.pages.history}">
                <span class="link-item">
                  <svg class="svgic smooth05"><use xlink:href="#op-calendario"></use></svg>
                  <span>{l s='My orders' d='Shop.Theme.Customeraccount'}</span>
                </span>
              </a>
            {/if}

            {* toglie il blocco preferiti del modulo pk *}
            {* block name='display_customer_account'}
              {hook h='displayCustomerAccount'}
            {/block *}

            {* inserisce direttamente il codice del modulo preferiti pk *}
            <a class="col-xs-3" id="favorites-link" href="{$link->getModuleLink('pkfavorites', 'account')}">
              <span class="link-item">
                <svg class="svgic smooth05"><use xlink:href="#op-like"></use></svg>
                <span>{l s='Wishes list' d='Shop.Theme.Customeraccount'}</span>
              </span>
            </a>

            {* toglie il blocco delle note di credito *}
            {* if !$configuration.is_catalog}
              <a class="col-xs-3" id="order-slips-link" href="{$urls.pages.order_slip}">
                <span class="link-item">
                  <svg class="svgic smooth05"><use xlink:href="#si-file2"></use></svg>
                  <span>{l s='Credit slips' d='Shop.Theme.Customeraccount'}</span>
                </span>
              </a>
            {/if *}

            {* GDPR *}
            <a class="col-xs-3" id="personal-data-link" href="/index.php?fc=module&module=psgdpr&controller=gdpr&id_lang=1">
              <span class="link-item">
                <svg class="svgic smooth05"><use xlink:href="#op-personal-data"></use></svg>
                <span>{l s='GDPR - Personal data' d='Shop.Theme.Customeraccount'}</span>
              </span>
            </a>

            {* GDPR 
            <a class="col-xs-3" id="avvisi-link" href="#">
              <span class="link-item">
                <svg class="svgic smooth05"><use xlink:href="#op-avvisi"></use></svg>
                <span>{l s='Warnings' d='Shop.Theme.Customeraccount'}</span>
              </span>
            </a>
            *}

            {if $configuration.voucher_enabled && !$configuration.is_catalog}
              <a class="col-xs-3" id="discounts-link" href="{$urls.pages.discount}">
                <span class="link-item">
                  <svg class="svgic smooth05"><use xlink:href="#op-buoni-sconto"></use></svg>
                  <span>{l s='Vouchers' d='Shop.Theme.Customeraccount'}</span>
                </span>
              </a>
            {/if}

            {if $configuration.return_enabled && !$configuration.is_catalog}
              <a class="col-xs-3" id="returns-link" href="{$urls.pages.order_follow}">
                <span class="link-item">
                  <svg class="svgic smooth05"><use xlink:href="#si-info"></use></svg>
                  <span>xx{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}</span>
                </span>
              </a>
            {/if}
