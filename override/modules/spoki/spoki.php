<?php

class SpokiOverride extends Spoki
{
    protected function getCustomerPayload($customer, $additional_custom_fields = []): array
    {
        $result = parent::getCustomerPayload($customer, $additional_custom_fields);

        $result['first_name'] = '';
        $result['last_name'] = '';

        return $result;
    }
}
