<?php

class CompraController extends Zend_Controller_Action
{
    var $idCompra;
    var $compras;
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
        //recebe os dados do usuário e envia para a view
        $this->modelUsuario = new Application_Model_Cadastro();
        $this->usuario = $this->modelUsuario->select('tlg_id ='.$ArrayIdentity['tlg_id']);
        $this->view->assign("usuario",$this->usuario[0]);
    }

    public function indexAction()
    {
        //recebe todas as compras cadastradas por aquele usuário e envia para a view
        $this->modelCompra = new Application_Model_Compra();
        if($this->usuario[0]['tpf_id'] == 1){
            $this->compras = $this->modelCompra->selectCompra();
        }
        
        else{
            $this->compras = $this->modelCompra->selectCompra('tu_id = '.$this->usuario[0]['tu_id'],'tcomp_id');
        }

        $this->view->assign('compras', $this->compras);
    }
    public function novoAction()
    {
        
    }

    public function criarAction()
    {
        //Recebe os dados da view e cadastra uma nova compra
        $this->modelCompra = new Application_Model_Compra();
        $compra = $this->_getAllParams();
        
        $this->idCompra = $this->modelCompra->insert($compra);
        $this->_redirect('compra/editar/id/'.$this->idCompra);
    }
    public function editarAction()
    {
        //Na tela de editar, o cliente adicionará os produtos relacionados daquela compra.
        $this->modelCompra = new Application_Model_Compra();
        $this->modelProduto = new Application_Model_Produto();
        
        $idCompra = $this->_getParam('id');
        $compras = $this->modelCompra->selectCompra('tcomp_id ='.$idCompra);
        $this->view->assign('compras', $compras);
        
        $usuario_fez_compra = $this->modelCompra->select('tcomp_id='.$idCompra);
        $this->view->assign('usuario_compra', $usuario_fez_compra);
        if($this->usuario[0]['tpf_id'] == 1){
            $produtos = $this->modelProduto->select();    
        }
        else{
            $produtos = $this->modelProduto->select('tu_id = '.$this->usuario[0]['tu_id']);
        }
        $this->view->assign("produtos",$produtos);
    }
    public function novoprodutoAction(){
        //Adicionará os produtos recebidos da view "editar"
        $this->modelCompra = new Application_Model_Compra();
        $produtos= $this->_getAllParams();
        
        $this->modelCompra->novaCompra($produtos);
        $this->_redirect('compra/editar/id/'.$produtos['compra']);
    }
    public function relatoriomesAction(){
        $this->_helper->layout->disableLayout();
	$this->_helper->viewRenderer->setNoRender(true);
        $mes = $this->getAllParams();
        if($mes['mes'] == '0'){
            $this->relatorioAction('geral');
        }
        else{
            $this->relatorioAction('mes', $mes['mes']);
        }
         
    }
    public function relatorioidAction(){
        $this->_helper->layout->disableLayout();
	$this->_helper->viewRenderer->setNoRender(true);
        $compra = $this->getParam('id');
        $this->relatorioAction('id', $compra['id']);
         
    }
    public function relatorioAction($param, $valor=0) {
		$this->_helper->layout->disableLayout();
		$this->_helper->viewRenderer->setNoRender(true);
                
                $this->modelCompra = new Application_Model_Compra();
		 if($this->usuario[0]['tpf_id'] == 1){
                    $this->compras = $this->modelCompra->selectCompra(null,'tcomp_id');
                 }
                 else{
                    if($param == 'mes'){
                         $this->compras = $this->modelCompra->selectCompra('tu_id = '.$this->usuario[0]['tu_id'].' And MONTH(tcomp_data) = '.$valor,'tcomp_id');
                    }
                    if($param == 'id'){
                        $this->compras = $this->modelCompra->selectCompra('tu_id = '.$this->usuario[0]['tu_id'].' And tcomp_id = '.$valor,'tcomp_id');
                    }
                    elseif($param == 'geral'){
                        $this->compras = $this->modelCompra->selectCompra('tu_id = '.$this->usuario[0]['tu_id'],'tcomp_id');
                    }
                 }
                $compra = $this->_getParam('id');
                
		require_once "../library/ModeloRelatorio.php";
		$modeloRelatorio = new ModeloRelatorio();
		$modeloRelatorio->setTitulo('Compras');

                $valorTotal =0;
                $key=0;
                foreach($this->compras as $key => $compra):
                    $modeloRelatorio->setValueAlinhadoDireita(30, 40, $compra['tcomp_id']);
                    $modeloRelatorio->setValue(80, $compra['tcomp_especificacao']);
                        $data = explode('-',$compra['tcomp_data']);
                        $hora = explode(' ', $data[2]);
                        $data2 = $hora[0].'/'.$data[1].'/'.$data[0];
                    $modeloRelatorio->setValue(200, $data2);
                    $modeloRelatorio->setValue(250, $hora[1]);
                    $modeloRelatorio->setNewLine();
                    $modeloRelatorio->setNewLine();
                    $this->usuarioCompra = $this->modelCompra->select('tcomp_id = '.$compra['tcomp_id']);
                    foreach($this->usuarioCompra as $key1 => $produtos):
                        $modeloRelatorio->setValue(60,$produtos['tpr_nome']);
                        $modeloRelatorio->setValue(120, $produtos['tpr_tamanho']);
                        $modeloRelatorio->setValue(150, $produtos['tpr_preco']);
                        $modeloRelatorio->setValue(200, $produtos['tcat_categoria']);
                        $modeloRelatorio->setNewLine();
                    endforeach;
                    $modeloRelatorio->setNewLine();
                    $modeloRelatorio->setValue(40,'Valor Total');
                    $valorTotal+=$compra['valor_total'];
                    $modeloRelatorio->setValue(120, $compra['valor_total']);
                    $modeloRelatorio->setNewLine();
                    $modeloRelatorio->setNewLine();
                endforeach;
                $modeloRelatorio->setNewLine();
                $modeloRelatorio->setNewLine();
                $modeloRelatorio->setNewLine();
                $modeloRelatorio->setNewLine();
                $modeloRelatorio->setValue(40, 'Seu Gasto Total é de:');
                $modeloRelatorio->setValue(140, $valorTotal);
		$modeloRelatorio->setNewLine();
                $modeloRelatorio->setValue(40, 'Média de Gastos:');
                $modeloRelatorio->setValue(140, $valorTotal/($key+1));
                $modeloRelatorio->setValue(180, 'por compra');
		$pdf = $modeloRelatorio->getRelatorio();

		ob_end_clean();
		header('Content-Disposition: attachment;filename="rel_pesqueiros.pdf"');
		header("Content-type: application/x-pdf");
		echo $pdf->render();
   }

}

