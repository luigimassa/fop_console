<?php

class CartController extends CartControllerCore
{
    public function checkAccess()
    {
        if (!$this->context->customer->isLogged() && !$this->ajax) {
            $this->redirect_after = ($this->authRedirection) ? urlencode($this->authRedirection) : 'my-account';
            $this->redirect();
        }

        return parent::checkAccess();
    }

}

