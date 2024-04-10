{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
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
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 *}

{assign var=grigio_scuro value="#818080"}
{assign var=grigio_leggero value="#EDEDED"}
{assign var=bianco value="white"}
{assign var=verde value="#95C11F"}
{assign var=backgroundgreen value="#95C11F"}

{assign var=color_header value="#F0F0F0"}
{assign var=color_border value="#000000"}
{assign var=color_border_lighter value="#CCCCCC"}
{assign var=color_line_even value="#FFFFFF"}
{assign var=color_line_odd value="#F9F9F9"}
{assign var=font_size_text value="9pt"}
{assign var=font_size_header value="9pt"}
{assign var=font_size_product value="9pt"}
{assign var=height_header value="20px"}
{assign var=table_padding value="4px"}
{assign var=boder_width value=""}
{assign var=is_solid value=""}

<style>
    /* stili generali */
    .left {
        text-align: left !important;
    }

    .fright {
        float: right;
    }

    .right {
        text-align: right !important;
    }

    .center {
        text-align: center !important;
    }

    .bold {
        font-weight: bold;
    }

    .border {
        border: 1px solid black;
    }
    .background-green{
        background-color: {$backgroundgreen} !important;
    }

    .no_top_border {
        border-top: hidden;
        border-bottom: 1px solid black;
        border-left: 1px solid black;
        border-right: 1px solid black;
    }

    .grey {
        background-color: {$color_header};

    }

    .white {
        background-color: #FFFFFF;
    }

    .big, tr.big td {
        font-size: 110%;
    }

    .small, table.small th, table.small td {
        font-size: small;
    }

    table, th, td {
        margin: 0 !important;
        padding: 0 !important;
        vertical-align: middle;
        white-space: nowrap;
    }
     th{
        padding: 4px !important;
    }

    tr.color_line_even {
        background-color: {$color_line_even};
    }

    tr.color_line_odd {
        background-color: {$color_line_odd};
    }

    tr.separator td {
        border-top: 1px solid;
    }

    tr.customization_data td {
    }

    /* testata conferma */
    table.intestazione {

    }

    table.tipo-documento {
        margin:0;
    }

    /* lista indirizzi - testata conferma*/
    table#addresses-tab tr td {
        font-size: large;
    }

    table#addresses-tab td.fatturazione {

    }

    table#addresses-tab td.spedizione {

    }

    table#addresses-tab td.dati-ordine {

    }

    /* testata tabella prodotti */
    table.product th {
        font-size: 8px;
        color: white;
    }
    table.product th.header {
        font-size: {$font_size_header};
        height: {$height_header};
        background-color: {$grigio_scuro};
        vertical-align: middle;
        text-align: center;
        font-weight: bold;
        color: {$bianco};
    }

    table.product th.header-right {
        font-size: {$font_size_header};
        height: {$height_header};
        background-color: {$grigio_scuro};
        vertical-align: middle;
        text-align: right;
        font-weight: bold;
        color: {$bianco};
    }
    table.product th.product {
        border-bottom: 1px solid {$color_border};
    }

    table.product tr.product td {
        border-bottom: 1px solid {$color_border_lighter};
    }

    table.product td.product {
        vertical-align: middle;
        font-size: {$font_size_product};
    }



    /* totale conferma */
    table#total-tab {
        padding: {$table_padding};
    }
    table#total-tab td.label{
        padding: 4px !important;
    }
    table#total-tab tr.bold.big.right td.label{
        color: {$bianco};
        background: {$verde}
    }
    table#total-tab td.amount{

    }
    {* box testo libero *}
    table#free-text-box td{
        text-align: left;
    }
    table#free-text-box td p.metodo-spedizione{
    }
    table#free-text-box td p.primo-testo{
        color: red;
    }
    table#free-text-box td p.primo-testo span.indirizzo-mail{
        color: {$verde};
    }
    table#free-text-box td p.secondo-testo span.label{

    }
    table#free-text-box td p.secondo-testo span.banca{
            color: #858585;
    }
    table#free-text-box td p.thanks{
        font-size: 20px;
        color: {$verde};
    }

    {* note del cliente*}
    table#note-tab tr {
        padding: {$table_padding};

    }

    table#note-tab td.note {
        word-wrap: break-word;
    }


    table#footer{
        width: 100%;
        background-color: {$grigio_scuro};
        padding: {$table_padding} !important;
        color: {$bianco};
    }


</style>

