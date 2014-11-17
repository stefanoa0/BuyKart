<?php

class SubcategoriaController extends Zend_Controller_Action
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
        $this->modelSubCategoria = new Application_Model_Subcategoria();
        $subcategorias = $this->modelSubCategoria->select('tu_id = '.$this->usuario[0]['tu_id']);
        $this->view->assign("subcategoria",$subcategorias);
    }
    public function novoAction()
    {
       $this->modelCategoria = new Application_Model_Categoria();
        $categorias = $this->modelCategoria->select('tu_id = '.$this->usuario[0]['tu_id']);
        $this->view->assign("categorias",$categorias);
    }
    public function criarAction()
     {
        $this->modelSubCategoria = new Application_Model_Subcategoria();
        $subcategoria = $this->_getAllParams();
        
        $this->modelSubCategoria->insert($subcategoria);
        $this->_redirect('subcategoria');
    }

}

