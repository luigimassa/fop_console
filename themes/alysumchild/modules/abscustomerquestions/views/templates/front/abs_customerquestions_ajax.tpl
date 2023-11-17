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
                        <button class="absq_post_question" type="button" data-abs_cq_nw="postanswer" data-abs_q="{$question['id_absquestion']|cleanHtml}">{l s='Post your answer' mod='abscustomerquestions'}</button></span>{/if}
{/if}
</div></div></div></div>
{$count=$count+1}
{if $count==$nqp}
{$count=0}
{$estapage=$estapage+1}
{if $totales-($nqp*($estapage-1))!=0}
<div id="absq_mq_{$clase|cleanHtml}search" class="absq_morequestions abs_row">
<span class="boton_absq_moreq_{$clase|cleanHtml}search bt-abs-cq-modal" data-abs_q_pager="{$estapage|cleanHtml}"><button><i class="absq_chevron"></i>  {l s='See more questions' mod='abscustomerquestions'} ({$totales-($nqp*($estapage-1))})</button></span></div>
{if $estapage>2}</div>{/if}
<div id="absq_{$clase|cleanHtml}search_page{$estapage|cleanHtml}" style="display:none;">
{/if}
{/if}

{/foreach}
    {if $resto!=0 && $estapage>1}</div>{/if}

{else}
<div class="abs_customerquestion abs_row">
    <div class="abs_question_text_noresults con_abs">{$abs_customerq_no_matching|cleanHtml}</div>
</div>
{/if}