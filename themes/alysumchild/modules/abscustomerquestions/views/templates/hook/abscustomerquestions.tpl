{* 2020- Antonio Baena Sánchez
 *
 * MODULE AbsCustomerQuestions
 *
 * @author    Antonio Baena SÃ¡nchez <abs@permotor.com>
 * @copyright Copyright (c) permanent, Antonio Baena Sánchez
 * @license   Addons PrestaShop license limitation
 * @version   1.0.5
 *
 * NOTICE OF LICENSE
 *
 * Don't use this module on several shops. The license provided by PrestaShop Addons
 * for all its modules is valid only once for a single shop.
 *}
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
var abs_cq_black_list={$blacklist|cleanHtml nofilter};
</script><a name="abscustomerquestions-module"></a>
<section class="page-product-box">    
<h3 class="abs_customerq page-product-heading">{$abs_customerq_title|cleanHtml nofilter}</h3>
<div class="abs_customerq_block">
<form class="askabscustomerquestion" method="post" onsubmit="return false;">
    <input type="hidden" name="abs_cq_searchController" value="{$abscustomerquestions_controller_url|cleanHtml}">
    <input type="hidden" name="abs_id_product" value="{$abs_id_product|cleanHtml}">
    <input type="hidden" name="act_abs_q_query" value="">
    <input type="hidden" name="abs_id_lang" value="{$abs_id_lang|cleanHtml}">
    <input type="hidden" name="abs_cq_token" value="{$secure_key|cleanHtml}">
<div class="inputaskabscustomerq"{if !$questions} style="display:none;"{/if}>
<div class="borro_abs_cq"></div>
    <input id="abs_question_search" class="a-input-abscustomerq form-control" type="search" maxlength="150" placeholder="{$abs_customerq_input|cleanHtml}" autocomplete="off" value="">    
</div>
<div id="abs_loading" class="abs_loading ">
    <div class="abs_loading_animation animate__animated animate__wobble animate__infinite"><i class="abs_loading_img"></i>
    </div>
</div>
<div class="abs_customerq_container">
<div id="abs_customerquestions_block_no_search" style="display:{if $questions}block{else}none{/if}">
{if $questions}
     {assign var="count" value="0"}
     {assign var="estapage" value="1"}
{foreach from=$questions item=question}
<div class="abs_customerquestion abs_row">
<div class="vote_abscustomerquestion con_abs">
<ul>
<li class="vote_abs_up"><a href="#"{if $logged} class="abs_qvoteup" data-abs_q="{$question['id_absquestion']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="abs_qvotenup"{/if}><img src="/img/cms/icone/sopra.svg"></a></li>
<li class="vote_abs_actual" id="abs_cq_vote{$question['id_absquestion']|cleanHtml}">{$question['votes']|cleanHtml}<br>{if $question['votes']!=1}{l s='votes' mod='abscustomerquestions'}{else}{l s='vote' mod='abscustomerquestions'}{/if}</li>
<li class="vote_abs_down"><a href="#"{if $logged} class="abs_qvotedown" data-abs_q="{$question['id_absquestion']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="abs_qvotenup"{/if}><img src="/img/cms/icone/sotto.svg"></a></li>
</ul>
</div>
<div class="abs_question_text con_abs">
<div class="abs_row">
<div class="absq_encabezado con_abs">{if $userid==$question['id_customer']}{l s='Your Question:' mod='abscustomerquestions'}{else}{l s='Question:' mod='abscustomerquestions'}{/if}</div>    
    <div class="absq_pregunta con_abs"><a class="abscustomerq-link" href="{$question.enlace|cleanHtml nofilter}"><span id="abs_cqqq{$question['id_absquestion']|cleanHtml}">{$question['question']|cleanHtml nofilter}</span></a><span class="absq_autor">{l s='By' mod='abscustomerquestions'} <span class="absq_user">{if $question['customer_name']!=''}{$question['customer_name']|cleanHtml}.{else}{l s='Customer' mod='abscustomerquestions'} {Configuration::get('PS_SHOP_NAME')}{/if}</span> - {$question['date_add']|cleanHtml}</span></div>
