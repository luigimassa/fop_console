<?php

use PrestaShop\PrestaShop\Core\Cart\AmountImmutable;
use PrestaShop\PrestaShop\Core\Cart\Calculator as CalculatorAlias;

/**
 * Created by Luigi Massa <lmassa@bwlab.it>
 */
class Calculator extends CalculatorAlias
{
    protected bool $virtual;

    public function __construct(
        Cart $cart,
        $carrierId,
        ?int $computePrecision = null,
        ?int $orderId = null,
        bool $virtual = false
    ) {
        parent::__construct($cart, $carrierId, $computePrecision, $orderId);
        $this->virtual = $virtual;
    }

    public function getAdditionalCosts($ignoreProcessedFlag = false)
    {
        $totals = Hook::exec(
            'actionGetTotal',
            [
                'cart'                => $this->cart,
                'cartRows'            => $this->cartRows,
                'computePrecision'    => $this->computePrecision,
                'ignoreProcessedFlag' => $ignoreProcessedFlag,
            ],
            null,
            true
        );
        $amount_hooks = new AmountImmutable(
            0, 0
        );
        foreach ($totals as $total) {
            $amount_hooks = $amount_hooks->add($total);
        }

        return $amount_hooks;
    }

    public function getTotal($ignoreProcessedFlag = false)
    {
        $result = parent::getTotal($ignoreProcessedFlag);
        if ((false === $this->virtual) && !$this->cart->id) {
            return $result;
        }

        return $result->add($this->getAdditionalCosts($ignoreProcessedFlag));
    }

}