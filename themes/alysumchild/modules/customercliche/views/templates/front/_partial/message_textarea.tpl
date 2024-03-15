<div class="mt-1">
    <h2> {l s='Messaggi' d='Modules.Customercliche.Shop'}</h2>
    <textarea id="fu_message_{$id_file}" type="text" class="form-control" name="message" placeholder="{l s='Il tuo messaggio' d='Modules.Customercliche.Shop'}"></textarea>

    <div class="m-t-1">
        <a
                href="javascript:void(0);"
                class="btn btn-primary do-send-message"
                data-id="{$id_file}"
                data-id-order="{$id_order}"
                onclick="{$callback}(this)"
        >
             {l s='invia' d='Modules.Customercliche.Shop'}
        </a>
    </div>

</div>