</div>
{if $question['respuestas']}
<div class="abs_row">
<div class="absq_encabezado con_abs">{l s='Answer:' mod='abscustomerquestions'}</div> 
<div class="absq_respuesta con_abs">
{foreach $question['respuestas'] item=respuesta}
<span class="absq_responde"><span id="abs_cqaa{$respuesta['id_absanswer']|cleanHtml}">{if isset($respuesta['answershort'])}<span class="absq_textshort">{$respuesta['answershort']|cleanHtml nofilter}</span><a class="absq_seemore" href="#">{l s='See more' mod='abscustomerquestions'}</a>
<span class="absq_textlong">{$respuesta['answer']|cleanHtml nofilter}</span><a class="absq_seeless" href="#">{l s='See less' mod='abscustomerquestions'}</a>{else}{$respuesta['answer']|cleanHtml nofilter}{/if}</span>
<span class="absq_autor">{l s='By' mod='abscustomerquestions'} {if $respuesta['customer_name']!=''}{$respuesta['customer_name']|cleanHtml}.{else}{if $respuesta['id_customer']==0}<span class="absq_c_seller">{l s='Seller' mod='abscustomerquestions'}</span>{else}{l s='Customer' mod='abscustomerquestions'} {Configuration::get('PS_SHOP_NAME')}{/if}{/if} - {$respuesta.date_add|cleanHtml}</span>
<div class="abs_cq_usefullness abs-row">
<span id="abs_cq_useful{$respuesta['id_absanswer']|cleanHtml}">{if $respuesta.votes==0}
{l s='Do you find this helpful?' mod='abscustomerquestions'}
{else}
{l s='%d of %d found this helpful.' mod='abscustomerquestions' sprintf=[$respuesta.usefulness, $respuesta.votes]}{if !$respuesta.voted} {l s='Do you?' mod='abscustomerquestions'}{/if}{/if}{if !$respuesta.voted} <a href="#"{if $logged} class="absq_useful" data-abs_q="{$respuesta['id_absanswer']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="absq_useful"{/if}>{l s='Yes' mod='abscustomerquestions'}</a><a href="#"{if $logged} class="absq_useless" data-abs_q="{$respuesta['id_absanswer']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="absq_useless"{/if}>{l s='No' mod='abscustomerquestions'}</a>{/if}</span><span id="abs_cq_report{$respuesta['id_absanswer']|cleanHtml}">&nbsp; | &nbsp;{if $respuesta['reported']}<span class="absq-reported">{l s='Abuse reported' mod='abscustomerquestions'}</span>{else}<a href="#"{if $logged} class="absq_report abscustomerq-link" data-abs_q="{$respuesta['id_absanswer']|cleanHtml}"{else} data-abs_cq_nw="postvoted" class="absq_report abscustomerq-link"{/if}>{l s='Report abuse' mod='abscustomerquestions'}</a>{/if}</span>
</div>
</span>
{if $question['respuestas']|@count > 1 && $respuesta@iteration==1}{$restan=($question['respuestas']|@count)-1} 
<a class="absq_moreanswers abscustomerq-link" href="#"><i class="absq_chevron"></i> {l s='See more answers' mod='abscustomerquestions'} ({$restan|cleanHtml})</a>
<span class="absq_restanswers">{/if}
{/foreach}
{if $question['respuestas']|@count > 1} 
<span class="absq_lessanswers bt-abs-cq-modal">
<button class="boton_absq_less"><i class="absq_chevron_up"></i> {l s='Collapse all answers' mod='abscustomerquestions'}</button>
</span></span>{/if} 
{if $question['cananswer']}     
<span class="bt-abs-cq-modal abs-cq-bt2">
<button class="absq_post_question" type="button" data-abs_cq_nw="postanswer" data-abs_q="{$question['id_absquestion']|cleanHtml}">{l s='Post your answer' mod='abscustomerquestions'}</button></span>{/if}   
 {else}
