<?php

class IndexController extends Zend_Controller_Action
{

    public function init()
    {
       if(Zend_Auth::getInstance()->hasIdentity()){
            $this->_helper->layout->setLayout('admin');
       }
    }

    public function indexAction()
    {

        if(Zend_Auth::getInstance()->hasIdentity()){
            $this->render('admin');
       }
    }
    public function adminAction()
    {
        $this->modelCompra = new Application_Model_Compra();
        $compras = $this->modelCompra->selectCompra('tu_id = '.$this->usuario[0]['tu_id']);
        
        $this->view->assign('compras', $compras);
    }

}

