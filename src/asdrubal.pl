:- use_module(library(clpfd)).

teste :-
		asdrubal( [3, 5, 6, 6, 1, 2],
				  [3, 5, 6, 7, 6, 6],
				  [6, 6, 6, 6, 10, 3],
				  [1, 2, 3, 1, 0, 1],
				  [3, 1, 2, 2, 2, 1, 1, 1],
				  [3, 3, 4, 2, 4, 6, 3, 1],
				  [4, 2, 1, 3, 4 ,3 ,2, 4],
				  [1991, 2002, 2010, 2003, 2007, 2006, 1999, 1991],
				  DinheiroGasto, QuantidadeDasPrateleirasCompradas, ListaDosLivrosDispostosEmCadaPrateleiraComprada).
				  %Espera-se obter:
				  %DinheiroGasto = 10
				  %QuantidadeDasPrateleirasCompradas = [0, 0, 1, 1, 0]
				  %ListaDosLivrosDispostosEmCadaPrateleiraComprada = [ 3-[3,7,2,4,6], 4-[1,8,5] ]
				  %																  OU  4-[8,1,5]
		

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
				dominioPrateleirasCompradas(QuantidadesDasPrateleirasCompradas, EstoqueDasPrateleiras, QtdeTotalPrateleiras),
				
				
				%O tamanho de ListaDosLivrosDispostosEmCadaPrateleiraComprada tem que ser igual a quantidade de prateleiras compradas
				sum(QuantidadesDasPrateleirasCompradas, #=, QtdeDasPrateleirasCompradas),
				length(ListaDosLivrosDispostosEmCadaPrateleiraComprada, QtdeDasPrateleirasCompradas),
				
				
				
				
				
				
				
				
				
				%Restrição para determinar o dinehiro gasto nas compras
				scalar_product(CustosDasPrateleiras, QuantidadesDasPrateleirasCompradas, #=, DinheiroGasto),
				
				%Pesquisa no labeling
				append([DinheiroGasto], QuantidadesDasPrateleirasCompradas, VarsTmp),
				append(VarsTmp, ListaDosLivrosDispostosEmCadaPrateleiraComprada, Vars),
				labeling([minimize(DinheiroGasto)], Vars),
				
				%Tempo medido para encontrar a solução
				statistics(walltime, [End, _]),
				Time is End - Start,
				format('Time spent to find the answer: ~3d s~n', [Time]).


		
%A quantidade comprada de cada prateleira varia entre 0 e o estoque máximo daquele tipo de prateleira		
dominioPrateleirasCompradas( _, _, 0).
dominioPrateleirasCompradas(QuantidadesDasPrateleirasCompradas, EstoqueDasPrateleiras, Indice) :- 
								element(Indice, EstoqueDasPrateleiras, QtdeEstoque),
								element(Indice, QuantidadesDasPrateleirasCompradas, QtdeComprada),
								domain([QtdeComprada], 0, QtdeEstoque),
								NovoIndice is Indice - 1,
								dominioPrateleirasCompradas(QuantidadesDasPrateleirasCompradas, EstoqueDasPrateleiras, NovoIndice).
				

