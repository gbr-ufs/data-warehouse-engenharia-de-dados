### Visão Geral da Minutagem (Total: 4 min e 50 s)

| Bloco / Tarefa | Duração | Tempo de Vídeo | Responsável Sugerido |
| :--- | :--- | :--- | :--- |
| **Abertura e Tarefa 1 (Ferramenta)** | 40 s | `00:00 - 00:40` | Integrante 1 |
| **Tarefa 2 (Modelagem Multidimensional)** | 1 min 10 s | `00:40 - 01:50` | Integrante 2 |
| **Tarefa 3 (Criação do Armazém / DDL)** | 50 s | `01:50 - 02:40` | Integrante 1 (ou 3) |
| **Tarefa 4 (Carga de Dados / ETL)** | 1 min 20 s | `02:40 - 04:00` | Integrante 2 (ou 3) |
| **Validação Analítica e Encerramento** | 50 s | `04:00 - 04:50` | Todos / Integrante 1 |

---

### Roteiro Detalhado com Falas Sugeridas

#### 1. Abertura e Instalação da Ferramenta (`00:00 - 00:40`) — Tarefa 1
* **Na tela:** Slide ou documento com os nomes completos e matrículas dos integrantes; em seguida, transição para o terminal/DBeaver mostrando a conexão ativa com o **PostgreSQL**.
* **Falas sugeridas (Integrante 1):**
  > *"Olá, professor! Nós somos o grupo composto por [Nome 1], [Nome 2] (e [Nome 3]) e vamos apresentar a Atividade 5 de Engenharia de Dados.*
  > 
  > *Iniciando pela **Tarefa 1**, a ferramenta escolhida para todo o projeto foi o **PostgreSQL**, gerenciado aqui via DBeaver. Como podemos ver na tela, o serviço do banco de dados já está em execução localmente e a conexão foi estabelecida com sucesso."*

---

#### 2. Modelagem Multidimensional (`00:40 - 01:50`) — Tarefa 2
* **Na tela:** Exibição do diagrama conceitual do Data Warehouse (esquema estrela centrado na `fato_vendas` conectada às dimensões `dim_tempo`, `dim_livro`, `dim_vendedor`, `dim_livraria` e `dim_localidade`).
* **Falas sugeridas (Integrante 2):**
  > *"Passando para a **Tarefa 2**, elaboramos a modelagem multidimensional focada no processo de vendas da rede literária.*
  > 
  > *No centro, temos a nossa tabela **`fato_vendas`**, contendo medidas como quantidade, preço unitário praticado, desconto e valor total. Ao redor, definimos cinco dimensões conformadas:*
  > * *A **`dim_tempo`**, com granularidade diária, trimestres e sinalizadores de fim de semana;*
  > * *A **`dim_livro`**, modelada com controle de histórico via SCD Tipo 2 (com datas de validade e flag ativo), atendendo diretamente ao requisito de rastrear alterações de preços;*
  > * *A **`dim_localidade`**, que mapeia bairros, cidades e regiões;*
  > * *E as dimensões **`dim_livraria`** e **`dim_vendedor`**, que nos permitem avaliar o volume de vendas por loja e por funcionário, além de prever vendas diretas sem intermediário."*

---

#### 3. Criação Física do Armazém de Dados (`01:50 - 02:40`) — Tarefa 3
* **Na tela:** Interface do DBeaver/pgAdmin mostrando a execução do script `init` (banco transacional operacional `rede_literaria`) e a execução do `dw_schema` (schema `dw_rede_literaria` com índices e chaves estrangeiras).
* **Falas sugeridas (Integrante 1 ou 3):**
  > *"Para a **Tarefa 3**, realizamos a criação física das estruturas no PostgreSQL.*
  > 
  > *Primeiro, criamos o banco operacional no schema **`rede_literaria`**, conforme solicitado para simular a origem das transações.*
  > 
  > *Em seguida, executamos o DDL do armazém no schema **`dw_rede_literaria`**. Como vemos na árvore de navegação à esquerda, foram criadas as tabelas dimensionais e a tabela fato, incluindo índices nas chaves de relacionamento para otimizar as consultas OLAP."*

---

#### 4. Carga e Inserção de Dados no DW (`02:40 - 04:00`) — Tarefa 4
* **Na tela:** Mostrar rapidamente as tabelas do schema operacional povoadas com o script `populate`; em seguida, executar o script `carga_de_dados` (ETL) e dar um `SELECT *` na `fato_vendas` e nas dimensões.
* **Falas sugeridas (Integrante 2 ou 3):**
  > *"Na **Tarefa 4**, demonstramos o fluxo de inserção de dados.*
  > 
  > *Iniciamos populando o banco transacional com dados fictícios de lojas, compradores, vendedores e livros novos e usados.*
  > 
  > *Agora, rodamos a nossa rotina de carga e ETL para o armazém. Esse script extrai as transações do sistema transacional, gera as chaves de tempo e conecta as chaves substitutas (SKs). Um detalhe importante: criamos uma linha de salvaguarda 'Sem Vendedor' na dimensão vendedor para tratar compras que ocorrem sem atendimento intermediário, cumprindo a regra do enunciado.*
  > 
  > *(Após executar o script)*: *Ao consultar a tabela **`fato_vendas`**, podemos verificar que todas as vendas foram carregadas com suas devidas métricas de desconto, quantidade e receita total calculadas."*

---

#### 5. Validação Analítica e Conclusão (`04:00 - 04:50`)
* **Na tela:** Execução de duas consultas SQL demonstrando a análise de livros por localidade e desempenho de vendedores.
* **Falas sugeridas (Integrante 1 ou Todos):**
  > *"Para finalizar e comprovar que o Data Warehouse atende a todas as tomadas de decisão solicitadas:*
  > 
  > *Executamos esta primeira consulta agrupando os **livros mais e menos vendidos por cidade e estado**, permitindo à gestão identificar praças para ajuste de preço.*
  > 
  > *E nesta segunda consulta, consolidamos o **volume de vendas por livraria e por vendedor**.*
  > 
  > *Com isso, cobrimos com sucesso a instalação, a modelagem conceitual, a criação do armazém e a carga completa dos dados dentro do prazo estipulado. Obrigado!"*

---

### Dicas de Gravação para Garantir a Pontuação

**Ambiente Preparado:** Deixe as abas do DBeaver/pgAdmin já abertas com os scripts e conexões prontas para não perder tempo digitando ou esperando carregamento.
