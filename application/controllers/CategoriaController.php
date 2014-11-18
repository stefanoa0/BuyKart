<?php

class CategoriaController extends Zend_Controller_Action
{
    protected $usuario;
    public function init()
    {
        ///verifica se o usuário está logado
        if(!Zend_Auth::getInstance()->hasIdentity()){
            $this->_redirect('index');
        }
        ///Caso logado, envia ele para a tela principal da tela "admin"
        $this->_helper->layout->setLayout('admin');
        
        //verifica os dados do usuário
        $auth = Zend_Auth::getInstance();
         if ( $auth->hasIdentity() ){
          $identity = $auth->getIdentity();
          $ArrayIdentity = get_object_vars($identity);
        }
        
        $this->modelUsuario = new Application_Model_Cadastro();
        //recebe os dados do usuário
        $this->usuario = $this->modelUsuario->select('tlg_id ='.$ArrayIdentity['tlg_id']);
        //envia os dados do usuário para a view
        $this->view->assign("usuario",$this->usuario);
        
    }

    public function indexAction()
    {
        $this->modelCategoria = new Application_Model_Categoria();
        if($this->usuario[0]['tpf_id'] == 1){
            $categorias = $this->modelCategoria->select();
        }
        
        ///imprime todas as categorias que o usuário logado inseriu
        else{
            $categorias = $this->modelCategoria->select('tu_id = '.$this->usuario[0]['tu_id']);
        }
        $this->view->assign("categoria",$categorias);
        
    }
    public function novoAction()
    {
        
    }
    public function criarAction()
     {
        ///adiciona uma nova categoria no banco de dados
        $this->modelCategoria = new Application_Model_Categoria();
        $categoria = $this->_getAllParams();
        
        $this->modelCategoria->insert($categoria);
        $this->_redirect('categoria');
    }

}

