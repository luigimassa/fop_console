<?php

class HTMLTemplateInvoice extends HTMLTemplateInvoiceCore
{

    public function getContent()
    {
        $invoiceAddressPatternRules = json_decode(Configuration::get('PS_INVCE_INVOICE_ADDR_RULES'), true);
        $deliveryAddressPatternRules = json_decode(Configuration::get('PS_INVCE_DELIVERY_ADDR_RULES'), true);

        $invoice_address = new Address((int)$this->order->id_address_invoice);
        $country = new Country((int)$invoice_address->id_country);
        $formatted_invoice_address =
            AddressFormat::generateAddress($invoice_address, $invoiceAddressPatternRules, '<br />', ' ');

        $delivery_address = null;
        $formatted_delivery_address = '';
        if (isset($this->order->id_address_delivery) && $this->order->id_address_delivery) {
            $delivery_address = new Address((int)$this->order->id_address_delivery);
            $formatted_delivery_address =
                AddressFormat::generateAddress($delivery_address, $deliveryAddressPatternRules, '<br />', ' ');
        }

        $customer = new Customer((int)$this->order->id_customer);
        $carrier = new Carrier((int)$this->order->id_carrier);
        $order_details = $this->order_invoice->getProducts();

        $has_discount = false;

        $totale_costo_conai = 0;
        $totale_costo_cliche = 0;

        foreach ($order_details as $id => &$order_detail) {
            // Find out if column 'price before discount' is required
            if ($order_detail['reduction_amount_tax_excl'] > 0) {
                $has_discount = true;
                $order_detail['unit_price_tax_excl_before_specific_price'] =
                    $order_detail['unit_price_tax_excl_including_ecotax'] + $order_detail['reduction_amount_tax_excl'];
            } elseif ($order_detail['reduction_percent'] > 0) {
                $has_discount = true;
                if ($order_detail['reduction_percent'] == 100) {
                    $order_detail['unit_price_tax_excl_before_specific_price'] = 0;
                } else {
                    $order_detail['unit_price_tax_excl_before_specific_price'] =
                        (100 * $order_detail['unit_price_tax_excl_including_ecotax']) /
                        (100 - $order_detail['reduction_percent']);
                }
            }

            $costo_conai_prodotto = $this->getCostoConai($order_detail);
            $costo_conai = is_bool($costo_conai_prodotto)?0:(float)$costo_conai_prodotto['costo_conai'];
            $fascia_conai = is_bool($costo_conai_prodotto)?'':(string)$costo_conai_prodotto['zone_name'];
            $totale_costo_conai +=  $costo_conai ;
            $order_detail['tot_of_conai'] = $costo_conai;
            $costo_cliche_prodotto = $this->getCostoCliche($order_detail);
            $has_cliche = is_array($costo_cliche_prodotto) && count($costo_cliche_prodotto) > 0;
            $costo_cliche = $has_cliche?(float)$costo_cliche_prodotto['costo_cliche']:0;
            $totale_costo_cliche += $costo_cliche;
            $order_detail['tot_of_cliche'] = $costo_cliche;
            // Set tax_code
            $taxes = OrderDetail::getTaxListStatic($id);
            $tax_temp = [];
            foreach ($taxes as $tax) {
                $obj = new Tax($tax['id_tax']);
                $translator = Context::getContext()
                    ->getTranslator()
                ;
                $tax_temp[] = $translator->trans(
                    '%taxrate%%space%%',
                    [
                        '%taxrate%' => ($obj->rate + 0),
                        '%space%'   => '&nbsp;',
                    ],
                    'Shop.Pdf'
                );
            }

            $order_details[$id]['order_detail_tax'] = $taxes;
            $order_details[$id]['order_detail_tax_label'] = implode(', ', $tax_temp);
            $order_detail['pezzi_per_cartone'] = \PackagingHelper::getPezziPerCartone($order_detail['product_id']);
            $order_detail['costo_unitario'] = \PackagingHelper::getCostoUnitario(
                $order_detail['product_id'],
                $order_detail['unit_price_tax_excl']);
            $order_detail['fascia_conai'] = $fascia_conai;
            if(true === $has_cliche) {
                $order_detail['is_ristampa'] = $order_detail['tot_of_cliche'] == 0 ? 'ristampa' : '';
            }else{
                $order_detail['is_ristampa'] = '';
            }
        }
        unset(
            $tax_temp, $order_detail
        );
//        if (Configuration::get('PS_PDF_IMG_INVOICE')) {
        foreach ($order_details as &$order_detail) {
            if ($order_detail['image'] != null) {
                $name = 'product_mini_'.(int)$order_detail['product_id'].
                    (isset($order_detail['product_attribute_id']) ? '_'.
                        (int)$order_detail['product_attribute_id'] : '').'.jpg';
                $path = _PS_PROD_IMG_DIR_.$order_detail['image']->getExistingImgPath().'.jpg';

                $order_detail['image_tag'] = preg_replace(
                    '/\.*'.preg_quote(__PS_BASE_URI__, '/').'/',
                    _PS_ROOT_DIR_.DIRECTORY_SEPARATOR,
                    ImageManager::thumbnail($path, $name, 45, 'jpg', false),
                    1
                );

                if (file_exists(_PS_TMP_IMG_DIR_.$name)) {
                    $order_detail['image_size'] = getimagesize(_PS_TMP_IMG_DIR_.$name);
                } else {
                    $order_detail['image_size'] = false;
                }
            }
        }
        unset($order_detail); // don't overwrite the last order_detail later
//        }

        $cart_rules = $this->order->getCartRules($this->order_invoice->id);
        $free_shipping = false;
        foreach ($cart_rules as $key => $cart_rule) {
            if ($cart_rule['free_shipping']) {
                $free_shipping = true;
                /*
                 * Adjust cart rule value to remove the amount of the shipping.
                 * We're not interested in displaying the shipping discount as it is already shown as "Free Shipping".
                 */
                $cart_rules[$key]['value_tax_excl'] -= $this->order_invoice->total_shipping_tax_excl;
                $cart_rules[$key]['value'] -= $this->order_invoice->total_shipping_tax_incl;

                /*
                 * Don't display cart rules that are only about free shipping and don't create
                 * a discount on products.
                 */
                if ($cart_rules[$key]['value'] == 0) {
                    unset($cart_rules[$key]);
                }
            }
        }

        $product_taxes = 0;
        foreach ($this->order_invoice->getProductTaxesBreakdown($this->order) as $details) {
            $product_taxes += $details['total_amount'];
        }

        $product_discounts_tax_excl = $this->order_invoice->total_discount_tax_excl;
        $product_discounts_tax_incl = $this->order_invoice->total_discount_tax_incl;
        if ($free_shipping) {
            $product_discounts_tax_excl -= $this->order_invoice->total_shipping_tax_excl;
            $product_discounts_tax_incl -= $this->order_invoice->total_shipping_tax_incl;
        }

        $products_after_discounts_tax_excl = $this->order_invoice->total_products - $product_discounts_tax_excl;
        $products_after_discounts_tax_incl = $this->order_invoice->total_products_wt - $product_discounts_tax_incl;

        $shipping_tax_excl = $free_shipping ? 0 : $this->order_invoice->total_shipping_tax_excl;
        $shipping_tax_incl = $free_shipping ? 0 : $this->order_invoice->total_shipping_tax_incl;
        $shipping_taxes = $shipping_tax_incl - $shipping_tax_excl;

        $wrapping_taxes = $this->order_invoice->total_wrapping_tax_incl - $this->order_invoice->total_wrapping_tax_excl;

        $total_taxes = $this->order_invoice->total_paid_tax_incl - $this->order_invoice->total_paid_tax_excl;
        $footer = [
            'products_before_discounts_tax_excl' => $this->order_invoice->total_products,
            'product_discounts_tax_excl'         => $product_discounts_tax_excl,
            'products_after_discounts_tax_excl'  => $products_after_discounts_tax_excl,
            'products_before_discounts_tax_incl' => $this->order_invoice->total_products_wt,
            'product_discounts_tax_incl'         => $product_discounts_tax_incl,
            'products_after_discounts_tax_incl'  => $products_after_discounts_tax_incl,
            'product_taxes'                      => $product_taxes,
            'shipping_tax_excl'                  => $shipping_tax_excl,
            'shipping_taxes'                     => $shipping_taxes,
            'shipping_tax_incl'                  => $shipping_tax_incl,
            'wrapping_tax_excl'                  => $this->order_invoice->total_wrapping_tax_excl,
            'wrapping_taxes'                     => $wrapping_taxes,
            'wrapping_tax_incl'                  => $this->order_invoice->total_wrapping_tax_incl,
            'ecotax_taxes'                       => $total_taxes - $product_taxes - $wrapping_taxes - $shipping_taxes,
            'total_taxes'                        => $total_taxes,
            'total_paid_tax_excl'                => $this->order_invoice->total_paid_tax_excl,
            'total_paid_tax_incl'                => $this->order_invoice->total_paid_tax_incl,
            'totale_costo_conai'                 => $totale_costo_conai,
            'totale_costo_cliche'                => $totale_costo_cliche,

        ];

        foreach ($footer as $key => $value) {
            $footer[$key] = Tools::ps_round(
                $value,
                Context::getContext()
                    ->getComputingPrecision(),
                $this->order->round_mode
            );
        }

        /**
         * Need the $round_mode for the tests.
         */
        $round_type = null;
        switch ($this->order->round_type) {
            case Order::ROUND_TOTAL:
                $round_type = 'total';

                break;
            case Order::ROUND_LINE:
                $round_type = 'line';

                break;
            case Order::ROUND_ITEM:
                $round_type = 'item';

                break;
            default:
                $round_type = 'line';

                break;
        }

        $display_product_images = Configuration::get('PS_PDF_IMG_INVOICE');
        $tax_excluded_display = Group::getPriceDisplayMethod($customer->id_default_group);

        $layout = $this->computeLayout(['has_discount' => $has_discount]);

        $legal_free_text = Hook::exec('displayInvoiceLegalFreeText', ['order' => $this->order]);
        if (!$legal_free_text) {
            $legal_free_text = Configuration::get(
                'PS_INVOICE_LEGAL_FREE_TEXT',
                (int)Context::getContext()->language->id,
                null,
                (int)$this->order->id_shop
            );
        }
        $note_ordine = $this->getNoteOrdine($this->order->id);
        $data = [
            'order'                      => $this->order,
            'order_invoice'              => $this->order_invoice,
            'order_details'              => $order_details,
            'note'                       => $note_ordine,
            'carrier'                    => $carrier,
            'cart_rules'                 => $cart_rules,
            'delivery_address'           => $formatted_delivery_address,
            'invoice_address'            => $formatted_invoice_address,
            'addresses'                  => ['invoice' => $invoice_address, 'delivery' => $delivery_address],
            'tax_excluded_display'       => $tax_excluded_display,
            'display_product_images'     => $display_product_images,
            'layout'                     => $layout,
            'tax_tab'                    => $this->getTaxTabContent(),
            'customer'                   => $customer,
            'footer'                     => $footer,
            'ps_price_compute_precision' => Context::getContext()
                ->getComputingPrecision(),
            'round_type'                 => $round_type,
            'legal_free_text'            => $legal_free_text,
        ];

        if (Tools::getValue('debug')) {
            die(json_encode($data));
        }

        $this->smarty->assign($data);

        $tpls = [
            'style_tab'     => $this->smarty->fetch($this->getTemplate('invoice.style-tab')),
            'addresses_tab' => $this->smarty->fetch($this->getTemplate('invoice.addresses-tab')),
            'summary_tab'   => $this->smarty->fetch($this->getTemplate('invoice.summary-tab')),
            'product_tab'   => $this->smarty->fetch($this->getTemplate('invoice.product-tab')),
            'tax_tab'       => $this->getTaxTabContent(),
            'payment_tab'   => $this->smarty->fetch($this->getTemplate('invoice.payment-tab')),
            'note_tab'      => $this->smarty->fetch($this->getTemplate('invoice.note-tab')),
            'total_tab'     => $this->smarty->fetch($this->getTemplate('invoice.total-tab')),
            'shipping_tab'  => $this->smarty->fetch($this->getTemplate('invoice.shipping-tab')),
        ];
        $this->smarty->assign($tpls);

        return $this->smarty->fetch($this->getTemplateByCountry($country->iso_code));
    }


