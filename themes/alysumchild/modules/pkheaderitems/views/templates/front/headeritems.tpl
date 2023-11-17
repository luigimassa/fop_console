{*
* Promokit Header Items Module
*
* @package   alysum
* @version   1.1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   You only can use module, nothing more!
*}

{if !empty($pkhiconfig) && is_array($pkhiconfig)}

{function name="headeritem" itemdata=[]}
{if $itemdata != []}
    <li 
        class="dd_el pkorder{$itemdata.order} {$itemdata.class}{if (isset($itemdata.dropdown) && !empty($itemdata.dropdown)) && !isset($itemdata.sidebar)} is-dropdown{/if}{if $pkhiconfig.sett_icons} item-icon-true{else} item-icon-false{/if}"
        {if isset($itemdata.id)} id="{$itemdata.id}"{/if}
        {if isset($itemdata.sidebar)}
        data-pktabname="{$itemdata.toggler_id}" data-pktabsection="{$itemdata.active_section}" data-pktabgroup="desktopbar" data-pktype="sidebar"
        {/if}>
        {if isset($itemdata.href)}<a class="pk-item-content relative" href="{$itemdata.href}">{else}<a class="pk-item-content">{/if}
            {if isset($itemdata.icon)} 
            <svg class="svgic{if !$pkhiconfig.sett_icons} hidden{/if}"{if isset($pkhiconfig.sett_iconsize) && $pkhiconfig.sett_iconsize != ''} style="width:{$pkhiconfig.sett_iconsize}px;height:{$pkhiconfig.sett_iconsize}px"{/if}>
                <use xlink:href="#si-{$itemdata.icon}"></use>
            </svg>
            {/if}
            <div>
               <span class="pkhi-item-title
                    {* @bwlab ---->*}
                    {* @bwlab aggiunta classe extra per eventuale style*}
                    {* @bwlab usata per mostrar il nome utente*}
                
                   {if isset($itemdata.extra_class)}{$itemdata.extra_class}{/if}">
                {if isset($itemdata.title)}{$itemdata.title nofilter}{/if}
            </span>

            {if $customer.is_logged}    
                <br/>
                <span class="groupname">{if isset($itemdata.groupname)}{$itemdata.groupname nofilter}{/if}</span>
            {/if}
            </div>
            
            {* <---- @bwlab*}
            {if (isset($itemdata.counter) && ($itemdata.counter > 0))}
                <span class="header-item-counter mainbg{if $itemdata.counter == 0} hidden{/if}{if isset($itemdata.id)} js-{$itemdata.id}-counter{/if}">{$itemdata.counter}</span>
            {/if}
        {if isset($itemdata.href)}</a>{else}</a>{/if}
        {if isset($itemdata.dropdown) && !isset($itemdata.sidebar)}
        {strip}
        <div class="opt-list dd_container dd_view{if isset($itemdata.dd_class)} {$itemdata.dd_class}{/if}{if $itemdata.dropdown == '' || (isset($itemdata.counter) && $itemdata.counter == 0)} hidden-important{/if}">
            <div class="indent{if isset($itemdata.id)} js-{$itemdata.id}-container{/if}">
            {$itemdata.dropdown nofilter}
            </div>
        </div>
        {/strip}
        {/if}
    </li>
{/if}
{/function}

{function name="headercart" itemdata=[]}
{if isset($pkcart)}
{*
{include file='module:ps_shoppingcart/ps_shoppingcart.tpl' cart_url=$pkcart.cart_url cart=$pkcart.cart urls=$urls sidebar=true}
<img src="{$urls.base_url}modules/pkheaderitems/views/img/payment_logos.png" width="310" height="28" loading="lazy" class="db">
*}
<li class="{$itemdata.class} pkorder{$itemdata.order}"{if isset($itemdata.sidebar)} data-pktabname="{$itemdata.toggler_id}"{/if} data-pktabgroup="desktopbar" data-pktype="sidebar">
<div id="desktop_cart">
  <div class="blockcart cart-preview {if $pkcart.cart.products_count > 0}active{else}inactive{/if}" data-refresh-url="{$pkcart.refresh_url}">
    <div class="header relative">
      <a rel="nofollow" href="{$pkcart.cart_url}" class="flex-container align-items-center relative cart-icon pk-item-content">
        <svg class="svgic{if isset($itemdata.icon) && !$pkhiconfig.sett_icons} hidden{/if}"{if isset($pkhiconfig.sett_iconsize) && $pkhiconfig.sett_iconsize != ''} style="width:{$pkhiconfig.sett_iconsize}px;height:{$pkhiconfig.sett_iconsize}px"{/if}><use xlink:href="#si-cart"></use></svg>
        <span class="cart-title pkhi-item-title{if !$pkhiconfig.sett_title} hidden{/if}">{l s='Cart' d='Modules.Shoppingcart.Shop'}</span>
        {if ($pkcart.cart.products_count > 0)}
            <span class="cart-products-count header-item-counter" data-cartproducts="{$pkcart.cart.products_count}">{$pkcart.cart.products_count}</span>
        {/if}
      </a>
    </div>
  </div>
