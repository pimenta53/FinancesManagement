prawn_document(:right_margin => 50, :left_margin => 50) do |pdf|
	time = Time.new
	pdf.move_down(350)
	if(time.month <= 8)
	pdf.text "Relatório de Contas de " + (time.year-1).to_s + "/" + time.year.to_s, :size => 35, :align => :center, :style => :bold_italic
	end
	if(time.month > 8)
	pdf.text "Relatório de Contas de " + time.year.to_s + "/" + (time.year+1).to_s, :size => 35, :align => :center, :style => :bold_italic
	end
	pdf.start_new_page
	
	pdf.move_down(50)
	pdf.text "Caixa", :size => 25, :style => :bold
	pdf.move_down(30)
	i = 0
	caixas = @caixasAno.map do |c|
	[
	i = i+1,
	c.id,
	c.nome,
	c.descricao,
	c.valor,
	c.estado,
	c.data,
	(utilizador_from_id(c.utilizador_id)) ? utilizador_from_id(c.utilizador_id).nome : "Inexistente"
	]
	end
	headC = ["#", "ID", "Nome", "Descrição", "Valor", "Transação", "Data", "Utilizador"]
	pdf.table([headC]+caixas, :header => true) do
		row(0).style(:font_style => :bold, :background_color => 'cccccc')
		column(3).style(:width => 100)
		column(0).style(:align => :left)
		column(1..6).style(:align => :center)
	end
	pdf.move_down(30)
	pdf.text "Faturação:", :size => 15
	pdf.move_down(15)
	pdf.text "Total de Vendas = " + @total_vendas.to_s + " €"
	pdf.move_down(15)
	pdf.text "Total de Compras = " + @total_compras.to_s + " €"
	pdf.start_new_page
	
	pdf.move_down(50)
	pdf.text "Orçamentos", :size => 25, :style => :bold
	pdf.move_down(30)
	j = 0
	orcamentos = @orcamentosAno.map do |o|
	[
	j = j+1,
	o.id,
	o.nome,
	o.descricao,
	o.valor,
	o.data,
	(o.actual) ? "Atualizado" : "Desatualizado",
	(grupo_from_id(o.grupo_id)) ? grupo_from_id(o.grupo_id).nome : "Inexistente"
	]
	end
	headO = ["#", "ID", "Nome", "Descrição", "Valor", "Data", "Estado", "Grupo"]
	pdf.table([headO]+orcamentos, :header => true) do
	row(0).style(:font_style => :bold, :background_color => 'cccccc')
	column(3).style(:width => 100)
	column(0).style(:align => :left)
	column(1..7).style(:align => :center)
	end
	pdf.move_down(30)
	pdf.text "Faturação:", :size => 15
	pdf.move_down(15)
	pdf.text "Gastos Totais = " + @total_orcamento.to_s + " €"
	pdf.start_new_page
		
	pdf.indent(20) do
		pdf.move_down(50)
		pdf.text "Sub-Orçamentos", :size => 20
		headS = ["#", "ID", "Descrição", "Valor", "Estado", "Utilizador", "Orçamento"]
		numOrc = 1
		@orcamentosAno.each do |o|
			pdf.move_down(30)
			pdf.text numOrc.to_s + " - " + o.nome, :size => 16
			numOrc = numOrc + 1 
			pdf.move_down(10)
			k = 0
			subOrcamentos = o.sub_orcamentos.map do |s|
			[
			k = k+1,
			s.id,
			s.descricao,
			s.valor,
			s.estado,
			Orcamento.find_by_id(s.orcamento_id).nome,
			(utilizador_from_id(s.utilizador_id)) ? utilizador_from_id(s.utilizador_id).nome : "Inexistente"
			]
			end
			pdf.table([headS] + subOrcamentos, :header => true) do
				row(0).style(:font_style => :bold, :background_color => 'cccccc')
				column(2).style(:width => 100)
				column(0).style(:align => :left)
				column(1..6).style(:align => :center)
			end
			pdf.move_down(30)
			totalSubOrcamentos(o)
			pdf.text "Faturação:", :size => 15
			pdf.move_down(15)
			pdf.text "Gastos Totais = " + @total_sub_orcamento.to_s + " €"
		end
	end
	pdf.start_new_page
	
	pdf.move_down(50)
	pdf.text "Patrocínios", :size => 25, :style => :bold
	pdf.move_down(30)
	l = 0
	patrocinios = @patrociniosAno.map do |p|
	[
	l = l+1,
	p.id,
	p.nome,
	p.descricao,
	p.valor,
	p.datainicio,
	p.datafim,
	p.link,
	(utilizador_from_id(p.utilizador_id)) ? utilizador_from_id(p.utilizador_id).nome : "Inexistente"
	]
	end
	headP = ["#", "ID", "Nome", "Descrição", "Valor", "Data Inicial", "Data Final", "Link", "Utilizador"]
	pdf.table([headP]+patrocinios, :header => true) do
		row(0).style(:font_style => :bold, :background_color => 'cccccc')
		row(0..7).style(:size => 9)
		column(3).style(:width => 100)
		column(0).style(:align => :left)
		column(1..8).style(:align => :center)
	end
	pdf.move_down(30)
	pdf.text "Faturação:", :size => 15
	pdf.move_down(15)
	pdf.text "Total de Receitas = " + @total_patrocinio.to_s + " €"
	pdf.move_down(75)
	pdf.text "O Tesoureiro,", :align => :right, :size => 13
	pdf.move_down(10)
	pdf.text "________________________", :align => :right
	pdf.move_down(15)
	pdf.text "O Presidente,", :align => :right, :size => 13
	pdf.move_down(10)
	pdf.text "________________________", :align => :right
end