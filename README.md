# Banco de Dados para Plataforma de Streaming de Áudio

Projeto acadêmico de banco de dados relacional desenvolvido em **PostgreSQL** para representar o funcionamento de uma plataforma de streaming de áudio. O modelo contempla usuários, artistas, ouvintes, podcasters, podcasts, episódios, músicas, álbuns, faixas, playlists, históricos de reprodução e registros de royalties.

## Objetivo

O objetivo do projeto é aplicar, na prática, conceitos de modelagem e implementação de bancos de dados relacionais, incluindo:

- criação de tabelas, chaves primárias e chaves estrangeiras;
- relacionamentos entre entidades;
- tabelas associativas para relações muitos-para-muitos;
- índices e sequências;
- inserção de dados para testes;
- consultas simples e consultas envolvendo múltiplas tabelas;
- funções de agregação, agrupamentos e subconsultas.

## Principais funcionalidades representadas

O banco permite armazenar e relacionar informações sobre:

- usuários com perfis de ouvinte, artista ou podcaster;
- podcasts, gêneros e episódios;
- músicas, álbuns e faixas;
- participação de artistas em álbuns e faixas;
- playlists criadas e seguidas pelos ouvintes;
- artistas e podcasts seguidos pelos usuários;
- histórico de reprodução de músicas e episódios;
- valores de royalties de faixas e episódios;
- planos de assinatura dos ouvintes.

## Estrutura do banco

A implementação possui:

- **25 tabelas**;
- **25 índices**;
- **7 sequências** para geração de identificadores;
- dados de exemplo para validação do modelo;
- **10 consultas SQL** desenvolvidas para a Etapa 6.

Entre as principais tabelas estão:

`usuario`, `ouvinte`, `artista`, `podcaster`, `podcast`, `episodio`, `musica`, `album`, `faixa`, `playlist`, `historico`, `registro_royalty_faixa` e `registro_royalty_episodio`.

## Consultas implementadas

A Etapa 6 contém as seguintes consultas:

| Nº | Tipo | Consulta |
|---:|---|---|
| 1 | Simples | Usuários cadastrados a partir de uma determinada data |
| 2 | Simples | Artistas com origem no Brasil |
| 3 | Junção | Podcasts e seus respectivos podcasters |
| 4 | Junção | Faixas com música, álbum e artista participante |
| 5 | Junção | Histórico de episódios reproduzidos pelos ouvintes |
| 6 | Função extrema | Maior valor de royalty registrado para episódio |
| 7 | Agrupamento | Quantidade de ouvintes por plano de assinatura |
| 8 | Agrupamento | Quantidade de reproduções por tipo de conteúdo |
| 9 | Agrupamento | Total de royalties de faixas por artista |
| 10 | Subconsulta | Episódios com royalty acima da média |

## Tecnologias utilizadas

- PostgreSQL
- SQL
- `psql`
- Microsoft Word para elaboração do relatório

## Organização dos arquivos

```text
.
├── README.md
├── projeto_etapa6_completo.sql
├── g8_sql_corrigido.sql
├── meus_inserts_corrigido.sql
├── consultas_etapa6.sql
├── relatorio_etapa6.docx
└── etapa6_resultados/
    ├── consulta_01.png
    ├── consulta_02.png
    ├── consulta_03.png
    ├── consulta_04.png
    ├── consulta_05.png
    ├── consulta_06.png
    ├── consulta_07.png
    ├── consulta_08.png
    ├── consulta_09.png
    └── consulta_10.png
```

### Descrição dos arquivos

- `projeto_etapa6_completo.sql`: cria o banco, insere os dados de exemplo e executa as consultas da Etapa 6.
- `g8_sql_corrigido.sql`: contém a estrutura do banco, suas restrições, índices e sequências.
- `meus_inserts_corrigido.sql`: contém os dados utilizados para testar o banco.
- `consultas_etapa6.sql`: contém somente as dez consultas solicitadas na etapa.
- `relatorio_etapa6.docx`: relatório com a descrição, o código SQL e o resultado de cada consulta.
- `etapa6_resultados/`: imagens dos resultados obtidos no PostgreSQL.

## Como executar

### Pré-requisitos

É necessário possuir o PostgreSQL instalado e ter acesso ao terminal `psql`.

### Opção 1 — Executar o projeto completo

Crie um banco de dados:

```bash
createdb -U postgres streaming_audio
```

Execute o arquivo completo:

```bash
psql -U postgres -d streaming_audio -f projeto_etapa6_completo.sql
```

### Opção 2 — Executar cada etapa separadamente

```bash
psql -U postgres -d streaming_audio -f g8_sql_corrigido.sql
psql -U postgres -d streaming_audio -f meus_inserts_corrigido.sql
psql -U postgres -d streaming_audio -f consultas_etapa6.sql
```

Em um servidor remoto, substitua o usuário, o host e o nome do banco:

```bash
psql -U seu_usuario -h seu_host -d seu_banco -f projeto_etapa6_completo.sql
```

## Resultados das consultas

<details>
<summary>Clique para visualizar as imagens</summary>

### Consulta 1

![Resultado da consulta 1](etapa6_resultados/consulta_01.png)

### Consulta 2

![Resultado da consulta 2](etapa6_resultados/consulta_02.png)

### Consulta 3

![Resultado da consulta 3](etapa6_resultados/consulta_03.png)

### Consulta 4

![Resultado da consulta 4](etapa6_resultados/consulta_04.png)

### Consulta 5

![Resultado da consulta 5](etapa6_resultados/consulta_05.png)

### Consulta 6

![Resultado da consulta 6](etapa6_resultados/consulta_06.png)

### Consulta 7

![Resultado da consulta 7](etapa6_resultados/consulta_07.png)

### Consulta 8

![Resultado da consulta 8](etapa6_resultados/consulta_08.png)

### Consulta 9

![Resultado da consulta 9](etapa6_resultados/consulta_09.png)

### Consulta 10

![Resultado da consulta 10](etapa6_resultados/consulta_10.png)

</details>

## Observações

Os nomes, e-mails, telefones, senhas e demais informações presentes nos arquivos de inserção são dados fictícios criados exclusivamente para testes acadêmicos.

As senhas de exemplo são armazenadas como texto simples apenas para facilitar a demonstração do banco. Em uma aplicação real, elas devem ser protegidas com algoritmos de hash seguros, como Argon2 ou bcrypt.

## Responsável pelo repositório

**Fonte-Boa Lázaro Torres**

Projeto desenvolvido para fins acadêmicos na área de Banco de Dados.
