SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.6 (Ubuntu 15.6-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--



--
-- Data for Name: donors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."donors" ("id", "name", "surname", "address", "email") VALUES
	(1, 'John', 'Doe', '-', 'johndoe@email.com');


--
-- Data for Name: gifts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."gifts" ("id", "price", "parts", "image", "hidden") VALUES
	(40, 50, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.3073494298498419.png', false),
	(41, 100, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.3399865164006908.png', false),
	(43, 150, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.8741549048738307.png', false),
	(45, 20, 4, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.21228445662193685.webp', false),
	(1, 50, 0, 'https://picsum.photos/275/320', false),
	(44, 120, 2, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.9295340499855826.webp', false),
	(46, 600, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.31451949155556225.png', false),
	(47, 160, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.7468145179556387.webp', false),
	(48, 40, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.7677857091774453.webp', false),
	(49, 55, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.7269363572853516.webp', false),
	(50, 150, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.8303413278758849.png', false),
	(51, 50, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.8110632498099748.png', false),
	(52, 60, 2, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.6297698112674929.webp', false),
	(53, 200, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.7107146061425804.webp', false),
	(10, 20, 8, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.32559991386649634.jpg', false),
	(15, 20, 8, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.10175646643416159.jpg', false),
	(16, 20, 8, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.5937627304626394.jpg', false),
	(17, 20, 8, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.999850538822654.jpg', false),
	(18, 100, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.2964452084960215.jpg', false),
	(19, 50, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.009754711681514094.jpg', false),
	(20, 100, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.6844673256018328.jpg', true),
	(21, 100, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.34015848115417135.jpg', true),
	(22, 300, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.737610104438109.jpg', false),
	(23, 300, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.13838221730410039.jpg', false),
	(24, 50, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.49638277599656777.jpg', false),
	(25, 20, 2, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.1801682516687816.jpg', false),
	(26, 20, 2, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.1801682516687816.jpg', false),
	(27, 60, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.11067181579398999.jpg', true),
	(28, 40, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.4467027003100461.png', true),
	(29, 30, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.7203176015516778.jpg', false),
	(30, 280, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.011469754458064307.jpg', false),
	(31, 80, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.32080570885601556.png', false),
	(32, 120, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.6800251497523152.png', false),
	(33, 300, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.3928930813091033.jpg', false),
	(34, 150, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.21383533302049107.jpg', false),
	(35, 50, 2, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.9873214350936317.png', false),
	(36, 125, 0, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.5965447244958315.png', false),
	(38, 40, 2, 'http://127.0.0.1:54321/storage/v1/object/public/images/0.17373995114866325.png', false);


--
-- Data for Name: gift_translations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."gift_translations" ("id", "language", "title", "description", "gift") VALUES
	(15, 'fr-CH', 'Assiettes creuses', 'Pour pouvoir manger (beaucoup) de pâtes ', 15),
	(16, 'de-CH', 'Pasta Teller', 'Damit wir (viel) Pasta essen können', 15),
	(17, 'fr-CH', 'Bols', 'Quand le souper se résume à un bol de céréales ', 16),
	(18, 'de-CH', 'Schalen', 'Wenn es zum Z''Nacht nur ein Müsli gibt', 16),
	(19, 'fr-CH', 'Tassen', 'Pour un grand café, un chocolat chaud, un thé,...', 17),
	(20, 'de-CH', 'Tassen', 'Für ein grosses Kaffi, eine heisse Schoggi, einen Thé', 17),
	(21, 'fr-CH', 'Set de verres à vin ', 'pour les apéros', 18),
	(22, 'de-CH', 'Weingläser set ', 'für alle Apéros ', 18),
	(23, 'fr-CH', 'Verres ', 'Utiles tous les jours', 19),
	(24, 'de-CH', 'Trinkgläser', 'Jeden Tag nützlich ', 19),
	(25, 'fr-CH', 'Caquelon fondue', 'Pour les soirées d''hiver', 20),
	(26, 'de-CH', 'Fondue Caquelon', 'Für die Winterabende', 20),
	(27, 'fr-CH', 'Four à raclette', 'Vive le fromage !', 21),
	(28, 'de-CH', 'Raclette Öffeli', 'Es lebe der Käse !', 21),
	(29, 'fr-CH', 'Grill', 'miam, miam', 22),
	(30, 'de-CH', 'Grill', 'Miam, miam ', 22),
	(31, 'fr-CH', 'Machine à café ', 'Pour les bon petits et grands café du matin (et de toute la journée)', 23),
	(32, 'de-CH', 'Kaffemaschine', 'Für alle grossen und kleinen Kaffes', 23),
	(33, 'fr-CH', 'Grille pain', 'Pour les tartines de pain grillé', 24),
	(34, 'de-CH', 'Toaster', 'Weil es getoastet besser ist', 24),
	(35, 'de-CH', 'Pizzablech', 'Für die traditionnelle Samstag Abend Pizza', 25),
	(36, 'fr-CH', 'Plaque à Pizza ', 'Pour les pizzas du samedi soir', 26),
	(37, 'de-CH', 'Pizzablech', 'Für die traditionnelle Samstag Abend Pizza', 26),
	(38, 'fr-CH', 'Four à crêpes', 'Pour les crêpes partys ', 27),
	(39, 'de-CH', 'Crêpes Öffeli', 'Für alle Crêpes Partys', 27),
	(40, 'fr-CH', 'Machine à croques-monsieur ', 'Quand on ne sait pas quoi cuisiner', 28),
	(41, 'de-CH', 'Croques-monsieur Maschine', 'Wenn wir keine Idee haben was zu kochen ', 28),
	(42, 'fr-CH', 'Bouteille thermos', 'Pour nos sorties dans la neige', 29),
	(43, 'de-CH', 'Thermosflasche', 'Für unsere Ausflüge in den Schnee', 29),
	(44, 'fr-CH', 'Commode ', 'Pour ranger les habits qui n''ont pas la place dans l''armoire', 30),
	(45, 'de-CH', 'Kommode', 'Damit wir die Kleider die im Schrank keinen Platz mehr haben doch verräumen können', 30),
	(46, 'fr-CH', 'Bibliothèque ', 'Pour que Franci puisse ranger tous ses livres', 31),
	(47, 'de-CH', 'Bibliothek ', 'Damit Francesco all seine Bücher behalten kann', 31),
	(48, 'fr-CH', 'Grand miroir', 'Pour faire le check de l''outfit du jour', 32),
	(49, 'de-CH', 'Grosser Spiegel', 'Um zu sehen ob das Outfit passt ', 32),
	(11, 'fr-CH', 'TEST', 'TEST', 1),
	(50, 'fr-CH', 'Literie ', 'Pour se retrouver dans de beaux draps ', 33),
	(51, 'fr-CH', 'Linges de bain ', '', 34),
	(52, 'fr-CH', 'Table de chevet', 'Pour stocker tous les livres en cours de lecture', 35),
	(53, 'de-CH', 'Nachttischli', 'Um alle angefangenen Bücher zu verräumen ', 35),
	(75, 'fr-CH', 'Plantoir pour balcon', '', 50),
	(54, 'fr-CH', 'étagère murale', 'pour plus de rangements ', 36),
	(55, 'de-CH', 'Wandregal', 'Für noch mehr Stauplatz', 36),
	(12, 'fr-CH', 'Assiettes', '', 10),
	(56, 'fr-CH', 'Lampe de chevet', '', 38),
	(57, 'de-CH', 'Nachttischlampe', '', 38),
	(58, 'fr-CH', 'Foehn ', 'Pour nos brushing quotidiens ', 40),
	(59, 'de-CH', 'Foehn', 'Für unsere tägliche Brushings ', 40),
	(60, 'fr-CH', 'Meuble à chaussure', '', 41),
	(61, 'fr-CH', 'Lampe à pied ', 'Pour qu''on puisse voir ce qu''on mange ', 43),
	(62, 'de-CH', 'Stehlampe', 'Damit wir sehen können was wir essen, denn "das Auge isst mit"', 43),
	(65, 'fr-CH', 'Tabourets ', 'Pour pouvoir accueillir plus de monde', 45),
	(66, 'de-CH', 'Tabouret', 'Damit wir mehr Leute empfangen können', 45),
	(63, 'fr-CH', 'Tiroirs à bureau', 'Pour que nos bureaux soient toujours bien rangés ', 44),
	(64, 'de-CH', 'Schreibtischschublade', 'Damit unsere Schreibtische immer gut aufgeräumt bleiben', 44),
	(67, 'fr-CH', 'Beamer', 'Pour des superbes soirées Films ', 46),
	(68, 'de-CH', 'Beamer', 'Für super Filmabende', 46),
	(69, 'fr-CH', 'Canapé balcon', 'Pour chiller dehors ', 47),
	(70, 'de-CH', 'Balcon Sofa', 'um draussen zu chillen', 47),
	(71, 'fr-CH', 'Table balcon', 'Pour l''apéro sur le balcon ', 48),
	(72, 'de-CH', 'Balcon Tischlein', 'Für ein Apéro an der frischen Luft', 48),
	(73, 'fr-CH', 'Banc pour balcon', '', 49),
	(74, 'de-CH', 'Balcon Bank', '', 49),
	(76, 'de-CH', 'Hochbeet', '', 50),
	(77, 'fr-CH', 'Plantes aromatiques', '', 51),
	(78, 'de-CH', 'Kräuterpflanzen', '', 51),
	(79, 'fr-CH', 'Plantes', '', 52),
	(80, 'de-CH', 'Pflanzen', '', 52),
	(81, 'fr-CH', 'Caisse à outils', '', 53),
	(82, 'de-CH', 'Werkzeugkiste', '', 53);


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."settings" ("id", "key", "value") VALUES
	(1, 'currency', 'CHF'),
	(2, 'languages_nb', '3'),
	(3, 'languages_string', '["fr-CH","de-CH","it-CH"]'),
	(4, 'languages_default', 'fr-CH');


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."transactions" ("id", "created_at", "amount", "gift", "donor") VALUES
	(1, '2024-05-30 19:51:13.276501+00', 50, 1, 1);


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id") VALUES
	('images', 'images', NULL, '2024-05-16 21:30:11.863486+00', '2024-05-16 21:30:11.863486+00', true, false, 2097152, '{image/*}', NULL);


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id") VALUES
	('42742b54-d084-4b61-adda-1d1fd8b2abc3', 'images', '0.3399865164006908.png', NULL, '2024-06-04 12:46:00.468134+00', '2024-06-04 12:46:00.468134+00', '2024-06-04 12:46:00.468134+00', '{"eTag": "\"913453ffc9ac222e890bec69e048edd3\"", "size": 203396, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:46:01.000Z", "contentLength": 203396, "httpStatusCode": 200}', 'e835b55e-d364-4db7-b554-31a8c357be4b', NULL),
	('f83a547b-3f66-4504-95ef-0bbefe041151', 'images', '0.31451949155556225.png', NULL, '2024-06-04 13:06:26.428567+00', '2024-06-04 13:06:26.428567+00', '2024-06-04 13:06:26.428567+00', '{"eTag": "\"6f606f517ae96805bba860eda5209677\"", "size": 449355, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T13:06:27.000Z", "contentLength": 449355, "httpStatusCode": 200}', '742ddcdc-77be-4b24-a5ab-687ff0326164', NULL),
	('c7c92b58-0045-4c60-8b0e-d7509658e682', 'images', '0.8303413278758849.png', NULL, '2024-06-04 14:31:22.227292+00', '2024-06-04 14:31:22.227292+00', '2024-06-04 14:31:22.227292+00', '{"eTag": "\"0828c5b96b22373e054f64a54307e0b8\"", "size": 1085454, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T14:31:23.000Z", "contentLength": 1085454, "httpStatusCode": 200}', '47c9f123-d3c6-4a83-a0ec-f639071ba580', NULL),
	('abb5facf-6272-478a-86ff-be90f0beb00f', 'images', 'SaveTheDate_140924.jpeg', NULL, '2024-06-03 20:08:22.601994+00', '2024-06-03 20:08:22.601994+00', '2024-06-03 20:08:22.601994+00', '{"eTag": "\"930bed6758ac0b6efa233831f0269f46\"", "size": 102137, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-03T20:08:23.000Z", "contentLength": 102137, "httpStatusCode": 200}', 'cd2d9235-bbf0-4736-b931-951162d00e5b', NULL),
	('f3717523-92c7-425a-b13e-65dd57f2b94c', 'images', '0.7714892122463842.png', NULL, '2024-06-03 21:03:58.354513+00', '2024-06-03 21:03:58.354513+00', '2024-06-03 21:03:58.354513+00', '{"eTag": "\"697c79f3cf1068c14e200093ceeca150\"", "size": 978941, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-03T21:03:59.000Z", "contentLength": 978941, "httpStatusCode": 200}', '82b7ed98-dba3-46c6-b241-7d7d2a4689d7', NULL),
	('1f637058-d00d-41f1-b7a0-8d6cfecbfd09', 'images', '0.32559991386649634.jpg', NULL, '2024-06-04 07:49:16.171333+00', '2024-06-04 07:49:16.171333+00', '2024-06-04 07:49:16.171333+00', '{"eTag": "\"7486e9dd6609b01d026e62959ce9898a\"", "size": 73969, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T07:49:17.000Z", "contentLength": 73969, "httpStatusCode": 200}', 'b78ccdb7-b7c6-413d-b579-804e85b3f200', NULL),
	('6fdca669-1c7c-4647-91b3-6db554bbe69a', 'images', '0.10175646643416159.jpg', NULL, '2024-06-04 07:58:24.783657+00', '2024-06-04 07:58:24.783657+00', '2024-06-04 07:58:24.783657+00', '{"eTag": "\"818eb1ab06f86e203a62b7ba66842e79\"", "size": 98828, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T07:58:25.000Z", "contentLength": 98828, "httpStatusCode": 200}', '4ff57dfb-1e9c-461f-b622-af602fb9363e', NULL),
	('774179b1-c34f-43fd-ab35-6186336b71c8', 'images', '0.5937627304626394.jpg', NULL, '2024-06-04 08:02:47.22844+00', '2024-06-04 08:02:47.22844+00', '2024-06-04 08:02:47.22844+00', '{"eTag": "\"b5e701de2e5750346f1a97fa0f4fdf3e\"", "size": 37468, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:02:48.000Z", "contentLength": 37468, "httpStatusCode": 200}', '3f480e25-c46f-455c-88d1-a239d2108e22', NULL),
	('8260f93e-6a70-4520-9667-facd8cd25c3e', 'images', '0.999850538822654.jpg', NULL, '2024-06-04 08:05:21.066435+00', '2024-06-04 08:05:21.066435+00', '2024-06-04 08:05:21.066435+00', '{"eTag": "\"25896986166125b7cb8a38902a69b9cb\"", "size": 67322, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:05:22.000Z", "contentLength": 67322, "httpStatusCode": 200}', '459ce1ae-2d7b-4ba6-ae7d-463fd70e265c', NULL),
	('1245d767-968d-484b-8a7b-7161c09a9e5b', 'images', '0.2964452084960215.jpg', NULL, '2024-06-04 08:13:11.365891+00', '2024-06-04 08:13:11.365891+00', '2024-06-04 08:13:11.365891+00', '{"eTag": "\"a921b65695a6e3c505357a177f0ff2e1\"", "size": 41866, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:13:12.000Z", "contentLength": 41866, "httpStatusCode": 200}', 'a313e365-27bf-4f05-b0c8-544e7a30318b', NULL),
	('29801232-20c2-4023-8567-eafe26c04578', 'images', '0.009754711681514094.jpg', NULL, '2024-06-04 08:15:19.736592+00', '2024-06-04 08:15:19.736592+00', '2024-06-04 08:15:19.736592+00', '{"eTag": "\"1247962b1a54e184bcf693b110f15cf6\"", "size": 72158, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:15:20.000Z", "contentLength": 72158, "httpStatusCode": 200}', 'c3a9702e-5012-4bcc-b4e7-17b783de2993', NULL),
	('218faf73-0e72-4760-ad4e-abf221d92c91', 'images', '0.6844673256018328.jpg', NULL, '2024-06-04 08:18:56.886198+00', '2024-06-04 08:18:56.886198+00', '2024-06-04 08:18:56.886198+00', '{"eTag": "\"1ebdb22569acbe2d9d813beeedba2777\"", "size": 56084, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:18:57.000Z", "contentLength": 56084, "httpStatusCode": 200}', '8335845b-031b-406f-9d84-615c2b566e24', NULL),
	('5a36b865-e01f-4c15-89ef-852f279a86d6', 'images', '0.34015848115417135.jpg', NULL, '2024-06-04 08:22:21.692365+00', '2024-06-04 08:22:21.692365+00', '2024-06-04 08:22:21.692365+00', '{"eTag": "\"437129e5a1ea3d1dc22ea08bf23aff23\"", "size": 74938, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:22:22.000Z", "contentLength": 74938, "httpStatusCode": 200}', '63addd1d-249c-4a51-8176-7b784e607b14', NULL),
	('da52f9b1-f47e-49be-b0fc-7f8b78f45db5', 'images', '0.737610104438109.jpg', NULL, '2024-06-04 08:28:34.300264+00', '2024-06-04 08:28:34.300264+00', '2024-06-04 08:28:34.300264+00', '{"eTag": "\"5086f5af95926968409f04baa87299c4\"", "size": 343698, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:28:35.000Z", "contentLength": 343698, "httpStatusCode": 200}', 'd61e4809-fbb4-4f19-b4dc-90067cb20d98', NULL),
	('e42f376c-3586-4fa0-8944-c436b07e21b7', 'images', '0.13838221730410039.jpg', NULL, '2024-06-04 08:31:01.160388+00', '2024-06-04 08:31:01.160388+00', '2024-06-04 08:31:01.160388+00', '{"eTag": "\"23a96aa94741d1f6e4b92cc9d1de21be\"", "size": 45934, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:31:02.000Z", "contentLength": 45934, "httpStatusCode": 200}', 'ba5b285b-8646-4ebf-b706-02eacbefb9e6', NULL),
	('1c9a6176-d694-4ba8-a337-aab20d2cfd8f', 'images', '0.49638277599656777.jpg', NULL, '2024-06-04 08:36:59.922334+00', '2024-06-04 08:36:59.922334+00', '2024-06-04 08:36:59.922334+00', '{"eTag": "\"9c15c6bd956a998565da008f2aee0686\"", "size": 188245, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:37:00.000Z", "contentLength": 188245, "httpStatusCode": 200}', '247ba0a6-83c0-4b27-b756-517ec322f742', NULL),
	('ca576dda-e96f-4879-9f1c-72faba6992aa', 'images', '0.1801682516687816.jpg', NULL, '2024-06-04 08:40:51.383599+00', '2024-06-04 08:40:51.383599+00', '2024-06-04 08:40:51.383599+00', '{"eTag": "\"eeca61e55d045117d1a2549cb996b660\"", "size": 23106, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:40:52.000Z", "contentLength": 23106, "httpStatusCode": 200}', 'e388a89c-58dd-48c4-86d3-81551d9b7d06', NULL),
	('b40794d1-5191-480e-bfb2-fbc577c776af', 'images', '0.11067181579398999.jpg', NULL, '2024-06-04 08:47:02.523612+00', '2024-06-04 08:47:02.523612+00', '2024-06-04 08:47:02.523612+00', '{"eTag": "\"459fd40563d27ca7ebe3de832f94fdea\"", "size": 15698, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:47:02.000Z", "contentLength": 15698, "httpStatusCode": 200}', 'a418779d-7d14-4123-9cd9-78cef1f2ea0d', NULL),
	('aea906ae-1d27-48cb-8c1a-9ecd658cae70', 'images', '0.8741549048738307.png', NULL, '2024-06-04 12:53:37.669055+00', '2024-06-04 12:53:37.669055+00', '2024-06-04 12:53:37.669055+00', '{"eTag": "\"a0de81f64d709b5f0261d0b4bf387d61\"", "size": 152359, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:53:38.000Z", "contentLength": 152359, "httpStatusCode": 200}', 'e0c3d6da-1b50-4530-8cf3-2d201a5b818f', NULL),
	('519a401c-a854-42dd-9d6d-26e4e105aaf6', 'images', '0.4467027003100461.png', NULL, '2024-06-04 08:52:11.18424+00', '2024-06-04 08:52:11.18424+00', '2024-06-04 08:52:11.18424+00', '{"eTag": "\"e836a60d9c09a66751a563a9f6616cf8\"", "size": 678178, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:52:12.000Z", "contentLength": 678178, "httpStatusCode": 200}', '0a44f551-603d-4f5c-9da7-af22b8e26491', NULL),
	('dfbe7fc0-b254-4c52-901d-e298412b92b7', 'images', '0.7203176015516778.jpg', NULL, '2024-06-04 08:56:53.668324+00', '2024-06-04 08:56:53.668324+00', '2024-06-04 08:56:53.668324+00', '{"eTag": "\"d76d444893b42c5262bda75e91f291ab\"", "size": 10198, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T08:56:54.000Z", "contentLength": 10198, "httpStatusCode": 200}', '2fa7af69-de73-4582-af34-7d74c76e3a93', NULL),
	('fadbe4ca-9f70-47bd-ae7c-43c6093bd6ec', 'images', '0.7468145179556387.webp', NULL, '2024-06-04 14:13:21.909109+00', '2024-06-04 14:13:21.909109+00', '2024-06-04 14:13:21.909109+00', '{"eTag": "\"a78d74fd13c319821247a39c1f38f78b\"", "size": 42624, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T14:13:22.000Z", "contentLength": 42624, "httpStatusCode": 200}', 'f14a513b-968f-400f-a35a-c42bbd5a80c2', NULL),
	('76ab89cb-71c6-4317-9c9e-808799e59893', 'images', '0.011469754458064307.jpg', NULL, '2024-06-04 09:01:15.719895+00', '2024-06-04 09:01:15.719895+00', '2024-06-04 09:01:15.719895+00', '{"eTag": "\"d9f586b76a12eb7511f4a9552efaab49\"", "size": 99454, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T09:01:16.000Z", "contentLength": 99454, "httpStatusCode": 200}', '04ec3f91-7426-4c77-928a-175f0bcf028c', NULL),
	('cdfca418-0356-4813-addf-9053864e79d5', 'images', '0.32080570885601556.png', NULL, '2024-06-04 09:04:31.074689+00', '2024-06-04 09:04:31.074689+00', '2024-06-04 09:04:31.074689+00', '{"eTag": "\"f32566b96497677e1839d804aaca9067\"", "size": 765355, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T09:04:31.000Z", "contentLength": 765355, "httpStatusCode": 200}', '0e6764f4-261b-412e-bc4a-18c35392e359', NULL),
	('77629bae-8289-46ae-92fa-3bebf031c408', 'images', '0.7677857091774453.webp', NULL, '2024-06-04 14:14:54.685432+00', '2024-06-04 14:14:54.685432+00', '2024-06-04 14:14:54.685432+00', '{"eTag": "\"4652e01512a434ec94f4e5b872581291\"", "size": 69194, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T14:14:55.000Z", "contentLength": 69194, "httpStatusCode": 200}', 'bc758954-1912-4c55-8f5d-2e5ce7cd770a', NULL),
	('caa003c4-3f04-4734-a46f-074bcd9303c8', 'images', '0.6800251497523152.png', NULL, '2024-06-04 09:08:06.313687+00', '2024-06-04 09:08:06.313687+00', '2024-06-04 09:08:06.313687+00', '{"eTag": "\"43fb7c620be9c2b6a84ec1ce0287b189\"", "size": 1439106, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T09:08:07.000Z", "contentLength": 1439106, "httpStatusCode": 200}', '6c46b9a3-8eab-49bd-a025-b7794f9de585', NULL),
	('22ced15c-2c50-4653-b986-1945997be80a', 'images', '0.3928930813091033.jpg', NULL, '2024-06-04 11:56:20.728317+00', '2024-06-04 11:56:20.728317+00', '2024-06-04 11:56:20.728317+00', '{"eTag": "\"7e4befa4090a8ed3a0204c8b924086c1\"", "size": 239987, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T11:56:21.000Z", "contentLength": 239987, "httpStatusCode": 200}', '7f767545-cdf8-4305-832a-0c79749631d0', NULL),
	('c837439a-0df7-46ae-96bb-a47cf0f9ad17', 'images', '0.21383533302049107.jpg', NULL, '2024-06-04 12:06:01.414695+00', '2024-06-04 12:06:01.414695+00', '2024-06-04 12:06:01.414695+00', '{"eTag": "\"7652a12496a4c091f4cce9ec5fe2f43d\"", "size": 326602, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:06:02.000Z", "contentLength": 326602, "httpStatusCode": 200}', '1a839005-5608-48fd-baf9-ce0d2f33c4c2', NULL),
	('ec5fbdc8-4907-4d56-ae9f-b70b24e27bf2', 'images', '0.9873214350936317.png', NULL, '2024-06-04 12:14:37.212449+00', '2024-06-04 12:14:37.212449+00', '2024-06-04 12:14:37.212449+00', '{"eTag": "\"092ec4d2bf6ee54f9cf91a260ed19e27\"", "size": 852040, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:14:37.000Z", "contentLength": 852040, "httpStatusCode": 200}', 'd32e5a21-35ea-4af7-be44-3261f1b97045', NULL),
	('e617d174-c716-4cae-b4b4-511699e5f6ea', 'images', '0.5965447244958315.png', NULL, '2024-06-04 12:32:35.661278+00', '2024-06-04 12:32:35.661278+00', '2024-06-04 12:32:35.661278+00', '{"eTag": "\"ff03e0b1d95c9687fa87a3c1c74d67bd\"", "size": 212050, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:32:36.000Z", "contentLength": 212050, "httpStatusCode": 200}', 'c308eca3-2c0b-424a-8963-6b4396d04c3e', NULL),
	('600d976c-c5fc-4725-a273-069187d47154', 'images', '0.8720023360105533.png', NULL, '2024-06-04 12:36:03.858279+00', '2024-06-04 12:36:03.858279+00', '2024-06-04 12:36:03.858279+00', '{"eTag": "\"77d3eb99940784603acd33411700833d\"", "size": 504879, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:36:04.000Z", "contentLength": 504879, "httpStatusCode": 200}', 'c1118e24-fb78-44c7-8b11-beae3504ca92', NULL),
	('0f14a310-a5ae-4cbe-a857-269b2e80f27c', 'images', '0.17373995114866325.png', NULL, '2024-06-04 12:36:56.575497+00', '2024-06-04 12:36:56.575497+00', '2024-06-04 12:36:56.575497+00', '{"eTag": "\"77d3eb99940784603acd33411700833d\"", "size": 504879, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:36:57.000Z", "contentLength": 504879, "httpStatusCode": 200}', 'df4a0a03-5a8a-4298-9334-23559acc439a', NULL),
	('c1038258-f95e-414e-ac84-c863a688d77e', 'images', '0.14025833640482055.png', NULL, '2024-06-04 12:41:59.773347+00', '2024-06-04 12:41:59.773347+00', '2024-06-04 12:41:59.773347+00', '{"eTag": "\"eb0babcfdd9c5e03ead6b8b0e71843b3\"", "size": 162653, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:42:00.000Z", "contentLength": 162653, "httpStatusCode": 200}', '9889a241-1d9a-4e44-ad5f-c84db6fc9221', NULL),
	('0a421b84-baa3-4d05-916b-19c764f03f8e', 'images', '0.3073494298498419.png', NULL, '2024-06-04 12:42:25.36284+00', '2024-06-04 12:42:25.36284+00', '2024-06-04 12:42:25.36284+00', '{"eTag": "\"eb0babcfdd9c5e03ead6b8b0e71843b3\"", "size": 162653, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T12:42:26.000Z", "contentLength": 162653, "httpStatusCode": 200}', 'd27a9d23-72df-46e5-85b7-3ed78e4ffaaf', NULL),
	('4161b877-8707-4658-9d92-6ba9881bd52a', 'images', '0.21228445662193685.webp', NULL, '2024-06-04 13:03:30.215444+00', '2024-06-04 13:03:30.215444+00', '2024-06-04 13:03:30.215444+00', '{"eTag": "\"fcf112f70cc137a1f7eafe022930f384\"", "size": 10010, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T13:03:31.000Z", "contentLength": 10010, "httpStatusCode": 200}', 'b2bd3e7e-d47f-4987-85f5-786aa84621fd', NULL),
	('09ff4539-6861-47cf-b8bf-e56f8ba562f2', 'images', '0.9295340499855826.webp', NULL, '2024-06-04 13:04:03.224538+00', '2024-06-04 13:04:03.224538+00', '2024-06-04 13:04:03.224538+00', '{"eTag": "\"dce60e8196fe8016d168e90ea7f57abd\"", "size": 91790, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T13:04:04.000Z", "contentLength": 91790, "httpStatusCode": 200}', 'a28c7618-2968-4927-8397-aa120f5441d4', NULL),
	('e5e5b291-2b68-4bc5-99b5-ade1ffd7815d', 'images', '0.7269363572853516.webp', NULL, '2024-06-04 14:25:27.702971+00', '2024-06-04 14:25:27.702971+00', '2024-06-04 14:25:27.702971+00', '{"eTag": "\"dfc1a71582947bf17b13d7ebf729358e\"", "size": 42364, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T14:25:28.000Z", "contentLength": 42364, "httpStatusCode": 200}', '29909543-6de4-4282-8e34-58cdd8045ced', NULL),
	('e9501527-2740-4a70-bece-f143deaf91c8', 'images', '0.8110632498099748.png', NULL, '2024-06-04 14:33:41.130628+00', '2024-06-04 14:33:41.130628+00', '2024-06-04 14:33:41.130628+00', '{"eTag": "\"2d211dc97c6e35cac47fdfff34fa8364\"", "size": 947191, "mimetype": "image/png", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T14:33:41.000Z", "contentLength": 947191, "httpStatusCode": 200}', '860d02ad-0e87-4101-9c15-e11d272ca348', NULL),
	('b5291824-261d-47e1-9b0e-27d2503a5c55', 'images', '0.6297698112674929.webp', NULL, '2024-06-04 14:36:32.484192+00', '2024-06-04 14:36:32.484192+00', '2024-06-04 14:36:32.484192+00', '{"eTag": "\"c8bbde46e9c042ea20da88243b2628bf\"", "size": 290832, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T14:36:33.000Z", "contentLength": 290832, "httpStatusCode": 200}', '8518921c-1ede-47ee-a1a0-9d420963ead3', NULL),
	('6688ec63-35da-40b8-807b-6202ee85baaa', 'images', '0.7107146061425804.webp', NULL, '2024-06-04 14:42:29.029514+00', '2024-06-04 14:42:29.029514+00', '2024-06-04 14:42:29.029514+00', '{"eTag": "\"9063d5e96d2b6ceee99ee21b3e47187e\"", "size": 49340, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2024-06-04T14:42:29.000Z", "contentLength": 49340, "httpStatusCode": 200}', 'd4007411-fb2d-4101-8a92-0d85d1a79dd7', NULL);


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('"pgsodium"."key_key_id_seq"', 1, false);


--
-- Name: donors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."donors_id_seq"', 1, true);


--
-- Name: gift_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."gift_translations_id_seq"', 82, true);


--
-- Name: gifts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."gifts_id_seq"', 53, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."settings_id_seq"', 4, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."transactions_id_seq"', 2, true);


--
-- PostgreSQL database dump complete
--

RESET ALL;
