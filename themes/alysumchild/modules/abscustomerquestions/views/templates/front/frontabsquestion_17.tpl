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
     
{extends file='page.tpl'}
     
     
{block name='page_content_container'}
<style type="text/css">
    .abscustomerq-link {
        color: {$color1|cleanHtml} !important;
    }
    .abscustomerq-link:hover, .abscustomerq-link2:hover {
	   color: {$color2|cleanHtml} !important;
    }
    .absq-reported, .absq_no_answers_for_now, .absq_c_seller {
	   color: {$color2|cleanHtml} !important;
    }
    .bt-abs-cq-modal.abs-cq-bt2 {
       background: -webkit-linear-gradient(top,{$color3|cleanHtml},{$color4|cleanHtml}) !important;
	   background: linear-gradient(to bottom,{$color3|cleanHtml},{$color4|cleanHtml}) !important;
    }
    .bt-abs-cq-modal.abs-cq-bt2:hover {
	   background: -webkit-linear-gradient(top,{$color5|cleanHtml},{$color6|cleanHtml}) !important;
	   background: linear-gradient(to bottom,{$color5|cleanHtml},{$color6|cleanHtml}) !important;
    }
</style>
<script type="text/javascript">
const abscqlink1='{$enlace1|cleanHtml nofilter}';
const abscqlink2='{$enlace2|cleanHtml nofilter}';
var abs_cq_postlogeed="{l s='You need to be %link1%logged in%link3% or %link2%screate an account%link3% to post your question' mod='abscustomerquestions'}";
var abs_cq_postvoted="{l s='You need to be %link1%logged in%link3% or %link2%create an account%link3% to performance this action' mod='abscustomerquestions'}";
</script>
 <div class="abs_customerq_block">
<form class="askabscustomerquestion" method="post" onsubmit="return false;">
             <input type="hidden" name="abs_cq_searchController" value="{$abscustomerquestions_controller_url|cleanHtml}">
             <input type="hidden" name="abs_id_product" value="{$abs_id_product|cleanHtml}">
                 <input type="hidden" name="abs_id_lang" value="{$abs_id_lang|cleanHtml}">
             <input type="hidden" name="abs_cq_token" value="{$secure_key|cleanHtml}">
{if $question}
<input type="hidden" name="abs_cqqq" value="{$question.id_absquestion|cleanHtml}">    
<div class="abs_customerq row mb-20"> 
<div class="col-xs-12 col-sm-3 col-md-2" style="text-align:center;">
<a class="abscustomerq-link" href="{$urlproduct|cleanHtml}">
    <img src="{$imgproduct|cleanHtml}" title="{$product->name|cleanHtml}" alt="{$product->name|cleanHtml}" style="max-width:125px;"></a>
<div style="margin-top:12px;">
<a class="abscustomerq-link2" href="{$urlproduct|cleanHtml}">{$product->name|cleanHtml}</a>
</div>
    </div>
<div class="col-xs-12 col-sm-9 col-md-8">
<div id="abs_cqqq{$question.id_absquestion|cleanHtml}" class="abs_text_question">{$question.question|cleanHtml nofilter}</div>
    <p class="abs_text_minus">{l s='asked by' mod='abscustomerquestions'} {if $question['customer_name']!=''}{$question['customer_name']|cleanHtml}.{else}{l s='Customer' mod='abscustomerquestions'} {Configuration::get('PS_SHOP_NAME')}{/if} - {$question.date_add|cleanHtml}</p>
<div id="abs_customerquestions_block_post_question">
<div class="abs_customerquestion abs_row">
{if $question.cananswer} 
<div class="abs_customerquestions_post_question">
<span class="abs_customerquestions_aclaro">{l s='As someone who owns this product, can you help this fellow customer?' mod='abscustomerquestions'}</span>
<span class="bt-abs-cq-modal abs-cq-bt2" style="margin-left:10px; margin-top:10px;">
<button class="absq_post_question" type="button" data-abs_cq_nw="postanswer" data-abs_q="{$question.id_absquestion|cleanHtml}">{l s='Post your answer' mod='abscustomerquestions'}</button></span>
                         </div>
{else}
<div class="abs_customerquestions_post_question">
<span class="abs_customerquestions_aclaro">{$abs_customerq_aclaro|cleanHtml}</span>
<span class="bt-abs-cq-modal abs-cq-bt2" style="margin-left:10px; margin-top:10px;">
    <a href="{$urlproduct|cleanHtml}"><button class="absq_post_question" type="button">{l s='Back to product page' mod='abscustomerquestions'}</button></a></span>
    </div>
{/if}

    </div></div>
