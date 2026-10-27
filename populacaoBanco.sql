-- =====================================================================
-- Carga de teste — 29º Troféu Alexandre Pussieldi 2025 (Sergipe / FASE)
-- PostgreSQL
--
-- Categorias conforme o enunciado: Pré-Mirim (até 9 anos) e Mirim (10–11).
-- Idade calculada pelo ANO de nascimento: idade = 2025 - ano de nascimento
--   Pré-Mirim: nascidos em 2016 e 2017 (8 e 9 anos)
--   Mirim:     nascidos em 2014 e 2015 (10 e 11 anos)
--
-- Competição em 2 dias e 4 etapas. Provas de 25 m (Pré-Mirim) e 50 m (Mirim)
-- nos quatro estilos, separadas por sexo.
-- Pontuação por prova: 1º=9, 2º=7, 3º=6, 4º=5, 5º=4, 6º=3, 7º=2, 8º=1.
-- Situações: 'Confirmado', 'Desclassificado' (sem colocação/pontos)
--            e 'Não Compareceu' (sem tempo).
--
-- Clubes de Sergipe; atletas, tempos e datas são FICTÍCIOS (dados de teste).
-- IDs explícitos; no final as sequências SERIAL são ajustadas.
-- =====================================================================

BEGIN;

-- ---------------------------------------------------------------------
-- CLUBE
-- ---------------------------------------------------------------------
INSERT INTO CLUBE (id_clube, nome, sigla, cidade, estado) VALUES
(1, 'Iate Clube de Aracaju', 'ICA', 'Aracaju', 'SE'),
(2, 'Clube dos Empregados da Petrobras', 'CEPE', 'Aracaju', 'SE'),
(3, 'Associação Desportiva Itabaiana', 'ADI', 'Itabaiana', 'SE'),
(4, 'Lagarto Esporte Clube Aquático', 'LECA', 'Lagarto', 'SE'),
(5, 'Associação Aquática de Nossa Senhora do Socorro', 'AANSS', 'Nossa Senhora do Socorro', 'SE'),
(6, 'Estância Natação Clube', 'ENC', 'Estância', 'SE');

-- ---------------------------------------------------------------------
-- CATEGORIA (idade = ano da competição - ano de nascimento)
-- ---------------------------------------------------------------------
INSERT INTO CATEGORIA (id_categoria, nome, idade_minima, idade_maxima) VALUES
(1, 'Pré-Mirim', 0, 9),   -- até 9 anos (sem idade mínima)
(2, 'Mirim',    10, 11);

-- ---------------------------------------------------------------------
-- ETAPA (2 dias, 4 etapas)
-- ---------------------------------------------------------------------
INSERT INTO ETAPA (id_etapa, numero_etapa, nome, data_etapa, horario_inicio) VALUES
(1, 1, '1ª Etapa - Sexta (manhã)', '2025-03-28', '08:00'),
(2, 2, '2ª Etapa - Sexta (tarde)', '2025-03-28', '15:00'),
(3, 3, '3ª Etapa - Sábado (manhã)', '2025-03-29', '08:00'),
(4, 4, '4ª Etapa - Sábado (tarde)', '2025-03-29', '15:00');

