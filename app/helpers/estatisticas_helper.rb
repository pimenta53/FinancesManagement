module EstatisticasHelper
  
  def caixaAno(data)
    if(data.month <= 8)
      @caixasAno = Caixa.find :all, :conditions => ['data BETWEEN ? AND ?', (data.year-1).to_s+"-09-01", data.year.to_s+"-08-31"]
    else
      @caixasAno = Caixa.find :all, :conditions => ['data BETWEEN ? AND ?', data.year.to_s+"-09-01", (data.year+1).to_s+"-08-31"]
    end
  end
  
  def orcamentoAno(data)
    if(data.month <= 8)
      @orcamentosAno = Orcamento.find :all, :conditions => ['data BETWEEN ? AND ?', (data.year-1).to_s+"-09-01", data.year.to_s+"-08-31"]
    else
      @orcamentosAno = Orcamento.find :all, :conditions => ['data BETWEEN ? AND ?', data.year.to_s+"-09-01", (data.year+1).to_s+"-08-31"]
    end
  end
  
  def patrocinioAno(data)
      @patrociniosAno = Patrocinio.find :all, :conditions => ['? BETWEEN datainicio AND datafim', data]
  end
  
  def totalCompras(caixa)
    @total_compras = 0.0
  	caixa.each do |c|
  		@total_compras = @total_compras + c.valor unless c.estado != "Compra"
  	end
  end
  
  def totalVendas(caixa)
    @total_vendas = 0.0
  	caixa.each do |c|
  		@total_vendas = @total_vendas + c.valor unless c.estado != "Venda"
  	end
  end
  
  def totalOrcamentos(orcamento)
    @total_orcamento = 0.0
  	orcamento.each do |o|
  		@total_orcamento = @total_orcamento + o.valor
  	end
  end
  
  def totalSubOrcamentos(orcamento)
    @total_sub_orcamento = 0.0
    orcamento.sub_orcamentos.each do |s|
      @total_sub_orcamento = @total_sub_orcamento + s.valor unless s.estado != "Aceite"
    end
  end
  
  def totalPatrocinios(patrocinio)
    @total_patrocinio = 0.0
  	patrocinio.each do |p|
  		@total_patrocinio = @total_patrocinio + p.valor
  	end
  end
  
  def utilizador_from_id(id)
    utilizador = Utilizador.find_by_id(id)
    return nil if utilizador.nil?
    return utilizador
  end
  
  def grupo_from_id(id)
    grupo = Grupo.find_by_id(id)
    return nil if grupo.nil?
    return grupo
  end
  
end
