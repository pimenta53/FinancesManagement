class EstatisticasController < ApplicationController

  def main
    @orcamento = Orcamento.all
    @caixa = Caixa.all
    @patrocinio = Patrocinio.all
    @grupo = Grupo.all

	  totalVendas(@caixa)
	  totalCompras(@caixa)
	  totalOrcamentos(@orcamento)
	  totalPatrocinios(@patrocinio)
  end

  def relatorio
    @caixa = Caixa.all
    @patrocinio = Patrocinio.all
    @orcamento = Orcamento.all
    
    @time = Time.new
    caixaAno(@time)
    orcamentoAno(@time)
    patrocinioAno(@time)
    
  	totalVendas(@caixasAno)
  	totalCompras(@caixasAno)
  	totalOrcamentos(@orcamentosAno)
  	totalPatrocinios(@patrociniosAno)
    
    respond_to do |f|
      f.pdf {render :pdf => "relatorio"}
    end
   
  end

end
