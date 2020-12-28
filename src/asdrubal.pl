:- use_module(library(clpfd)).

%O predicado principal para resolver o problema terá a seguinte estrutura:
% 				asdrubal(+CustosDasPrateleiras, +LargurasDasPrateleiras, +AlturasDasPrateleiras, +EstoqueDasPrateleiras, 
%						 +LargurasDosLivros, +AlturasDosLivros, +TemasDosLivros, +DataDePubDosLivros,
%						 -DinheiroGasto, -QuantidadeDasPrateleirasCompradas, -ListaDosLivrosDispostosEmCadaPrateleiraComprada).

asdrubal(CustosDasPrateleiras, LargurasDasPrateleiras, AlturasDasPrateleiras, EstoqueDasPrateleiras, 
		 LargurasDosLivros, AlturasDosLivros, TemasDosLivros, DataDePubDosLivros,
		 DinheiroGasto, QuantidadesDasPrateleirasCompradas, ListaDosLivrosDispostosEmCadaPrateleiraComprada) :- 
		 
				statistics(walltime, [Start,_]),
				
				%Listas de entrada das prateleiras tem que ser do mesmo tamanho
				length(CustosDasPrateleiras, QtdeTotalPrateleiras), length(LargurasDasPrateleiras, QtdeTotalPrateleiras),
				length(AlturasDasPrateleiras, QtdeTotalPrateleiras), length(EstoqueDasPrateleiras, QtdeTotalPrateleiras),
				length(QuantidadesDasPrateleirasCompradas, QtdeTotalPrateleiras),
				
				%Listas de entrada dos livros tem que ser do mesmo tamanho
				length(LargurasDosLivros, QtdeTotaldeLivros), length(AlturasDosLivros, QtdeTotaldeLivros),
				length(TemasDosLivros, QtdeTotaldeLivros), length(DataDePubDosLivros, QtdeTotaldeLivros),
				
				
				%Dominio das Variáveis de output
				dominioPrateleirasCompradas(QuantidadesDasPrateleirasCompradas, EstoqueDasPrateleiras, QtdeTotalPrateleiras).
				
				
				%O tamanho de ListaDosLivrosDispostosEmCadaPrateleiraComprada tem que ser igual a quantidade de prateleiras compradas
				length(ListaDosLivrosDispostosEmCadaPrateleiraComprada, QtdeDasPrateleirasCompradas),
				sum(QuantidadesDasPrateleirasCompradas, #=, QtdeDasPrateleirasCompradas),
				
				
				
				
				
				%Restrição para determinar o dinehiro gasto nas compras
				scalar_product(CustosDasPrateleiras, QuantidadesDasPrateleirasCompradas, #=, DinheiroGasto),
				
				%Pesquisa no labeling
				append(DinheiroGasto, QuantidadesDasPrateleirasCompradas, VarsTmp),
				append(VarsTmp, ListaDosLivrosDispostosEmCadaPrateleiraComprada, Vars),
				labeling([minimize(DinheiroGasto)], Vars),
				
				%Tempo medido para encontrar a solução
				statistics(walltime, [End, _]),
				Time is End - Start,
				format('Time spent to find the answer: ~3d s~n', [Time]).


		
%A quantidade comprada de cada prateleira varia entre 0 e o estoque máximo daquele tipo de prateleira		
dominioPrateleirasCompradas( _, _, 0).
dominioPrateleirasCompradas(QuantidadesDasPrateleirasCompradas, EstoqueDasPrateleiras, Index) :- 
								element(Index, EstoqueDasPrateleiras, QtdeEstoque),
								element(Index, QuantidadesDasPrateleirasCompradas, QtdeComprada),
								domain([QtdeComprada], 0, QtdeEstoque).
				
				

