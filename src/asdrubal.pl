:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(file_systems)).



%Auxiliares para input handling
%input_int(-Input) -> recebe um número de até 2 dígitos para input
%limitar n digitos
input_int(Input):-
	get_code(Char1),
    get_code(Char2),
	Char1 > 47,
	Char1 < 58,
    aux_int(Char1, Char2, Input).

% code do Char2 = 10 por exemplo '\n' ou seja, caso de numero de 1 digito
aux_int( Char1, 10, Input):-
    Input is Char1 - 48.

/*prevenir contra a possibilidade de estar um \n na input Stream
aux_int( 10, Char2, Input):-
    write('\n So pa testar \t'),
    input_int(Input).
*/


%  caso de numero de 2 digitos
aux_int( Char1, Char2, Input):-
	Char2 > 47,
	Char2 < 58,
    Digit1 is Char1 - 48,
    Digit2 is Char2 - 48,
    Temp is Digit1 * 10,
    Input is Temp + Digit2,
    get_char(_).



input_int2(Input):-
	get_code(Char1),
    get_code(Char2),
	Char1 > 47,
	Char1 < 58,
    aux_int(Char1, Char2, Input).

% code do Char2 = 10 por exemplo '\n' ou seja, caso de numero de 1 digito
aux_int2( Char1, 10, Input):-
    Input is Char1 - 48.

/*prevenir contra a possibilidade de estar um \n na input Stream
aux_int( 10, Char2, Input):-
    write('\n So pa testar \t'),
    input_int(Input).
*/


%  caso de numero de 2 digitos
aux_int2( Char1, Char2, Input):-
	Char2 > 47,
	Char2 < 58,
    Digit1 is Char1 - 48,
    Digit2 is Char2 - 48,
    Temp is Digit1 * 10,
    Input is Temp + Digit2,
    get_char(_).


%Handler para o menu principal que garante que os inputs de limite inferior não ultrapassamn os de limite superior 
%causa bug de jumpto
limit_handler(Inferior, Superior):-
	Inferior < Superior -> ! ;
	%limit_handler(Inferior, Superior, NovoInf, NovoSup).
	write('seu maroto').
/*
limit_handler(Inferior, Superior, NovoInf, NovoSup):-
	Inferior < Superior -> ! ;
	Inferior > Superior,
	format('O limite inferior ~w ultrapassa o limite superior ~w2. Por favor indique novos limites: ~t', [Inferior, Superior]),
	write('\n A largura minima desejada: \t'),
	input_int(NovoInf),
	format(' escolheu ~w como largura minima ~n', NovoInf),
	write('\n A largura maxima desejada: \t'),
	input_int(NovoSup),
	format('~n escolheu ~w como largura maxima ~t', NovoSup),
	Inferior is NovoInf,
	Superior is NovoSup,
	limit_handler(NovoInf, NovoSup). 

	*/
	
	



%input_palavra(-Palavra, +Atom) -> lê characteres e gera um atomo com eles até encontrar '\n'
    
input_palavra(Palavra, Atom):-
    get_char(Char),
    Char \= '\n',
    atom_concat(Acc, Char, Atom2),
    input_palavra(Palavra, Atom2).

input_palavra(Palavra, Palavra).
%Auxiliares para input handling -> Fim


