<?php

class CadastroController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
    }
    public function cadastroAction()
    {
        ///Inclusão da classe de cadastros
        $this->modelUsuario = new Application_Model_Cadastro();
        ///Recebe os parâmetros da view index
        $usuario = $this->_getAllParams();
        
        ///insere os dados do usuário
        $this->modelUsuario->insert($usuario);
        ///redireciona para a tela de login
        $this->_redirect('login');
    }

}

