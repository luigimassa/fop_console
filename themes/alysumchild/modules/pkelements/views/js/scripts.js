$(document).ready(function()
{
    $('.submit-widget-newsletter').click(function(e){
        e.preventDefault();

        let parent = $(this).closest('.newsletter-widget'),
            email_address = parent.find('[name=email_wdg]').val(),
            gdpr = parent.find('input[type=checkbox]').prop('checked'),
            gdpr_message = parent.find('.agree-gdpr').val(),
            emailtitle  = parent.find('.email-title').val();

        if (typeof gdpr === 'undefined') { // if no GDPR checkbox then gdpr eq true
            gdpr = true;
        }

        if (!gdpr) {

            $.jGrowl(gdpr_message, {theme: $.jGrowl.defaults.theme+' error', header: emailtitle});

        } else {

            $.ajax({
                type: 'POST',
                headers: {
                    'cache-control': 'no-cache'
                },
                async: false,
                url: pkelements.controller,
                dataType: 'json',
                data: {
                    pksubscription: 1,
                    email: email_address,
                    action: 0
                },
                success: function(data)
                {
                    if (data)
                    {
                        if (data.error)
                        {
                            $.jGrowl(data.error, {theme: $.jGrowl.defaults.theme+' error', header: emailtitle});
                        }
                        if (data.valid)
                        {
                            $.jGrowl(data.valid, {theme: $.jGrowl.defaults.theme+' success', header: emailtitle});
                        }
                    }
                },
                error: function (data) {
                    $.jGrowl('undefined error', {theme: $.jGrowl.defaults.theme+' error', header: emailtitle});
                }
            });
        }
    });

    // contact form widget
    $('.submitMessage').click(function(){

        let parent = $(this).closest('.contact-form-widget'),
            gdpr = parent.find('input[type=checkbox]').prop('checked'),
            emailtitle  = parent.find('.email-title').val();

        if (typeof gdpr === 'undefined') { // if no GDPR checkbox then gdpr eq true
            gdpr = true;
        }

        if (!gdpr) {

            $.jGrowl(parent.find('.agree-gdpr').val(), {theme: $.jGrowl.defaults.theme+' error', header: emailtitle});

        } else {

            $.ajax({
              type: 'POST',
              url: pkelements.controller,
              dataType: 'json',
              data: {
                url: '',
                content_only: 1,
                referente: parent.find('[name=referente]').val(),
                azienda: parent.find('[name=azienda]').val(),
                telefono: parent.find('[name=telefono]').val(),
                settore: parent.find('[name=settore]').val(),
                token: parent.find('[name=token]').val(),
                from: parent.find('[name=from]').val(),
                message: parent.find('[name=message]').val(),
                id_contact: parent.find('[name=id_contact]').val(),
              },
              success: function (data) {
                if (data)
                {
                    if (data.error)
                    {
                        $.jGrowl(data.error, {theme: $.jGrowl.defaults.theme+' error', header: emailtitle});
                    }
                    if (data.valid)
                    {
                        $.jGrowl(data.valid, {theme: $.jGrowl.defaults.theme+' success', header: emailtitle});
                    }
                }
              },
              error: function (data) {
                $.jGrowl('undefined error', {theme: $.jGrowl.defaults.theme+' error', header: emailtitle});
              }
            });
        }

    });
});