{*
* File Uploads
*
* NOTICE OF LICENSE
*
* This source file is subject to the Open Software License (OSL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/osl-3.0.php
*
* @author    FMM Modules
* @copyright Copyright 2021 © FMM Modules
* @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
* @category  FMM Modules
* @package   customercliche
*}

<div id="customercliche{if isset($id) AND $id}-{$id|escape:'htmlall':'UTF-8'}{/if}">
    <script type="text/javascript">
        var check_cart_prod = parseInt("{$checkCartProduct|escape:'htmlall':'UTF-8'}");
    </script>

    <!-- list template -->
    <script type="text/html" id="files-template">
        <li class="media">
            <div class="col-lg-12">
                <div class="col-md-3">
                    <img class="mr-3 mb-2 preview-img"
                         width="64"
                         src="{if $force_ssl == 1}{$base_dir_ssl|escape:'htmlall':'UTF-8'}{else}{$base_dir|escape:'htmlall':'UTF-8'}{/if}modules/customercliche/views/img/no_image.png">
                    <div class="mb-2 file_name">
                        <strong>%%filename%%</strong>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="media-body mb-1">
                        <div class="file_details col-md-12">
                            <div class="form-group row">
                                <!-- file title -->
                                <div class="col-md-12">
                                    <input type="text" class="form-control"
                                           placeholder="{l s='Title' mod='customercliche'}"
                                           name="title_%%id_file%%" value="">
                                    {if $title_required}<p class="detail-required">*{l s='required' mod='customercliche'}
                                    <p>{/if}
                                </div>
                            </div>
                            <!-- file description -->
                            <div class="form-group row">
                                <div class="col-md-12">
                  <textarea type="text" class="form-control" placeholder="{l s='Description' mod='customercliche'}"
                            name="desc_%%id_file%%"></textarea>
                                    {if $description_required}<p class="detail-required">
                                        *{l s='required' mod='customercliche'}<p>{/if}
                                </div>
                            </div>
                        </div>
                        <div class="file_actions col-md-12">
                            <div class="form-group row">
                                <div class="col-md-6">
                                    <button class="up_button btn btn-info"
                                            data-file="%%id_file%%"
                                            disabled="disabled"
                                            title="{l s='Update' mod='customercliche'}">
                                        {l s='Update' mod='customercliche'}
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="del_button btn btn-danger"
                                            data-file="%%id_file%%"
                                            disabled="disabled"
                                            title="{l s='Delete File' mod='customercliche'}">
                                        {l s='Delete' mod='customercliche'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary" role="progressbar"
                     style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="col-lg-12">
                <div class="file-status">
                    {l s='Status' mod='customercliche'}:
                    <span class="upload_status text-muted status">{l s='Waiting' mod='customercliche'}</span>
                </div>
                <div class="controls mb-2">
                    <button href="#" class="btn btn-sm btn-primary upload-start"
                            role="button">{l s='Start' mod='customercliche'}</button>
                    <button href="#" class="btn btn-sm btn-warning upload-cancel" role="button"
                            disabled="disabled">{l s='Cancel' mod='customercliche'}</button>
                </div>
                <hr class="mt-1 mb-1"/>
                <div>
        </li>
    </script>
</div>