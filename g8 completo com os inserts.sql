SET client_encoding = 'UTF8';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table usuario
-- -----------------------------------------------------
DROP TABLE IF EXISTS usuario CASCADE;

CREATE TABLE IF NOT EXISTS usuario (
  id_usuario INTEGER NOT NULL,
  nome VARCHAR(100) NULL,
  data_cadastro DATE NULL,
  email VARCHAR(150) NULL,
  senha VARCHAR(45) NULL,
  e_podcaster BOOLEAN NULL,
  e_ouvinte BOOLEAN NULL,
  e_artista BOOLEAN NULL,
  PRIMARY KEY (id_usuario));


-- -----------------------------------------------------
-- Table podcaster
-- -----------------------------------------------------
DROP TABLE IF EXISTS podcaster CASCADE;

CREATE TABLE IF NOT EXISTS podcaster (
  usuario_id_usuario INTEGER NOT NULL,
  nome_canal VARCHAR(45) NULL,
  PRIMARY KEY (usuario_id_usuario),
  CONSTRAINT fk_podcaster_usuario
    FOREIGN KEY (usuario_id_usuario)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_podcaster_1 ON podcaster (usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table ouvinte
-- -----------------------------------------------------
DROP TABLE IF EXISTS ouvinte CASCADE;

CREATE TABLE IF NOT EXISTS ouvinte (
  usuario_id_usuario INTEGER NOT NULL,
  plano_assinatura VARCHAR(45) NULL,
  PRIMARY KEY (usuario_id_usuario),
  CONSTRAINT fk_podcaster_usuario0
    FOREIGN KEY (usuario_id_usuario)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_ouvinte_1 ON ouvinte (usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table artista
-- -----------------------------------------------------
DROP TABLE IF EXISTS artista CASCADE;

CREATE TABLE IF NOT EXISTS artista (
  usuario_id_usuario INTEGER NOT NULL,
  nome_artistico VARCHAR(45) NULL,
  pais_origem VARCHAR(45) NULL,
  PRIMARY KEY (usuario_id_usuario),
  CONSTRAINT fk_podcaster_usuario00
    FOREIGN KEY (usuario_id_usuario)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_artista_1 ON artista (usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table podcast
-- -----------------------------------------------------
DROP TABLE IF EXISTS podcast CASCADE;

CREATE TABLE IF NOT EXISTS podcast (
  id_podcast INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  descricao TEXT NULL,
  idioma VARCHAR(45) NULL,
  podcaster_usuario_id_usuario INTEGER NOT NULL,
  PRIMARY KEY (id_podcast),
  CONSTRAINT fk_podcast_podcaster1
    FOREIGN KEY (podcaster_usuario_id_usuario)
    REFERENCES podcaster (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_podcast_1 ON podcast (podcaster_usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table genero_podcast
-- -----------------------------------------------------
DROP TABLE IF EXISTS genero_podcast CASCADE;

CREATE TABLE IF NOT EXISTS genero_podcast (
  podcast_id_podast INTEGER NOT NULL,
  genero VARCHAR(45) NOT NULL,
  seq_genero INTEGER NOT NULL,
  PRIMARY KEY (podcast_id_podast, seq_genero),
  CONSTRAINT fk_genero_podcast_podcast1
    FOREIGN KEY (podcast_id_podast)
    REFERENCES podcast (id_podcast)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table episodio
-- -----------------------------------------------------
DROP TABLE IF EXISTS episodio CASCADE;

CREATE TABLE IF NOT EXISTS episodio (
  podcast_id_podast INTEGER NOT NULL,
  nroepisodio INTEGER NOT NULL,
  titulo VARCHAR(45) NULL,
  duracao TIME NULL,
  PRIMARY KEY (nroepisodio, podcast_id_podast),
  CONSTRAINT fk_episodio_podcast1
    FOREIGN KEY (podcast_id_podast)
    REFERENCES podcast (id_podcast)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_episodio_1 ON episodio (podcast_id_podast ASC);


-- -----------------------------------------------------
-- Table registro_royalty_episodio
-- -----------------------------------------------------
DROP TABLE IF EXISTS registro_royalty_episodio CASCADE;

CREATE TABLE IF NOT EXISTS registro_royalty_episodio (
  id_registro INTEGER NOT NULL,
  episodio_nroepisodio INTEGER NOT NULL,
  episodio_podcast_id_podast INTEGER NOT NULL,
  periodo_inicio DATE NULL,
  periodo_fim DATE NULL,
  valor_total DECIMAL(10,2) NULL,
  PRIMARY KEY (id_registro),
  CONSTRAINT fk_registro_royalty_episodio_episodio1
    FOREIGN KEY (episodio_nroepisodio , episodio_podcast_id_podast)
    REFERENCES episodio (nroepisodio , podcast_id_podast)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_registro_royalty_episodio_1 ON registro_royalty_episodio (episodio_nroepisodio ASC, episodio_podcast_id_podast ASC);


-- -----------------------------------------------------
-- Table ouvinte_segue_podcast
-- -----------------------------------------------------
DROP TABLE IF EXISTS ouvinte_segue_podcast CASCADE;

CREATE TABLE IF NOT EXISTS ouvinte_segue_podcast (
  ouvinte_usuario_id_usuario INTEGER NOT NULL,
  podcast_id_podast INTEGER NOT NULL,
  PRIMARY KEY (ouvinte_usuario_id_usuario, podcast_id_podast),
  CONSTRAINT fk_ouvinte_has_podcast_ouvinte1
    FOREIGN KEY (ouvinte_usuario_id_usuario)
    REFERENCES ouvinte (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ouvinte_has_podcast_podcast1
    FOREIGN KEY (podcast_id_podast)
    REFERENCES podcast (id_podcast)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_ouvinte_segue_podcast_1 ON ouvinte_segue_podcast (podcast_id_podast ASC);

CREATE INDEX idx_ouvinte_segue_podcast_2 ON ouvinte_segue_podcast (ouvinte_usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table playlist
-- -----------------------------------------------------
DROP TABLE IF EXISTS playlist CASCADE;

CREATE TABLE IF NOT EXISTS playlist (
  id_playlist INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  descricao TEXT NULL,
  data_criacao DATE NULL,
  ouvinte_usuario_id_usuario INTEGER NOT NULL,
  PRIMARY KEY (id_playlist),
  CONSTRAINT fk_playlist_ouvinte1
    FOREIGN KEY (ouvinte_usuario_id_usuario)
    REFERENCES ouvinte (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_playlist_1 ON playlist (ouvinte_usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table ouvinte_segue_playlist
-- -----------------------------------------------------
DROP TABLE IF EXISTS ouvinte_segue_playlist CASCADE;

CREATE TABLE IF NOT EXISTS ouvinte_segue_playlist (
  ouvinte_usuario_id_usuario INTEGER NOT NULL,
  playlist_id_playlist INTEGER NOT NULL,
  PRIMARY KEY (ouvinte_usuario_id_usuario, playlist_id_playlist),
  CONSTRAINT fk_ouvinte_has_playlist_ouvinte1
    FOREIGN KEY (ouvinte_usuario_id_usuario)
    REFERENCES ouvinte (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ouvinte_has_playlist_playlist1
    FOREIGN KEY (playlist_id_playlist)
    REFERENCES playlist (id_playlist)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_ouvinte_segue_playlist_1 ON ouvinte_segue_playlist (playlist_id_playlist ASC);

CREATE INDEX idx_ouvinte_segue_playlist_2 ON ouvinte_segue_playlist (ouvinte_usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table ouvinte_segue_artista
-- -----------------------------------------------------
DROP TABLE IF EXISTS ouvinte_segue_artista CASCADE;

CREATE TABLE IF NOT EXISTS ouvinte_segue_artista (
  ouvinte_usuario_id_usuario INTEGER NOT NULL,
  artista_usuario_id_usuario INTEGER NOT NULL,
  PRIMARY KEY (ouvinte_usuario_id_usuario, artista_usuario_id_usuario),
  CONSTRAINT fk_ouvinte_has_artista_ouvinte1
    FOREIGN KEY (ouvinte_usuario_id_usuario)
    REFERENCES ouvinte (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ouvinte_has_artista_artista1
    FOREIGN KEY (artista_usuario_id_usuario)
    REFERENCES artista (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_ouvinte_segue_artista_1 ON ouvinte_segue_artista (artista_usuario_id_usuario ASC);

CREATE INDEX idx_ouvinte_segue_artista_2 ON ouvinte_segue_artista (ouvinte_usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table musica
-- -----------------------------------------------------
DROP TABLE IF EXISTS musica CASCADE;

CREATE TABLE IF NOT EXISTS musica (
  id_musica INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  data_lancamento DATE NULL,
  PRIMARY KEY (id_musica));


-- -----------------------------------------------------
-- Table album
-- -----------------------------------------------------
DROP TABLE IF EXISTS album CASCADE;

CREATE TABLE IF NOT EXISTS album (
  id_album INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  data_lancamento DATE NULL,
  PRIMARY KEY (id_album));


-- -----------------------------------------------------
-- Table faixa
-- -----------------------------------------------------
DROP TABLE IF EXISTS faixa CASCADE;

CREATE TABLE IF NOT EXISTS faixa (
  album_id_album INTEGER NOT NULL,
  musica_id_musica INTEGER NOT NULL,
  nro_faixa INTEGER NOT NULL,
  duracao TIME NULL,
  PRIMARY KEY (musica_id_musica, album_id_album),
  CONSTRAINT fk_musica_has_album_musica1
    FOREIGN KEY (musica_id_musica)
    REFERENCES musica (id_musica)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_musica_has_album_album1
    FOREIGN KEY (album_id_album)
    REFERENCES album (id_album)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_faixa_1 ON faixa (album_id_album ASC);

CREATE INDEX idx_faixa_2 ON faixa (musica_id_musica ASC);


-- -----------------------------------------------------
-- Table genero_musica
-- -----------------------------------------------------
DROP TABLE IF EXISTS genero_musica CASCADE;

CREATE TABLE IF NOT EXISTS genero_musica (
  musica_id_musica INTEGER NOT NULL,
  genero VARCHAR(45) NOT NULL,
  seq_genero INTEGER NOT NULL,
  PRIMARY KEY (musica_id_musica, seq_genero),
  CONSTRAINT fk_genero_podcast_copy1_musica1
    FOREIGN KEY (musica_id_musica)
    REFERENCES musica (id_musica)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_genero_musica_1 ON genero_musica (musica_id_musica ASC);


-- -----------------------------------------------------
-- Table playlist_contem_faixa
-- -----------------------------------------------------
DROP TABLE IF EXISTS playlist_contem_faixa CASCADE;

CREATE TABLE IF NOT EXISTS playlist_contem_faixa (
  playlist_id_playlist INTEGER NOT NULL,
  faixa_musica_id_musica INTEGER NOT NULL,
  faixa_album_id_album INTEGER NOT NULL,
  posicao_playlist INTEGER NULL,
  PRIMARY KEY (playlist_id_playlist, faixa_musica_id_musica, faixa_album_id_album),
  CONSTRAINT fk_playlist_has_faixa_playlist1
    FOREIGN KEY (playlist_id_playlist)
    REFERENCES playlist (id_playlist)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_playlist_has_faixa_faixa1
    FOREIGN KEY (faixa_musica_id_musica , faixa_album_id_album)
    REFERENCES faixa (musica_id_musica , album_id_album)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_playlist_contem_faixa_1 ON playlist_contem_faixa (faixa_musica_id_musica ASC, faixa_album_id_album ASC);

CREATE INDEX idx_playlist_contem_faixa_2 ON playlist_contem_faixa (playlist_id_playlist ASC);


-- -----------------------------------------------------
-- Table artista_participa_faixa
-- -----------------------------------------------------
DROP TABLE IF EXISTS artista_participa_faixa CASCADE;

CREATE TABLE IF NOT EXISTS artista_participa_faixa (
  artista_usuario_id_usuario INTEGER NOT NULL,
  faixa_musica_id_musica INTEGER NOT NULL,
  faixa_album_id_album INTEGER NOT NULL,
  PRIMARY KEY (artista_usuario_id_usuario, faixa_musica_id_musica, faixa_album_id_album),
  CONSTRAINT fk_artista_has_faixa_artista1
    FOREIGN KEY (artista_usuario_id_usuario)
    REFERENCES artista (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_artista_has_faixa_faixa1
    FOREIGN KEY (faixa_musica_id_musica , faixa_album_id_album)
    REFERENCES faixa (musica_id_musica , album_id_album)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_artista_participa_faixa_1 ON artista_participa_faixa (faixa_musica_id_musica ASC, faixa_album_id_album ASC);

CREATE INDEX idx_artista_participa_faixa_2 ON artista_participa_faixa (artista_usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table artista_participa_album
-- -----------------------------------------------------
DROP TABLE IF EXISTS artista_participa_album CASCADE;

CREATE TABLE IF NOT EXISTS artista_participa_album (
  artista_usuario_id_usuario INTEGER NOT NULL,
  album_id_album INTEGER NOT NULL,
  PRIMARY KEY (artista_usuario_id_usuario, album_id_album),
  CONSTRAINT fk_artista_has_album_artista1
    FOREIGN KEY (artista_usuario_id_usuario)
    REFERENCES artista (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_artista_has_album_album1
    FOREIGN KEY (album_id_album)
    REFERENCES album (id_album)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_artista_participa_album_1 ON artista_participa_album (album_id_album ASC);

CREATE INDEX idx_artista_participa_album_2 ON artista_participa_album (artista_usuario_id_usuario ASC);


-- -----------------------------------------------------
-- Table registro_royalty_faixa
-- -----------------------------------------------------
DROP TABLE IF EXISTS registro_royalty_faixa CASCADE;

CREATE TABLE IF NOT EXISTS registro_royalty_faixa (
  id_registro INTEGER NOT NULL,
  periodo_inicio DATE NULL,
  periodo_fim DATE NULL,
  valor_total DECIMAL(10,2) NULL,
  faixa_musica_id_musica INTEGER NOT NULL,
  faixa_album_id_album INTEGER NOT NULL,
  PRIMARY KEY (id_registro),
  CONSTRAINT fk_registro_royalty_faixa_faixa1
    FOREIGN KEY (faixa_musica_id_musica , faixa_album_id_album)
    REFERENCES faixa (musica_id_musica , album_id_album)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_registro_royalty_faixa_1 ON registro_royalty_faixa (faixa_musica_id_musica ASC, faixa_album_id_album ASC);


-- -----------------------------------------------------
-- Table tipo_artista
-- -----------------------------------------------------
DROP TABLE IF EXISTS tipo_artista CASCADE;

CREATE TABLE IF NOT EXISTS tipo_artista (
  artista_usuario_id_usuario INTEGER NOT NULL,
  tipo VARCHAR(45) NOT NULL,
  seq_tipo INTEGER NOT NULL,
  PRIMARY KEY (artista_usuario_id_usuario, seq_tipo),
  CONSTRAINT fk_tipo_artista_artista1
    FOREIGN KEY (artista_usuario_id_usuario)
    REFERENCES artista (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table historico
-- -----------------------------------------------------
DROP TABLE IF EXISTS historico CASCADE;

CREATE TABLE IF NOT EXISTS historico (
  ouvinte_usuario_id_usuario INTEGER NOT NULL,
  seq_historico INTEGER NOT NULL,
  tipo VARCHAR(45) NULL,
  data_hora TIMESTAMP NULL,
  PRIMARY KEY (ouvinte_usuario_id_usuario, seq_historico),
  CONSTRAINT fk_historico_ouvinte1
    FOREIGN KEY (ouvinte_usuario_id_usuario)
    REFERENCES ouvinte (usuario_id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table historico_episodio
-- -----------------------------------------------------
DROP TABLE IF EXISTS historico_episodio CASCADE;

CREATE TABLE IF NOT EXISTS historico_episodio (
  historico_ouvinte_usuario_id_usuario INTEGER NOT NULL,
  historico_seq_historico INTEGER NOT NULL,
  episodio_nroepisodio INTEGER NOT NULL,
  episodio_podcast_id_podast INTEGER NOT NULL,
  PRIMARY KEY (historico_ouvinte_usuario_id_usuario, historico_seq_historico),
  CONSTRAINT fk_historico_episodio_historico1
    FOREIGN KEY (historico_ouvinte_usuario_id_usuario , historico_seq_historico)
    REFERENCES historico (ouvinte_usuario_id_usuario , seq_historico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_historico_episodio_episodio1
    FOREIGN KEY (episodio_nroepisodio , episodio_podcast_id_podast)
    REFERENCES episodio (nroepisodio , podcast_id_podast)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_historico_episodio_1 ON historico_episodio (episodio_nroepisodio ASC, episodio_podcast_id_podast ASC);


-- -----------------------------------------------------
-- Table historico_faixa
-- -----------------------------------------------------
DROP TABLE IF EXISTS historico_faixa CASCADE;

CREATE TABLE IF NOT EXISTS historico_faixa (
  historico_ouvinte_usuario_id_usuario INTEGER NOT NULL,
  historico_seq_historico INTEGER NOT NULL,
  faixa_musica_id_musica INTEGER NOT NULL,
  faixa_album_id_album INTEGER NOT NULL,
  PRIMARY KEY (historico_ouvinte_usuario_id_usuario, historico_seq_historico),
  CONSTRAINT fk_historico_episodio_historico10
    FOREIGN KEY (historico_ouvinte_usuario_id_usuario , historico_seq_historico)
    REFERENCES historico (ouvinte_usuario_id_usuario , seq_historico)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_historico_faixa_faixa1
    FOREIGN KEY (faixa_musica_id_musica , faixa_album_id_album)
    REFERENCES faixa (musica_id_musica , album_id_album)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX idx_historico_faixa_1 ON historico_faixa (faixa_musica_id_musica ASC, faixa_album_id_album ASC);


-- -----------------------------------------------------
-- Table fones_usuario
-- -----------------------------------------------------
DROP TABLE IF EXISTS fones_usuario CASCADE;

CREATE TABLE IF NOT EXISTS fones_usuario (
  usuario_id_usuario INTEGER NOT NULL,
  fone VARCHAR(20) NOT NULL,
  seq_fone INTEGER NOT NULL,
  PRIMARY KEY (usuario_id_usuario, seq_fone),
  CONSTRAINT fk_fones_usuario_usuario1
    FOREIGN KEY (usuario_id_usuario)
    REFERENCES usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

DROP SEQUENCE IF EXISTS seq_usuario CASCADE;
DROP SEQUENCE IF EXISTS seq_podcast CASCADE;
DROP SEQUENCE IF EXISTS seq_playlist CASCADE;
DROP SEQUENCE IF EXISTS seq_musica CASCADE;
DROP SEQUENCE IF EXISTS seq_album CASCADE;
DROP SEQUENCE IF EXISTS seq_registro_royalty_episodio CASCADE;
DROP SEQUENCE IF EXISTS seq_registro_royalty_faixa CASCADE;

CREATE SEQUENCE seq_usuario START 1 INCREMENT 1;
CREATE SEQUENCE seq_podcast START 1 INCREMENT 1;
CREATE SEQUENCE seq_playlist START 1 INCREMENT 1;
CREATE SEQUENCE seq_musica START 1 INCREMENT 1;
CREATE SEQUENCE seq_album START 1 INCREMENT 1;
CREATE SEQUENCE seq_registro_royalty_episodio START 1 INCREMENT 1;
CREATE SEQUENCE seq_registro_royalty_faixa START 1 INCREMENT 1;

-- usuarios que são podcaster
INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Ana Castro', '2026-06-01', 'ana.castro@gmail.com', 'senha123', TRUE, FALSE, FALSE);

INSERT INTO podcaster (usuario_id_usuario, nome_canal)
VALUES (currval('seq_usuario'), 'Ana Tech');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Bruno Lima', '2026-06-02', 'bruno.lima@gmail.com', 'senha123', TRUE, FALSE, FALSE);

INSERT INTO podcaster (usuario_id_usuario, nome_canal)
VALUES (currval('seq_usuario'), 'Bruno, o Historiador');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Carla Mendes', '2026-06-03', 'carla.mendes@gmail.com', 'senha123', TRUE, FALSE, FALSE);

INSERT INTO podcaster (usuario_id_usuario, nome_canal)
VALUES (currval('seq_usuario'), 'Carla Fitness');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Diego Ramos', '2026-06-04', 'diego.ramos@gmail.com', 'senha123', TRUE, FALSE, FALSE);

INSERT INTO podcaster (usuario_id_usuario, nome_canal)
VALUES (currval('seq_usuario'), 'Diego Cinefilo');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Elisa Rocha', '2026-06-05', 'elisa.rocha@gmail.com', 'senha123', TRUE, FALSE, FALSE);

INSERT INTO podcaster (usuario_id_usuario, nome_canal)
VALUES (currval('seq_usuario'), 'Elisa Empreendedora');

-- usuarios que são ouvintes
INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Fernanda Alves', '2026-06-06', 'fernanda.alves@gmail.com', 'senha123', FALSE, TRUE, FALSE);

INSERT INTO ouvinte (usuario_id_usuario, plano_assinatura)
VALUES (currval('seq_usuario'), 'Premium');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Gustavo Pereira', '2026-06-07', 'gustavo.pereira@gmail.com', 'senha123', FALSE, TRUE, FALSE);

INSERT INTO ouvinte (usuario_id_usuario, plano_assinatura)
VALUES (currval('seq_usuario'), 'Gratis');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Helena Souza', '2026-06-08', 'helena.souza@gmail.com', 'senha123', FALSE, TRUE, FALSE);

INSERT INTO ouvinte (usuario_id_usuario, plano_assinatura)
VALUES (currval('seq_usuario'), 'Familia');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Igor Martins', '2026-06-09', 'igor.martins@gmail.com', 'senha123', FALSE, TRUE, FALSE);

INSERT INTO ouvinte (usuario_id_usuario, plano_assinatura)
VALUES (currval('seq_usuario'), 'Premium');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Juliana Nunes', '2026-06-10', 'juliana.nunes@gmail.com', 'senha123', FALSE, TRUE, FALSE);

INSERT INTO ouvinte (usuario_id_usuario, plano_assinatura)
VALUES (currval('seq_usuario'), 'Estudante');

-- usuarios que são artistas
INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Kaique Santos', '2026-06-11', 'kaique.santos@gmail.com', 'senha123', FALSE, FALSE, TRUE);

INSERT INTO artista(usuario_id_usuario, nome_artistico, pais_origem)
VALUES (currval('seq_usuario'), 'K Santos', 'Brasil');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Laura Costa', '2026-06-12', 'laura.costa@gmail.com', 'senha123', FALSE, FALSE, TRUE);

INSERT INTO artista(usuario_id_usuario, nome_artistico, pais_origem)
VALUES (currval('seq_usuario'), 'Laura C', 'Brasil');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Marcos Vieira', '2026-06-13', 'marcos.vieira@gmail.com', 'senha123', FALSE, FALSE, TRUE);

INSERT INTO artista(usuario_id_usuario, nome_artistico, pais_origem)
VALUES (currval('seq_usuario'), 'MV Beats', 'Portugal');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Nina Barbosa', '2026-06-14', 'nina.barbosa@gmail.com', 'senha123', FALSE, FALSE, TRUE);

INSERT INTO artista(usuario_id_usuario, nome_artistico, pais_origem)
VALUES (currval('seq_usuario'), 'Nina B', 'Argentina');

INSERT INTO usuario (id_usuario, nome, data_cadastro, email, senha, e_podcaster, e_ouvinte, e_artista)
VALUES (nextval('seq_usuario'), 'Otavio Freitas', '2026-06-15', 'otavio.freitas@gmail.com', 'senha123', FALSE, FALSE, TRUE);

INSERT INTO artista(usuario_id_usuario, nome_artistico, pais_origem)
VALUES (currval('seq_usuario'), 'DJ Ota', 'Brasil');


-- Telefone dos usuários que tem cadastro de Telefone
INSERT INTO fones_usuario(usuario_id_usuario, fone, seq_fone)
VALUES (1, '1191111-0001', 1);

INSERT INTO fones_usuario(usuario_id_usuario, fone, seq_fone)
VALUES (2, '1192222-0002', 1);

INSERT INTO fones_usuario(usuario_id_usuario, fone, seq_fone)
VALUES (6, '1193333-0003', 1);

INSERT INTO fones_usuario(usuario_id_usuario, fone, seq_fone)
VALUES (11, '1194444-0004', 1);

INSERT INTO fones_usuario(usuario_id_usuario, fone, seq_fone)
VALUES (12, '1195555-0005', 1);


-- Podcasts
INSERT INTO podcast(id_podcast, nome, descricao, idioma, podcaster_usuario_id_usuario)
VALUES (nextval('seq_podcast'), 'Tech em Foco', 'Podcast sobre tecnologia e inovacao', 'Portugues', 1);

INSERT INTO podcast(id_podcast, nome, descricao, idioma, podcaster_usuario_id_usuario)
VALUES (nextval('seq_podcast'), 'Historia Cast', 'Conversas sobre fatos historicos', 'Portugues', 2);

INSERT INTO podcast(id_podcast, nome, descricao, idioma, podcaster_usuario_id_usuario)
VALUES (nextval('seq_podcast'), 'Saude na Rotina', 'Dicas de saude e bem-estar', 'Portugues', 3);

INSERT INTO podcast(id_podcast, nome, descricao, idioma, podcaster_usuario_id_usuario)
VALUES (nextval('seq_podcast'), 'Cinema Sem Spoiler', 'Analises de filmes e series', 'Portugues', 4);

INSERT INTO podcast(id_podcast, nome, descricao, idioma, podcaster_usuario_id_usuario)
VALUES (nextval('seq_podcast'), 'Negocios Online', 'Empreendedorismo e vendas digitais', 'Portugues', 5);


-- Gênero do podcast
INSERT INTO genero_podcast(podcast_id_podast, genero, seq_genero)
VALUES (1, 'Tecnologia', 1);

INSERT INTO genero_podcast(podcast_id_podast, genero, seq_genero)
VALUES (2, 'Historia', 1);

INSERT INTO genero_podcast(podcast_id_podast, genero, seq_genero)
VALUES (3, 'Saude', 1);

INSERT INTO genero_podcast(podcast_id_podast, genero, seq_genero)
VALUES (4, 'Cinema', 1);

INSERT INTO genero_podcast(podcast_id_podast, genero, seq_genero)
VALUES (5, 'Negocios', 1);

-- Episódios dos Podcasts
INSERT INTO episodio(podcast_id_podast, nroEpisodio, titulo, duracao)
VALUES (1,1,'Inteligencia Artificial','00:42:00');

INSERT INTO episodio(podcast_id_podast, nroEpisodio, titulo, duracao)
VALUES (2,1,'Brasil colonial','00:38:30');

INSERT INTO episodio(podcast_id_podast, nroEpisodio, titulo, duracao)
VALUES (3,1,'Sono e produtividade','00:35:15');

INSERT INTO episodio(podcast_id_podast, nroEpisodio, titulo, duracao)
VALUES (4,1,'Classicos dos anos 90','00:50:10');

INSERT INTO episodio(podcast_id_podast, nroEpisodio, titulo, duracao)
VALUES (5,1,'Como vender melhor','00:44:45');


-- Registro de Royalty dos Episódios
INSERT INTO registro_royalty_episodio(id_registro, episodio_nroepisodio, episodio_podcast_id_podast, periodo_inicio, periodo_fim, valor_total)
VALUES (nextval('seq_registro_royalty_episodio'), 1, 1, '2026-06-01', '2026-06-30', 120.5);

INSERT INTO registro_royalty_episodio(id_registro, episodio_nroepisodio, episodio_podcast_id_podast, periodo_inicio, periodo_fim, valor_total)
VALUES (nextval('seq_registro_royalty_episodio'), 1, 2, '2026-06-01', '2026-06-30', 98.75);

INSERT INTO registro_royalty_episodio(id_registro, episodio_nroepisodio, episodio_podcast_id_podast, periodo_inicio, periodo_fim, valor_total)
VALUES (nextval('seq_registro_royalty_episodio'), 1, 3, '2026-06-01', '2026-06-30', 87.4);

INSERT INTO registro_royalty_episodio(id_registro, episodio_nroepisodio, episodio_podcast_id_podast, periodo_inicio, periodo_fim, valor_total)
VALUES (nextval('seq_registro_royalty_episodio'), 1, 4, '2026-06-01', '2026-06-30', 140);

INSERT INTO registro_royalty_episodio(id_registro, episodio_nroepisodio, episodio_podcast_id_podast, periodo_inicio, periodo_fim, valor_total)
VALUES (nextval('seq_registro_royalty_episodio'), 1, 5, '2026-06-01', '2026-06-30', 165.9);


-- Ouvinte segue Podcast
INSERT INTO ouvinte_segue_podcast(ouvinte_usuario_id_usuario, podcast_id_podast)
VALUES (6,1);

INSERT INTO ouvinte_segue_podcast(ouvinte_usuario_id_usuario, podcast_id_podast)
VALUES (7,2);

INSERT INTO ouvinte_segue_podcast(ouvinte_usuario_id_usuario, podcast_id_podast)
VALUES (8,3);

INSERT INTO ouvinte_segue_podcast(ouvinte_usuario_id_usuario, podcast_id_podast)
VALUES (9,4);

INSERT INTO ouvinte_segue_podcast(ouvinte_usuario_id_usuario, podcast_id_podast)
VALUES (10,5);


-- Playlist
INSERT INTO playlist(id_playlist, nome, descricao, data_criacao, ouvinte_usuario_id_usuario)
VALUES (nextval('seq_playlist'), 'Rotina de Estudos', 'Conteudos para estudar', '2026-06-16', 6); 

INSERT INTO playlist(id_playlist, nome, descricao, data_criacao, ouvinte_usuario_id_usuario)
VALUES (nextval('seq_playlist'), 'Corrida da Manha', 'Musicas para treinar', '2026-06-17', 7); 

INSERT INTO playlist(id_playlist, nome, descricao, data_criacao, ouvinte_usuario_id_usuario)
VALUES (nextval('seq_playlist'), 'Relaxar a Noite', 'Audios para descansar', '2026-06-18', 8); 

INSERT INTO playlist(id_playlist, nome, descricao, data_criacao, ouvinte_usuario_id_usuario)
VALUES (nextval('seq_playlist'), 'Favoritas Pop', 'Faixas pop preferidas', '2026-06-19', 9); 

INSERT INTO playlist(id_playlist, nome, descricao, data_criacao, ouvinte_usuario_id_usuario)
VALUES (nextval('seq_playlist'), 'Podcasts da Semana', 'Episodios para ouvir depois', '2026-06-20', 10); 


-- Ouvinte segue Playlist
INSERT INTO ouvinte_segue_playlist(ouvinte_usuario_id_usuario, playlist_id_playlist)
VALUES (6, 5);

INSERT INTO ouvinte_segue_playlist(ouvinte_usuario_id_usuario, playlist_id_playlist)
VALUES (7, 1);

INSERT INTO ouvinte_segue_playlist(ouvinte_usuario_id_usuario, playlist_id_playlist)
VALUES (8, 2);

INSERT INTO ouvinte_segue_playlist(ouvinte_usuario_id_usuario, playlist_id_playlist)
VALUES (9, 3);

INSERT INTO ouvinte_segue_playlist(ouvinte_usuario_id_usuario, playlist_id_playlist)
VALUES (10, 4);

-- Ouvinte segue Artista
INSERT INTO ouvinte_segue_artista(ouvinte_usuario_id_usuario, artista_usuario_id_usuario)
VALUES (6, 11);

INSERT INTO ouvinte_segue_artista(ouvinte_usuario_id_usuario, artista_usuario_id_usuario)
VALUES (7, 12);

INSERT INTO ouvinte_segue_artista(ouvinte_usuario_id_usuario, artista_usuario_id_usuario)
VALUES (8, 13);

INSERT INTO ouvinte_segue_artista(ouvinte_usuario_id_usuario, artista_usuario_id_usuario)
VALUES (9, 14);

INSERT INTO ouvinte_segue_artista(ouvinte_usuario_id_usuario, artista_usuario_id_usuario)
VALUES (10, 15);


-- Música
INSERT INTO musica(id_musica, nome, data_lancamento)
VALUES (nextval('seq_musica'), 'Sol de Janeiro', '2026-01-10');

INSERT INTO musica(id_musica, nome, data_lancamento)
VALUES (nextval('seq_musica'), 'Noite Azul', '2026-02-12');

INSERT INTO musica(id_musica, nome, data_lancamento)
VALUES (nextval('seq_musica'), 'Batida Livre', '2026-03-05');

INSERT INTO musica(id_musica, nome, data_lancamento)
VALUES (nextval('seq_musica'), 'Chuva Leve', '2026-04-08');

INSERT INTO musica(id_musica, nome, data_lancamento)
VALUES (nextval('seq_musica'), 'Estrada Norte', '2026-05-01');


-- Álbum
INSERT INTO album(id_album, nome, data_lancamento)
VALUES (nextval('seq_album'), 'Verano Beats', '2026-01-20');

INSERT INTO album(id_album, nome, data_lancamento)
VALUES (nextval('seq_album'), 'Luzes da Cidade', '2026-02-25');

INSERT INTO album(id_album, nome, data_lancamento)
VALUES (nextval('seq_album'), 'Pulso Urbano', '2026-03-15');

INSERT INTO album(id_album, nome, data_lancamento)
VALUES (nextval('seq_album'), 'Acustico Casa', '2026-04-18');

INSERT INTO album(id_album, nome, data_lancamento)
VALUES (nextval('seq_album'), 'Viagem Sonora', '2026-05-12');


-- Faixa
INSERT INTO faixa(album_id_album, musica_id_musica, nro_faixa, duracao)
VALUES (1,1,1,'00:03:32');

INSERT INTO faixa(album_id_album, musica_id_musica, nro_faixa, duracao)
VALUES (2,2,1,'00:04:05');

INSERT INTO faixa(album_id_album, musica_id_musica, nro_faixa, duracao)
VALUES (3,3,1,'00:02:58');

INSERT INTO faixa(album_id_album, musica_id_musica, nro_faixa, duracao)
VALUES (4,4,1,'00:03:47');

INSERT INTO faixa(album_id_album, musica_id_musica, nro_faixa, duracao)
VALUES (5,5,1,'00:03:20');


-- Gênero da Música
INSERT INTO genero_musica(musica_id_musica, genero, seq_genero)
VALUES (1, 'Pop', 1);

INSERT INTO genero_musica(musica_id_musica, genero, seq_genero)
VALUES (2, 'MPB', 1);

INSERT INTO genero_musica(musica_id_musica, genero, seq_genero)
VALUES (3, 'Eletronica', 1);

INSERT INTO genero_musica(musica_id_musica, genero, seq_genero)
VALUES (4, 'Acustico', 1);

INSERT INTO genero_musica(musica_id_musica, genero, seq_genero)
VALUES (5, 'Rock', 1);


-- Playlist contém faixa
INSERT INTO playlist_contem_faixa(playlist_id_playlist, faixa_musica_id_musica, faixa_album_id_album, posicao_playlist)
VALUES (1,1,1,1);

INSERT INTO playlist_contem_faixa(playlist_id_playlist, faixa_musica_id_musica, faixa_album_id_album, posicao_playlist)
VALUES (2,2,2,1);

INSERT INTO playlist_contem_faixa(playlist_id_playlist, faixa_musica_id_musica, faixa_album_id_album, posicao_playlist)
VALUES (3,3,3,1);

INSERT INTO playlist_contem_faixa(playlist_id_playlist, faixa_musica_id_musica, faixa_album_id_album, posicao_playlist)
VALUES (4,4,4,1);

INSERT INTO playlist_contem_faixa(playlist_id_playlist, faixa_musica_id_musica, faixa_album_id_album, posicao_playlist)
VALUES (5,5,5,1);


-- Artista participa de Faixa
INSERT INTO artista_participa_faixa(artista_usuario_id_usuario, faixa_musica_id_musica, faixa_album_id_album)
VALUES (11,1,1);

INSERT INTO artista_participa_faixa(artista_usuario_id_usuario, faixa_musica_id_musica, faixa_album_id_album)
VALUES (12,2,2);

INSERT INTO artista_participa_faixa(artista_usuario_id_usuario, faixa_musica_id_musica, faixa_album_id_album)
VALUES (13,3,3);

INSERT INTO artista_participa_faixa(artista_usuario_id_usuario, faixa_musica_id_musica, faixa_album_id_album)
VALUES (14,4,4);

INSERT INTO artista_participa_faixa(artista_usuario_id_usuario, faixa_musica_id_musica, faixa_album_id_album)
VALUES (15,5,5);


-- Artista participa de Álbum
INSERT INTO artista_participa_album(artista_usuario_id_usuario, album_id_album)
VALUES (11,1);

INSERT INTO artista_participa_album(artista_usuario_id_usuario, album_id_album)
VALUES (12,2);

INSERT INTO artista_participa_album(artista_usuario_id_usuario, album_id_album)
VALUES (13,3);

INSERT INTO artista_participa_album(artista_usuario_id_usuario, album_id_album)
VALUES (14,4);

INSERT INTO artista_participa_album(artista_usuario_id_usuario, album_id_album)
VALUES (15,5);


-- Registro de Royalty das Faixas
INSERT INTO registro_royalty_faixa(id_registro, periodo_inicio, periodo_fim, valor_total, faixa_musica_id_musica, faixa_album_id_album)
VALUES (nextval('seq_registro_royalty_faixa'), '2026-06-01', '2026-06-30', 75.5, 1, 1);

INSERT INTO registro_royalty_faixa(id_registro, periodo_inicio, periodo_fim, valor_total, faixa_musica_id_musica, faixa_album_id_album)
VALUES (nextval('seq_registro_royalty_faixa'), '2026-06-01', '2026-06-30', 63.9, 2, 2);

INSERT INTO registro_royalty_faixa(id_registro, periodo_inicio, periodo_fim, valor_total, faixa_musica_id_musica, faixa_album_id_album)
VALUES (nextval('seq_registro_royalty_faixa'), '2026-06-01', '2026-06-30', 110, 3, 3);

INSERT INTO registro_royalty_faixa(id_registro, periodo_inicio, periodo_fim, valor_total, faixa_musica_id_musica, faixa_album_id_album)
VALUES (nextval('seq_registro_royalty_faixa'), '2026-06-01', '2026-06-30', 58.25, 4, 4);

INSERT INTO registro_royalty_faixa(id_registro, periodo_inicio, periodo_fim, valor_total, faixa_musica_id_musica, faixa_album_id_album)
VALUES (nextval('seq_registro_royalty_faixa'), '2026-06-01', '2026-06-30', 92.8, 5, 5);


-- Tipo artista
INSERT INTO tipo_artista(artista_usuario_id_usuario, tipo, seq_tipo)
VALUES (11,'Cantor',1);

INSERT INTO tipo_artista(artista_usuario_id_usuario, tipo, seq_tipo)
VALUES (12,'Compositor',1);

INSERT INTO tipo_artista(artista_usuario_id_usuario, tipo, seq_tipo)
VALUES (13,'Produtor',1);

INSERT INTO tipo_artista(artista_usuario_id_usuario, tipo, seq_tipo)
VALUES (14,'Vocalista',1);

INSERT INTO tipo_artista(artista_usuario_id_usuario, tipo, seq_tipo)
VALUES (15,'DJ',1);


-- Histórico dos ouvintes
INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (6, 1, 'episodio','2026-06-21 09:10:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (6, 2, 'faixa','2026-06-21 09:55:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (7, 1, 'episodio','2026-06-22 10:15:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (7, 2, 'faixa','2026-06-22 10:50:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (8, 1, 'episodio','2026-06-23 11:20:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (8, 2, 'faixa','2026-06-23 12:05:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (9, 1, 'episodio','2026-06-24 13:30:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (9, 2, 'faixa','2026-06-24 14:10:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (10, 1, 'episodio','2026-06-25 15:00:00');

INSERT INTO historico(ouvinte_usuario_id_usuario, seq_historico, tipo, data_hora)
VALUES (10, 2, 'faixa','2026-06-25 15:40:00');


-- Histórico de Episódios
INSERT INTO historico_episodio(historico_ouvinte_usuario_id_usuario,historico_seq_historico, episodio_nroepisodio, episodio_podcast_id_podast)
VALUES(6,1,1,1);

INSERT INTO historico_episodio(historico_ouvinte_usuario_id_usuario,historico_seq_historico, episodio_nroepisodio, episodio_podcast_id_podast)
VALUES(7,1,1,2);

INSERT INTO historico_episodio(historico_ouvinte_usuario_id_usuario,historico_seq_historico, episodio_nroepisodio, episodio_podcast_id_podast)
VALUES(8,1,1,3);

INSERT INTO historico_episodio(historico_ouvinte_usuario_id_usuario,historico_seq_historico, episodio_nroepisodio, episodio_podcast_id_podast)
VALUES(9,1,1,4);

INSERT INTO historico_episodio(historico_ouvinte_usuario_id_usuario,historico_seq_historico, episodio_nroepisodio, episodio_podcast_id_podast)
VALUES(10,1,1,5);


-- Histórico de Faixas
INSERT INTO historico_faixa(historico_ouvinte_usuario_id_usuario, historico_seq_historico, faixa_musica_id_musica, faixa_album_id_album)
VALUES (6,2,1,1);

INSERT INTO historico_faixa(historico_ouvinte_usuario_id_usuario, historico_seq_historico, faixa_musica_id_musica, faixa_album_id_album)
VALUES (7,2,2,2);

INSERT INTO historico_faixa(historico_ouvinte_usuario_id_usuario, historico_seq_historico, faixa_musica_id_musica, faixa_album_id_album)
VALUES (8,2,3,3);

INSERT INTO historico_faixa(historico_ouvinte_usuario_id_usuario, historico_seq_historico, faixa_musica_id_musica, faixa_album_id_album)
VALUES (9,2,4,4);

INSERT INTO historico_faixa(historico_ouvinte_usuario_id_usuario, historico_seq_historico, faixa_musica_id_musica, faixa_album_id_album)
VALUES (10,2,5,5);

-- =============================================================
-- PROJETO - ETAPA 6: CONSULTAS E RELATORIOS
-- Banco de dados: plataforma de streaming de audio
-- Execute este arquivo depois de g8_sql.sql e meus_inserts.sql.
-- =============================================================

-- -------------------------------------------------------------
-- CONSULTA 1 - CONSULTA SIMPLES
-- Usuários cadastrados a partir de 10/06/2026
-- Descricao: Lista os usuários que se cadastraram a partir de 10 de junho de 2026, mostrando identificador, nome, e-mail e data de cadastro.
-- -------------------------------------------------------------
SELECT id_usuario,
       nome,
       email,
       data_cadastro
FROM usuario
WHERE data_cadastro >= DATE '2026-06-10'
ORDER BY data_cadastro;

-- -------------------------------------------------------------
-- CONSULTA 2 - CONSULTA SIMPLES
-- Artistas com origem no Brasil
-- Descricao: Consulta diretamente a tabela de artistas e exibe somente os artistas cujo país de origem é o Brasil.
-- -------------------------------------------------------------
SELECT usuario_id_usuario AS id_artista,
       nome_artistico,
       pais_origem
FROM artista
WHERE pais_origem = 'Brasil'
ORDER BY nome_artistico;

-- -------------------------------------------------------------
-- CONSULTA 3 - CONSULTA COM JUNÇÃO
-- Podcasts e seus respectivos podcasters
-- Descricao: Relaciona as tabelas podcast, podcaster e usuario para apresentar o nome de cada podcast, o canal responsável e o nome civil do podcaster.
-- -------------------------------------------------------------
SELECT p.id_podcast,
       p.nome AS podcast,
       po.nome_canal,
       u.nome AS podcaster
FROM podcast AS p
JOIN podcaster AS po
  ON po.usuario_id_usuario = p.podcaster_usuario_id_usuario
JOIN usuario AS u
  ON u.id_usuario = po.usuario_id_usuario
ORDER BY p.id_podcast;

-- -------------------------------------------------------------
-- CONSULTA 4 - CONSULTA COM JUNÇÃO
-- Faixas com música, álbum e artista participante
-- Descricao: Combina as tabelas faixa, musica, album, artista_participa_faixa e artista para mostrar os dados completos de cada faixa cadastrada.
-- -------------------------------------------------------------
SELECT m.nome AS musica,
       a.nome AS album,
       ar.nome_artistico AS artista,
       f.nro_faixa,
       f.duracao
FROM faixa AS f
JOIN musica AS m
  ON m.id_musica = f.musica_id_musica
JOIN album AS a
  ON a.id_album = f.album_id_album
JOIN artista_participa_faixa AS apf
  ON apf.faixa_musica_id_musica = f.musica_id_musica
 AND apf.faixa_album_id_album = f.album_id_album
JOIN artista AS ar
  ON ar.usuario_id_usuario = apf.artista_usuario_id_usuario
ORDER BY a.id_album, f.nro_faixa;

-- -------------------------------------------------------------
-- CONSULTA 5 - CONSULTA COM JUNÇÃO
-- Histórico de episódios reproduzidos pelos ouvintes
-- Descricao: Relaciona o histórico de reprodução aos usuários, episódios e podcasts, permitindo identificar quem ouviu cada episódio e em qual data e horário.
-- -------------------------------------------------------------
SELECT u.nome AS ouvinte,
       p.nome AS podcast,
       e.titulo AS episodio,
       h.data_hora
FROM historico AS h
JOIN usuario AS u
  ON u.id_usuario = h.ouvinte_usuario_id_usuario
JOIN historico_episodio AS he
  ON he.historico_ouvinte_usuario_id_usuario = h.ouvinte_usuario_id_usuario
 AND he.historico_seq_historico = h.seq_historico
JOIN episodio AS e
  ON e.nroepisodio = he.episodio_nroepisodio
 AND e.podcast_id_podast = he.episodio_podcast_id_podast
JOIN podcast AS p
  ON p.id_podcast = e.podcast_id_podast
ORDER BY h.data_hora;

-- -------------------------------------------------------------
-- CONSULTA 6 - CONSULTA COM FUNÇÃO EXTREMA
-- Maior valor de royalty registrado para episódio
-- Descricao: Utiliza a função MAX para localizar o maior valor de royalty entre todos os registros de episódios.
-- -------------------------------------------------------------
SELECT MAX(valor_total) AS maior_royalty_episodio
FROM registro_royalty_episodio;

-- -------------------------------------------------------------
-- CONSULTA 7 - CONSULTA COM AGRUPAMENTO
-- Quantidade de ouvintes por plano de assinatura
-- Descricao: Agrupa os ouvintes pelo plano de assinatura e conta quantos usuários existem em cada modalidade.
-- -------------------------------------------------------------
SELECT plano_assinatura,
       COUNT(*) AS quantidade_ouvintes
FROM ouvinte
GROUP BY plano_assinatura
ORDER BY quantidade_ouvintes DESC, plano_assinatura;

-- -------------------------------------------------------------
-- CONSULTA 8 - CONSULTA COM AGRUPAMENTO
-- Quantidade de reproduções por tipo de conteúdo
-- Descricao: Agrupa o histórico pelo tipo de conteúdo reproduzido e apresenta quantas reproduções são de faixas e quantas são de episódios.
-- -------------------------------------------------------------
SELECT tipo,
       COUNT(*) AS total_reproducoes
FROM historico
GROUP BY tipo
ORDER BY total_reproducoes DESC, tipo;

-- -------------------------------------------------------------
-- CONSULTA 9 - CONSULTA COM AGRUPAMENTO
-- Total de royalties de faixas por artista
-- Descricao: Agrupa os registros por artista e soma os royalties das faixas em que cada artista participa, produzindo um total financeiro individual.
-- -------------------------------------------------------------
SELECT ar.nome_artistico,
       SUM(rrf.valor_total) AS total_royalties
FROM artista AS ar
JOIN artista_participa_faixa AS apf
  ON apf.artista_usuario_id_usuario = ar.usuario_id_usuario
JOIN registro_royalty_faixa AS rrf
  ON rrf.faixa_musica_id_musica = apf.faixa_musica_id_musica
 AND rrf.faixa_album_id_album = apf.faixa_album_id_album
GROUP BY ar.usuario_id_usuario, ar.nome_artistico
ORDER BY total_royalties DESC;

-- -------------------------------------------------------------
-- CONSULTA 10 - CONSULTA COM SUBCONSULTA
-- Episódios com royalty acima da média
-- Descricao: A subconsulta calcula a média dos royalties de episódios. A consulta principal retorna apenas os episódios cujo valor é superior a essa média.
-- -------------------------------------------------------------
SELECT p.nome AS podcast,
       e.titulo AS episodio,
       rre.valor_total
FROM registro_royalty_episodio AS rre
JOIN episodio AS e
  ON e.nroepisodio = rre.episodio_nroepisodio
 AND e.podcast_id_podast = rre.episodio_podcast_id_podast
JOIN podcast AS p
  ON p.id_podcast = e.podcast_id_podast
WHERE rre.valor_total > (
    SELECT AVG(valor_total)
    FROM registro_royalty_episodio
)
ORDER BY rre.valor_total DESC;

