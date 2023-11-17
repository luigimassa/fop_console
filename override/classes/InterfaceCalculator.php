<?php

use PrestaShop\PrestaShop\Core\Cart\AmountImmutable;

interface InterfaceCalculator
{
    public function getTotal($ignoreProcessedFlag = false): AmountImmutable;
}