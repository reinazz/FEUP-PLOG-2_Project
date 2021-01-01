:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(file_systems)).

/*revisão nota tele móvel

to do */
%Sistema de Ficheiros -> para revisão 
file_Path(FilePath):-
    current_directory(Dir),
    atom_concat(Dir, 'test.pl', FilePath).

guardarLivros(Lista_Livros, Nome_Lista):-
    file_Path(Path_Livros),
    Term =.. [Nome_Lista, Lista_Livros],    
    open(Path_Livros, append, Stream), 
    write(Stream, '\n'),
    write_term(Stream, Term, []), 
    write(Stream, '.\n'), 
    close(Stream),
    write(Nome_Lista), write(' gravada com sucesso no directorio: '), write(Path_Livros), nl, nl,
    reconsult(Path_Livros).

guardarPrateleiras(Lista_Prateleiras, Nome_Lista):-
    file_Path(Path_Prateleiras),
    Term =.. [Nome_Lista, Lista_Prateleiras],    
    open(Path_Livros, append, Stream), 
    write(Stream, '\n'),
    write_term(Stream, Term, []), 
    write(Stream, '.\n'), 
    close(Stream),
    write(Nome_Lista), write(' gravada com sucesso no directorio: '), write(Path_Prateleiras), nl, nl,
    reconsult(Path_Prateleiras).
%Sistema de ficheiros -> Fim -> para revisão 

%Auxiliares para input handling
%aux_int(-Input) -> recebe um número de até 2 dígitos para input
%limitar n digitos
aux_int(Input):-
	get_code(Char1),
    get_code(Char2),
	Char1 > 47,
	Char1 < 58,
    aux2_int(Char1, Char2, Input).

% code do Char2 = 10 por exemplo '\n' ou seja, caso de numero de 1 digito
aux2_int( Char1, 10, Input):-
    Input is Char1 - 48.

%  caso de numero de 2 digitos
aux2_int( Char1, Char2, Input):-
	Char2 > 47,
	Char2 < 58,
    Digit1 is Char1 - 48,
    Digit2 is Char2 - 48,
    Temp is Digit1 * 10,
    Input is Temp + Digit2,
    get_char(_).


%aux_palavra(-Palavra, +Atom) -> lê characteres e gera um atomo com eles até encontrar '\n'
    
aux_palavra(Palavra, Atom):-
    get_char(Char),
    Char \= '\n',
    atom_concat(Acc, Char, Atom2),
    aux_palavra(Palavra, Atom2).

aux_palavra(Palavra, Palavra).
%Auxiliares para input handling -> Fim


%Auxiliares de interface
%limpa -> simula a limpeza da consola ao printar 100 newlines ('\n)
 
limpa:- 
    limpa(100), !.


%limpa(+N) -> printa N numero de newlines

limpa(0).
limpa(N):-
	nl,
	N1 is N-1,
	limpa(N1).


%pff_enter -> Pede ao utilizador que carregue na tecla enter

pff_enter:-
	write('Por favor pressione a tecla <Enter> para continuar.\n'),
	get_char(_), !.

%Auxiliares de interface -> FIM
%gerador de livros -> just for test atm
gerador_livros(Input, Lista_Livros):-
	guardarLivros( [[3, 1, 2, 2, 2, 1, 1, 1], 
					[3, 3, 4, 2, 4, 6, 3, 1], 
					[4, 2, 1, 3, 4 ,3 ,2, 4], 
					[1991, 2002, 2010, 2003, 2007, 2006, 1999, 1991] ] , 'livros'),
write('Por implementar \n ').



gerador_prateleiras(Input, Lista_Prateleiras):-			
	guardarPrateleiras([[3, 5, 6, 6, 1, 2], 
						[3, 5, 6, 7, 6, 6], 
						[6, 6, 6, 6, 10, 3],
						[1, 2, 3, 1, 0, 1]	] , 'prateleiras'),
write('Por implementar \n ').
%geradores, test phase


menu_main:-          
	print_main,
	aux_int(Input),
	main_option(Input).

main_option(1):- 
	asdrubal(Lista_Livros, Lista_Prateleiras) .

main_option(2):- 
	write('\n Por favor indique quantos livros deseja gerar: \n'),
	aux_int(Input),
	gerador_livros(Input, Lista_Prateleiras).
	
main_option(3):- 
	write('\n Por favor indique quantas prateleiras deseja gerar: \n'),
	aux_int(Input),
	gerador_prateleiras(Input, Lista_Prateleiras).
	
main_option(4):- 
	write('\n Por favor indique quantas prateleiras deseja gerar: \n'),
	aux_int(Input1),
	write('\n Por favor indique quantos livros deseja gerar: \n'),
	aux_int(Input2),
	gerador_prateleiras(Input1, Lista_Prateleiras), gerador_livros(Input2, Lista_Livros).
	
%Termina o programa
main_option(5).

%handler de inputs inválidos
main_option(_):- 
	write('\n Erro, a opção escolhida não é válida, escolha uma das opções disponíveis [1, 5]. \n'),
	pff_enter,
	menu_main.

print_main:-
	limpa,
	write('==================================\n'),
	write('|Biblioteca do Professor Asdrubal|\n'),
	write('|--------------------------------|\n'),
	write('|                                |\n'),
	write('| 1. Resolver problema           |\n'),
	write('| 2. Gerar livros                |\n'),
	write('| 3. Gerar Prateleiras           |\n'),
	write('| 4. Gerar Prateleiras e Livros  |\n'),
	write('| 5. Sair                        |\n'),
	write('==================================\n'),
	write('Escolha a opção pretendida:\t').
%Menus -> Fim



teste :-
		asdrubal( [3, 5, 6, 6, 1, 2], %custo de cada prateleira
				  [3, 5, 6, 7, 6, 6], %largura de cada prateleira
				  [6, 6, 6, 6, 10, 3], %altura de cada prateleira
				  [1, 2, 3, 1, 0, 1], %stock de cada
				  %provavelmente será preciso adicionar um Unique_ID para cada livro e, talvez título
				  [3, 1, 2, 2, 2, 1, 1, 1], %largura dos livros
				  [3, 3, 4, 2, 4, 6, 3, 1], % altura dos livros
				  [4, 2, 1, 3, 4 ,3 ,2, 4], %tema dos livros
				  [1991, 2002, 2010, 2003, 2007, 2006, 1999, 1991],% ano de publicação dos livros
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
				
				%Altura do livro mais alto de um dado tema será o primeiro factor restritivo para a aquisição da prateleira correspondente
				%Somatório das larguras dos livros definem o comprimento de prateleira necessário, sendo que se deve comparar o preço de 1 que tenha o comprimento necessário com a soma de N prateleiras mais pequenas que juntas cheguem para arrumar os lvros
				%Por outro lado, se uma prateleira não for ocupada na totalidade, o espaço que resta deve ser tratado como uma "nova" prateleira de custo 0 vs Fazer a relação de preço/comprimento para definir o custo da "nova" sendo este subtraído ao da prateleira "Mãe" -> dependerá do professor
				
		
				%Determinar o dinheiro gasto nas compras
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
				
				

