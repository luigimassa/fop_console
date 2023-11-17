<div class="block-contactinfo contact-form-widget">
    <form
            action="{$urls.pages.contact}"
            method="post">
        <div class="form-fields">

            {*-----------------*}
            {*  campi custom  *}
            <div class="form-group col-md-6">
                <div class="icon-true relative">
                    <input
                            class="form-control input-txt"
                            type="text"
                            name="referente"
                            value=""
                            required
                            placeholder="{l
                            s='referente' d='Modules.Pkelements.Pkcontactform'}"/>
                    <svg class="svgic input-icon">
                        <use xlink:href="#si-account"></use>
                    </svg>
                </div>
            </div>

            <div class="form-group col-md-6">
                <div class="icon-true relative">
                    <input
                            class="form-control input-txt"
                            type="text"
                            name="azienda"
                            value=""
                            required
                            placeholder="{l
                            s='azienda'   d='Modules.Pkelements.Pkcontactform'}"/>
                    <svg class="svgic input-icon">
                        <use xlink:href="#si-rocket"></use>
                    </svg>
                </div>
            </div>

            <div class="form-group col-md-6">
                <div class="icon-true relative">
                    <input
                            class="form-control input-txt"
                            type="text"
                            name="telefono"
                            value=""
                            placeholder="{l
                            s='telefono'   d='Modules.Pkelements.Pkcontactform'}"/>
                    <svg class="svgic input-icon">
                        <use xlink:href="#si-phone"></use>
                    </svg>
                </div>
            </div>

            <div class="form-group col-md-6">
                <div class="icon-true relative">
                    <input
                            class="form-control input-txt ac-email"
                            type="email"
                            name="from"
                            value=""
                            required
                            placeholder="{l s='Email' d='Modules.Pkelements.Pkcontactform'}"/>
                    <svg class="svgic input-icon">
                        <use xlink:href="#si-email"></use>
                    </svg>
                </div>
            </div>

            <div class="form-group col-xs-12">
                <div class="icon-true relative">
                    <select required
                            class="form-control input-txt"
                            name="settore">
                        <option>{l s='seleziona il tuo settore....' d='Modules.Pkelements.Pkcontactform'} </option>
                        <option value="Pasticceria - Caffetteria - Bar">{l s='Pasticceria - Caffetteria - Bar' d='Modules.Pkelements.Pkcontactform'} </option>
                        <option value="Gelateria">{l s='Gelateria' d='Modules.Pkelements.Pkcontactform'} </option>
                        <option value="Birreria - Enoteca - Pub">{l s='Birreria - Enoteca - Pub' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Paninerie - Hamburgerie">{l s='Paninerie - Hamburgerie' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Ristorazione Italiana - Pizzeria">{l s='Ristorazione Italiana - Pizzeria' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Ristorazione Internazionale">{l s='Ristorazione Internazionale' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Macellerie - Pescherie">{l s='Macellerie - Pescherie' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Aziende Agricole">{l s='Aziende Agricole' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Studi medici">{l s='Studi medici' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="E-commerce">{l s='E-commerce' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Negozi fisici">{l s='Negozi fisici' d='Modules.Pkelements.Pkcontactform'}</option>
                        <option value="Ospitality (B&B - Hotel)">{l s='Ospitality (B&B - Hotel)' d='Modules.Pkelements.Pkcontactform'}</option>
                    </select>
                    {*                    <input  value="" placeholder="*}
                    {*                                        <svg class="svgic input-icon"><use xlink:href="#si-info "></use></svg>*}
                </div>
            </div>
            {*-----------------*}

            <div class="form-group textarea-area col-xs-12">
                <div class="icon-true relative">
                    <textarea
                            class="form-control input-txt ac-message"
                            cols="67"
                            rows="3"
                            name="message"
                            placeholder="{l s='Message' d='Modules.Pkelements.Pkcontactform'}"></textarea>
                    <svg class="svgic input-icon">
                        <use xlink:href="#si-pencil"></use>
                    </svg>
                </div>
            </div>
            
            {if (isset($contactform_id)) && (isset($show_gdpr) && $show_gdpr)}
                {hook h='displayGDPRConsent' id_module=$contactform_id}
            {/if}
        </div>
        <footer class="form-footer">
            <input
                    type="hidden"
                    name="id_contact"
                    class="ac-id_contact"
                    value="2">
            <input
                    type="hidden"
                    name="token"
                    class="ac-token"
                    value="{$token|escape:'htmlall':'UTF-8'}">
            <input
                    type="hidden"
                    name="url"
                    value="">
            <button
                    type="button"
                    class="btn submitMessage"
                    name="submitMessage">
                {if isset($button_text)}
                    {$button_text}
                {else}
                    {l s='Send' d='Modules.Pkelements.Pkcontactform'}
                {/if}
            </button>
        </footer>
    </form>
    <input
            type="hidden"
            class="agree-gdpr"
            value="{l s='You have to agree with our GDPR Policy' d='Modules.Pkelements.Pkcontactform'}">
    <input
            type="hidden"
            class="email-title"
            value="{l s='Contact Form' d='Modules.Pkelements.Pkcontactform'}">
</div>