USE mydb;

INSERT INTO autores (id_autor, nome) VALUES (1, "Autor A");
INSERT INTO autores (id_autor, nome) VALUES (2, "Autor B");
INSERT INTO autores (id_autor, nome) VALUES (3, "Autor C");
INSERT INTO autores (id_autor, nome) VALUES (4, "Machado de Assis");

INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (1, "Livro A", 1, 1);
INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (2, "Livro B", 1, 1);
INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (3, "Livro C", 1, 1);

INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (4, "Livro D", 1, 2);
INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (5, "Livro E", 1, 2);
INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (6, "Livro F", 1, 2);

INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (7, "Livro G", 1, 3);
INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (8, "POO", 1, 3);
INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (9, "Livro Banco de dados", 1, 3);

INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (10, "Memórias Póstumas de Bras Cubas", 1, 4);
INSERT INTO
	livros(id_livro, titulo, edição, id_autor)
VALUES (11, "Quincas Borba", 1, 4);

INSERT INTO exemplares (id_exemplar, id_livro) VALUES (1, 8);
INSERT INTO exemplares (id_exemplar, id_livro) VALUES (2, 9);
INSERT INTO exemplares (id_exemplar, id_livro) VALUES (3, 10);
INSERT INTO exemplares (id_exemplar, id_livro) VALUES (4, 11);
INSERT INTO exemplares (id_exemplar, id_livro) VALUES (5, 1);
INSERT INTO exemplares (id_exemplar, id_livro) VALUES (6, 1);

INSERT INTO servidores (id_servidor, nome) VALUES (1, "Servidor A");
INSERT INTO servidores (id_servidor, nome) VALUES (2, "Servidor B");
INSERT INTO servidores (id_servidor, nome) VALUES (3, "Servidor C");

INSERT INTO alunos (id_aluno, nome) VALUES (1, "Aluno A");
INSERT INTO alunos (id_aluno, nome) VALUES (2, "Aluno B");
INSERT INTO alunos (id_aluno, nome) VALUES (3, "Aluno C");

INSERT INTO emprestimos
	(id_emprestimo, data_emprestimo, prazo_devolucao, id_aluno, id_servidor, id_exemplar)
VALUES
	(1, DATE_ADD(now(), INTERVAL 1 DAY), DATE_ADD(now(), INTERVAL 13 DAY), 3, 1, 1);
INSERT INTO emprestimos
	(id_emprestimo, data_emprestimo, prazo_devolucao, id_aluno, id_servidor, id_exemplar)
VALUES
	(2, DATE_ADD(now(), INTERVAL 1 DAY), DATE_ADD(now(), INTERVAL 13 DAY), 1, 1, 2);
INSERT INTO emprestimos
	(id_emprestimo, data_emprestimo, prazo_devolucao, id_aluno, id_servidor, id_exemplar)
VALUES
	(3, DATE_ADD(now(), INTERVAL -13 DAY), DATE_ADD(now(), INTERVAL -1 DAY), 1, 1, 3);
INSERT INTO emprestimos
	(id_emprestimo, data_emprestimo, prazo_devolucao, id_aluno, id_servidor, id_exemplar)
VALUES
	(4, DATE_ADD(now(), INTERVAL -13 DAY), DATE_ADD(now(), INTERVAL -1 DAY), 2, 1, 4);
    INSERT INTO emprestimos
	(id_emprestimo, data_emprestimo, prazo_devolucao, id_aluno, id_servidor, id_exemplar)
VALUES
	(5, DATE_ADD(now(), INTERVAL 3 DAY), DATE_ADD(now(), INTERVAL 15 DAY),3, 1, 5);
INSERT INTO emprestimos
	(id_emprestimo, data_emprestimo, prazo_devolucao, id_aluno, id_servidor, id_exemplar)
VALUES
	(6, DATE_ADD(now(), INTERVAL 4 DAY), DATE_ADD(now(), INTERVAL 16 DAY), 3, 1, 6);
    
UPDATE emprestimos SET emprestimos.data_devolucao = DATE_ADD(CURDATE(), INTERVAL -3 DAY) WHERE emprestimos.id_emprestimo = 4;