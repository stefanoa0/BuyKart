<?php

class Application_Model_Compra
{
 private $dbTableCompra;

    public function select($where = null, $order = null, $limit = null)
    {
        $this->dbTableCompra = new Application_Model_DbTable_VUsuarioCompraProduto();
        $select = $this->dbTableCompra->select()
                ->from($this->dbTableCompra)->order($order)->limit($limit);

        if(!is_null($where)){
            $select->where($where);
        }

        return $this->dbTableCompra->fetchAll($select)->toArray();
    }

    public function selectCompra($where = null, $order = null, $limit = null)
    {
        $this->dbTableCompra = new Application_Model_DbTable_VCompra();
        $select = $this->dbTableCompra->select()
                ->from($this->dbTableCompra)->order($order)->limit($limit);

        if(!is_null($where)){
            $select->where($where);
        }

        return $this->dbTableCompra->fetchAll($select)->toArray();
    }
    public function find($id)
    {
        $this->dbTableCompra = new Application_Model_DbTable_Compra();
        $arr = $this->dbTableCompra->find($id)->toArray();
        return $arr[0];
    }
    
    public function insert(array $request)
    {
        date_default_timezone_set('America/Bahia');
        $this->dbTableCompra = new Application_Model_DbTable_Compra();
        
        $dadosCompra = array(
            'tcomp_especificacao' => $request['especificacao'],
            'tcomp_data' => date("Y-m-d h:m"),
            'tu_id' => $request['usuario']
        );
        

        return $this->dbTableCompra->insert($dadosCompra);;
    }
    public function novaCompra(array $request)
    {
        $this->dbTableUsuarioCompraProduto = new Application_Model_DbTable_UsuarioCompraProduto();
        
        $produtosDaCompra = array(
            't_usuario_tu_id' => $request['usuario'],
            't_produto_tpr_id' => $request['produto'],
            'tucp_quantidade' => $request['quantidade'],
            'tcomp_id' => $request['compra']
        );
        return $this->dbTableUsuarioCompraProduto->insert($produtosDaCompra);;
    }
    public function update(array $request)
    {
        $this->dbTableCompra = new Application_Model_DbTable_Compra();
        
        $dadosCompra = array(
            'tcomp_especificacao' => $request['especificacao'],
            'tcomp_data' => date("Y-m-d h:m"),
            'tu_id' => $request['usuario']
        );
        
        $whereCompra= $this->dbTableCompra->getAdapter()
                ->quoteInto('"tcomp_id" = ?', $request['idCompra']);
        
        $this->dbTableCompra->update($dadosCompra, $whereCompra);
    }
    
    public function delete($idCompra)
    {
        $this->dbTableCompra = new Application_Model_DbTable_Compra();       
                
        $whereCompra= $this->dbTableCompra->getAdapter()
                ->quoteInto('"tareap_id" = ?', $idCompra);
        
        $this->dbTableCompra->delete($whereCompra);
    }

}