-- ---------------------------------------------------------------------
-- ATLETA
-- ---------------------------------------------------------------------
INSERT INTO ATLETA (id_atleta, nome, data_nascimento, sexo, id_clube) VALUES
-- Pré-Mirim Feminino
(1, 'Rebeca Oliveira Prado', '2016-08-21', 'F', 1),
(2, 'Helena Teles Menezes', '2017-08-11', 'F', 2),
(3, 'Yasmin Melo Leite', '2016-12-07', 'F', 3),
(4, 'Giovanna Barreto Carvalho', '2017-07-26', 'F', 4),
(5, 'Luana Rocha Cardoso', '2016-04-18', 'F', 5),
(6, 'Manuela Dantas Sobral', '2017-09-25', 'F', 6),
(7, 'Cecília Leite Nascimento', '2016-09-05', 'F', 1),
(8, 'Lívia Dantas Rocha', '2017-12-21', 'F', 2),
(9, 'Melissa Machado Prado', '2016-12-12', 'F', 3),
(10, 'Maria Clara Sobral Fontes', '2017-12-11', 'F', 4),
-- Pré-Mirim Masculino
(11, 'Vicente Resende Andrade', '2016-11-09', 'M', 5),
(12, 'Murilo Santos Franco', '2017-07-18', 'M', 6),
(13, 'Theo Fontes Dantas', '2016-01-28', 'M', 1),
(14, 'Otávio Oliveira Dantas', '2017-02-01', 'M', 2),
(15, 'Joaquim Cardoso Oliveira', '2016-01-17', 'M', 3),
(16, 'Miguel Fontes Barreto', '2017-12-15', 'M', 4),
(17, 'Gael Menezes Santos', '2016-12-07', 'M', 5),
(18, 'Benício Santos Fontes', '2017-04-04', 'M', 6),
(19, 'Lorenzo Oliveira Franco', '2016-04-07', 'M', 1),
(20, 'Heitor Melo Carvalho', '2017-06-08', 'M', 2),
-- Mirim Feminino
(21, 'Maria Clara Leite Dantas', '2014-10-06', 'F', 3),
(22, 'Laura Prado Leite', '2015-01-13', 'F', 4),
(23, 'Manuela Santos Resende', '2014-07-05', 'F', 5),
(24, 'Lara Teles Machado', '2015-08-13', 'F', 6),
(25, 'Isadora Menezes Resende', '2014-04-16', 'F', 1),
(26, 'Sarah Sampaio Carvalho', '2015-10-08', 'F', 2),
(27, 'Lívia Sampaio Barreto', '2014-11-17', 'F', 3),
(28, 'Melissa Oliveira Sampaio', '2015-01-21', 'F', 4),
(29, 'Bianca Sampaio Dantas', '2014-01-04', 'F', 5),
(30, 'Cecília Carvalho Resende', '2015-04-04', 'F', 6),
-- Mirim Masculino
(31, 'Henrique Andrade Carvalho', '2014-07-08', 'M', 1),
(32, 'Theo Melo Resende', '2015-06-13', 'M', 2),
(33, 'Samuel Andrade Prado', '2014-12-06', 'M', 3),
(34, 'Bernardo Rocha Menezes', '2015-11-09', 'M', 4),
(35, 'Ravi Prado Carvalho', '2014-04-05', 'M', 5),
(36, 'Nicolas Teles Resende', '2015-12-03', 'M', 6),
(37, 'Bento Prado Resende', '2014-12-24', 'M', 1),
(38, 'Arthur Prado Teles', '2015-05-28', 'M', 2),
(39, 'Heitor Melo Teles', '2014-03-17', 'M', 3),
(40, 'Otávio Barreto Cardoso', '2015-01-15', 'M', 4);

-- ---------------------------------------------------------------------
-- PROVA
-- ---------------------------------------------------------------------
INSERT INTO PROVA (id_prova, numero_prova, distancia, estilo, sexo, id_categoria, id_etapa) VALUES
-- Etapa 1
(1, 1, 25, 'Livre', 'F', 1, 1),
(2, 2, 25, 'Livre', 'M', 1, 1),
(3, 3, 50, 'Livre', 'F', 2, 1),
(4, 4, 50, 'Livre', 'M', 2, 1),
-- Etapa 2
(5, 5, 25, 'Costas', 'F', 1, 2),
(6, 6, 25, 'Costas', 'M', 1, 2),
(7, 7, 50, 'Costas', 'F', 2, 2),
(8, 8, 50, 'Costas', 'M', 2, 2),
-- Etapa 3
(9, 9, 25, 'Peito', 'F', 1, 3),
(10, 10, 25, 'Peito', 'M', 1, 3),
(11, 11, 50, 'Peito', 'F', 2, 3),
(12, 12, 50, 'Peito', 'M', 2, 3),
-- Etapa 4
(13, 13, 25, 'Borboleta', 'F', 1, 4),
(14, 14, 25, 'Borboleta', 'M', 1, 4),
(15, 15, 50, 'Borboleta', 'F', 2, 4),
(16, 16, 50, 'Borboleta', 'M', 2, 4);

