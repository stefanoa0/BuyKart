<?php

class Application_Model_Cadastro
{
 private $dbTableCadastro;

    public function select($where = null, $order = null, $limit = null)
    {
        $this->dbTableCadastro = new Application_Model_DbTable_Usuario();
        $select = $this->dbTableCadastro->select()
                ->from($this->dbTableCadastro)->order($order)->limit($limit);

        if(!is_null($where)){
            $select->where($where);
        }

        return $this->dbTableCadastro->fetchAll($select)->toArray();
    }

    
    public function find($id)
    {
        $this->dbTableCadastro = new Application_Model_DbTable_Usuario();
        $arr = $this->dbTableCadastro->find($id)->toArray();
        return $arr[0];
    }
    
    public function insert(array $request)
    {
        $this->dbTableCadastro = new Application_Model_DbTable_Usuario();
        $this->dbTableLogin = new Application_Model_DbTable_Login();
        
        $dadosLogin = array(
            'tlg_login' => $request['login'],
            'tlg_senha' => sha1($request['senha']),
        );
        $idLogin = $this->dbTableLogin->insert($dadosLogin);
        $dadosCadastro = array(
            'tu_nome' => $request['nome'],
            'tu_email' => $request['email'],
            'tu_cpf' => $request['cpf'],
            'tpf_id' => '2',
            'tlg_id' => $idLogin
        );
        
        $this->dbTableCadastro->insert($dadosCadastro);

        return;
    }
    
    public function update(array $request)
    {
        $this->dbTableCadastro = new Application_Model_DbTable_Usuario();
        
        $dadosCadastro = array(
            'tu_nome' => $request['nome'],
            'tu_email' => $request['email'],
            'tu_cpf' => $request['cpf'],
        );
        
        $whereCadastro= $this->dbTableCadastro->getAdapter()
                ->quoteInto('"tu_id" = ?', $request['idUsuario']);
        
        $this->dbTableCadastro->update($dadosCadastro, $whereCadastro);
    }
    
    public function delete($idUsuario)
    {
        $this->dbTableCadastro = new Application_Model_DbTable_Usuario();       
                
        $whereCadastro= $this->dbTableCadastro->getAdapter()
                ->quoteInto('"tu_id" = ?', $idUsuario);
        
        $this->dbTableCadastro->delete($whereCadastro);
    }

}