</div>
</li>
{/if}
{/function}

{function name="printlink" link='#' title=''}
<li class="smooth02">
    <a href="{$link}" title="{$title}">{$title}</a>
</li>
{/function}

{function name="printformitem" itemdata=[]}
<div class="relative">
    <div class="icon-true">
    <input autocomplete="off" class="form-control" name="{$itemdata.name}" type="{$itemdata.type}" value="" placeholder="{$itemdata.ph}" required="">
    <span class="focus-border"><i></i></span>
    <svg class="svgic input-icon maincolor"><use xlink:href="#si-{$itemdata.icon}"></use></svg>
    </div>
</div>
{/function}

{function name="myaccount"}
<ul>
    {printlink link="{$urls.pages.identity}" title="{l s='Information' d='Shop.Theme.Customeraccount'}"}
{if $customer.addresses|count}
    {printlink link="{$urls.pages.addresses}" title="{l s='Addresses' d='Shop.Theme.Customeraccount'}"}
{else}
    {printlink link="{$urls.pages.address}" title="{l s='Add first address' d='Shop.Theme.Customeraccount'}"}
{/if}
{if !$configuration.is_catalog}
    {printlink link="{$urls.pages.history}" title="{l s='Order history and details' d='Shop.Theme.Customeraccount'}"}
    {printlink link="{$urls.pages.order_slip}" title="{l s='Credit slips' d='Shop.Theme.Customeraccount'}"}
    {if $configuration.voucher_enabled}
    {printlink link="{$urls.pages.discount}" title="{l s='Vouchers' d='Shop.Theme.Customeraccount'}"}
    {/if}
    {if $configuration.return_enabled}
    {printlink link="{$urls.pages.order_follow}" title="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}"}
    {/if}
    {if ($customer.is_logged == 1)}
    {printlink link="{$urls.actions.logout}" title="{l s='Sign out' d='Shop.Theme.Actions'}"}
    {/if}
{/if}
</ul>
{/function}
{function name="loginform"}
<div class="title-wrap flex-container">
    <h4>
        <span class="active" data-pktabname="signin" data-pktabgroup="pkhiloginfom">{l s='Sign in' d='Shop.Theme.Actions'}</span>
        {if $pkhiconfig.item_register}
        <span>/</span>
        <span data-pktabname="register" data-pktabgroup="pkhiloginfom">{l s='Register' d='Shop.Theme.Actions'}</span>
        {/if}
    </h4>
