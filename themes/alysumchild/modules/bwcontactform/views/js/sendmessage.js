/**
 * <your license here>
 */
(function () {
    let file = null;
    const handleBrowserFile = function (ev) {
        file = ev.target.files[0]
    }
    const getFormData = function (values) {
        const formData = new FormData();
        for (const [key, data] of Object.entries(values)) {
            formData.append(data.name, data.value);
        }
        return formData;
    }

    $('input[name=fileUpload]').on('change', handleBrowserFile);

    $('form[name="bwcontactform"]').submit(function (event) {
        event.preventDefault();
        const form_values = getFormData($(this).serializeArray());
        form_values.append('fc', 'module');
        form_values.append('module', 'bwcontactform');
        form_values.append('controller', 'sendmessage');
        form_values.append('action', 'sendmessage');
        form_values.append('ajax', true);
        form_values.append('fileUpload', file);

        $.ajax({
            type: 'POST',
            headers: {"cache-control": "no-cache"},
            url: prestashop.urls.shop_domain_url,
            async: true,
            data: form_values,
            contentType: false,
            processData: false,
            success: function (data) {
                $.jGrowl('Il tuo messaggio è stato inviato con successo', {
                    theme: $.jGrowl.defaults.theme + ' success',
                    header: 'Messaggio inviato'
                });
            },
            error: function (jqXHR, statusText, errorThrown) {
                $.jGrowl('Ci sono stati errori nell\'invio del messaggio. Contatta il supporto tramite telefono. Grazie', {
                    theme: $.jGrowl.defaults.theme + ' success',
                    header: 'Errore'
                });
            }
        });
    });

})()
