module OrcamentosHelper

  def orcamentoValorActual(orcamento)
    orcamento.valor = 0.0
    orcamento.actual = 1
    orcamento.sub_orcamentos.each do |so|
    if so.estado == "Aceite"
       orcamento.valor = orcamento.valor + so.valor
    end
    if so.estado == "Em Espera"
      orcamento.actual = 0
    end
    end
    orcamento.save
  end
end