</div>
<div class="form-wrap">
    <form class="customer-form active" data-pktabcontent="signin" data-pktabgroup="pkhiloginfom" method="post" action="{$urls.pages.authentication}">
        <input type="hidden" name="submitLogin" value="1">
        {printformitem itemdata=['name' => 'email', 'type' => 'email', 'icon' => 'email', 'ph' => "{l s='Email' d='Modules.Pkheaderitems.Shop'}"]}
        {printformitem itemdata=['name' => 'password', 'type' => 'password', 'icon' => 'password', 'ph' => "{l s='Password' d='Shop.Forms.Labels'}"]}
        <div class="forgot-password flex-container align-items-top">
            <button class="btn btn-primary" data-link-action="sign-in" type="submit">{l s='Sign in' d='Shop.Theme.Actions'}</button>
            &nbsp;{hook h='displayFacebookConnect'}
        </div>
        <a href="{$urls.pages.password}" rel="nofollow">{l s='Forgot your password?' d='Shop.Theme.Customeraccount'}</a>
    </form>
    <form class="customer-form" method="post" data-pktabcontent="register" data-pktabgroup="pkhiloginfom" action="{$urls.pages.register}?back=identity">
        <input type="hidden" value="1" name="submitCreate">
        <input type="hidden" value="0" name="newsletter">
        <input type="hidden" value="0" name="optin">
        <input type="hidden" value=""  name="id_customer">
        <input type="hidden" value="1" name="id_gender">
        {printformitem itemdata=['name' => 'email', 'type' => 'email', 'icon' => 'email', 'ph' => "{l s='Email' d='Modules.Pkheaderitems.Shop'}"]}
        {printformitem itemdata=['name' => 'firstname', 'type' => 'text', 'icon' => 'account', 'ph' => "{l s='First Name' d='Modules.Pkheaderitems.Shop'}"]}
        {printformitem itemdata=['name' => 'lastname', 'type' => 'text', 'icon' => 'account', 'ph' => "{l s='Last Name' d='Modules.Pkheaderitems.Shop'}"]}
        {printformitem itemdata=['name' => 'password', 'type' => 'password', 'icon' => 'password', 'ph' => "{l s='Password' d='Shop.Forms.Labels'}"]}
        {if isset($id_pkgdpr) && (isset($is_pkgdpr) && $is_pkgdpr)}
          {hook h='displayGDPRConsent' id_module=$id_pkgdpr}
        {/if}
        <div class="pkheader-captcha"></div>
        <button class="btn btn-primary form-control-submit register-button" type="submit" data-back="{$urls.pages.identity}">{l s='Register' d='Shop.Theme.Actions'}</button>
    </form>
</div>
{/function}

{function name="productlist" products=[]}
    {foreach from=$products item=product name=loop}
    {include file='catalog/_partials/miniatures/module-miniproduct.tpl' product=$product}
    {/foreach}
{/function}

{function name="languages"}
    <ul>
    {foreach from=$pklanguage.languages item=language}
    <li>
        <a class="flex-container align-items-center" href="{url entity='language' id=$language.id_lang}" title="{$language.name}">
            <img class="db" src="{$urls.img_lang_url}{$language.id_lang}.jpg" width="16" height="11" alt="{$language.name_simple}" />&nbsp;{$language.name_simple}
        </a>
    </li>
    {/foreach}
    </ul>
{/function}

{function name="currencies"}
    <ul>
    {foreach from=$pkcurrencies.currencies item=currency}
    {if $pkcurrencies.current_currency.iso_code != $currency.iso_code}
    <li>
        <a class="db" href="{$currency.url}" title="{$currency.name}" rel="nofollow">{$currency.iso_code} {$currency.sign}</a>
    </li>
    {/if}
    {/foreach}
    </ul>
{/function}

{function name="printsearch" inline=false order=''}
    {if $inline}
        <li class="pk_search static-important pkorder{$order}{if isset($itemdata.icon) && !$pkhiconfig.sett_icons} hide-icon{/if}">
        {if isset($pkhiconfig.sett_searchwidth) && !empty($pkhiconfig.sett_searchwidth)}
        {literal}<style scoped>@media (min-width: 1024px) { body:not(.gs-popup-search) .pkheaderitems .pk_search {{/literal}width:{$pkhiconfig.sett_searchwidth}px{literal}} }</style>{/literal}
        {/if}
    {/if}
    {assign var="sstr" value=''}
    {if isset($pksearch.search_string)}
        {assign var="sstr" value=$pksearch.search_string}
    {/if}
    {include file='module:ps_searchbar/ps_searchbar.tpl' search_controller_url=$pksearch.search_controller_url search_string=$sstr}
    {if $inline}</li>{/if}
{/function}

{function name="printlinks" links=[]}
    <ul>
    {foreach $links as $link}
      <li>
        <a class="{$link.class}" href="{$link.url}" title="{$link.description}"{if !empty($link.target)} target="{$link.target}"{/if}>
          {$link.title}
        </a>
      </li>
    {/foreach}
    </ul>
{/function}

