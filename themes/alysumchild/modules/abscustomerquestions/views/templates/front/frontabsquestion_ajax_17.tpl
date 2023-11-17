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
{if $question.respuestas}
<p class="abs_text_minus" style="margin-bottom:24px;">{l s='Showing %d-%d of %d answers' mod='abscustomerquestions' sprintf=[$inicio, $final, $totales]}</p>
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
<span class="absq_no_answers_for_now">{l s='No answers for now' mod='abscustomerquestions'}</span>
    </div></div>
                
             
             
{/if}
