{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{block name='head_seo'}
    <title>{block name='head_seo_title'}{$page.meta.title}{/block}</title>
    {block name='hook_after_title_tag'}{hook h='displayAfterTitleTag'}{/block}
    <meta charset="utf-8">
    <meta name="description" content="{block name='head_seo_description'}{$page.meta.description}{/block}">
    {if $page.meta.keywords !== ''}
        <meta name="keywords" content="{block name='head_seo_keywords'}{$page.meta.keywords}{/block}">
    {/if}
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="marek[at]promokit.eu">
    <meta name="copyright" content="promokit.eu">
    <meta name="application-name" content="Alysum Prestashop AMP Template">
    {if isset($pktheme.version)}
        <meta name="application-version" content="{$pktheme.version}">
    {/if}
    {if $page.meta.robots !== 'index'}
        <meta name="robots" content="{$page.meta.robots}">
    {/if}
    {block name='head_microdata'}
        {include file="_partials/microdata/head-jsonld.tpl"}
    {/block}
    {block name='head_microdata_special'}{/block}
    {block name='head_pagination_seo'}
        {include file="_partials/pagination-seo.tpl"}
    {/block}
    {block name='head_open_graph'}
        {if  $page.page_name  == 'module-h_simpleblog-single'}
            <meta property="og:url" content="{$urls.current_url}">
            <meta property="og:title" content="{$page.meta.title}">
            <meta property="og:locale" content="{$language.locale}">
            <meta property="og:site_name" content="{Configuration::get('PS_SHOP_NAME')}">
            {if !isset($product) && $page.page_name != 'product'}
                <meta property="og:type" content="website">
                <meta property="og:description" content="{$page.meta.description}">
                <meta property="og:image" content="{$shop.logo}">
            {/if}
        {/if}
        {foreach from=$urls.alternative_langs item=pageUrl key=code}
            <meta property="og:locale:alternate" content="{$code}">
        {/foreach}
    {/block}
    {block name='head_canonical'}
        <link rel="canonical" href="{if $page.canonical}{$page.canonical}{else}{$urls.current_url}{/if}">
    {/block}
    {block name='head_hreflang'}
        {if (isset($urls.alternative_langs) && ($urls.alternative_langs|count > 1))}
            {foreach from=$urls.alternative_langs item=pageUrl key=code}
                <link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
            {/foreach}
        {/if}
    {/block}
{/block}

{block name='head_icons'}
    <link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
    <link rel="icon shortcut" type="image/x-icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
{/block}

{block name='stylesheets'}
    {include file="_partials/stylesheets.tpl" stylesheets=$stylesheets}
{/block}

{block name='javascript_head'}
    {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}
{/block}

{block name='hook_header'}
    {$HOOK_HEADER nofilter}{hook h="displayTagManager"}
{/block}

{block name='hook_extra'}{/block}