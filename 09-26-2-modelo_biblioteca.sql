use mydb; /* IMPORTANTE! */

/*
	a) Visualizar os livros cadastrados com o autor “Machado de Assis”;
*/

DROP TABLE mydb.livros;

SELECT
	livros.titulo
FROM
	livros, autores
WHERE
	autores.nome = "Machado de Assis" AND
    autores.id_autor = livros.id_autor;

/*
	b) Visualizar todos as informações sobre os exemplares cadastrados dos livros com nome “Banco
	de dados” no título;
*/
SELECT
	exemplares.*
FROM
	livros, exemplares
WHERE
	livros.id_livro = exemplares.id_livro AND
	livros.titulo LIKE "%Banco de dados%";

/*
	c) Mostrar todos os empréstimos realizados em ordem de data constando: nome do aluno, data
	do empréstimo e nome do servidor que emprestou;
*/
SELECT
	alunos.nome, emprestimos.data_emprestimo, servidores.nome
FROM
	alunos, emprestimos, servidores
WHERE
	alunos.id_aluno = emprestimos.id_aluno AND
    emprestimos.id_servidor = servidores.id_servidor
ORDER BY emprestimos.data_emprestimo ASC;

/*
	d) Mostrar em ordem alfabética por nome do livro uma relação de exemplares que estão em
	atraso em termo de devolução por parte dos alunos;
*/
SELECT
	livros.id_livro, alunos.nome, livros.titulo
FROM
	livros, exemplares, emprestimos, alunos
WHERE
	livros.id_livro = exemplares.id_livro AND
	exemplares.id_exemplar = emprestimos.id_exemplar AND
    emprestimos.id_aluno = alunos.id_aluno AND
    emprestimos.prazo_devolucao < CURDATE() AND
    emprestimos.data_devolucao is NULL
ORDER BY livros.titulo;

/*
	e) Mostrar uma relação de alunos que estão com livros em atraso em relação a devolução com o
	nome dos livros e a quantidade de dias que eles estão em atraso;
*/
SELECT
	alunos.nome, livros.titulo, DATEDIFF(CURDATE(), prazo_devolucao) as atraso_dias
FROM
	alunos, emprestimos, livros, exemplares
WHERE
	alunos.id_aluno = emprestimos.id_aluno AND
    emprestimos.id_exemplar = exemplares.id_exemplar AND
    exemplares.id_livro = livros.id_livro AND
    emprestimos.prazo_devolucao < NOW() AND
    emprestimos.data_devolucao is NULL;
/*
	f) Mostrar uma relação em ordem alfabética pelo nome do aluno e nome do livro, todos os livros
	que foram pegos emprestados pelos respectivos alunos;
*/
SELECT
	alunos.nome, livros.titulo
FROm
	alunos, emprestimos, livros, exemplares
WHERE
	alunos.id_aluno = emprestimos.id_aluno AND
    emprestimos.id_exemplar = exemplares.id_exemplar AND
    exemplares.id_livro = livros.id_livro
ORDER BY alunos.nome, livros.titulo;

/*
	g) Mostrar sem repetições o nome de todos os alunos que pegaram emprestado o livro cujo título
	é “POO”;
*/
SELECT
	alunos.nome, livros.titulo
FROm
	alunos, emprestimos, livros, exemplares
WHERE
	alunos.id_aluno = emprestimos.id_aluno AND
    emprestimos.id_exemplar = exemplares.id_exemplar AND
    exemplares.id_livro = livros.id_livro AND
    livros.titulo = "POO"
ORDER BY alunos.nome, livros.titulo;

/*
	h) Mostrar um resumo com a relação de todos os alunos que pegaram fizeram empréstimos e a
	quantidade de empréstimos que eles realizaram;
*/
SELECT
	alunos.nome, COUNT(alunos.id_aluno)
FROM
	alunos, emprestimos, livros, exemplares
WHERE
	alunos.id_aluno = emprestimos.id_aluno AND
    emprestimos.id_exemplar = exemplares.id_exemplar AND
    exemplares.id_livro = livros.id_livro
GROUP BY alunos.nome;

/*
	i) Mostrar um resumo com a relação de todos os alunos que pegaram livros emprestados com a
	quantidade de livros total pegos em todos os empréstimos já realizados;
*/
SELECT
	alunos.nome, COUNT(alunos.id_aluno)
FROM
	alunos, emprestimos, livros, exemplares
WHERE
	alunos.id_aluno = emprestimos.id_aluno AND
    emprestimos.id_exemplar = exemplares.id_exemplar AND
    exemplares.id_livro = livros.id_livro
GROUP BY alunos.nome;

/*
	j) Mostrar uma relação de livros com a quantidade de todos os exemplares (quantidade) que
	existem para cada livro na biblioteca;
*/
SELECT
	livros.titulo, COUNT(livros.titulo)
FROM
	livros, exemplares
WHERE
	livros.id_livro = exemplares.id_livro
GROUP BY livros.titulo;

/*
	k) Mostrar uma relação contendo o nome dos alunos e os valores totais de multas que eles
	pagaram tem todos os empréstimos entregues atrasados;
*/
SELECT
	alunos.nome, SUM(devolucao.valor_multa) as total_multas
FROM
	alunos, emprestimos, devolucao
WHERE
	alunos.id_aluno = emprestimos.id_emprestimo AND
    emprestimos.id_emprestimo = devolucao.id_emprestimo
GROUP BY alunos.id_aluno;