CREATE SCHEMA rede_literaria;

CREATE TABLE rede_literaria.endereco (
        id SERIAL PRIMARY KEY,
        rua VARCHAR NOT NULL,
        numero VARCHAR NOT NULL,
        bairro VARCHAR NOT NULL,
        cidade VARCHAR NOT NULL,
        complemento VARCHAR
);

CREATE TABLE rede_literaria.livraria (
        id SERIAL PRIMARY KEY,
        nome VARCHAR NOT NULL,
        endereco_id INT REFERENCES rede_literaria.endereco(id)
);

CREATE TABLE rede_literaria.usuario (
        id SERIAL PRIMARY KEY,
        nome VARCHAR NOT NULL,
        cpf VARCHAR NOT NULL UNIQUE,
        idade INT NOT NULL
);

CREATE TABLE rede_literaria.vendedor (
        id SERIAL PRIMARY KEY,
        usuario_id INT REFERENCES rede_literaria.usuario(id),
        livraria_id INT REFERENCES rede_literaria.livraria(id)
);

CREATE TABLE rede_literaria.comprador (
        id SERIAL PRIMARY KEY,
        usuario_id INT REFERENCES rede_literaria.usuario(id)
);

CREATE TYPE rede_literaria.status_livro AS ENUM ('usado', 'novo');

CREATE TABLE rede_literaria.livro (
        id SERIAL PRIMARY KEY,
        titulo VARCHAR NOT NULL,
        autores VARCHAR,
        preco DECIMAL NOT NULL,
        editora VARCHAR,
        status rede_literaria.status_livro NOT NULL,
        ano_publicacao INT NOT NULL
);

CREATE TABLE rede_literaria.transacao (
        id SERIAL PRIMARY KEY,
        data TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        status_livro rede_literaria.status_livro NOT NULL,
        comprador_id INT REFERENCES rede_literaria.comprador(id),
        vendedor_id INT REFERENCES rede_literaria.vendedor(id),
        livraria_id INT REFERENCES rede_literaria.livraria(id),
        endereco_id INT REFERENCES rede_literaria.endereco(id),
        livro_id INT REFERENCES rede_literaria.livro(id),
        valor_total DECIMAL NOT NULL,
        desconto DECIMAL NOT NULL DEFAULT 0.00,
        quantidade INT NOT NULL
);

CREATE TABLE rede_literaria.estoque (
        id SERIAL PRIMARY KEY,
        livro_id INT REFERENCES rede_literaria.livro(id),
        livraria_id INT REFERENCES rede_literaria.livraria(id),
        data_aquisicao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        status_livro rede_literaria.status_livro NOT NULL,
        quantidade INT NOT NULL
);