    private function getNoteOrdine(int $id_order)
    {
        $note_ordine = DB::getInstance()->getRow('select * from '._DB_PREFIX_.'order_note where id_order = '.$id_order);
        if($note_ordine){
            return $note_ordine['note']?:'--';
        }
        return '--';
}
    public function getHeader()
    {
        $this->smarty->assign([
            'erpcode' => $this->getCustomerErpCode(),
            'pec_sdi' => $this->getPecSdi(),
        ]);

        return parent::getHeader();
    }

    private function getCostoCliche( $order_detail)
    {
        $id_product = $order_detail['product_id'];
        $id_attribute = $order_detail['product_attribute_id'];
        $id_order = $order_detail['id_order'];

        return Db::getInstance()
            ->getRow(
                (new \DbQuery())->from('order_detail_cliche')
                    ->where(
                        'id_product = '.$id_product.' and id_order = '.$id_order.' and id_attribute = '.$id_attribute
                    )
            )
        ;
    }

    private function getCostoConai(&$order_detail)
    {
        //inserire costo cliche e costo conai
        $id_order = $order_detail['id_order'];
        $id_product = $order_detail['product_id'];
        $id_attribute = $order_detail['product_attribute_id'];
        $costo_conai_prodotto = Db::getInstance()
            ->getRow(
                (new DbQuery())->from('order_detail_conai')
                    ->where('id_order = '.$id_order.' and id_product = '.$id_product.' and id_attribute = '.$id_attribute)
            )
        ;

        return $costo_conai_prodotto;
    }

    private function getCustomerErpCode()
    {
        $id_customer = $this->order->getCustomer()->id;
        $id_shop = $this->order->id_shop;

        return \Db::getInstance()
            ->getValue(
                'select erpcode from '._DB_PREFIX_.'bwcustomererp where id_customer = '.$id_customer.' and id_shop = '.
                $id_shop
            )
        ;
    }

    private function getPecSdi()
    {
        $id_customer = $this->order->getCustomer()->id;
        $id_shop = $this->order->id_shop;
        $id_address_invoice = $this->order->id_address_invoice;
        $sql = new DbQuery();
        $sql->from('bwsigninextend')
            ->select('codice_sdi, pec')
            ->where('id_customer = '.$id_customer)
            ->where('id_address = '.$id_address_invoice)
        ;

        return \Db::getInstance()
            ->getRow($sql)
        ;
    }

}