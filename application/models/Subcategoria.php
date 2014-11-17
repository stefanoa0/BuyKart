<?php

class Application_Model_Subcategoria
{
 private $dbTableSubcategoria;

    public function select($where = null, $order = null, $limit = null)
    {
        $this->dbTableSubcategoria = new Application_Model_DbTable_VSubcategoria();
        $select = $this->dbTableSubcategoria->select()
                ->from($this->dbTableSubcategoria)->order($order)->limit($limit);

        if(!is_null($where)){
            $select->where($where);
        }

        return $this->dbTableSubcategoria->fetchAll($select)->toArray();
    }
    
    public function find($id)
    {
        $this->dbTableSubcategoria = new Application_Model_DbTable_Subcategoria();
        $arr = $this->dbTableSubcategoria->find($id)->toArray();
        return $arr[0];
    }
    
    public function insert(array $request)
    {
        $this->dbTableSubcategoria = new Application_Model_DbTable_Subcategoria();
        
        $dadosSubcategoria = array(
            'tsub_nome' => $request['subcategoria'],
            'tsub_descricao' => $request['descricao'],
            'tcat_id' => $request['categoria'],
            'tu_id' => $request['usuario']
        );
        
        $this->dbTableSubcategoria->insert($dadosSubcategoria);

        return;
    }
    
    public function update(array $request)
    {
        $this->dbTableSubcategoria = new Application_Model_DbTable_Subcategoria();
        
        $dadosSubcategoria = array(
            'tareap_areapesca' => $request['areaPesca']
        );
        
        $whereSubcategoria= $this->dbTableSubcategoria->getAdapter()
                ->quoteInto('"tareap_id" = ?', $request['idSubcategoria']);
        
        $this->dbTableSubcategoria->update($dadosSubcategoria, $whereSubcategoria);
    }
    
    public function delete($idSubcategoria)
    {
        $this->dbTableSubcategoria = new Application_Model_DbTable_Subcategoria();       
                
        $whereSubcategoria= $this->dbTableSubcategoria->getAdapter()
                ->quoteInto('"tareap_id" = ?', $idSubcategoria);
        
        $this->dbTableSubcategoria->delete($whereSubcategoria);
    }

}

