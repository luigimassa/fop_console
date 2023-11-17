{* 2020- Antonio Baena Sánchez
 *
 * MODULE AbsCustomerQuestions
 *
 * @author    Antonio Baena SÃ¡nchez
 * @copyright Copyright (c) permanent, Antonio Baena Sánchez
 * @license   Addons PrestaShop license limitation
 * @version   1.0.5
 *
 * NOTICE OF LICENSE
 *
 * Don't use this module on several shops. The license provided by PrestaShop Addons
 * for all its modules is valid only once for a single shop.
 *}
 <div class="abs_cq_pagination_block">
{if $showpagination}
{assign var="puntos" value="0"}
<ul class="abs_cq_pagination_list">
<li class="{if $pagera!=1}abs_cq_page{else}abs_cq_page_disabled{/if}">{if $pagera!=1}<a class="abs_cq_gopage" href="#" data-absq-page="{$pagera-1|cleanHtml}">{/if}←<span class="abs-cq-space"></span><span class="abs-cq-space"></span>{l s='Previous' mod='abscustomerquestions'}{if $pagera!=1}</a>{/if}</li>
{for $count=1 to $totalpages}
{if $count==$pagera}
<li class="abs_cq_page abs_cq_page_current"><a href="#" onclick="return false;">{$count|cleanHtml}</a></li>
{else}
{if $count==1 || $count==$pagera-1 || $count==$pagera+1 || ($count+3>=$totalpages && $pagera+3>=$totalpages) || ($count-2<=1 && $pagera-3<=1)}
{if $puntos=="1"}
<li class="abs_cq_page_disabled">...</li>
{$puntos="0"}
{/if}
<li class="abs_cq_page"><a class="abs_cq_gopage" href="#" data-absq-page="{$count|cleanHtml}">{$count|cleanHtml}</a></li>
{else}
{$puntos="1"}
{/if}
{/if}
{/for}
{if $puntos=="1"}
<li class="abs_cq_page_disabled">...</li>
{$puntos="0"}
<li class="abs_cq_page_disabled">{$totalpages|cleanHtml}</li>
{/if}
<li class="{if $pagera!=$totalpages}abs_cq_page{else}abs_cq_page_disabled{/if}">{if $pagera!=$totalpages}<a class="abs_cq_gopage" href="#" data-absq-page="{$pagera+1|cleanHtml}">{/if}{l s='Next' mod='abscustomerquestions'}<span class="abs-cq-space"></span><span class="abs-cq-space"></span>→{if $pagera!=$totalpages}</a>{/if}</li>
</ul>
{/if}
<hr aria-hidden="true" class="abs_cq_divid">
</div>