<div class="abs_row norespuestas{$question['id_absquestion']|cleanHtml}">
<div class="absq_encabezado con_abs"></div> 
<div class="absq_respuesta con_abs">
<span class="absq_no_answers_for_now absq_responde">{l s='No answers for now' mod='abscustomerquestions'}</span>
{if $question['cananswer']}<span class="bt-abs-cq-modal abs-cq-bt2">
<button class="absq_post_question" type="button" data-abs_cq_nw="postanswer" data-abs_q="{$question['id_absquestion']|cleanHtml}">{l s='Post your answer' mod='abscustomerquestions'}</button></span>{/if}     {/if}
</div></div></div></div>
    
{$count=$count+1}
{if $count==$nqp}
{$count=0}
{$estapage=$estapage+1}
{if $totales-($nqp*($estapage-1))!=0}
<div id="absq_mq_no_search" class="absq_morequestions abs_row">
<span class="boton_absq_moreq_no_search bt-abs-cq-modal" data-abs_q_pager="{$estapage|cleanHtml}"><button><i class="absq_chevron"></i>  {l s='See more questions' mod='abscustomerquestions'} ({$totales-($nqp*($estapage-1))|cleanHtml})</button></span></div>
{if $estapage>2}</div>{/if}
<div id="absq_no_search_page{$estapage|cleanHtml}" style="display:none;">
{/if}
{/if}

{/foreach}
{if $resto!=0 && $estapage>1}</div>{/if}
{/if}              
</div>                
</div>
<div id="abs_customerquestions_block_search">
</div>                
<div id="abs_customerquestions_block_post_question">
<div class="abs_customerquestion abs_row">
                         <div class="abs_customerquestions_post_question">
                             <span class="abs_customerquestions_aclaro">{if $questions}{l s='Don\'t see the answer you\'re looking for?' mod='abscustomerquestions'}{else}{l s='No questions about the product at the moment,' mod='abscustomerquestions'}{/if}</span>
                             <span class="bt-abs-cq-modal abs-cq-bt2" style="margin-left:10px;">
                        <button class="absq_post_question" type="button" data-abs_cq_nw={if $logged}"postquestion"{else}"postlogeed"{/if}>{l s='Post your question' mod='abscustomerquestions'}</button></span>
                         </div>
</div>
</div>
</div>
</form>  
</div>

<div class="modal fade abs-cq-modal" id="abs-cq-post-question" tabindex="-1" role="dialog" >
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<h4>{l s='Post your question' mod='abscustomerquestions'}</h4>
<button class="closemodalabsq" data-dismiss="modal" aria-label="Close">
<span aria-hidden="true">&times;</span>
</button>
</div>
<div class="modal-body clearfix">
<form>
<textarea maxlength="150" placeholder="{l s='Please enter a question.' mod='abscustomerquestions'}" class="abs_cq_askQuestion" name="abs_cq_askQuestion"></textarea>
<span class="abs_cq_aclaracion">{l s='Your question might be answered by both vendors and customers who have purchased this product.' mod='abscustomerquestions'}</span>
<div class="modal-footer">
<div id="abs_postquestion" class="abs_loading ">
<div class="abs_loading_animation animate__animated animate__wobble animate__infinite">
<i class="abs_postquestion_img"></i>
</div></div>
<span class="bt-abs-cq-modal"><button data-dismiss="modal" aria-label="Close">{l s='Cancel' mod='abscustomerquestions'}</button></span>
<span class="bt-abs-cq-modal abs-cq-bt2"><button id="bt-post-abs-cq" type="button" data-abs_q="0">{l s='Post' mod='abscustomerquestions'}</button></span>
</div>
</form>
</div>	
</div>
</div>
</div>
     
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
<textarea maxlength="4000" placeholder="{l s='Please enter your answer.' mod='abscustomerquestions'}" class="abs_cq_askQuestion" name="abs_cq_askQuestion"></textarea>
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
</section>