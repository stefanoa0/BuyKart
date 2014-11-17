<?php

class LoginController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
    }
    public function loginAction() {
        $login = $this->_getParam('login');
        $senha = $this->_getParam('senha');
        //verificação inicial dos parâmetros de login
        if (empty($login) || empty($senha)) {
            $this->view->mensagem = "Preencha o formulário corretamente.";
        } else {
            $this->_helper->viewRenderer->setNoRender();
            
            $dbAdapter = Zend_Db_Table_Abstract::getDefaultAdapter();
            $authAdapter = new Zend_Auth_Adapter_DbTable($dbAdapter);
            //faz a autenticação na tabela de Login
            $authAdapter->setTableName('t_login')->setIdentityColumn('tlg_login')->setCredentialColumn('tlg_senha');
            //verifica a identidade e a senha criptografada do cliente
            $authAdapter->setIdentity($login)->setCredential(sha1($senha));
            //realiza a autenticação
            $result = $authAdapter->authenticate();

            if ($result->isValid()) {
                $usuario = $authAdapter->getResultRowObject();
                
                $storage = Zend_Auth::getInstance()->getStorage();
                //salva os dados do usuário em uma instância para ser usado nos controllers
                $storage->write($usuario);
                //
                //
                $this->_redirect('compra');
            } else {
                $this->_redirect('autenticacao/logout');
            }
        }
    }
    public function logoutAction() {
        //limpa a identidade do usuário e faz o logoff
        Zend_Auth::getInstance()->clearIdentity();
        
        $this->_redirect('index');
    }

}

