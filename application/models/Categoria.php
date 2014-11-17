<?php

class Application_Model_Categoria
{
 private $dbTableCategoria;

    public function select($where = null, $order = null, $limit = null)
    {
        $this->dbTableCategoria = new Application_Model_DbTable_Categoria();
        $select = $this->dbTableCategoria->select()
                ->from($this->dbTableCategoria)->order($order)->limit($limit);

        if(!is_null($where)){
            $select->where($where);
        }

        return $this->dbTableCategoria->fetchAll($select)->toArray();
    }
    
    public function find($id)
    {
        $this->dbTableCategoria = new Application_Model_DbTable_Categoria();
        $arr = $this->dbTableCategoria->find($id)->toArray();
        return $arr[0];
    }
    
    public function insert(array $request)
    {
        $this->dbTableCategoria = new Application_Model_DbTable_Categoria();
        
        $dadosCategoria = array(
            'tcat_categoria' => $request['categoria'],
            'tcat_descricao' => $request['descricao'],
            'tu_id' => $request['usuario']
        );
        
        $this->dbTableCategoria->insert($dadosCategoria);

        return;
    }
    
    public function update(array $request)
    {
        $this->dbTableCategoria = new Application_Model_DbTable_Categoria();
        
        $dadosCategoria = array(
            'tcat_categoria' => $request['categoria'],
            'tcat_descricao' => $request['descricao']
        );
        
        $whereCategoria= $this->dbTableCategoria->getAdapter()
                ->quoteInto('"tcat_id" = ?', $request['idCategoria']);
        
        $this->dbTableCategoria->update($dadosCategoria, $whereCategoria);
    }
    
    public function delete($idCategoria)
    {
        $this->dbTableCategoria = new Application_Model_DbTable_Categoria();       
                
        $whereCategoria= $this->dbTableCategoria->getAdapter()
                ->quoteInto('"tcat_id" = ?', $idCategoria);
        
        $this->dbTableCategoria->delete($whereCategoria);
    }

}

