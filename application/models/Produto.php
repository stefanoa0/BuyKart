<?php

class Application_Model_Produto
{
 private $dbTableProduto;

    public function select($where = null, $order = null, $limit = null)
    {
        $this->dbTableProduto = new Application_Model_DbTable_VProduto();
        $select = $this->dbTableProduto->select()
                ->from($this->dbTableProduto)->order($order)->limit($limit);

        if(!is_null($where)){
            $select->where($where);
        }

        return $this->dbTableProduto->fetchAll($select)->toArray();
    }
    
    public function find($id)
    {
        $this->dbTableProduto = new Application_Model_DbTable_Produto();
        $arr = $this->dbTableProduto->find($id)->toArray();
        return $arr[0];
    }
    
    public function insert(array $request)
    {
        $this->dbTableProduto = new Application_Model_DbTable_Produto();
        $ArrayPreco = explode(',', $request['preco']);
        $preco = implode ('.', $ArrayPreco);
        $dadosProduto = array(
            'tpr_nome' => $request['produto'],
            'tpr_preco' => $preco,
            'tpr_tamanho' => $request['tamanho'],
            'tsub_id' => $request['subcategoria'],
            'tu_id' => $request['usuario']
        );
        
        $this->dbTableProduto->insert($dadosProduto);

        return;
    }
    
    public function update(array $request)
    {
        $this->dbTableProduto = new Application_Model_DbTable_Produto();
        
        $dadosProduto = array(
            'tpr_nome' => $request['produto'],
            'tpr_preco' => $preco,
            'tpr_tamanho' => $request['tamanho'],
            'tsub_id' => $request['subcategoria'],
            'tu_id' => $request['usuario']
        );
        
        $whereProduto= $this->dbTableProduto->getAdapter()
                ->quoteInto('"tpr_id" = ?', $request['idProduto']);
        
        $this->dbTableProduto->update($dadosProduto, $whereProduto);
    }
    
    public function delete($idProduto)
    {
        $this->dbTableProduto = new Application_Model_DbTable_Produto();       
                
        $whereProduto= $this->dbTableProduto->getAdapter()
                ->quoteInto('"tpr_id" = ?', $idProduto);
        
        $this->dbTableProduto->delete($whereProduto);
    }

}

