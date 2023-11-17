<div class="p-a-1 container-file">
    <div class="file-upload">
        <form class="button-and-form">
            <h1>{l s='Carica qui il tuo file' d='Modules.Customercliche.Shop'}</h1>
            <p class="alert alert-success hidden">{l s='Il file è stato caricato con successo' d='Modules.CutomerCliche
.Shop'}</p>
            <div class="op_inputfile">
                <input class="file-input" type="file" name="file[]" />
                <button class="choose" type="button">{l s='Seleziona un file' d='Modules.Customercliche.Shop'}</button>
                <span class="selected-file-name">--</span>
            </div>

            <div class="op_nomefile">
                <input type="text" class="form-control title" name="title" placeholder="{l s='Denominazione file' mod='customercliche'}" />
            </div>

            <div class="op_descfile">
                <textarea type="text" class="form-control note" name="note" placeholder="{l s='Note file' mod='customercliche'}"></textarea>
            </div>

            <div class="op_tuttifile">
                <span class="custom-checkbox">
                    <label>{l s='Applica a tutti i file' d='Modules.Customercliche.Shop'}</label >
                    <input name="all" class="all" type="checkbox">
                    <span><svg class="svgic svgic-done"><use xlink:href="#si-done"></use></svg></span>
                </span>
            </div>

            <div class="op_submitfile">
                <a href="javascript:void(0);" class="btn btn-primary upload"/>{l s='Carica il file' d='Modules.Customercliche.Shop'}</a>
                <a href="javascript:void(0);" class="btn btn-primary button-reset"/> {l s='Annulla' d='Modules.Customercliche.Shop'}</a>
            </div>

            <input type="hidden" name="id-product" value="{$id_product}">
            <input type="hidden" name="id-attribute" value="{$id_attribute}">

            <input type="hidden" name="id-order" value="{$id_order  }">
        </form>

        <div class="load-file-list"></div>
    </div>

    <div class="load-messages"></div>
</div>
