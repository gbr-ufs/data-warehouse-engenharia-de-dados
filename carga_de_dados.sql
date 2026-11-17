INSERT INTO dw_rede_literaria.dim_tempo (
    id_tempo, data_completa, dia, mes, nome_mes, trimestre, ano, dia_semana, eh_fim_de_semana
)
SELECT DISTINCT
    TO_CHAR(d::DATE, 'YYYYMMDD')::INT AS id_tempo,
    d::DATE AS data_completa,
    EXTRACT(DAY FROM d)::INT AS dia,
    EXTRACT(MONTH FROM d)::INT AS mes,
    TO_CHAR(d, 'TMMonth') AS nome_mes,
    EXTRACT(QUARTER FROM d)::INT AS trimestre,
    EXTRACT(YEAR FROM d)::INT AS ano,
    TO_CHAR(d, 'TMDay') AS dia_semana,
    CASE WHEN EXTRACT(ISODOW FROM d) IN (6, 7) THEN TRUE ELSE FALSE END AS eh_fim_de_semana
FROM (
    SELECT DISTINCT date_trunc('day', data) AS d FROM rede_literaria.transacao
) sub
ON CONFLICT (id_tempo) DO NOTHING;



INSERT INTO dw_rede_literaria.dim_livro (
    cod_livro_nk, titulo, autor, categoria_genero, editora, 
    preco_sugerido_catalogo, data_inicio_validade, data_fim_validade, flag_ativo
)
SELECT 
    l.id::VARCHAR AS cod_livro_nk,
    l.titulo,
    l.autores AS autor,
    CONCAT('Literatura (', l.status, ')') AS categoria_genero,
    COALESCE(l.editora, 'Não Informada') AS editora,
    l.preco AS preco_sugerido_catalogo,
    CURRENT_DATE AS data_inicio_validade,
    NULL AS data_fim_validade,
    TRUE AS flag_ativo
FROM rede_literaria.livro l
WHERE NOT EXISTS (
    SELECT 1 FROM dw_rede_literaria.dim_livro dl WHERE dl.cod_livro_nk = l.id::VARCHAR
);



INSERT INTO dw_rede_literaria.dim_localidade (
    cod_ibge, bairro, cidade, estado, regiao, pais
)
SELECT DISTINCT
    NULL AS cod_ibge,
    e.bairro,
    e.cidade,
    CASE 
        WHEN e.cidade IN ('São Paulo') THEN 'SP'
        WHEN e.cidade IN ('Rio de Janeiro') THEN 'RJ'
        WHEN e.cidade IN ('Curitiba') THEN 'PR'
        WHEN e.cidade IN ('Belo Horizonte') THEN 'MG'
        WHEN e.cidade IN ('Salvador') THEN 'BA'
        WHEN e.cidade IN ('Porto Alegre') THEN 'RS'
        WHEN e.cidade IN ('Recife') THEN 'PE'
        ELSE 'Outro'
    END AS estado,
    CASE 
        WHEN e.cidade IN ('São Paulo', 'Rio de Janeiro', 'Belo Horizonte') THEN 'Sudeste'
        WHEN e.cidade IN ('Curitiba', 'Porto Alegre') THEN 'Sul'
        WHEN e.cidade IN ('Salvador', 'Recife') THEN 'Nordeste'
        ELSE 'Brasil'
    END AS regiao,
    'Brasil' AS pais
FROM rede_literaria.endereco e
WHERE NOT EXISTS (
    SELECT 1 FROM dw_rede_literaria.dim_localidade dloc 
    WHERE dloc.bairro = e.bairro AND dloc.cidade = e.cidade
);



INSERT INTO dw_rede_literaria.dim_livraria (
    cod_livraria_nk, nome_fantasia, tipo_loja, endereco
)
SELECT 
    liv.id::VARCHAR AS cod_livraria_nk,
    liv.nome AS nome_fantasia,
    'Loja Física' AS tipo_loja,
    CONCAT(e.rua, ', ', e.numero, ' - ', e.bairro, ', ', e.cidade) AS endereco
FROM rede_literaria.livraria liv
JOIN rede_literaria.endereco e ON liv.endereco_id = e.id
WHERE NOT EXISTS (
    SELECT 1 FROM dw_rede_literaria.dim_livraria dliv WHERE dliv.cod_livraria_nk = liv.id::VARCHAR
);

INSERT INTO dw_rede_literaria.dim_vendedor (
    sk_vendedor, cod_vendedor_nk, nome, cargo, data_admissao, flag_ativo
)
OVERRIDING SYSTEM VALUE
VALUES (0, '0', 'Sem Vendedor / Venda Direta', 'N/A', CURRENT_DATE, TRUE)
ON CONFLICT (sk_vendedor) DO NOTHING;



INSERT INTO dw_rede_literaria.dim_vendedor (
    cod_vendedor_nk, nome, cargo, data_admissao, flag_ativo
)
SELECT 
    v.id::VARCHAR AS cod_vendedor_nk,
    u.nome,
    'Vendedor de Loja' AS cargo,
    CURRENT_DATE AS data_admissao,
    TRUE AS flag_ativo
FROM rede_literaria.vendedor v
JOIN rede_literaria.usuario u ON v.usuario_id = u.id
WHERE NOT EXISTS (
    SELECT 1 FROM dw_rede_literaria.dim_vendedor dv WHERE dv.cod_vendedor_nk = v.id::VARCHAR
);



INSERT INTO dw_rede_literaria.fato_vendas (
    id_tempo, sk_livro, sk_vendedor, sk_livraria, sk_localidade,
    quantidade, preco_unitario_venda, valor_desconto, valor_total_venda
)
SELECT 
    TO_CHAR(t.data, 'YYYYMMDD')::INT AS id_tempo,
    dl.sk_livro,
    COALESCE(dv.sk_vendedor, 0) AS sk_vendedor,
    dliv.sk_livraria,
    dloc.sk_localidade,
    t.quantidade,
    ROUND(((t.valor_total + t.desconto) / t.quantidade)::NUMERIC, 2) AS preco_unitario_venda,
    t.desconto AS valor_desconto,
    t.valor_total AS valor_total_venda
FROM rede_literaria.transacao t
JOIN dw_rede_literaria.dim_livro dl 
    ON dl.cod_livro_nk = t.livro_id::VARCHAR AND dl.flag_ativo = TRUE
LEFT JOIN dw_rede_literaria.dim_vendedor dv 
    ON dv.cod_vendedor_nk = t.vendedor_id::VARCHAR
JOIN dw_rede_literaria.dim_livraria dliv 
    ON dliv.cod_livraria_nk = t.livraria_id::VARCHAR
JOIN rede_literaria.endereco e 
    ON t.endereco_id = e.id
JOIN dw_rede_literaria.dim_localidade dloc 
    ON dloc.bairro = e.bairro AND dloc.cidade = e.cidade;

