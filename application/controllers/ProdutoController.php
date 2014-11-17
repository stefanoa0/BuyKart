<?php

class ProdutoController extends Zend_Controller_Action
{

    public function init()
    {
        if(!Zend_Auth::getInstance()->hasIdentity()){
            $this->_redirect('index');
        }
        
        $this->_helper->layout->setLayout('admin');
        
        $auth = Zend_Auth::getInstance();
         if ( $auth->hasIdentity() ){
          $identity = $auth->getIdentity();
          $ArrayIdentity = get_object_vars($identity);
        }
        
        $this->modelUsuario = new Application_Model_Cadastro();
        $this->usuario = $this->modelUsuario->select($ArrayIdentity['tlg_id']);
        $this->view->assign("usuario",$this->usuario);
    }

    public function indexAction()
    {
        $this->modelProduto = new Application_Model_Produto();
        $produtos = $this->modelProduto->select('tu_id = '.$this->usuario[0]['tu_id']);
        $this->view->assign("produtos",$produtos);
    }
    public function novoAction()
    {
        $this->modelSubcategoria = new Application_Model_Subcategoria();
        $subcategorias = $this->modelSubcategoria->select('tu_id = '.$this->usuario[0]['tu_id']);
        $this->view->assign("subcategorias",$subcategorias);
    }
    public function criarAction()
    {
        $this->modelProduto = new Application_Model_Produto();
        $produto = $this->_getAllParams();
        
        $this->modelProduto->insert($produto);
        $this->_redirect('produto');
    }

}