</div>
</div>
<div class="abs_customerq row">
<div class="divisor"></div>
<div id="abs_customerquestions_block_page">
{if $question.respuestas}
<p class="abs_text_minus" style="margin-bottom:24px;">{if $totales!=1}{l s='Showing %d-%d of %d answers' mod='abscustomerquestions' sprintf=[$inicio, $final, $totales]}{else}{l s='Showing 1 answer' mod='abscustomerquestions'}{/if}</p>
{foreach $question.respuestas item=respuesta}
<div id="abs_cq_annn{$respuesta['id_absanswer']|cleanHtml}" class="abs_row absq_answer">
<div class="absq_respuesta con_abs">
<span class="absq_responde">{$respuesta.answer|cleanHtml nofilter}                    
    <span class="absq_autor">{l s='By' mod='abscustomerquestions'} {if $respuesta['customer_name']!=''}<span class="absq_user">{$respuesta['customer_name']|cleanHtml}.</span>{else}{if $respuesta['id_customer']==0}<span class="absq_c_seller">{l s='Seller' mod='abscustomerquestions'}</span>{else}<span class="absq_user">{l s='Customer' mod='abscustomerquestions'} {Configuration::get('PS_SHOP_NAME')}</span>{/if}{/if} - {$respuesta.date_add|cleanHtml}</span>
<div class="abs_cq_usefullness abs-row">
<span id="abs_cq_useful{$respuesta['id_absanswer']|cleanHtml}">{if $respuesta.votes==0}
{l s='Do you find this helpful?' mod='abscustomerquestions'}
{else}
    {l s='%d of %d found this helpful.' mod='abscustomerquestions' sprintf=[$respuesta.usefulness, $respuesta.votes]}{if !$respuesta.voted} {l s='Do you?' mod='abscustomerquestions'}{/if}{/if}{if !$respuesta.voted} <a href="#"{if $logged} class="absq_useful" data-abs_q="{$respuesta['id_absanswer']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="absq_useful"{/if}>{l s='Yes' mod='abscustomerquestions'}</a><a href="#"{if $logged} class="absq_useless" data-abs_q="{$respuesta['id_absanswer']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="absq_useless"{/if}>{l s='No' mod='abscustomerquestions'}</a>{/if}</span><span id="abs_cq_report{$respuesta['id_absanswer']|cleanHtml}">&nbsp; | &nbsp;{if $respuesta['reported']}<span class="absq-reported">{l s='Abuse reported' mod='abscustomerquestions'}</span>{else}<a href="#"{if $logged} class="absq_report abscustomerq-link" data-abs_q="{$respuesta['id_absanswer']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="absq_report abscustomerq-link"{/if}>{l s='Report abuse' mod='abscustomerquestions'}</a>{/if}</span>
    </div>
                     </span>
                                               
   
     </div></div>{if !$respuesta@last}
<hr aria-hidden="true" class="abs_cq_divid">{/if}
{/foreach}

{include file='module:abscustomerquestions/views/templates/front/pagination.tpl'}   
 {else}
<div class="abs_row absq_answer">
<div class="absq_respuesta con_abs">
<span class="absq_no_answers_for_now">{l s='No answers for now. This question might be answered by sellers or customers who bought this product.' mod='abscustomerquestions'}</span>
    </div></div>             
{/if}
    </div></div>{/if}</form></div>
<div class="abs_customerq row mb-20"> 
<div class="col-xs-12 col-sm-5 col-md-2" style="text-align:center;">

    </div>
