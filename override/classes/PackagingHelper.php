<?php

/**
 * Created by Luigi Massa <lmassa@bwlab.it>
 */
class PackagingHelper
{
    public static function getCostoUnitario($id_product, $amount)
    {
        //-->ticket #506
        $pezzi_per_cartone = self::getPezziPerCartone($id_product);

        $costo_unitario = $pezzi_per_cartone === 0 ? 0 : $amount / $pezzi_per_cartone;

        return [
            'amount' => $costo_unitario,
            'displayAmount' => self::formatEuro($costo_unitario),
        ];
        //  #506<----
    }

    public static function getPezziPerCartone(int $id_product): int
    {
        $list_of_fv = Product::getFeaturesStatic($id_product);
        // filter id_future_value by id_feature
        $id_feature_pezzi_per_cartone = 7;
        $data_of_fv = array_filter(
            $list_of_fv,
            static function ($item) use ($id_feature_pezzi_per_cartone) {
                return $item['id_feature'] == $id_feature_pezzi_per_cartone;
            }
        );
        $id_fv = array_column($data_of_fv, 'id_feature_value');
        if (is_array($id_fv)) {
            $id_fv = $id_fv[0];
        }
        $fv = new FeatureValue($id_fv, \Context::getContext()->language->id);

        return (int)str_replace('.', '', $fv->value);
    }

    public static function formatEuro($amount)
    {
        $displayAmount = number_format($amount, 3, ',', '.'); // Formatta il float in formato euro con 3 decimali
        $displayAmount = $displayAmount . ' €'; // Aggiungi il simbolo dell'euro

        return $displayAmount;
    }

    public static function getTolleranza(int $id_product): string
    {
        $id_feature_filter = 33;
        $list_f = Product::getFrontFeaturesStatic(Context::getContext()->language->id,$id_product);
        // filter id_future_value by id_feature
        $array = array_filter(
            $list_f,
            static function ($item) use ($id_feature_filter) {
                return (int)$item['id_feature'] === (int)$id_feature_filter;
            }
        );
        $feature = array_shift($array);
        if (null === $feature) return '';
        return $feature['value'];
    }

}