<?php
declare(strict_types=1);
class Customer extends CustomerCore
{
	
    
    
    /*
    * module: spoki
    * date: 2023-04-06 15:57:13
    * version: 1.0.0
    */
    public $whatsapp;
    /*
    * module: spoki
    * date: 2023-04-06 15:57:13
    * version: 1.0.0
    */
    public function __construct($id = null)
    {
        parent::__construct($id);
        self::$definition['fields']['whatsapp'] = [
            'type' => self::TYPE_STRING,
            'validate' => 'isPhoneNumber',
            'size' => 20,
        ];
    }
}