-- ---------------------------------------------------------------------
-- RESULTADO
-- ---------------------------------------------------------------------
INSERT INTO RESULTADO
(id_resultado, id_prova, id_atleta, tempo_obtido, colocacao, pontuacao, situacao, numero_serie, numero_raia) VALUES
-- Prova 1: 25 Livre Feminino Pré-Mirim
(1, 1, 9, '00:00:24.53', 8, 1.00, 'Confirmado', 1, 4),
(2, 1, 2, '00:00:23.74', 7, 2.00, 'Confirmado', 2, 1),
(3, 1, 5, '00:00:22.56', 5, 4.00, 'Confirmado', 2, 2),
(4, 1, 3, '00:00:22.10', 4, 5.00, 'Confirmado', 2, 3),
(5, 1, 6, '00:00:21.18', 1, 9.00, 'Confirmado', 2, 4),
(6, 1, 4, '00:00:21.20', 2, 7.00, 'Confirmado', 2, 5),
(7, 1, 8, '00:00:21.86', 3, 6.00, 'Confirmado', 2, 6),
(8, 1, 7, '00:00:22.83', 6, 3.00, 'Confirmado', 2, 7),
(9, 1, 10, '00:00:24.16', NULL, 0.00, 'Desclassificado', 2, 8),
-- Prova 2: 25 Livre Masculino Pré-Mirim
(10, 2, 20, '00:00:24.47', 8, 1.00, 'Confirmado', 1, 4),
(11, 2, 14, '00:00:24.33', 7, 2.00, 'Confirmado', 1, 5),
(12, 2, 13, '00:00:23.11', 5, 4.00, 'Confirmado', 2, 1),
(13, 2, 17, '00:00:21.59', 3, 6.00, 'Confirmado', 2, 2),
(14, 2, 19, '00:00:20.80', 2, 7.00, 'Confirmado', 2, 3),
(15, 2, 11, '00:00:18.78', 1, 9.00, 'Confirmado', 2, 4),
(16, 2, 16, '00:00:20.44', NULL, 0.00, 'Desclassificado', 2, 5),
(17, 2, 12, NULL, NULL, 0.00, 'Não Compareceu', 2, 6),
(18, 2, 15, '00:00:22.80', 4, 5.00, 'Confirmado', 2, 7),
(19, 2, 18, '00:00:23.58', 6, 3.00, 'Confirmado', 2, 8),
-- Prova 3: 50 Livre Feminino Mirim
(20, 3, 25, '00:00:40.72', 8, 1.00, 'Confirmado', 1, 4),
(21, 3, 29, '00:00:41.47', 9, 0.00, 'Confirmado', 1, 5),
(22, 3, 24, '00:00:38.67', 6, 3.00, 'Confirmado', 2, 1),
(23, 3, 28, '00:00:38.06', 4, 5.00, 'Confirmado', 2, 2),
(24, 3, 30, '00:00:36.46', 3, 6.00, 'Confirmado', 2, 3),
(25, 3, 23, '00:00:34.28', 1, 9.00, 'Confirmado', 2, 4),
(26, 3, 21, NULL, NULL, 0.00, 'Não Compareceu', 2, 5),
(27, 3, 22, '00:00:36.35', 2, 7.00, 'Confirmado', 2, 6),
(28, 3, 27, '00:00:38.41', 5, 4.00, 'Confirmado', 2, 7),
(29, 3, 26, '00:00:39.04', 7, 2.00, 'Confirmado', 2, 8),
-- Prova 4: 50 Livre Masculino Mirim
(30, 4, 31, '00:00:40.01', 9, 0.00, 'Confirmado', 1, 4),
(31, 4, 33, '00:00:38.18', 7, 2.00, 'Confirmado', 2, 1),
(32, 4, 36, '00:00:37.18', 5, 4.00, 'Confirmado', 2, 2),
(33, 4, 38, '00:00:34.59', 2, 7.00, 'Confirmado', 2, 3),
(34, 4, 34, '00:00:33.69', 1, 9.00, 'Confirmado', 2, 4),
(35, 4, 35, '00:00:34.60', 3, 6.00, 'Confirmado', 2, 5),
(36, 4, 40, '00:00:36.04', 4, 5.00, 'Confirmado', 2, 6),
(37, 4, 37, '00:00:37.87', 6, 3.00, 'Confirmado', 2, 7),
(38, 4, 39, '00:00:39.21', 8, 1.00, 'Confirmado', 2, 8),
-- Prova 5: 25 Costas Feminino Pré-Mirim
(39, 5, 2, '00:00:28.15', 8, 1.00, 'Confirmado', 1, 4),
(40, 5, 7, '00:00:26.88', 7, 2.00, 'Confirmado', 2, 1),
(41, 5, 5, '00:00:25.72', 5, 4.00, 'Confirmado', 2, 2),
(42, 5, 6, '00:00:24.57', 3, 6.00, 'Confirmado', 2, 3),
(43, 5, 1, '00:00:22.76', 1, 9.00, 'Confirmado', 2, 4),
(44, 5, 3, '00:00:24.07', 2, 7.00, 'Confirmado', 2, 5),
(45, 5, 4, '00:00:25.35', 4, 5.00, 'Confirmado', 2, 6),
(46, 5, 10, '00:00:26.10', 6, 3.00, 'Confirmado', 2, 7),
(47, 5, 9, '00:00:28.17', 9, 0.00, 'Confirmado', 2, 8),
-- Prova 6: 25 Costas Masculino Pré-Mirim
(48, 6, 13, '00:00:27.54', 7, 2.00, 'Confirmado', 1, 1),
(49, 6, 14, '00:00:27.41', 6, 3.00, 'Confirmado', 1, 2),
(50, 6, 12, '00:00:23.84', 3, 6.00, 'Confirmado', 1, 3),
(51, 6, 11, '00:00:22.07', 1, 9.00, 'Confirmado', 1, 4),
(52, 6, 19, '00:00:22.68', 2, 7.00, 'Confirmado', 1, 5),
(53, 6, 15, '00:00:26.07', 4, 5.00, 'Confirmado', 1, 6),
(54, 6, 18, '00:00:26.96', 5, 4.00, 'Confirmado', 1, 7),
(55, 6, 20, '00:00:27.91', 8, 1.00, 'Confirmado', 1, 8),
-- Prova 7: 50 Costas Feminino Mirim
(56, 7, 25, '00:00:45.21', 9, 0.00, 'Confirmado', 1, 4),
(57, 7, 29, NULL, NULL, 0.00, 'Não Compareceu', 1, 5),
(58, 7, 26, '00:00:44.61', 7, 2.00, 'Confirmado', 2, 1),
(59, 7, 28, '00:00:42.44', 5, 4.00, 'Confirmado', 2, 2),
(60, 7, 22, '00:00:42.12', 4, 5.00, 'Confirmado', 2, 3),
(61, 7, 23, '00:00:39.22', 1, 9.00, 'Confirmado', 2, 4),
(62, 7, 21, '00:00:40.95', 2, 7.00, 'Confirmado', 2, 5),
(63, 7, 30, '00:00:41.67', 3, 6.00, 'Confirmado', 2, 6),
(64, 7, 27, '00:00:44.03', 6, 3.00, 'Confirmado', 2, 7),
(65, 7, 24, '00:00:44.91', 8, 1.00, 'Confirmado', 2, 8),
-- Prova 8: 50 Costas Masculino Mirim
(66, 8, 39, '00:00:46.49', 9, 0.00, 'Confirmado', 1, 4),
(67, 8, 33, '00:00:45.04', 7, 2.00, 'Confirmado', 2, 1),
(68, 8, 32, '00:00:42.38', 5, 4.00, 'Confirmado', 2, 2),
(69, 8, 34, '00:00:40.41', 2, 7.00, 'Confirmado', 2, 3),
(70, 8, 35, '00:00:40.19', 1, 9.00, 'Confirmado', 2, 4),
(71, 8, 40, '00:00:40.81', 4, 5.00, 'Confirmado', 2, 5),
(72, 8, 36, '00:00:40.78', 3, 6.00, 'Confirmado', 2, 6),
(73, 8, 37, '00:00:43.58', 6, 3.00, 'Confirmado', 2, 7),
(74, 8, 31, '00:00:46.23', 8, 1.00, 'Confirmado', 2, 8),
-- Prova 9: 25 Peito Feminino Pré-Mirim
(75, 9, 9, '00:00:29.47', 9, 0.00, 'Confirmado', 1, 4),
(76, 9, 7, '00:00:29.12', 7, 2.00, 'Confirmado', 2, 1),
(77, 9, 10, '00:00:28.21', 6, 3.00, 'Confirmado', 2, 2),
(78, 9, 4, '00:00:25.91', 3, 6.00, 'Confirmado', 2, 3),
(79, 9, 6, '00:00:24.87', 1, 9.00, 'Confirmado', 2, 4),
(80, 9, 1, '00:00:25.54', 2, 7.00, 'Confirmado', 2, 5),
(81, 9, 8, '00:00:26.17', 4, 5.00, 'Confirmado', 2, 6),
(82, 9, 5, '00:00:28.05', 5, 4.00, 'Confirmado', 2, 7),
(83, 9, 2, '00:00:29.20', 8, 1.00, 'Confirmado', 2, 8),
-- Prova 10: 25 Peito Masculino Pré-Mirim
(84, 10, 13, '00:00:28.89', 9, 0.00, 'Confirmado', 1, 4),
(85, 10, 14, '00:00:30.02', 10, 0.00, 'Confirmado', 1, 5),
(86, 10, 15, '00:00:27.86', 7, 2.00, 'Confirmado', 2, 1),
(87, 10, 17, '00:00:26.67', 5, 4.00, 'Confirmado', 2, 2),
(88, 10, 12, '00:00:25.43', 3, 6.00, 'Confirmado', 2, 3),
(89, 10, 19, '00:00:25.02', 2, 7.00, 'Confirmado', 2, 4),
(90, 10, 11, '00:00:24.97', 1, 9.00, 'Confirmado', 2, 5),
(91, 10, 16, '00:00:25.94', 4, 5.00, 'Confirmado', 2, 6),
(92, 10, 18, '00:00:27.68', 6, 3.00, 'Confirmado', 2, 7),
(93, 10, 20, '00:00:28.46', 8, 1.00, 'Confirmado', 2, 8),
-- Prova 11: 50 Peito Feminino Mirim
(94, 11, 29, '00:00:51.04', 8, 1.00, 'Confirmado', 1, 4),
(95, 11, 24, '00:00:48.48', 6, 3.00, 'Confirmado', 2, 1),
(96, 11, 28, '00:00:46.66', 4, 5.00, 'Confirmado', 2, 2),
(97, 11, 21, '00:00:44.82', 3, 6.00, 'Confirmado', 2, 3),
(98, 11, 23, '00:00:43.65', 1, 9.00, 'Confirmado', 2, 4),
(99, 11, 30, '00:00:44.52', 2, 7.00, 'Confirmado', 2, 5),
(100, 11, 22, '00:00:46.32', NULL, 0.00, 'Desclassificado', 2, 6),
(101, 11, 27, '00:00:47.91', 5, 4.00, 'Confirmado', 2, 7),
(102, 11, 25, '00:00:49.81', 7, 2.00, 'Confirmado', 2, 8),
-- Prova 12: 50 Peito Masculino Mirim
(103, 12, 39, '00:00:49.32', 8, 1.00, 'Confirmado', 1, 4),
(104, 12, 37, '00:00:47.62', 7, 2.00, 'Confirmado', 2, 1),
(105, 12, 40, '00:00:45.07', 4, 5.00, 'Confirmado', 2, 2),
(106, 12, 36, '00:00:44.30', 3, 6.00, 'Confirmado', 2, 3),
(107, 12, 35, '00:00:42.56', 1, 9.00, 'Confirmado', 2, 4),
(108, 12, 34, '00:00:44.29', 2, 7.00, 'Confirmado', 2, 5),
(109, 12, 38, '00:00:45.31', 5, 4.00, 'Confirmado', 2, 6),
(110, 12, 32, '00:00:46.30', 6, 3.00, 'Confirmado', 2, 7),
(111, 12, 33, '00:00:49.44', 9, 0.00, 'Confirmado', 2, 8),
-- Prova 13: 25 Borboleta Feminino Pré-Mirim
(112, 13, 2, '00:00:27.92', 6, 3.00, 'Confirmado', 1, 4),
(113, 13, 9, '00:00:27.14', NULL, 0.00, 'Desclassificado', 2, 1),
(114, 13, 5, '00:00:25.87', 5, 4.00, 'Confirmado', 2, 2),
(115, 13, 4, '00:00:24.09', 4, 5.00, 'Confirmado', 2, 3),
(116, 13, 1, '00:00:22.23', 1, 9.00, 'Confirmado', 2, 4),
(117, 13, 6, '00:00:23.24', 2, 7.00, 'Confirmado', 2, 5),
(118, 13, 3, '00:00:23.84', 3, 6.00, 'Confirmado', 2, 6),
(119, 13, 7, '00:00:26.87', NULL, 0.00, 'Desclassificado', 2, 7),
(120, 13, 10, '00:00:26.96', NULL, 0.00, 'Desclassificado', 2, 8),
-- Prova 14: 25 Borboleta Masculino Pré-Mirim
(121, 14, 14, '00:00:27.13', NULL, 0.00, 'Desclassificado', 1, 4),
(122, 14, 20, '00:00:26.39', 7, 2.00, 'Confirmado', 2, 1),
(123, 14, 16, '00:00:24.67', 5, 4.00, 'Confirmado', 2, 2),
(124, 14, 12, '00:00:22.45', 3, 6.00, 'Confirmado', 2, 3),
(125, 14, 19, '00:00:21.75', 1, 9.00, 'Confirmado', 2, 4),
(126, 14, 11, '00:00:22.45', 2, 7.00, 'Confirmado', 2, 5),
(127, 14, 17, '00:00:22.69', 4, 5.00, 'Confirmado', 2, 6),
(128, 14, 18, '00:00:25.32', 6, 3.00, 'Confirmado', 2, 7),
(129, 14, 13, '00:00:26.75', 8, 1.00, 'Confirmado', 2, 8),
-- Prova 15: 50 Borboleta Feminino Mirim
(130, 15, 26, '00:00:43.91', 7, 2.00, 'Confirmado', 1, 1),
(131, 15, 28, '00:00:41.94', 5, 4.00, 'Confirmado', 1, 2),
(132, 15, 22, '00:00:40.16', 3, 6.00, 'Confirmado', 1, 3),
(133, 15, 30, '00:00:38.45', 1, 9.00, 'Confirmado', 1, 4),
(134, 15, 23, '00:00:38.84', 2, 7.00, 'Confirmado', 1, 5),
(135, 15, 21, '00:00:40.79', 4, 5.00, 'Confirmado', 1, 6),
(136, 15, 24, '00:00:42.88', 6, 3.00, 'Confirmado', 1, 7),
(137, 15, 29, '00:00:46.01', 8, 1.00, 'Confirmado', 1, 8),
-- Prova 16: 50 Borboleta Masculino Mirim
(138, 16, 39, '00:00:45.36', 7, 2.00, 'Confirmado', 1, 4),
(139, 16, 31, '00:00:45.89', 8, 1.00, 'Confirmado', 1, 5),
(140, 16, 32, '00:00:41.34', 5, 4.00, 'Confirmado', 2, 1),
(141, 16, 36, '00:00:40.66', 4, 5.00, 'Confirmado', 2, 2),
(142, 16, 35, '00:00:39.17', 2, 7.00, 'Confirmado', 2, 3),
(143, 16, 34, '00:00:37.68', NULL, 0.00, 'Desclassificado', 2, 4),
(144, 16, 38, '00:00:38.33', 1, 9.00, 'Confirmado', 2, 5),
(145, 16, 37, NULL, NULL, 0.00, 'Não Compareceu', 2, 6),
(146, 16, 40, '00:00:40.60', 3, 6.00, 'Confirmado', 2, 7),
(147, 16, 33, '00:00:45.05', 6, 3.00, 'Confirmado', 2, 8);