<div class="col-xs-12 col-sm-7 col-md-8">
<div id="abs_customerquestions_block_post_question">
<div class="abs_customerquestion abs_row">
<div class="abs_customerquestions_post_question">
<span class="abs_customerquestions_aclaro">{$abs_customerq_aclaro|cleanHtml}</span>
<span class="bt-abs-cq-modal abs-cq-bt2" style="margin-left:10px;">
    <a href="{$urlproduct|cleanHtml}#abscustomerquestions-module"><button class="absq_post_question" type="button">{l s='See all questions' mod='abscustomerquestions'}</button></a></span>
                     </div>

    </div>
</div>
</div>
</div>
{if $thanked}
<script type="text/javascript">
var abs_cq_thanked=1;
</script>
<div class="modal fade abs-cq-modal" id="abs-cq-thanks" tabindex="-1" role="dialog" >
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h4>{$thanked.title|cleanHtml}</h4>
<button class="closemodalabsq" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>
<div class="modal-body clearfix">
<span class="abs_cq_aclaracion abs_cq_thanks">{$thanked.content|cleanHtml nofilter}</span>
<div class="modal-footer">
<span class="bt-abs-cq-modal"><button data-dismiss="modal" aria-label="Close">{l s='Accept' mod='abscustomerquestions'}</button></span>
</div>
</div>	
</div>
</div>
</div>
{/if}
{if $postanswer}
<script type="text/javascript">
var abs_cq_post=1;
</script>
{/if}
{if $question.cananswer} 
<div class="modal fade abs-cq-modal" id="abs-cq-post-answer" tabindex="-1" role="dialog" >
<div class="modal-dialog" role="document">

<div class="modal-content">
<div class="modal-header">
<h4>{l s='Post your answer' mod='abscustomerquestions'}</h4>
<button class="closemodalabsq" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>
<div class="modal-body clearfix">
<form>
<span class="abs_cq_abs_qq_aclaracion"></span>
<textarea maxlength="150" placeholder="{l s='Please enter your answer.' mod='abscustomerquestions'}" class="abs_cq_askQuestion" name="abs_cq_askQuestion"></textarea>
<input type="hidden" id="abs_cq_callr" name="abs_cq_callr" value="pagefront">
<div class="modal-footer" style="margin-top:14px;">
<div id="abs_postanswer" class="abs_loading ">
<div class="abs_loading_animation animate__animated animate__wobble animate__infinite">
<i class="abs_postquestion_img"></i>
</div></div>
<span class="bt-abs-cq-modal"><button data-dismiss="modal" aria-label="Close">{l s='Cancel' mod='abscustomerquestions'}</button></span>
<span class="bt-abs-cq-modal abs-cq-bt2"><button id="bt-post-abs-answ" type="button" data-abs_q="0">{l s='Post' mod='abscustomerquestions'}</button></span>
</div>
</form>
</div>	
</div>
</div>
</div>
{/if}   
<div class="modal fade abs-cq-modal" id="abs-cq-error" tabindex="-1" role="dialog" >
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h4>{l s='Attention' mod='abscustomerquestions'}</h4>
<button class="closemodalabsq" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>
<div class="modal-body clearfix">
<span class="abs_cq_aclaracion"></span>
<div class="modal-footer">
<span class="bt-abs-cq-modal"><button data-dismiss="modal" aria-label="Close">{l s='Accept' mod='abscustomerquestions'}</button></span>
</div>
</div>	
</div>
</div>
</div>
<div class="modal fade abs-cq-modal" id="abs-cq-notif" tabindex="-1" role="dialog" >
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<span class="abs-cq-icon"><i></i></span>
<h4 style="margin-left:30px;"></h4>
<button class="closemodalabsq" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>
<div class="modal-body clearfix">
<span class="abs_cq_aclaracion with_abs_line"></span>
<div class="modal-footer" style="text-align:center;">
<span class="bt-abs-cq-modal"><button data-dismiss="modal" aria-label="Close">{l s='Accept' mod='abscustomerquestions'}</button></span>
</div>
</div>	
</div>
</div>
</div> 
{/block}