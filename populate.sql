-- Arquivo de população do banco de dados.

INSERT INTO rede_literaria.endereco (rua, numero, bairro, cidade, complemento) VALUES
('Avenida Paulista', '1578', 'Bela Vista', 'São Paulo', 'Andar 1'),
('Rua das Flores', '450', 'Centro', 'Curitiba', NULL),
('Rua do Ouvidor', '120', 'Centro', 'Rio de Janeiro', 'Loja B'),
('Avenida Afonso Pena', '2300', 'Funcionários', 'Belo Horizonte', 'Sobreloja'),
('Rua Chile', '75', 'Pelourinho', 'Salvador', NULL),
('Rua dos Andradas', '1001', 'Centro Histórico', 'Porto Alegre', 'Conjunto 201'),
('Rua Augusta', '890', 'Consolação', 'São Paulo', 'Apto 42'),
('Rua da Aurora', '320', 'Boa Vista', 'Recife', 'Bloco C, Apto 104');

INSERT INTO rede_literaria.livraria (nome, endereco_id) VALUES
('Livraria Central Paulista', 1),
('Livraria Jardim do Saber', 2),
('Sebo & Livraria Imperial', 3),
('Livraria Mineira de Artes', 4),
('Livraria Bahia Literária', 5),
('Livraria Farroupilha', 6);

INSERT INTO rede_literaria.usuario (nome, cpf, idade) VALUES
('Carlos Alberto Silva', '111.222.333-01', 34),
('Mariana Costa Santos', '222.333.444-02', 29),
('Rodrigo Mendes de Oliveira', '333.444.555-03', 42),
('Juliana Ferreira Lima', '444.555.666-04', 38),
('Lucas Pereira Souza', '555.666.777-05', 25),
('Fernanda Rocha Martins', '666.777.888-06', 31),
('Beatriz Almeida Ramos', '777.888.999-07', 22),
('Gabriel Ribeiro Castro', '888.999.000-08', 27),
('Camila Duarte Silveira', '999.000.111-09', 33),
('Thiago Nogueira Gomes', '000.111.222-10', 45),
('Larissa Azevedo Campos', '123.456.789-11', 28),
('Rafael Guimarães Borges', '234.567.890-12', 39);

INSERT INTO rede_literaria.vendedor (usuario_id, livraria_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

INSERT INTO rede_literaria.comprador (usuario_id) VALUES
(7),
(8),
(9),
(10),
(11),
(12);

INSERT INTO rede_literaria.livro (titulo, autores, preco, editora, status, ano_publicacao) VALUES
('Dom Casmurro', 'Machado de Assis', 39.90, 'Editora Garnier', 'novo', 1899),
('Memórias Póstumas de Brás Cubas', 'Machado de Assis', 29.50, 'Editora Antofágica', 'usado', 1881),
('Grande Sertão: Veredas', 'João Guimarães Rosa', 85.00, 'Companhia das Letras', 'novo', 1956),
('Capitães da Areia', 'Jorge Amado', 45.00, 'Companhia das Letras', 'novo', 1937),
('O Cortiço', 'Aluísio Azevedo', 25.00, 'Editora Ática', 'usado', 1890),
('Vidas Secas', 'Graciliano Ramos', 35.00, 'Editora Record', 'usado', 1938),
('Ensaio sobre a Cegueira', 'José Saramago', 59.90, 'Companhia das Letras', 'novo', 1995),
('A Hora da Estrela', 'Clarice Lispector', 32.00, 'Editora Rocco', 'novo', 1977);

INSERT INTO rede_literaria.estoque (livro_id, livraria_id, data_aquisicao, status_livro, quantidade) VALUES
(1, 1, '2026-01-15 10:30:00', 'novo', 25),
(2, 3, '2026-02-10 14:00:00', 'usado', 5),
(3, 1, '2026-01-20 09:15:00', 'novo', 15),
(4, 5, '2026-02-01 11:45:00', 'novo', 30),
(5, 3, '2026-02-18 16:20:00', 'usado', 8),
(6, 4, '2026-03-05 13:10:00', 'usado', 12),
(7, 2, '2026-03-12 15:50:00', 'novo', 20),
(8, 6, '2026-03-20 17:00:00', 'novo', 18);

INSERT INTO rede_literaria.transacao (data, status_livro, comprador_id, vendedor_id, livraria_id, endereco_id, livro_id, valor_total, desconto, quantidade) VALUES
('2026-03-01 10:15:00', 'novo', 1, 1, 1, 7, 1, 74.80, 5.00, 2),
('2026-03-02 11:30:00', 'usado', 2, 3, 3, 8, 2, 29.50, 0.00, 1),
('2026-03-05 14:20:00', 'novo', 3, 1, 1, 1, 3, 75.00, 10.00, 1),
('2026-03-10 16:45:00', 'novo', 4, 5, 5, 5, 4, 90.00, 0.00, 2),
('2026-03-15 09:50:00', 'usado', 5, 3, 3, 3, 5, 22.50, 2.50, 1),
('2026-03-18 18:00:00', 'novo', 6, 2, 2, 2, 7, 54.90, 5.00, 1),
('2026-03-22 13:40:00', 'novo', 1, 6, 6, 6, 8, 90.00, 6.00, 3),
('2026-03-25 15:10:00', 'usado', 2, 4, 4, 4, 6, 35.00, 0.00, 1);
