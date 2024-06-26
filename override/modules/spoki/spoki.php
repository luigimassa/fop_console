<?php

class SpokiOverride extends Spoki
{
    protected function getCustomerPayload($customer, $additional_custom_fields = []): array
    {
        $result = parent::getCustomerPayload($customer, $additional_custom_fields);

        unset($result['first_name']);
        unset($result['last_name']);

        return $result;
    }
}
