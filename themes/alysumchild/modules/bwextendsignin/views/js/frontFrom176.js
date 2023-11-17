/**
 * 2014 - 2022 Bwlab.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Commercial License
 * you can't distribute, modify or sell this code
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file
 * If you need hel please contact  info@bwlab.it
 *
 * @author    Bwlab di Luigi Massa <info@bwlab.it>
 * @copyright 20014 - 2099 Bwlab
 * @license   commercial
 */

$(document).ready(function () {
    class Field {
        container = null;
        field = null;
        original_required = false;

        constructor(field) {
            this.field = $(field);
            this.original_required = this.field.attr('required') ? true : false

            function find(i, e) {
                var found = $(e).find(field);
                if (found.length == 1) {
                    this.container = $(e);
                }
            }

            $('.js-address-form')
                .find('.form-group.row')
                .each(find.bind(this));
        }

        exist() {
            return this.field.length > 0;
        }

        show() {
            this.container.slideDown();
        }

        showRequired() {
            this.show();
            this.field.attr('required', 'required');
            this.setComment('')
        }

        setComment(testo) {
            if (!this.container.find('.form-control-comment')) return;
            this.container.find('.form-control-comment').html(testo)
        }

        hide() {
            if (!this.container) return;
            this.container.hide();
            this.field.attr('required', false);
            this.setComment('Optional')
        }

        clone() {
            const new_container = this.container.clone()
            const field = new Field('');
            field.container = new_container;
            field.field = new_container.find('input[name="' + this.field.attr('name') + '"]')
            return field;
        }

    }

    function extendSignIn(changeCountry = false) {
        var lista_campi_comuni = {
            'firstname': new Field('input[name="firstname"]'),
            'lastname': new Field('input[name="lastname"]'),
            'country': new Field('select[name="id_country"]'),
            'type': new Field('input[name="saveAddress"]'),
            'same_address': new Field('input[name="use_same_address"]'),
            'title': $('<p id="#titolo-indirizzo"></p>'),
            'id_address_invoice': new Field('input[name="id_address_invoice"]'),
        }

        var lista_campi = {
            'categoria_fiscale': new Field('select[name="categoria_fiscale"]'),
            'pi': new Field('input[name="vat_number"]'),
            'sdi': new Field('input[name="codice_sdi"]'),
            'pec': new Field('input[name="pec"]'),
            'company': new Field('input[name="company"]'),
            'citta_nascita': new Field('input[name="citta_nascita"]'),
            'data': new Field('input[name="borndate"]'),
            'cf': new Field('input[name="dni"]'),
            'tipo_attivita': new Field('select[name="tipo_attivita"]'),
            'giorno_chiusura': new Field('select[name="giorno_chiusura"]'),

        }

        let isDelivery = lista_campi_comuni.type.field.val() === 'delivery' ? true : false;
        console.log('tipo indirizzo: ', isDelivery)

        //l'indirizzo non può essere mai lo stesso
        lista_campi_comuni.same_address.hide();
        lista_campi_comuni.same_address.field.val(0);
        lista_campi_comuni.same_address.field.trigger('click');
        if (true === isDelivery) {
            hideAll();
            lista_campi_comuni.same_address.container.hide();
            lista_campi.company.container.show();
            lista_campi.giorno_chiusura.container.hide();
            return;
        }

        if (lista_campi_comuni.country.field.val() !== country) {
            //se diverso da italia devo nascondere tutto
            hideAll();
            if (lista_campi.company.exist())
                lista_campi.company.show();
            if (lista_campi.cf.exist())
                lista_campi.cf.show();
            if (lista_campi.pi.exist())
                lista_campi.pi.show();
            return;

        }
        ;

        if (lista_campi_comuni.id_address_invoice.exist() === true) {
            if (lista_campi_comuni.id_address_invoice.field.is(':checked') === false) {
                $(lista_campi_comuni.id_address_invoice.field[0]).trigger('click');
            }
        }
        if (lista_campi_comuni.firstname.exist() === false) return;


        lista_campi_comuni.title.text(
            lista_campi_comuni.same_address.field.is(':checked') === true ?
                'Questo è un indirizzo sia di fatturazione che spedizione'
                : 'Questo è un indirizzo di spedizione'
        );

        if (lista_campi_comuni.same_address.exist() === true) {
            lista_campi_comuni.same_address.container.before(lista_campi_comuni.title);
        }

        if (lista_campi.categoria_fiscale.exist() === false) return;

        checkPartitaIvaCodiceFiscale();

        if (isDelivery === true) {
            lista_campi_comuni.same_address.container.hide();
            hideAll();
            lista_campi_comuni.same_address.field.is(':checked') ?
                lista_campi.company.showRequired() : lista_campi.company.show();

        } else {
            lista_campi.categoria_fiscale.field.val('societa').trigger('change');
        }

        function hideAll() {
            Object.keys(lista_campi).forEach(function (fl) {
                lista_campi[fl].hide();
            })
        }

        function checkPartitaIvaCodiceFiscale() {

            lista_campi.categoria_fiscale.container.after(lista_campi.company.container);
            lista_campi.company.container.after(lista_campi.pi.container);
            lista_campi.pi.container.after(lista_campi.cf.container);

            if (lista_campi.citta_nascita.exist() === true) {
                lista_campi.citta_nascita.field.devbridgeAutocomplete({
                    serviceUrl: '//' + window.location.host + '/index.php?fc=module&module=bwextendsignin&controller=belfiorecode&ajax=1'
                });
            }

            lista_campi.pi.field.on('input', function (ev) {
                if (lista_campi.categoria_fiscale.field.val() === 'societa') {
                    lista_campi.cf.field.val(this.value);
                }
            });


            lista_campi.categoria_fiscale.field.change(function (e) {
                hideAll();
                lista_campi.categoria_fiscale.showRequired();

                switch ($(this).val()) {

                    case 'privato':
                        showPf()
                        lista_campi.tipo_attivita.hide()
                        lista_campi.giorno_chiusura.hide()

                        break;

                    case 'autonomo':
                        showPf();
                        showAutonomo();
                        lista_campi.tipo_attivita.showRequired();
                        lista_campi.giorno_chiusura.show();
                        break;

                    case 'associazione':
                        showAssoc();
                        lista_campi.giorno_chiusura.show();
                        break;

                    case 'societa':
                        showBusiness()
                        lista_campi.tipo_attivita.showRequired();
                        lista_campi.giorno_chiusura.show();
                        break;
                }


            })

            function showPf() {
                if (lista_campi.citta_nascita.exist() === true) {
                    lista_campi.citta_nascita.showRequired();
                    lista_campi.data.showRequired();
                }
                if (lista_campi.citta_nascita.exist() === true) {
                    lista_campi.citta_nascita.showRequired();
                    lista_campi.data.showRequired();
                }
                lista_campi.cf.showRequired()

            }

            function showPecAndSdi() {
                if (lista_campi.sdi.original_required === true) {
                    lista_campi.sdi.showRequired();
                } else {
                    lista_campi.sdi.show();
                }
                if (lista_campi.pec.original_required === true) {
                    lista_campi.pec.showRequired();
                } else {
                    lista_campi.pec.show();
                }
            }

            function showBusiness() {
                lista_campi.company.showRequired();
                lista_campi.pi.showRequired();
                lista_campi.cf.showRequired();
                showPecAndSdi();
            }

            function showAutonomo() {
                lista_campi.company.show();
                lista_campi.pi.showRequired();
                showPecAndSdi();
            }

            function showAssoc() {
                lista_campi.cf.showRequired()
                showPecAndSdi();
            }

        }
    }

    extendSignIn();

    var updatedAddressForm = function (t, e) {
        extendSignIn(true);
    }
    prestashop.addListener('updatedAddressForm', updatedAddressForm);
    $('#copia-indirizzo-spedizione').on('change', function (e) {
        var lista_campi_fatturazione = {
            'firstname': new Field('input[name="firstname"]'),
            'lastname': new Field('input[name="lastname"]'),
            'address1': new Field('input[name="address1"]'),
            'address2': new Field('input[name="address2"]'),
            'postcode': new Field('input[name="postcode"]'),
            'city': new Field('input[name="city"]'),
            'phone': new Field('input[name="phone"]'),
            'phone_mobile': new Field('input[name="phone_mobile"]'),
            'company': new Field('input[name="company"]'),
            'id_country': new Field('select[name="id_country"]'),
            'id_state': new Field('select[name="id_state"]'),
        }
        try {
            const indirizzo_spedizione_selezionato = JSON.parse($(this).val());
            console.log(indirizzo_spedizione_selezionato);
            lista_campi_fatturazione.firstname.field.val(indirizzo_spedizione_selezionato.firstname);
            lista_campi_fatturazione.lastname.field.val(indirizzo_spedizione_selezionato.lastname);
            lista_campi_fatturazione.address1.field.val(indirizzo_spedizione_selezionato.address1);
            lista_campi_fatturazione.address2.field.val(indirizzo_spedizione_selezionato.address2);
            lista_campi_fatturazione.postcode.field.val(indirizzo_spedizione_selezionato.postcode);
            lista_campi_fatturazione.city.field.val(indirizzo_spedizione_selezionato.city);
            lista_campi_fatturazione.phone.field.val(indirizzo_spedizione_selezionato.phone);
            lista_campi_fatturazione.phone_mobile.field.val(indirizzo_spedizione_selezionato.phone_mobile);
            lista_campi_fatturazione.company.field.val(indirizzo_spedizione_selezionato.company);
            if (lista_campi_fatturazione.id_state.field.val() !== indirizzo_spedizione_selezionato.id_state) {
                lista_campi_fatturazione.id_state.field.val(indirizzo_spedizione_selezionato.id_state);
                lista_campi_fatturazione.id_state.field.trigger('change');
            }
            if (lista_campi_fatturazione.id_country.field.val() !== indirizzo_spedizione_selezionato.id_country) {
                lista_campi_fatturazione.id_country.field.val(indirizzo_spedizione_selezionato.id_country);
                lista_campi_fatturazione.id_country.field.trigger('change');
            }
        } catch (e) {
            //.... è stato selezionata l'opzione nulla
        }

    }
    )
        ;
});