<div class="pkheaderitems">
    <ul class="flex-container list-unstyled {$pkhiconfig.sett_valign} {$pkhiconfig.sett_halign} {$pkhiconfig.sett_itemsspace} {$pkhiconfig.sett_iconposition}{if isset($indicator_view)} ind-{$indicator_view}{/if}{if $pkhiconfig.sett_title} item-title-true{else} item-title-false{/if}{if $pkhiconfig.sett_icons} item-icon-true{else} item-icon-false{/if}">
        {if $pkhiconfig.item_login}
            {assign var=itemdata value="{l s='Sign in' d='Shop.Theme.Actions'}"}
            {if $customer.is_logged}
                {assign var=itemdata value="{l s='Your account' d='Shop.Theme.Customeraccount'}"}
            {/if}
            {headeritem itemdata = [
                "id" => "pk_register",
                "class" => "dd_cont pk_register",
                "dd_class" => "customer-form-container",
                "title" => $itemdata,
                "icon" => "lock2",
                "sidebar" => true,
                "toggler_id" => "pk-register",
                "active_section" => "login",
                "order" => $pkhiconfig.sett_login_order,
                "href" => {$link->getPageLink('my-account', true)}
            ]}
        {/if}
        {if $pkhiconfig.item_account}
            {assign var=itemdata value=[
                "id" => "pk_myaccount",
                "class" => "dd_list pk_myaccount",
                "title" => "{l s='Your account' d='Shop.Theme.Customeraccount'}",
                "icon" => "account",
                "order" => $pkhiconfig.sett_account_order,
                "href" => {$link->getPageLink('my-account', true)}
            ]}
            
            {if ($customer.is_logged == true)}
                {* @bwlab--------- *}
                {*       aggiunto il nome del gruppo clienti  *}
                {$itemdata['title'] = "{l s='Ciao' d='Modules.Pkheaderitems.Shop'} {$customer.firstname} {$customer.lastname}" }
                {$itemdata['dropdown'] = {myaccount}}
                {$itemdata['groupname'] = {$pkhiconfig.default_group_name}}
                {$itemdata['extra_class'] = 'username'}
            {/if}
            {headeritem itemdata = $itemdata}
        {/if}
        {if $pkhiconfig.item_watchlist}
            {assign var=itemdata value=[
                "id" => "pk_watchlist",
                "class" => "dd_cont pk_watchlist",
                "title" => "{l s='Recently Viewed' d='Modules.Pkheaderitems.Shop'}",
                "icon" => "eye",
                "href" => "#",
                "counter" => 0,
                "order" => $pkhiconfig.sett_watchlist_order
            ]}
            {if !empty($pkwatchlist)}
                {$itemdata['counter'] = count($pkwatchlist)}
            {/if}
            {if (isset($pkhiconfig.sett_watchlist_style) && ($pkhiconfig.sett_watchlist_style == 'sidebar'))}
                {$itemdata['sidebar'] = true}
                {$itemdata['toggler_id'] = "pk-productsbar"}
                {$itemdata['active_section'] = "watchlist"}
            {else}
                {$itemdata['dropdown'] = {productlist products=$pkwatchlist}}
            {/if}
            {headeritem itemdata = $itemdata}
        {/if}
        {if $pkhiconfig.item_compare}
        
            {assign var=itemdata value=[
                "id" => "pkcompare",
                "class" => "dd_cont pk_comparelist",
                "title" => "{l s='comparison' d='Modules.Pkcompare.Shop'}",
                "icon" => "compare",
                "order" => $pkhiconfig.sett_compare_order,
                "counter" => 0,
                "href" => {$link->getModuleLink('pkcompare', 'compare')}
            ]}
            {if !empty($pkcomparelist)}
                {$itemdata['counter'] = count($pkcomparelist)}
            {/if}
            {if (isset($pkhiconfig.sett_compare_style) && ($pkhiconfig.sett_compare_style == 'sidebar'))}
                {$itemdata['sidebar'] = true}
                {$itemdata['toggler_id'] = "pk-productsbar"}
                {$itemdata['active_section'] = "compare"}
            {else}
                {$itemdata['dropdown'] = {productlist products=$pkcomparelist}}
            {/if}
            {headeritem itemdata = $itemdata}
        {/if}
        {if $pkhiconfig.item_favorites}
            {assign var=itemdata value=[
                "id" => "pkfavorites",
                "class" => "dd_cont pk_favorites",
                "title" => "{l s='favorites' d='Modules.Pkfavorites.Shop'}",
                "icon" => "heart",
                "dropdown" => "",
                "counter" => 0,
                "order" => $pkhiconfig.sett_favorites_order,
                "href" => {$link->getModuleLink('pkfavorites', 'account')}
            ]}
            {if !empty($pkfavorites)}
                {$itemdata['counter'] = count($pkfavorites)}
            {/if}
            {if (isset($pkhiconfig.sett_favorites_style) && ($pkhiconfig.sett_favorites_style == 'sidebar'))}
                {$itemdata['sidebar'] = true}
                {$itemdata['toggler_id'] = "pk-productsbar"}
                {$itemdata['active_section'] = "favorites"}
            {else}
                {$itemdata['dropdown'] = {productlist products=$pkfavorites}}
            {/if}
            {headeritem itemdata = $itemdata}
        {/if}
        {if $pkhiconfig.item_cart}
            {assign var=itemdata value=[
                "id" => "desktop_cart",
                "class" => "dd_cont pk_cart cart-title",
                "dd_class" => "shopping_cart",
                "title" => "{l s='Cart' d='Modules.Shoppingcart.Shop'}",
                "icon" => "cart",
                "order" => $pkhiconfig.sett_cart_order,
                "href" => $urls.pages.cart,
                "sidebar" => true,
                "dropdown" => false,
                "toggler_id" => "pk-shoppingcart",
                "active_section" => ''
            ]}
            
            {headercart itemdata = $itemdata}
        {/if}
        {if $pkhiconfig.item_search}
            {assign var=itemdata value=[
                "id" => "pk_search",
                "class" => "dd_el dd_cont pk_search",
                "title" => "{l s='Search' d='Modules.Searchbar.Shop'}",
                "icon" => "search",
                "href" => "#",
                "order" => $pkhiconfig.sett_search_order,
                "dropdown" => {printsearch}
            ]}
            {if ($pkhiconfig.sett_searchview == 'inline')}
                {printsearch inline=true order=$pkhiconfig.sett_search_order}
            {else}
                {headeritem itemdata = $itemdata}
            {/if}
        {/if}
        {if $pkhiconfig.item_languages}
            {assign var=itemdata value=[
                "id" => "pk_languages",
                "class" => "dd_list pk_languages",
                "title" => $pklanguage.current_language.name_simple,
                "icon" => "globe",
                "order" => $pkhiconfig.sett_languages_order
            ]}
            {if (!empty($pklanguage.languages) && count($pklanguage.languages) > 1)}
                {$itemdata['dropdown'] = {languages}}
            {/if}
            {headeritem itemdata = $itemdata}
        {/if}
        {if $pkhiconfig.item_currencies}
            {assign var=itemdata value=[
                "id" => "pk_currencies",
                "class" => "dd_list pk_currencies",
                "title" => $pkcurrencies.current_currency.name,
                "order" => $pkhiconfig.sett_currencies_order,
                "icon" => "currency"
            ]}
            {if (!empty($pkcurrencies.currencies) && count($pkcurrencies.currencies) > 1)}
                {$itemdata['dropdown'] = {currencies}}
            {/if}
            {headeritem itemdata = $itemdata}
        {/if}
        {if $pkhiconfig.item_linklist}
            {if $pkhiconfig.sett_linklistdisplay == 'blocks'}
            {foreach $pklinklist.linkBlocks as $linkBlock}
                {assign var=itemdata value=[
                    "class" => "dd_list pk_linklist",
                    "title" => $linkBlock.title,
                    "order" => $pkhiconfig.sett_linklist_order
                ]}
                {if (!empty($linkBlock.links) && count($linkBlock.links) > 1)}
                    {$itemdata['dropdown'] = {printlinks links=$linkBlock.links}}
                {/if}
                {headeritem itemdata = $itemdata}
            {/foreach}
            {else}
            {foreach $pklinklist.linkBlocks as $linkBlock}
                {foreach $linkBlock.links as $link}
                {headeritem itemdata = [
                    "id" => "pk_linklist",
                    "class" => "dd_cont pk_linklist {$link.class}",
                    "title" => "{$link.description}",
                    "href" => "{$link.url}",
                    "order" => $pkhiconfig.sett_linklist_order
                ]}
                {/foreach}
            {/foreach}
            {/if}
        {/if}
    </ul>
</div>
{else}
<div class="alert alert-danger">
    {l s='Header Items module is not configured' d='Modules.Pkheaderitems.Shop'}
</div>
{/if}