%Auxiliares de interface
%limpa -> simula a limpeza da consola ao printar 100 newlines ('\n)
 
limpa:- 
    limpa(50), !.


%limpa(+N) -> printa N numero de newlines

limpa(0).
limpa(N):-
	nl,
	N1 is N-1,
	limpa(N1).


%pff_enter -> Pede ao utilizador que carregue na tecla enter

pff_enter:-
	write('\n Por favor pressione a tecla <Enter> para continuar.\n'),
	get_char(_), !.

%Auxiliares de interface -> FIM
%gerador de livros -> just for test atm
gerador_livros(L_LarguraMin, L_LarguraMax, L_AlturaMin, L_AlturaMax, [], TemasLivros, LargurasLivros, AlturasLivros).
gerador_livros(L_LarguraMin, L_LarguraMax, L_AlturaMin, L_AlturaMax,  H | T, TemasLivros, LargurasLivros, AlturasLivros):-
	random(L_LarguraMin, L_LarguraMax , Largura),
	append(Largura, LargurasLivros),
	random(L_AlturaMin, L_AlturaMax, Altura),
	append(Altura, AlturasLivros),
	random(1, 9, Tema),
	append(Tema, TemasLivros),
	append(H, DtofLivros),
	gerador_livros(L_Quantidade, L_LarguraMin, L_LarguraMax, L_AlturaMin, L_AlturaMax, T, TemasLivros, LargurasLivros, AlturasLivros).

gera_DoP(Quantidade, L_DoP):-
Quantidade = 0 -> ! ;
					random(0, 99,Dop),
					member(DoP, L_DoP) -> gera_DoP(Quantidade, L_DoP, DoP);
										append(DoP, L_DoP),
										NewQuantidade is Quantidade - 1,
										gera_DoP(NewQuantidade, L_DoP).

gera_DoP(Quantidade, L_DoP, LastRand):-
Quantidade = 0 -> ! ;
					NewRand is LastRand - abs(random(3, 9)),
					random(NewRand, 99 ,DoP),
					member(DoP, L_DoP) -> gera_DoP(Quantidade, L_DoP);
										  append(DoP, L_DoP),
										  NewQuantidade is Quantidade - 1,
										  gera_DoP(NewQuantidade, L_DoP).


gerador_prateleiras(Quantidade, P_LarguraMin, P_LarguraMax, P_AlturaMin, P_AlturaMax,MinPrice, MaxPrice, Stock, LargurasPrateleiras, AlturasPrateleiras, Precos, ListaPrateleiras):-
	Quantidade #= 0 -> write(Precos), write(LargurasPrateleiras), write(AlturasPrateleiras), ListaPrateleirasAux = append (LargurasPrateleiras, AlturasPrateleiras, Aux), append(Precos, ListaPrateleirasAux, ListaPrateleiras) 
						;
						write('pass1'),
		random(P_LarguraMin, P_LarguraMax, Largura), 
		write('pass2'),
		append([Largura], LargurasLivros, NewLarguras), % causa do erro "no"
		write('pass3'),
		random(P_AlturaMin, P_AlturaMax, Altura ),
		append([Altura] , AlturasLivros, NewAlturas),
		random(0, 3, Available),
		append([Available], Stock, NewStock),
		random(MinPrice, MaxPrice, Price),
		append([Price], Precos, NewPrecos),
		NewQuantidade is Quantidade - 1,
		gerador_prateleiras(NewQuantidade, P_LarguraMin, P_LarguraMax, P_AlturaMin, P_AlturaMax,MinPrice, MaxPrice, NewStock, NewLarguras, NewAlturas, NewPrecos, ListaPrateleiras),
		write('test gerador').





	


gera_pID(Quantidade, L_pID):-
Quantidade = 0 -> ! ;
					random(0, 99 ,Pid),
					member(Pid, P_pID) -> gera_Pid(Quantidade, L_pID, Pid);
										append(Pid, L_pID),
										NewQuantidade is Quantidade - 1,
										gera_DoP(NewQuantidade, L_pID).

gera_pID(Quantidade, L_pID, LastPid):-
Quantidade = 0 -> ! ;
					NewPid is LastPid - abs(random(2, 9)),
					random(NewPid, 99 ,Pid),
					member(Pid, L_pID) -> gera_DoP(Quantidade, L_pID);
										  append(Pid, L_pID),
										  NewQuantidade is Quantidade - 1,
										  gera_DoP(NewQuantidade, L_pID).


	
	

	 

	



menu_main:-          
	print_main,
	input_int2(Input),
	main_option(Input).


main_option(1):- 
	print_info_geracao,
	fazer_prateleiras,
	fazer_livros,
	write('\n Estes são os dados do problema que será agora resolvido da melhor forma possível: \n '),
	%mostrar problema
	pff_enter.


main_option(2). %sair do programa
	
	
	
%handler de inputs inválidos
/*main_option(_):- 
	write('\n Erro, a opção escolhida não é válida, escolha uma das opções disponíveis 1 ou 2. \n'),
	pff_enter,
	menu_main.
*/

print_main:-
	limpa,
	write('===================================\n'),
	write('|Biblioteca do Professor Asdrubal |\n'),
	write('|---------------------------------|\n'),
	write('|                                 |\n'),
	write('| 1. Gerar e Resolver o Problema  |\n'),
	write('| 2. Sair                         |\n'),
	write('|                                 |\n'),
	write('===================================\n'),
	write('Escolha a opção pretendida: \t').








print_info_geracao:-
    write('\n ================== Menu de geração do problema ===================== \n'),
	write('\n  |       De seguida tera a oportunidade de gerar                  | \n'),
	write('\n  |       de forma aleatoria, definindo os limites                 | \n'),
	write('\n  |       de cada parametro, as prateleiras disponiveis            | \n'),
	write('\n  |       e os livros que devem ser distribuidos pelas mesmas.     | \n'),
	write('\n  |       Cuidado, os valores mínimos nao podem ultrapassar os     | \n'),
	write('\n  |       valores máximos para cada parametro, se o fizer será     | \n'),
	write('\n  |       enviado de volta para o  menu principal.                 | \n'),
	write('\n =================================================================== \n'),
	pff_enter.


fazer_prateleiras:-
    limpa,
	write('\n ========= Gerador de Prateleiras ========== \n'),
	write('\n Por favor indique quantos tipos de prateleiras deseja gerar: \t'),
	input_int(P_Input1),
	format(' escolheu ter ~w tipos de prateleira  ~n', P_Input1),
	write('\n Sobre as prateleiras, por favor, indique: \n'),
	write('\n A largura mínima desejada: \t'),
	input_int(P_Input2),
	format(' escolheu ~w como largura minima ~n', P_Input2),
	write('\n A largura máxima desejada: \t'),
	input_int(P_Input3),
	format(' escolheu ~w como largura maxima ~n', P_Input3),
	%limit_handler(P_Input2, P_Input3),
	write('\n A altura minima permitida: \t'),
	input_int(P_Input4),
	format(' escolheu ~w como altura minima ~n', P_Input4),
	write('\n A altura máxima pretendida:  \t'),
	input_int(P_Input5),
	format(' escolheu ~w como altura maxima ~n', P_Input5),
	%limit_handler(P_Input4, P_Input5),
	write('\n O preço mínimo permitido:  \t'),
	input_int2(P_Input6),
	format(' escolheu o preco minimo de ~w yangs ~n', P_Input6),
	write('\n O preço máximo pretendido:  \t'),
	input_int2(P_Input7),
	format('escolheu o preco maximo de ~w yangs ~t ', P_Input7),
	%limit_handler(P_Input6, P_Input7),
	write('\n chekc2 \t'),
	gerador_prateleiras(P_Input1, P_Input2, P_Input3, P_Input4, P_Input5, P_Input6, P_Input7, Stock, LargurasPrateleiras, AlturasPrateleiras, Precos, ListaPrateleiras),  %CUSTO, LARGURA, ALTURA, STOCK
	write('\n chekc1 \t'),
	write(ListaPrateleiras),
	write('\n sucesso \t').

fazer_livros:-
    limpa,
	write('\n ========= Gerador de Livros ========== \t'),
	write('\n Por favor indique quantos livros deseja gerar: \t'),
	input_int(L_Input1),
	write('\n Sobre os livros a serem gerados, por favor, indique: \n'),
	write('\n A largura minima desejada: \t'),
	input_int(L_Input2),
	format(' escolheu ~w como largura minima ~n', L_Input2),
	write('\n A largura máxima desejada: \t'),
	input_int(L_Input3),
	format(' escolheu ~w como largura maxima ~n', L_Input3),
	limit_handler(L_Input2, L_Input3),
	write('\n A altura minima permitida: \t'),
	input_int(L_Input4),
	format(' escolheu ~w como altura minima ~n', L_Input4),
	write('\n A altura maxima pretendida:  \t'),
	input_int(L_Input5),
	format(' escolheu ~w como altura maxima ~n', P_Input5),
	limit_handler(L_Input4, L_Input5),
	gera_DoP(L_Input1, L_DoP), 
	gerador_livros(L_Input2, L_Input3, L_Input4, L_DoP, TemasLivros, LargurasLivros, AlturasLivros), %LARGURA, ALTURA, TEMA, DOP
	ListaLivrosOG = [LargurasLivros, AlturasLivros, TemasLivros, L_DoP],
	write(ListaLivrosOG),
	write('\n sucesso \t').

%Menus -> Fim




teste :-
		asdrubal( [3, 5, 6, 6, 1, 2], %custo de cada prateleira %CUSTO, LARGURA, ALTURA, STOCK
				  [3, 5, 6, 7, 6, 6], %largura de cada prateleira
				  [6, 6, 6, 6, 10, 3], %altura de cada prateleira
				  [1, 2, 3, 1, 0, 1], %stock de cada
				  %provavelmente será preciso adicionar um Unique_ID para cada livro e, talvez título
				  [3, 1, 2, 2, 2, 1, 1, 1], %largura dos livros %LARGURA, ALTURA, TEMA, DOP
				  [3, 3, 4, 2, 4, 6, 3, 1], % altura dos livros
				  [4, 2, 1, 3, 4 ,3 ,2, 4], %tema dos livros
				  [1991, 2002, 2010, 2003, 2007, 2006, 1999, 1991], % ano de publicação dos livros
				  DinheiroGasto, QuantidadeDasPrateleirasCompradas, ListaLivrosDispostosEmCadaPrateleiraComprada).
				  
				  
				  %Espera-se obter:
				  %DinheiroGasto = 10
				  %QuantidadeDasPrateleirasCompradas = [0, 0, 1, 1, 0]
				  %ListaLivrosDispostosEmCadaPrateleiraComprada = [ 3-[3,7,2,4,6], 4-[1,8,5] ]
				  %																  OU  4-[8,1,5]
		

%O predicado principal para resolver o problema terá a seguinte estrutura:
% 				asdrubal(+CustosPrateleiras, +LargurasPrateleiras, +AlturasPrateleiras, +EstoquePrateleiras, 
%						 +LargurasLivros, +AlturasLivros, +TemasLivros, +DataDePubLivros,
%						 -DinheiroGasto, -QuantidadeDasPrateleirasCompradas, -ListaLivrosDispostosEmCadaPrateleiraComprada).

asdrubal(CustosPrateleiras, LargurasPrateleiras, AlturasPrateleiras, EstoquePrateleiras, 
		 LargurasLivros, AlturasLivros, TemasLivros, DataDePubLivros,
		 DinheiroGasto, QtdsPrateleirasCompradas, ListaLivrosDispostosEmCadaPrateleiraComprada) :- 
		 
				statistics(walltime, [Start,_]),
				
				%Listas de entrada das prateleiras tem que ser do mesmo tamanho
				length(CustosPrateleiras, QtdeTotalPrateleiras), length(LargurasPrateleiras, QtdeTotalPrateleiras),
				length(AlturasPrateleiras, QtdeTotalPrateleiras), length(EstoquePrateleiras, QtdeTotalPrateleiras),
				length(QtdsPrateleirasCompradas, QtdeTotalPrateleiras),
				
				%Listas de entrada dos livros tem que ser do mesmo tamanho
				length(LargurasLivros, QtdeTotalLivros), length(AlturasLivros, QtdeTotalLivros),
				length(TemasLivros, QtdeTotalLivros), length(DataDePubLivros, QtdeTotalLivros),
				
				
				%Dominio das Variáveis de output
				dominioPrateleirasCompradas(QtdsPrateleirasCompradas, EstoquePrateleiras, QtdeTotalPrateleiras),
			
				
				%O tamanho de ListaLivrosDispostosEmCadaPrateleiraComprada tem que ser igual a quantidade de prateleiras compradas
				sum(QtdsPrateleirasCompradas, #=, TotalPrateleirasCompradas),
				length(ListaLivrosDispostosEmCadaPrateleiraComprada, TotalPrateleirasCompradas),
				

				dominioListaLivrosDispostosEmCadaPrateleiraComprada(ListaLivrosDispostosEmCadaPrateleiraComprada,
																		QtdeTotalLivros, QtdsPrateleirasCompradas,
																		LargurasPrateleiras, AlturasPrateleiras,
																		LargurasLivros, AlturasLivros),
		




				%Determinar o dinheiro gasto nas compras
				scalar_product(CustosPrateleiras, QtdsPrateleirasCompradas, #=, DinheiroGasto),
				
				
				%colocaLivrosNasPrateleiras(ListaLivrosDispostosEmCadaPrateleiraComprada,
				%							),
				

				%Pesquisa no labeling
				append([DinheiroGasto], QtdsPrateleirasCompradas, VarsTmp),
				append(VarsTmp, ListaLivrosDispostosEmCadaPrateleiraComprada, Vars),
				labeling([minimize(DinheiroGasto)], Vars),
				
				%Tempo medido para encontrar a solução
				statistics(walltime, [End, _]),
				Time is End - Start,
				format('Time spent to find the answer: ~3d s~n', [Time]).


		
%A quantidade comprada de cada prateleira varia entre 0 e o estoque máximo daquele tipo de prateleira		
dominioPrateleirasCompradas( _, _, 0).
dominioPrateleirasCompradas(QtdsPrateleirasCompradas, EstoquePrateleiras, Indice) :- 
								element(Indice, EstoquePrateleiras, QtdeEstoque),
								element(Indice, QtdsPrateleirasCompradas, QtdeComprada),
								domain([QtdeComprada], 0, QtdeEstoque),
								NovoIndice is Indice - 1,
								dominioPrateleirasCompradas(QtdsPrateleirasCompradas, EstoquePrateleiras, NovoIndice).
				
				
dominioListaLivrosDispostosEmCadaPrateleiraComprada( [IndicePrat-ListaLivrosDispostos | RestoDasPrateleiras],
														QtdeTotalLivros, QtdsPrateleirasCompradas,
														LargurasPrateleiras, AlturasPrateleiras,
														LargurasLivros, AlturasLivros) :-
																						element(IndicePrat, QtdsPrateleirasCompradas, Qtde),
																						Qtde #\= 0, NovaQtde #= Qtde - 1,
																						domain(ListaLivrosDispostos, 1, QtdeTotalLivros),
																						all_distinct(ListaLivrosDispostos),
																						element(IndicePrat, LargurasPrateleiras, LarguraPrat),
																						element(IndicePrat, AlturasPrateleiras, AlturaPrat),
																						restricaoLivrosDispostos(ListaLivrosDispostos,
																												LargurasLivros, AlturasLivros,
																												LarguraPrat, AlturaPrat),
																						replaceElementInList( IndicePrat, QtdsPrateleirasCompradas, NovaQtde, NovaQtdsPrateleirasCompradas),
																						dominioListaLivrosDispostosEmCadaPrateleiraComprada( RestoDasPrateleiras, QtdeTotalLivros, NovaQtdsPrateleirasCompradas,
																																			LargurasPrateleiras, AlturasPrateleiras, LargurasLivros, AlturasLivros).
																						
dominioListaLivrosDispostosEmCadaPrateleiraComprada( [], _, _, _, _, _, _).

%Substitui um element de um determinado indice por outro valor
%    replaceElementInList(+Indice, +Lista, +NovoElemento, -NovaLista)
replaceElementInList(Indice, Lista, NovoElemento, NovaLista) :- replaceElementInList(Indice, Lista, NovoElemento, NovaLista, 1).

replaceElementInList(Indice, [Elem | Resto1], NovoElemento, [Elem | Resto2], AcumuladorIndice) :-
												Indice #\= AcumuladorIndice,
												NovoAcumuladorIndice #= AcumuladorIndice + 1,
												replaceElementInList(Indice, Resto1, NovoElemento, Resto2, NovoAcumuladorIndice).

replaceElementInList(Indice, [_Elem | Resto1], NovoElemento, [NovoElemento | Resto2], AcumuladorIndice) :-
												Indice #= AcumuladorIndice,
												NovoAcumuladorIndice #= AcumuladorIndice + 1,
												replaceElementInList(Indice, Resto1, NovoElemento, Resto2, NovoAcumuladorIndice).

replaceElementInList(_, [], _, [], _).


%Restricao de largura e altura dos livros dispostos neste prateleira
restricaoLivrosDispostos(ListaLivrosDispostos, LargurasLivros, AlturasLivros, LarguraPrat, AlturaPrat) :-
												restringirLargura(ListaLivrosDispostos, LargurasLivros, LarguraPrat, 0),
												restringirAltura(ListaLivrosDispostos, AlturasLivros, AlturaPrat).


%Total da largura ocupada pelos livros tem que ser menor ou igual a largura da prateleira
restringirLargura( [IndiceLivro | RestoLivros], LargurasLivros, LarguraPrat, AcumuladorLarg) :-
															AcumuladorLarg	#=< LarguraPrat,
															element(IndiceLivro, LargurasLivros, LarguraLiv),
															NovoAcumuladorLarg #= AcumuladorLarg + LarguraLiv,
															restringirLargura( RestoLivros, LargurasLivros, LarguraPrat, NovoAcumuladorLarg).

restringirLargura( [], _, LarguraPrat, AcumuladorLarg) :- AcumuladorLarg #=< LarguraPrat.

%As alturas de todos os livros tem que ser menor ou igual a altura da prateleira
restringirAltura( [IndiceLivro | RestoLivros], AlturasLivros, AlturaPrat) :-
	element(IndiceLivro, AlturasLivros, AlturaLiv),
	AlturaPrat #>= AlturaLiv,
	restringirAltura( RestoLivros, AlturasLivros, AlturaPrat).

restringirAltura([], _, _).
