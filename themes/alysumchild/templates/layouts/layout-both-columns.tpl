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
 
{* get elementor template ID in Editor mode *}
{assign var='preview_id' value=false}
{if isset($smarty.get.uid)} {* legacy variable, CE 1.4.10 *}
  {assign var='preview_id' value=$smarty.get.uid}
{/if}
{if isset($smarty.get.preview_id)} {* preview ID CE >=2.5 *}
  {assign var='preview_id' value=$smarty.get.preview_id}
{/if}

<!doctype html>
<html lang="{$language.locale}">

  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

  <body id="{$page.page_name}" class="{$page.body_classes|classnames}">

    {block name='hook_after_body_opening_tag'}
      {hook h='displayAfterBodyOpeningTag'}
    {/block}

    <div id="pattern" class="root-item">

      {block name='product_activation'}
        {include file='catalog/_partials/product-activation.tpl'}
      {/block}

      {if !$preview_id}
      {block name='header'}
        {include file='_partials/header.tpl'}
      {/block}
      {/if}

      <section class="main-contant-wrapper">
        <h2 class="hidden">Alysum theme section heading</h2>

        {hook h="displayWrapperTop"}

        {if $preview_id && isset($smarty.get.controller)}
          {assign var="CT" value=$smarty.get.controller}
          
          {if $CT == 'index' && isset($PKCE)} {* these hooks used to edit elementor "Content Anywhere" *}
            {assign var="hookName" value=$PKCE::getUidHook($preview_id)}
            {if $hookName}{hook h=$hookName}{/if}
          {/if}

          {if $CT == 'preview'} {* block for elementor preview mode *}
            {block name='content'}{/block}
          {/if}

          {if $CT == 'cms'} {* block used to edit elementor CMS pages *}
            {block name='page_content_container'}{/block}
          {/if}

          {if $CT == 'product'} {* block used to edit product footer & description *}
          <div class="elementor-template-hook">
            {block name="content_wrapper"}{/block}
          </div>
          {/if}

          {if $CT == 'category'} {* block used to edit category description *}
            {$category.description nofilter}
          {/if}

          {if $CT == 'manufacturer'} {* block used to edit brand description *}
            {$manufacturer.description nofilter}
          {/if}

        {else}

          {if !isset($pktheme) || empty($pktheme)}

            <p class="elementor-alert elementor-alert-danger">
              "Theme Settings" module error. Make sure the module is installed, enabled, and hooked on "displayHeader" hook.
            </p>

          {else}

            {if ($page.page_name == 'index')}

              {if $pktheme.hp_builder == 0}
                {hook h='displayHomeBuilder'}
              {else}
                {hook h='CETemplate' id="{$pktheme.hp_builder}"}
              {/if}

            {else}

              <div class="page-width top-content">
                {block name='notifications'}
                  {include file='_partials/notifications.tpl'}
                {/block}

                {block name='breadcrumb'}
                  {include file='_partials/breadcrumb.tpl'}
                {/block}
              </div>

              {if ($page.page_name == 'category') && ($pktheme.cp_builder_layout != 0)}

                {if ($pktheme.cp_builder_layout == -1)}
                  {hook h='displayCategoryPageBuilder'}
                {else}
                  {hook h='CETemplate' id="{$pktheme.cp_builder_layout}"}
                {/if}
                
              {else}

                <div class="page-width main-content">
                  <div id="wrapper" class="clearfix container">
                    <div class="row">

                      {block name='left_column'}
                        <div id="left-column" class="sidebar col-xs-12 col-sm-4 col-md-3 relative smooth05">
                          {if $page.page_name == 'product'}
                            {hook h='displayLeftColumnProduct'}
                          {else}
                            {hook h='displayLeftColumn'}
                          {/if}
                          <div class="sidebar-toggler flex-container align-items-center justify-content-center smooth05 hidden">
                            <svg class="svgic smooth05"><use xlink:href="#si-arrowleft"></use></svg>
                          </div>
                        </div>
                      {/block}

                      {block name='right_column'}
                        <div id="right-column" class="sidebar col-xs-12 col-sm-4 col-md-3">
                          {if $page.page_name == 'product'}
                            {hook h='displayRightColumnProduct'}
                          {else}
                            {hook h='displayRightColumn'}
                          {/if}
                        </div>
                      {/block}

                      {block name='content_wrapper'}
                        <div id="content-wrapper" class="wide left-column right-column">
                          {block name='content'}{/block}
                        </div>
                      {/block}

                    </div>
                  </div>
                </div>

              {/if}
            {/if}
          {/if}
        {/if}
        {hook h="displayWrapperBottom"}
      </section>

      {if !$preview_id}
      <footer id="footer" class="relative js-footer">
        {block name='footer'}
          {include file='_partials/footer.tpl'}
        {/block}
      </footer>
      {/if}

    </div>

    {block name='svg_graphics'}
      {include file='_partials/svg.tpl'} {* theme's SVG library *}
    {/block}

    {block name='javascript_bottom'}
      {include file='_partials/javascript.tpl' javascript=$javascript.bottom}
    {/block}

    {if !$preview_id}
    {block name='hook_before_body_closing_tag'}
      {hook h='displayBeforeBodyClosingTag'}
    {/block}
    {/if}
  </body>

</html>