-- ---------------------------------------------------------------------
-- Ajuste das sequências SERIAL (próximos INSERTs sem id funcionam)
-- ---------------------------------------------------------------------
SELECT setval(pg_get_serial_sequence('clube',     'id_clube'),     (SELECT MAX(id_clube)     FROM CLUBE));
SELECT setval(pg_get_serial_sequence('categoria', 'id_categoria'), (SELECT MAX(id_categoria) FROM CATEGORIA));
SELECT setval(pg_get_serial_sequence('etapa',     'id_etapa'),     (SELECT MAX(id_etapa)     FROM ETAPA));
SELECT setval(pg_get_serial_sequence('atleta',    'id_atleta'),    (SELECT MAX(id_atleta)    FROM ATLETA));
SELECT setval(pg_get_serial_sequence('prova',     'id_prova'),     (SELECT MAX(id_prova)     FROM PROVA));
SELECT setval(pg_get_serial_sequence('resultado', 'id_resultado'), (SELECT MAX(id_resultado) FROM RESULTADO));

COMMIT;

-- ---------------------------------------------------------------------
-- Conferência (opcional)
-- ---------------------------------------------------------------------
-- 1) Nenhum atleta fora da categoria/sexo da prova (deve retornar 0 linhas):
-- SELECT r.id_resultado, a.nome, c.nome AS categoria,
--        2025 - EXTRACT(YEAR FROM a.data_nascimento) AS idade
--   FROM RESULTADO r
--   JOIN ATLETA a    ON a.id_atleta = r.id_atleta
--   JOIN PROVA p     ON p.id_prova = r.id_prova
--   JOIN CATEGORIA c ON c.id_categoria = p.id_categoria
--  WHERE 2025 - EXTRACT(YEAR FROM a.data_nascimento) NOT BETWEEN c.idade_minima AND c.idade_maxima
--     OR (p.sexo <> 'Misto' AND p.sexo <> a.sexo);
--
-- 2) Pontos por clube:
-- SELECT cl.sigla, SUM(r.pontuacao) AS pontos
--   FROM RESULTADO r
--   JOIN ATLETA a  ON a.id_atleta = r.id_atleta
--   JOIN CLUBE cl  ON cl.id_clube = a.id_clube
--  GROUP BY cl.sigla
--  ORDER BY pontos DESC;
