CREATE SCHEMA dw_rede_literaria;


CREATE TABLE IF NOT EXISTS dw_rede_literaria.dim_tempo (
    id_tempo INT PRIMARY KEY,
    data_completa DATE NOT NULL,
    dia INT NOT NULL,
    mes INT NOT NULL,
    nome_mes VARCHAR(20) NOT NULL,
    trimestre INT NOT NULL,
    ano INT NOT NULL,
    dia_semana VARCHAR(20) NOT NULL,
    eh_fim_de_semana BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS dw_rede_literaria.dim_livro (
    sk_livro SERIAL PRIMARY KEY,
    cod_livro_nk VARCHAR(50) NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(150),
    categoria_genero VARCHAR(100),
    editora VARCHAR(100),
    preco_sugerido_catalogo NUMERIC(10, 2) NOT NULL,
    data_inicio_validade DATE NOT NULL,
    data_fim_validade DATE,
    flag_ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS dw_rede_literaria.dim_vendedor (
    sk_vendedor SERIAL PRIMARY KEY,
    cod_vendedor_nk VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    cargo VARCHAR(100),
    data_admissao DATE,
    flag_ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS dw_rede_literaria.dim_localidade (
    sk_localidade SERIAL PRIMARY KEY,
    cod_ibge VARCHAR(20),
    bairro VARCHAR(100),
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    regiao VARCHAR(50),
    pais VARCHAR(50) DEFAULT 'Brasil'
);

CREATE TABLE IF NOT EXISTS dw_rede_literaria.dim_livraria (
    sk_livraria SERIAL PRIMARY KEY,
    cod_livraria_nk VARCHAR(50) NOT NULL,
    nome_fantasia VARCHAR(150) NOT NULL,
    tipo_loja VARCHAR(50),
    endereco VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS dw_rede_literaria.fato_vendas (
    id_venda BIGSERIAL PRIMARY KEY,
    id_tempo INT NOT NULL REFERENCES dw_rede_literaria.dim_tempo(id_tempo),
    sk_livro INT NOT NULL REFERENCES dw_rede_literaria.dim_livro(sk_livro),
    sk_vendedor INT NOT NULL REFERENCES dw_rede_literaria.dim_vendedor(sk_vendedor),
    sk_livraria INT NOT NULL REFERENCES dw_rede_literaria.dim_livraria(sk_livraria),
    sk_localidade INT NOT NULL REFERENCES dw_rede_literaria.dim_localidade(sk_localidade),
    quantidade INT NOT NULL,
    preco_unitario_venda NUMERIC(10, 2) NOT NULL,
    valor_desconto NUMERIC(10, 2) DEFAULT 0.00,
    valor_total_venda NUMERIC(10, 2) NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_fato_tempo ON dw_rede_literaria.fato_vendas(id_tempo);
CREATE INDEX IF NOT EXISTS idx_fato_livro ON dw_rede_literaria.fato_vendas(sk_livro);
CREATE INDEX IF NOT EXISTS idx_fato_vendedor ON dw_rede_literaria.fato_vendas(sk_vendedor);
CREATE INDEX IF NOT EXISTS idx_fato_livraria ON dw_rede_literaria.fato_vendas(sk_livraria);
CREATE INDEX IF NOT EXISTS idx_fato_localidade ON dw_rede_literaria.fato_vendas(sk_localidade);
