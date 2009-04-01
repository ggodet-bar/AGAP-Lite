BEGIN TRANSACTION;
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
INSERT INTO "schema_migrations" VALUES('20090316160134');
INSERT INTO "schema_migrations" VALUES('20090316160203');
INSERT INTO "schema_migrations" VALUES('20090316160215');
INSERT INTO "schema_migrations" VALUES('200903160612');
INSERT INTO "schema_migrations" VALUES('200903170839');
INSERT INTO "schema_migrations" VALUES('200903170905');
INSERT INTO "schema_migrations" VALUES('20090317092550');
INSERT INTO "schema_migrations" VALUES('200903171045');
INSERT INTO "schema_migrations" VALUES('20090317092830');
INSERT INTO "schema_migrations" VALUES('200903171114');
INSERT INTO "schema_migrations" VALUES('200903171119');
INSERT INTO "schema_migrations" VALUES('200903171244');
INSERT INTO "schema_migrations" VALUES('20090317114530');
INSERT INTO "schema_migrations" VALUES('20090317132130');
INSERT INTO "schema_migrations" VALUES('20090317140130');
INSERT INTO "schema_migrations" VALUES('20090317142830');
INSERT INTO "schema_migrations" VALUES('200903171714');
INSERT INTO "schema_migrations" VALUES('1');
INSERT INTO "schema_migrations" VALUES('20090318140431');
INSERT INTO "schema_migrations" VALUES('20090318144835');
INSERT INTO "schema_migrations" VALUES('20090318153447');
INSERT INTO "schema_migrations" VALUES('20090319081036');
INSERT INTO "schema_migrations" VALUES('20090319105559');
INSERT INTO "schema_migrations" VALUES('20090319115917');
INSERT INTO "schema_migrations" VALUES('20090320183325');
CREATE TABLE "product_patterns" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "identifier" varchar(255) NOT NULL, "author" varchar(255), "classification" varchar(255), "problem" text, "forces" text, "product_image_id" integer, "product_model_uri" varchar(255), "product_solution" text, "uses" varchar(255), "requires" varchar(255), "alternative" varchar(255), "created_at" datetime, "updated_at" datetime, "name" varchar(255), "pattern_system_id" integer);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('participants',795762450);
INSERT INTO "sqlite_sequence" VALUES('process_patterns',136429225);
INSERT INTO "sqlite_sequence" VALUES('pattern_systems',266847005);
INSERT INTO "sqlite_sequence" VALUES('mappable_images',16);
INSERT INTO "sqlite_sequence" VALUES('use_patterns',136429217);
INSERT INTO "sqlite_sequence" VALUES('maps',45);
CREATE TABLE "maps" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "mappable_image_id" integer, "x_corner" integer, "y_corner" integer, "width" integer, "height" integer, "pattern_id" integer, "created_at" datetime, "updated_at" datetime);
INSERT INTO "maps" VALUES(16,9,414,118,115,69,136429199,'2009-03-21 18:40:37','2009-03-21 18:40:37');
INSERT INTO "maps" VALUES(17,9,189,253,122,73,136429200,'2009-03-21 18:42:19','2009-03-21 18:42:19');
INSERT INTO "maps" VALUES(18,9,253,329,176,73,136429202,'2009-03-21 18:45:19','2009-03-21 18:45:19');
INSERT INTO "maps" VALUES(24,12,28,168,723,43,136429204,'2009-03-22 10:04:56','2009-03-22 10:04:56');
INSERT INTO "maps" VALUES(30,13,33,57,748,44,136429205,'2009-03-22 13:46:58','2009-03-22 13:46:58');
INSERT INTO "maps" VALUES(31,13,36,149,350,38,136429207,'2009-03-22 13:46:58','2009-03-22 13:46:58');
INSERT INTO "maps" VALUES(32,13,35,215,350,38,136429208,'2009-03-22 13:46:58','2009-03-22 13:46:58');
INSERT INTO "maps" VALUES(33,13,714,396,76,29,136429201,'2009-03-22 13:46:58','2009-03-22 13:46:58');
INSERT INTO "maps" VALUES(34,11,299,95,329,41,136429213,'2009-03-22 13:48:16','2009-03-22 13:48:16');
INSERT INTO "maps" VALUES(35,10,22,80,760,45,136429212,'2009-03-22 13:50:38','2009-03-22 13:50:38');
INSERT INTO "maps" VALUES(36,10,447,147,107,34,136429214,'2009-03-22 13:50:38','2009-03-22 13:50:38');
INSERT INTO "maps" VALUES(37,10,436,199,333,44,136429203,'2009-03-22 13:50:38','2009-03-22 13:50:38');
INSERT INTO "maps" VALUES(38,10,429,263,154,35,136429210,'2009-03-22 13:50:38','2009-03-22 13:50:38');
INSERT INTO "maps" VALUES(39,10,226,265,159,34,136429209,'2009-03-22 13:50:38','2009-03-22 13:50:38');
INSERT INTO "maps" VALUES(40,10,212,332,377,41,136429211,'2009-03-22 13:50:38','2009-03-22 13:50:38');
INSERT INTO "maps" VALUES(41,10,22,191,363,43,136429215,'2009-03-22 15:47:37','2009-03-22 15:47:37');
INSERT INTO "maps" VALUES(42,11,320,299,290,45,136429216,'2009-03-22 22:06:11','2009-03-22 22:06:11');
INSERT INTO "maps" VALUES(43,11,347,193,246,40,136429217,'2009-03-22 22:09:54','2009-03-22 22:09:54');
INSERT INTO "maps" VALUES(45,16,30,81,120,30,136429225,'2009-04-01 11:32:34','2009-04-01 11:32:34');
CREATE TABLE "mappable_images" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "filename" varchar(255), "width" integer, "height" integer, "process_pattern_id" integer, "map_id" integer, "created_at" datetime, "updated_at" datetime, "size" integer, "content_type" varchar(255), "thumbnail" varchar(255));
INSERT INTO "mappable_images" VALUES(9,'CycleSymphAugmente.png',800,954,136429198,NULL,'2009-03-20 18:17:56','2009-03-20 18:51:07',201146,'image/png',NULL);
INSERT INTO "mappable_images" VALUES(10,'PhaseSpecOrgaInter.png',800,444,136429202,NULL,'2009-03-20 18:42:54','2009-03-22 13:50:38',103592,'image/png',NULL);
INSERT INTO "mappable_images" VALUES(11,'SpecExternesInteraction.png',800,573,136429203,NULL,'2009-03-20 18:45:16','2009-03-22 13:48:16',145393,'image/png',NULL);
INSERT INTO "mappable_images" VALUES(12,'PhaseEtudePrealable.png',800,444,136429199,NULL,'2009-03-22 09:53:52','2009-03-22 10:04:56',77888,'image/png',NULL);
INSERT INTO "mappable_images" VALUES(13,'PhaseSpecConceptuelle.png',800,491,136429200,NULL,'2009-03-22 11:55:08','2009-03-22 13:46:58',94097,'image/png',NULL);
INSERT INTO "mappable_images" VALUES(14,'Connexion_Spec.png',800,568,136429211,NULL,'2009-03-22 12:37:22','2009-03-22 20:00:31',133939,'image/png',NULL);
INSERT INTO "mappable_images" VALUES(16,'PhaseEtudePrealable.png',800,444,136429224,NULL,'2009-04-01 11:31:32','2009-04-01 11:32:34',77888,'image/png',NULL);
CREATE TABLE "participants" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" text, "created_at" datetime, "updated_at" datetime, "pattern_system_id" integer);
INSERT INTO "participants" VALUES(795762445,'Spécialiste GL','<p>Le sp&eacute;cialiste GL poss&egrave;de des comp&eacute;tences en conception de syst&egrave;mes logiciels. Ces comp&eacute;tences couvrent l''ensemble des domaines techniques li&eacute;s &agrave; la conception et &agrave; l''impl&eacute;mentation d''applications (hors comp&eacute;tences IHM), telles que :</p>
<ul>
<li>la conception de bases de donn&eacute;es,</li>
<li>la description de l''architecture syst&egrave;me,</li>
<li>la conception de l''architecture r&eacute;seau d''un syst&egrave;me distribu&eacute;,</li>
<li>etc.</li>
</ul>','2009-03-20 18:12:07','2009-03-20 18:12:07',266846998);
INSERT INTO "participants" VALUES(795762446,'Spécialiste IHM','<p>Le sp&eacute;cialiste IHM est un informaticien sp&eacute;cialis&eacute; dans la <strong>conception d''interfaces homme-machine</strong>, du point de vue logiciel. Il poss&egrave;de des notions en <strong>ergonomie logicielle</strong> (utilisabilit&eacute;).</p>','2009-03-20 18:12:30','2009-03-20 18:12:30',266846998);
INSERT INTO "participants" VALUES(795762447,'Ergonome','<p>L''ergonome dispose de comp&eacute;tences en psychologie sociale, anthropologie ou sociologie. Il ne fait pas appel &agrave; des connaissances "fondamentales" en informatique, mais axe sa pratique sur l''&eacute;valuation et le conseil en interaction homme-machine.</p>','2009-03-20 18:12:45','2009-03-20 18:12:45',266846998);
INSERT INTO "participants" VALUES(795762448,'Expert métier','<p>L''expert m&eacute;tier est un r&eacute;f&eacute;rent de l''&eacute;quipe de d&eacute;veloppement pour tout ce qui concerne le m&eacute;tier &agrave; informatiser. &Agrave; ce titre, il peut appartenir &agrave; l''organisation qui commande le logiciel, bien que son r&ocirc;le ne soit pas celui de "client" (qu''il est pr&eacute;f&eacute;rable de distinguer).</p>','2009-03-20 18:13:03','2009-03-20 18:13:03',266846998);
INSERT INTO "participants" VALUES(795762450,'Un acteur quelconque','<p>En fait, un commentaire pertinent</p>','2009-04-01 11:29:04','2009-04-01 11:29:15',266847005);
CREATE TABLE "process_patterns" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "author" varchar(255), "classification" varchar(255), "processContext" varchar(255), "productContext" varchar(255), "problem" text, "forces" text, "process_model_uri" varchar(255), "process_solution" text, "product_solution" text, "uses" varchar(255), "requires" varchar(255), "alternative" varchar(255), "created_at" datetime, "updated_at" datetime, "name" varchar(255), "pattern_system_id" integer, "application_case" text, "application_consequence" text);
INSERT INTO "process_patterns" VALUES(70140977,'Bob Le Poulpe','Regarder en l''air et penser au week-end',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-03-20 18:01:21','2009-03-20 18:01:21',NULL,0,NULL,NULL);
INSERT INTO "process_patterns" VALUES(105961208,'Bob Le Poulpe','Rien fiche',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-03-20 18:01:21','2009-03-20 18:01:21',NULL,0,NULL,NULL);
INSERT INTO "process_patterns" VALUES(136429197,'Bob Le Poulpe','Farniente',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-03-20 18:01:21','2009-03-20 18:01:21',NULL,0,NULL,NULL);
INSERT INTO "process_patterns" VALUES(136429198,'Guillaume Godet-Bar, David Juras','<p>D&eacute;marche de d&eacute;veloppement</p>',NULL,'','<p>On veut d&eacute;velopper un syst&egrave;me interactif.</p>','<ul>
<li>Propose un cadre de conception adapt&eacute; aux probl&eacute;matiques de conception complexes (situations de mobilit&eacute;, par exemple)</li>
<li>Permet d''envisager des interactions riches</li>
</ul>',NULL,'','',NULL,NULL,NULL,'2009-03-20 18:15:00','2009-03-20 18:17:56','Cycle de développement Symphony Augmentée',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>On prendra comme cas d''&eacute;tude la <strong>r&eacute;alisation d''un &eacute;tat des lieux</strong> par un expert commissionn&eacute; par une agence immobilii&egrave;re.</p>
<p>En effet, cette t&acirc;che peut &ecirc;tre longue autant que fastidieuse : l''expert doit parcourir le logement, qualifier les dommages en termes de leur nature, localisation et &eacute;tendue, &agrave; chaque fois qu''un locataire s''y installe ou le quitte.</p>
<p>La plupart du temps, cette t&acirc;che est r&eacute;alis&eacute;e sur papier, &eacute;ventuellement sur un assistant de poche (PDA) &agrave; l''aide de formulaires &eacute;lectroniques. D''autre part, il est courant qu''un expert doive &eacute;valuer l''&eacute;volution d''un logement &agrave; partir de notes prises par un coll&egrave;gue. Celles-ci peuvent &ecirc;tre incompl&egrave;tes ou trop peu pr&eacute;cises.</p>
<p>Par cons&eacute;quent, identifier les responsabilit&eacute;s pour un dommage constitue un autre point laborieux de la r&eacute;alisation d''un &eacute;tat des lieux. Des contentieux opposent r&eacute;guli&egrave;rement propri&eacute;taire, locataires et agence immobili&egrave;re.</p>
<p>Afin de r&eacute;soudre ces probl&egrave;mes, une solution serait d''am&eacute;liorer l''informatisation du processus de r&eacute;alisation d''un &eacute;tat des lieux. Il est notablement indispensable de fournir des moyens de caract&eacute;risation des dommages plus adapt&eacute;s, ainsi que d''am&eacute;liorer l''int&eacute;gration des donn&eacute;es issues de ce processus avec la base de donn&eacute;es de l''agence immobili&egrave;re, afin d''apporter plus de valeur &agrave; cette activit&eacute;.</p>','');
INSERT INTO "process_patterns" VALUES(136429199,'David Juras, Guillaume Godet-Bar ','<p>Phase</p>',NULL,'','<p>On cherche &agrave; comprendre et structurer le m&eacute;tier, mais aussi &agrave; positionner l''interface homme-machine (IHM) et/ou le syst&egrave;me d''information (SI) &agrave; d&eacute;velopper parmi les sous-ensembles fonctionnels identifi&eacute;s.</p>','<p>Une approche m&eacute;tier en amont du projet permettant :</p>
<ul>
<li>une prise en compte coh&eacute;rente et logique des objectifs et pratiques de chaque sp&eacute;cialit&eacute;, dans le cadre d''une d&eacute;marche m&eacute;tier favorisant:     
<ul>
<li> <span style="white-space: pre;"> </span>la d&eacute;finition d''un r&eacute;f&eacute;rentiel commun de caract&eacute;risation et de compr&eacute;hension du m&eacute;tier,</li>
<li> <span style="white-space: pre;"> </span>la capitalisation du savoir et savoir-faire m&eacute;tier mis en oeuvre,</li>
<li> <span style="white-space: pre;"> </span>sa r&eacute;utilisation ult&eacute;rieure au travers d''objets m&eacute;tier,</li>
</ul>
</li>
</ul>
<ul>
<li>la d&eacute;finition d''un fil conducteur et d''une organisation des it&eacute;rations de d&eacute;veloppement,</li>
<li>l''identification des probl&egrave;mes d''ergonomie logicielle (utilisabilit&eacute;) et/ou fonctionnelle.</li>
</ul>',NULL,'<p>La phase est volontairement plac&eacute;e &agrave; un haut niveau d''abstraction m&eacute;tier et s''appuie sur les activit&eacute;s suivantes :</p>
<ul>
<li> <strong>Le recueil des besoins</strong>, qui permet l''extraction des besoins et des exigences m&eacute;tier des utilisateurs &agrave; partir du cahier des charges (CDC),</li>
<li> <strong>Le d&eacute;coupage fonctionnel du m&eacute;tier</strong>, qui aboutit &agrave; l''identification des fonctions et/ou objectifs principaux du m&eacute;tier, appel&eacute;s processus m&eacute;tier (PM), ainsi qu''&agrave; l''identification des acteurs externes et internes (utilisateurs) du syst&egrave;me,</li>
<li> <strong>L''identification des concepts</strong>, qui permet de d&eacute;finir clairement les concepts manipul&eacute;s par le m&eacute;tier (&agrave; travers ses processus m&eacute;tier) et de proposer une base pour un r&eacute;f&eacute;rentiel commun de compr&eacute;hension et de communication entre sp&eacute;cialit&eacute;s,</li>
<li> <strong>La priorisation des processus m&eacute;tier</strong>, o&ugrave; l''ensemble de l''&eacute;quipe de d&eacute;veloppement va &eacute;valuer la complexit&eacute; de d&eacute;veloppement ainsi que les risques associ&eacute;s, pour chaque processus m&eacute;tier. D''autre part, l''&eacute;quipe de d&eacute;veloppement doit d&eacute;terminer les processus m&eacute;tier dont le d&eacute;veloppement apportera le plus de valeur &agrave; l''organisation. &Agrave; l''issue de cette &eacute;valuation, une priorit&eacute; de d&eacute;veloppement doit &ecirc;tre associ&eacute;e &agrave; chaque processus m&eacute;tier,</li>
<li> <strong>L''identification des probl&egrave;mes d''ergonomie</strong>&nbsp;dans la pratique actuelle du m&eacute;tier, au niveau logiciel (outils non adapt&eacute;s) ou au niveau fonctionnel (mauvaise utilisation des outils et identification des activit&eacute;s complexes du processus m&eacute;tier). Cette activit&eacute; doit notamment permettre des points cl&eacute; de valorisation pour l''organisation.</li>
</ul>
<p>&Agrave; l''issue de cette phase, l''&eacute;quipe de d&eacute;veloppement doit donc avoir s&eacute;lectionn&eacute; un premier processus m&eacute;tier qu''elle entreprendra de d&eacute;velopper. Pour cette raison, la phase suivante de <em>sp&eacute;cification conceptuelle des besoins </em>d&eacute;crit la <strong>d&eacute;marche de d&eacute;veloppement sur un seul processus m&eacute;tier</strong>.</p>','<ul>
<li>Un <strong>d</strong><strong>ossier d''&eacute;tude pr&eacute;alable</strong>, dans lequel le sous-ensemble du m&eacute;tier &agrave; informatiser sera d&eacute;coup&eacute; en fonction des <strong>processus m&eacute;tier identifi&eacute;s</strong>.</li>
<li>Une <strong>priorisation des processus m&eacute;tier</strong>, en fonction des risques de d&eacute;veloppement ainsi que de la valeur apport&eacute;e &agrave; l''organisation.</li>
<li>Un <strong>glossaire</strong>&nbsp;des termes sp&eacute;cifiques au m&eacute;tier.</li>
<li>Un <strong>dossier de prescription ergonomiques</strong>, reprenant l''analyse de l''ergonome.</li>
</ul>',NULL,NULL,NULL,'2009-03-20 18:37:02','2009-03-22 10:04:56','Phase d''étude préalable',266846998,'<p><strong>Recueil des besoins</strong></p>
<p>L''agence immobili&egrave;re souligne son besoin de simplifier la r&eacute;alisation de l''&eacute;tat des lieux.</p>
<p>&nbsp;</p>
<p><strong>Priorisation</strong></p>
<p>Dans le cadre de cette &eacute;tude, nous nous concentrerons sur la r&eacute;alisation de l''&eacute;tat des lieux, qui constitue le processus m&eacute;tier le plus valorisant pour l''organisation (c''est-&agrave;-dire, l''agence immobili&egrave;re).</p>
<p>&nbsp;</p>
<p><strong>Glossaire</strong></p>
<p>Quant au glossaire, celui-ci ne contient aucun terme sp&eacute;cifique.</p>','');
INSERT INTO "process_patterns" VALUES(136429200,'David Juras, Guillaume Godet-Bar ','<p>Phase</p>',NULL,'','<p>Cette phase de mod&eacute;lisation des besoins a pour objectif l''identification des finalit&eacute;s de chaque processus m&eacute;tier. Il s''agit de d&eacute;crire le "Quoi", de se focaliser sur les objectifs et contraintes de chaque processus li&eacute; aux acteurs externes en faisant abstraction des contraintes d''organisation et des acteurs internes au processus.</p>','<ul>
<li>Une description conceptuelle et formelle des processus m&eacute;tier identifi&eacute;s en prenant en compte les apports de chaque sp&eacute;cialit&eacute; des acteurs du d&eacute;veloppement,</li>
<li>La d&eacute;couverte d''objectifs non encore d&eacute;tect&eacute;s,</li>
<li>Une d&eacute;composition plus fine du m&eacute;tier, facilitant ainsi le d&eacute;veloppement de sous-syst&egrave;mes m&eacute;tier.</li>
</ul>',NULL,'<p>On cherche principalement ici &agrave; affiner le d&eacute;coupage du m&eacute;tier en <strong>processus m&eacute;tier composant</strong> (PMC), ainsi qu''&agrave; d&eacute;finir le type d''interface &agrave; d&eacute;velopper pour chaque PMC, en fonction de <strong>prescriptions d''ergonomie</strong>.</p>
<p>Cette phase se base sur les activit&eacute;s suivantes :</p>
<p>&nbsp;</p>
<p><strong>Description conceptuelle du processus m&eacute;tier</strong></p>
<p>Consiste &agrave; pr&eacute;ciser les relations entre les acteurs dits "externes" et le processus m&eacute;tier, au travers de :</p>
<ul>
<li>Un sc&eacute;nario "principal" ou "nominal",</li>
<li>Un diagramme de s&eacute;quences UML bas&eacute; sur ce sc&eacute;nario.</li>
</ul>
<p>&nbsp;</p>
<p><strong>D&eacute;composition du processus m&eacute;tier composant<br /></strong></p>
<p>Consiste &agrave; raffiner la d&eacute;composition du m&eacute;tier en descendant &agrave; un niveau de granularit&eacute; proche de la t&acirc;che utilisateur, en appliquant la m&ecirc;me approche que pour la description conceptuelle du processus m&eacute;tier, cette fois en impliquant les acteurs internes. Il s''agit donc de d&eacute;crire des sc&eacute;narii nominaux et alternatifs, ainsi que des diagrammes de s&eacute;quences,</p>
<p>&nbsp;</p>
<p><strong>Identification des processus m&eacute;tier composant (PMC)</strong></p>
<p>On r&eacute;partit les &eacute;changes entre acteur(s) interne(s) et processus m&eacute;tier en processus m&eacute;tier composant.</p>
<p>&nbsp;</p>
<p><strong>Affectation de priorit&eacute;s aux PMC</strong></p>
<p>De m&ecirc;me que pour les processus m&eacute;tier de haut niveau, il s''agit de prioriser le d&eacute;veloppement des processus m&eacute;tier composant, toujours en fonction de la valeur apport&eacute;e &agrave; l''organisation et du risque associ&eacute; au d&eacute;veloppement</p>
<p>&nbsp;</p>
<p><strong>S&eacute;lection du panel repr&eacute;sentatif d''utilisateurs</strong></p>
<p>Consiste &agrave; identifier les utilisateurs qui seront sujets pour les &eacute;valuations d''ergonomie des phases suivantes.</p>
<p>&nbsp;</p>
<p><strong>Identifier le type d''interaction</strong></p>
<p>&Agrave; partir des pr&eacute;conisations ergonomiques et des descriptions du processus m&eacute;tier ainsi que des processus m&eacute;tier composant, l''ergonome d&eacute;termine le type d''interaction le plus adapt&eacute; au contexte (utilisateurs, environnement, contraintes etc.).</p>','',NULL,NULL,NULL,'2009-03-20 18:38:56','2009-03-20 18:38:56','Phase de spécification conceptuelle des besoins',266846998,'','');
INSERT INTO "process_patterns" VALUES(136429201,'David Juras, Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>D&eacute;terminer quelle type d''interaction serait la plus adapt&eacute;e, en fonction du contexte et des processus m&eacute;tier composants identifi&eacute;s.</p>','<ul>
<li>D&eacute;clenche la conception de l''interaction homme-machine en amont du processus de d&eacute;veloppement global,</li>
<li>Permet d''envisager des interfaces plus efficaces et plus cr&eacute;atives.</li>
</ul>',NULL,'<p>&Agrave; partir des pr&eacute;conisations ergonomiques &eacute;labor&eacute;es lors de l''&eacute;tude pr&eacute;alable ainsi que des processus m&eacute;tier composant, l''ergonome d&eacute;termine quel type d''interaction serait la plus adapt&eacute;e pour r&eacute;aliser l''ensemble du processus m&eacute;tier. On entend par type d''interaction le type d''interface homme-machine et le paradigme d''interaction, parmi la classification classique suivante :</p>
<ul>
<li>Interfaces en ligne de commande,</li>
<li>Interfaces bas&eacute;es sur les formulaires et le tryptique clavier-&eacute;cran-souris,</li>
<li>Interfaces graphiques hors formulaires, toujours bas&eacute;es sur clavier, &eacute;cran et souris,</li>
<li>Interfaces multimodales sur station de travail, utilisant par exemple la voix ou le geste,</li>
<li>Interfaces multimodales hors station de travail, qui comprennent :    
<ul>
<li>les interfaces sur surface tactile : table digitale par exemple,</li>
<li>les interfaces mobiles, bas&eacute;es sur les dispositifs mobiles tels que t&eacute;l&eacute;phones portables, smartphones, PDAs. &Agrave; noter que, bien que mobiles, ces interfaces peuvent utiliser des formulaires ou des approches type ligne de commande, aussi bien que des interfaces plus cr&eacute;atives,</li>
<li>les interfaces de r&eacute;alit&eacute; mixte,</li>
<li>les interfaces en r&eacute;alit&eacute; virtuelle</li>
</ul>
</li>
</ul>
<p>Bien s&ucirc;r, la classification ci-dessus n''est pas absolu : d''autres cat&eacute;gories d''interfaces peuvent &ecirc;tre propos&eacute;es, ou bien des combinaisons parmi cette classification peuvent &ecirc;tre envisag&eacute;es.</p>
<p>Toutefois, il est indispensable que le choix d''interaction soit justifi&eacute; par l''apport de valeurs distinctives pour les acteurs principaux internes (c''est-&agrave;-dire, les utilisateurs manipulant le syst&egrave;me) et/ou pour les acteurs principaux externes. Ces apports doivent &ecirc;tre clairement pr&eacute;sent&eacute;s &agrave; l''organisation, &agrave; qui il est indispensable de signaler &eacute;galement le risque associ&eacute; au d&eacute;veloppement d''interfaces complexes telles que les interfaces de r&eacute;alit&eacute; mixte ou de r&eacute;alit&eacute; virtuelle.</p>','',NULL,NULL,NULL,'2009-03-20 18:40:21','2009-03-22 10:06:40','Identifier le type d''interaction',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux<br /></strong></p>
<p>Consid&eacute;rant notre cas d''&eacute;tude, le sous-syst&egrave;me correspondant au processus m&eacute;tier "R&eacute;aliser un &eacute;tat des lieux" est un bon candidat pour une interaction en r&eacute;alit&eacute; mixte. En effet, on a identifi&eacute; les contraintes suivantes :</p>
<ul>
<li>La r&eacute;alisation d''un &eacute;tat des lieux est une situation de mobilit&eacute; typique, dans laquelle l''utilisateur (ici, l''expert) ne peut utiliser d''ordinateur de bureau pendant la r&eacute;alisation de l''activiti&eacute;,</li>
<li>Les descriptions textuelles sont &agrave; la fois impr&eacute;cises et laborieuses, en particulier pour la description de l''&eacute;volution spaciale et temporelle des dommages,</li>
<li>Plusieurs activit&eacute;s manuelles sont n&eacute;cessaires pour d&eacute;crire exhaustivement les dommages, par ex., prendre des mesures, des photographies, etc.</li>
<li>Les donn&eacute;s acquises pendant l''&eacute;tat des lieux ne peuvent &ecirc;tre directement entr&eacute;es dans le syst&egrave;me d''information (sauf si l''utilisateur utilise un dispositif sans fil),</li>
<li>Les dispositifs sans fil classiques (PDA, smartphones etc.) ne permettent actuellement que des approches textuelles limit&eacute;es</li>
</ul>','');
INSERT INTO "process_patterns" VALUES(136429202,'Guillaume Godet-Bar, David Juras','<p>Phase</p>',NULL,'','<p>Cette phase a pour objectif de d&eacute;crire le "Qui fait quoi et quand", de l''analyser et d''envisager une interaction satisfaisante pour le r&eacute;aliser.</p>','<ul>
<li>Mise en &eacute;vidence des cas d''utilisation et proposition d''une cartographie d''Objets M&eacute;tier (OM) et d''Objets Interactionnels (OI), favorisant &agrave; terme la r&eacute;utilisation ainsi que la g&eacute;n&eacute;ration automatique d''&eacute;l&eacute;ments du syst&egrave;me.</li>
</ul>',NULL,'<p>Cette phase est certainement la plus riche de la d&eacute;marche Symphony. Elle repose sur les activit&eacute;s suivantes :</p>
<p>&nbsp;</p>
<p><strong>D&eacute;composition organisationnelle des PMC (processus m&eacute;tier composant)</strong></p>
<p>Cette activit&eacute; permet de d&eacute;terminer les processus m&eacute;tier composant &agrave; informatiser et les processus m&eacute;tier composant manuels.</p>
<p><strong>IMPORTANT</strong> : &Agrave; l''issue de cette phase, le d&eacute;veloppement se scinde entre groupes de d&eacute;veloppement GL et groupes de d&eacute;veloppement IHM. Les groupes &eacute;laborent pour le reste de la phase leur propre vision du syst&egrave;me, qui sera r&eacute;solue lors de l''activit&eacute; de <strong>Connexion des espaces m&eacute;tier et interactionnel</strong>.</p>
<p>&nbsp;</p>
<p><strong>Description des mod&egrave;les de t&acirc;ches</strong></p>
<p>Activit&eacute; optionnelle permettant de clarifier les interactions des acteurs internes avec le syst&egrave;me.</p>
<p>&nbsp;</p>
<p><strong>Sp&eacute;cifications externes de l''interaction</strong></p>
<p>&Eacute;laboration de l''interface homme-machine.</p>
<p>&nbsp;</p>
<p><strong>Description de la cartographie des Objets M&eacute;tier</strong></p>
<p>Consiste en une structuration des concepts du m&eacute;tier (Objets M&eacute;tier Entit&eacute;) et processus (Objets M&eacute;tier Processus), mis en relation et structur&eacute;s.</p>
<p>&nbsp;</p>
<p><strong>Description de la cartographie des Objets Interactionnels</strong></p>
<p>Consiste en une structuration des concepts interactionnels (Objets Interactionnels Entit&eacute;) et processus (Objets Interactionnels Processus), mis en relation et structur&eacute;s.</p>
<p>&nbsp;</p>
<p><strong>Connexion des espaces m&eacute;tier et interactionnel</strong></p>
<p>Cette activit&eacute; tente de concilier les visions m&eacute;tier et interactionnelle du futur syst&egrave;me, en se basant sur un mod&egrave;le de connexion des Objets M&eacute;tier et des Objets Interactionnels.</p>','',NULL,NULL,NULL,'2009-03-20 18:42:10','2009-03-22 17:49:35','Phase de spécification organisationnelle et interactionnelle des besoins',266846998,'','');
INSERT INTO "process_patterns" VALUES(136429203,'Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On cherche &agrave; sp&eacute;cifier l&rsquo;interaction qui va permettre de r&eacute;aliser les besoins des acteurs (utilisateurs) dans le cadre du nouveau syst&egrave;me.</p>','<ul>
<li>Reprend le processus &laquo; classique &raquo; de conception des interfaces homme-machine, l&rsquo;int&egrave;gre dans une d&eacute;marche de d&eacute;veloppement GL et l&rsquo;adapte aux syst&egrave;mes mixtes,</li>
<li>Met en &eacute;vidence l&rsquo;ensemble des concepts interactionnels manipul&eacute;s et visualis&eacute;s par l&rsquo;utilisateur, ainsi que les modes et techniques d&rsquo;interaction associ&eacute;s,</li>
<li>Int&egrave;gre la validation ergonomique de l&rsquo;interface homme-machine, &agrave; partir de scenarii consensuels,</li>
<li>Int&egrave;gre le cycle de d&eacute;veloppement centr&eacute; utilisateur tel que d&eacute;crit par ISO 13407.</li>
</ul>',NULL,'<p><strong>&Eacute;laboration des scenarii projet&eacute;s abstraits de l&rsquo;interaction</strong></p>
<p>Permet de d&eacute;crire les &eacute;changes entre les utilisateurs (acteurs internes) et le syst&egrave;me selon une approche abstraite, orient&eacute;e interaction homme-machine.</p>
<p>&nbsp;</p>
<p><strong>Description des artefacts interactionnels</strong></p>
<p>Il s&rsquo;agit pour cette activit&eacute; d&rsquo;identifier les concepts faisant sens du point de vue de l&rsquo;interaction personne-syst&egrave;me. &Agrave; partir des <strong>scenarii projet&eacute;s abstraits de l&rsquo;interaction</strong>, le concepteur identifie les concepts manipul&eacute;s par l&rsquo;utilisateur et envisage leur repr&eacute;sentation. Dans la mesure o&ugrave; cette activit&eacute; est &eacute;troitement li&eacute;e aux techniques d&rsquo;interaction adopt&eacute;es, il est &eacute;galement n&eacute;cessaire pour le concepteur d&rsquo;envisager l&rsquo;int&eacute;gration d&rsquo;artefacts interactionnels &laquo; outils &raquo; servant &agrave; leur mise en &oelig;uvre.</p>
<p>Quant aux concepts trop peu coh&eacute;rents pour &ecirc;tre repr&eacute;sent&eacute;s sous forme d&rsquo;une entit&eacute;, ils pourront &ecirc;tre int&eacute;gr&eacute;s &agrave; des formulaires d&rsquo;information, sous des formes plus classiques d&rsquo;interaction. Il est d&rsquo;ailleurs recommand&eacute; d&rsquo;envisager un processus de construction &laquo; par les espaces de travail &raquo; pour tous les &eacute;l&eacute;ments de l&rsquo;interface homme-machine regroup&eacute;s sous des formulaires ou interfaces classiques.</p>
<p>&nbsp;</p>
<p><strong>Description des techniques d&rsquo;interaction</strong></p>
<p>Il s&rsquo;agit de documenter les diff&eacute;rents moyens d&rsquo;interaction avec le syst&egrave;me, d&rsquo;un point de vue dynamique. Cette sp&eacute;cification doit &ecirc;tre suffisamment explicite pour permettre, lors de la phase d&rsquo;analyse, d&rsquo;identifier les services que devront proposer les Objets Interactionnels en fonction des techniques d&rsquo;interaction choisies.</p>
<p>En fonction de l&rsquo;importance et du nombre des artefacts interactionnels envisag&eacute;s, on &eacute;tablit les grandes classes de modalit&eacute;s les plus adapt&eacute;es &agrave; leur rendu et leur manipulation (par exemple, r&eacute;partition sur les sens humains). Cette description pourra &ecirc;tre pond&eacute;r&eacute;e, le cas &eacute;ch&eacute;ant, par les contraintes sur les classes de support pour l&rsquo;interaction.</p>
<p>Nous renvoyons le lecteur aux diff&eacute;rents syst&egrave;mes de patrons destin&eacute;s &agrave; la description des techniques d&rsquo;interaction pour les Syst&egrave;mes de R&eacute;alit&eacute; Mixtes, la multimodalit&eacute; etc.</p>
<p>&nbsp;</p>
<p><strong>Choix des classes de support pour l&rsquo;interaction</strong></p>
<p>Lorsque le type d''interaction choisie implique des dispositifs diff&eacute;rents des classiques "clavier-&eacute;cran-souris", ce patron permet d''identifier plus ais&eacute;ment les classes de dispositifs adapt&eacute;es aux artefacts interactionnels et techniques d''interactions &eacute;labor&eacute;s au cours de cette activit&eacute;.</p>
<p>&nbsp;</p>
<p><strong>Prototypage de l&rsquo;interface graphique</strong></p>
<p>Tout au long des activit&eacute;s de construction du &laquo; Dossier de l&rsquo;interaction &raquo;, il est recommand&eacute; de construire des prototypes logiciel (pr&eacute;sentations, &eacute;bauches d&rsquo;interface homme-machine) mettant en &oelig;uvre les diff&eacute;rents produits &eacute;labor&eacute;s au cours des diff&eacute;rentes activit&eacute;s de la <strong>sp&eacute;cification externe de l&rsquo;interaction</strong>. Au-del&agrave; de l&rsquo;avantage de l&rsquo;exploration des solutions de conception, les prototypes permettront &agrave; l&rsquo;ergonome de mener des tests utilisateur de validation des sp&eacute;cifications externes.</p>
<p>Il est &agrave; noter que, bien qu&rsquo;aucune collaboration entre sp&eacute;cialistes fonctionnels et sp&eacute;cialistes techniques ne soit explicitement d&eacute;crite, cette activit&eacute; constitue &eacute;galement une occasion de mettre en &oelig;uvre les technologies pressenties pour le syst&egrave;me final.</p>
<p>&nbsp;</p>
<p><strong>&Eacute;laboration des scenarii projet&eacute;s concrets de l&rsquo;interaction</strong></p>
<p>Permet aux ergonomes et sp&eacute;cialistes IHM de r&eacute;sumer l''ensemble de leurs contributions de sp&eacute;cification externe de l''interaction au sein de scenarii d&eacute;crivant l''utilisation concr&egrave;te du futur syst&egrave;me.</p>
<p>&nbsp;</p>
<p><strong>&Eacute;laboration des guides de style de l&rsquo;application</strong><br />&Agrave; partir des premiers &eacute;l&eacute;ments de conception de l&rsquo;interaction, l&rsquo;ergonome rassemble un ensemble de recommandations et de r&egrave;gles portant sur l&rsquo;apparence g&eacute;n&eacute;rale de l&rsquo;interface homme-machine. On se concentrera sur les points suivants :</p>
<ul>
<li>Description de la charte graphique du projet : il s&rsquo;agit de d&eacute;crire les codes de couleur employ&eacute;s ainsi que leurs d&eacute;clinaisons, les polices de caract&egrave;re, &eacute;ventuellement les logos associ&eacute;s au projet,</li>
<li>Description des registres de langage utilis&eacute;s lors des dialogues avec l&rsquo;utilisateur, des modalit&eacute;s associ&eacute;es aux diff&eacute;rents types de dialogues (alerte, information etc.),</li>
<li>Rappel &eacute;ventuel des r&egrave;gles de style associ&eacute;es aux variations culturelles, aux usages informatiques (r&egrave;gles d&rsquo;homog&eacute;n&eacute;it&eacute; et de coh&eacute;rence)&hellip;</li>
</ul>
<p><br /><strong>Pr&eacute;paration des tests utilisateur [Bo&icirc;te noire]</strong><br />Ayant &agrave; sa disposition le &laquo; Dossier de l&rsquo;interaction &raquo;, la &laquo; Maquette &raquo; de l&rsquo;application ainsi que les descriptions des Processus M&eacute;tier, l&rsquo;ergonome &eacute;labore les tests utilisateurs qui permettront la validation des produits &eacute;tablis lors des &laquo; Sp&eacute;cifications externes de l&rsquo;interaction &raquo;. Ces tests consistent essentiellement en un ensemble des scenarii que devront suivre les utilisateurs finaux, ainsi qu&rsquo;en des discussions d&rsquo;&eacute;valuation et de conception participative.</p>
<p><br /><br /><strong>Validation des sp&eacute;cifications externes de l&rsquo;interaction [Bo&icirc;te noire]</strong><br />Cette activit&eacute; consiste, pour l&rsquo;ergonome, &agrave; r&eacute;unir un panel d&rsquo;utilisateurs finaux en vue de leur faire r&eacute;aliser les tests mentionn&eacute;s ci-dessus. &Agrave; l&rsquo;issue de ces tests, l&rsquo;ergonome doit diagnostiquer l&rsquo;utilisabilit&eacute;, et plus largement la qualit&eacute; d&rsquo;usage ainsi que la valeur d&rsquo;usage du produit dans son &eacute;tat actuel. Une remise en cause de ces crit&egrave;res peut impacter jusqu&rsquo;aux scenarii projet&eacute;s abstraits, mais plus g&eacute;n&eacute;ralement il s&rsquo;agira de reprendre les activit&eacute;s de construction du <strong>dossier de l&rsquo;interaction</strong> remises en cause lors des tests.</p>
<p>Le cas &eacute;ch&eacute;ant, il est recommand&eacute; de mettre &agrave; jour les <strong>scenarii projet&eacute;s concrets de l&rsquo;interaction</strong>, afin de permettre &agrave; l&rsquo;ergonome d&rsquo;&eacute;laborer de nouveaux tests utilisateurs.</p>','<p>L''ensemble des produits de cette activit&eacute; sont regroup&eacute;s au sein d''un <strong>dossier de l''interaction</strong> (voir repr&eacute;sentation de l''activit&eacute;, plus haut). Ce dossier sera principalement utilis&eacute; par les ergonomes afin de construire des test d''utilisabilit&eacute;s adapt&eacute;s.</p>',NULL,NULL,NULL,'2009-03-20 18:45:15','2009-03-23 09:16:46','Spécification externe de l''interaction',266846998,'','');
INSERT INTO "process_patterns" VALUES(136429204,'David Juras, Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On cherche &agrave; <strong>d&eacute;composer le m&eacute;tier</strong> en sous-ensembles coh&eacute;rents appel&eacute;s processus m&eacute;tier (PM), et &agrave; <strong>identifier et</strong> <strong>caract&eacute;riser les acteurs</strong> intervenants dans ces processus.</p>','<ul>
<li>Une structuration globale du m&eacute;tier permettant d''organiser les it&eacute;rations de d&eacute;veloppement, ainsi que d''avoir une organisation intuitive des concepts m&eacute;tier (plus tard raffin&eacute;s en Objets M&eacute;tier)</li>
<li>Une &eacute;bauche du r&eacute;f&eacute;rentiel des utilisateurs du syst&egrave;me</li>
</ul>',NULL,'<p><strong>Identification des processus m&eacute;tier</strong></p>
<p>L''expert m&eacute;tier d&eacute;termine les processus m&eacute;tier, selon la logique suivante :</p>
<ol>
<li> <em>Un processus m&eacute;tier r&eacute;pond &agrave; l''un des besoins essentiels de l''organisation</em>,</li>
<li><em>Un processus m&eacute;tier est d&eacute;clench&eacute; par un acteur externe (voir plus bas) et est conclut par le retour d''une donn&eacute;e,</em></li>
<li><em>Un processus m&eacute;tier doit pouvoir &ecirc;tre d&eacute;velopp&eacute; int&eacute;gralement (c''est-&agrave;-dire qu''un logiciel fonctionnel doit pouvoir &ecirc;tre d&eacute;livr&eacute;) en un <strong>macro cycle</strong> de d&eacute;veloppement.</em></li>
</ol>
<p><em><br /></em></p>
<p><strong>Description des processus m&eacute;tier en langage naturel</strong></p>
<p>Les processus m&eacute;tier sont d&eacute;crits en langage naturel, de mani&egrave;re &agrave; &ecirc;tre compr&eacute;hensibles par l''ensemble de l''&eacute;quipe de d&eacute;veloppement, ainsi que par l''organisation (&agrave; des fins de validation des processus m&eacute;tier : voir ci-dessous). &Agrave; ce niveau de description, <strong>aucune r&eacute;f&eacute;rence ne doit &ecirc;tre faite</strong> quant aux solutions envisag&eacute;es pour informatiser le processus m&eacute;tier.</p>
<p>&nbsp;</p>
<p><strong>Identification des acteurs des processus m&eacute;tier</strong></p>
<p>L''identification des acteurs remplit deux fonctions :</p>
<ul>
<li>D''une part, elle permet &agrave; l''<strong>ergonome</strong> d''&eacute;baucher son <strong>R&eacute;f&eacute;rentiel des utilisateurs</strong>,</li>
<li>D''autre part, elle permet d''identifier les diff&eacute;rents acteurs qui seront soit utilisateurs directs du syst&egrave;me, soit interviennent indirectement sur celui-ci.</li>
</ul>
<p>&nbsp;</p>
<p><strong>Validation des processus m&eacute;tier</strong></p>
<p>Le <strong>responsable m&eacute;tier</strong> s''appuie sur sa connaissance du m&eacute;tier et sur l''opinion de l''organisation (obtenue lors d''interviews, par ex.) pour v&eacute;rifier que la description du m&eacute;tier est conforme &agrave; son exp&eacute;rience.</p>','<p>Cette activit&eacute; collaborative aboutit &agrave; un <strong>Dossier des processus m&eacute;tier</strong>, qui sera enrichi au fil des activit&eacute;s. Celui comportera au final toutes les informations propres au m&eacute;tier (description des processus m&eacute;tier, sc&eacute;narios associ&eacute;s et classification des acteurs). &Agrave; ce niveau du d&eacute;veloppement, ce dossier ne comperte que la <strong>description des processus m&eacute;tier</strong>.</p>
<p>&nbsp;</p>
<p>L''activit&eacute; produit &eacute;galement un <strong>Dossier des profils utilisateur</strong>, &agrave; l''&eacute;tat d''&eacute;bauche.</p>',NULL,NULL,NULL,'2009-03-20 18:47:15','2009-03-20 21:52:47','Découpage fonctionnel du métier',266846998,'<p>La r&eacute;alisation d''un &eacute;tat des lieux englobe diff&eacute;rentes "phases", certaines ayant lieu tr&egrave;s en amont de l''arriv&eacute;e de l''expert dans le logement, d''autres plus en aval :</p>
<ul>
<li><strong><span style="font-weight: normal;"><strong>R&eacute;cup&eacute;rer le dernier &eacute;tat des lieux enregistr&eacute; ainsi que les donn&eacute;es li&eacute;es au logement</strong>&nbsp;(coordonn&eacute;es du propri&eacute;taire et des locataires, surface habitable, nombre de pi&egrave;ces, historique des interventions de r&eacute;paration etc.),</span></strong></li>
<li>L''agence immobili&egrave;re doit d''abord <strong>organiser l''&eacute;tat des lieux</strong>, c''est &agrave; dire prendre rendez-vous avec les diff&eacute;rentes parties concern&eacute;es :                      
<ul>
<li>les locataires arrivant ou sortant,&nbsp;</li>
<li>l''expert commissionn&eacute; par l''agence (si celui-ci est un sous-traitant),&nbsp;</li>
<li>&eacute;ventuellement le propri&eacute;taire.</li>
</ul>
</li>
<li>Une fois l''expert sur les lieux, il doit <strong>r&eacute;aliser l''&eacute;tat des lieux</strong>&nbsp;proprement dit,</li>
<li>Une fois l''&eacute;tat des lieux r&eacute;alis&eacute;, les donn&eacute;es doivent &ecirc;tre <strong>transmises &agrave; l''agence immobili&egrave;re</strong>.</li>
</ul>','');
INSERT INTO "process_patterns" VALUES(136429205,'David Juras, Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On cherche &agrave; &eacute;tablir une description plus formelle du processus m&eacute;tier, &agrave; partir des descriptions conceptuelles g&eacute;n&eacute;ralistes existantes.</p>','<ul>
<li>Fournir une vision formalis&eacute;e et structuris&eacute;e du processus m&eacute;tier,</li>
<li>Propose une approche it&eacute;rative sur les scenarii permettant de valider la prise en compte de tous les aspects majeurs du processus m&eacute;tier</li>
</ul>',NULL,'<p>On d&eacute;crit uniquement les scenarii d''interaction entre les <strong>acteurs externes</strong> et le processus m&eacute;tier. Dans le cadre de cette activit&eacute;, celui-ci est assimil&eacute; &agrave; un "fournisseur de services" opaque. On ne fait donc aucune hypoth&egrave;se sur les sous-ensembles du syst&egrave;me sollicit&eacute;s pour r&eacute;aliser le service.</p>
<p>D''autre part, toujours suivant la m&eacute;taphore des services, l''&eacute;change entre acteurs externes et processus m&eacute;tier doit envisag&eacute; comme un encha&icirc;nement de s&eacute;quences, selon le mod&egrave;le suivant :</p>
<ol>
<li>Une <strong>demande de service</strong> de la part d''un acteur externe aupr&egrave;s du processus m&eacute;tier fournisseur de service,</li>
<li>La <strong>production d''une valeur</strong>, de la part du processus m&eacute;tier, destin&eacute;e &agrave; l''acteur en ayant fait la demande.</li>
<li>Une nouvelle demande de service...</li>
</ol>
<p>&Agrave; noter que la demande de service et la production de valeur, tel que d&eacute;crit ci-dessus, peut aussi bien comprendre la commande d''un v&eacute;hicule de chantier, sa production et livraison que le lancement d''un algorithme de calcul de la millioni&egrave;me d&eacute;cimale de &pi;.</p>
<p>La description des scenarii doit &ecirc;tre pr&eacute;c&eacute;d&eacute;e de pr&eacute;conditions permettant de situer le contexte dans lequel chaque sc&eacute;nario se d&eacute;roule. Pour reprendre l''exemple de la pompe &agrave; essence, si le processus m&eacute;tier peut &ecirc;tre formul&eacute; comme "Prendre de l''essence", une pr&eacute;condition probables aux scenarii pourrait &ecirc;tre "<em>L''utilisateur (acteur externe) se rendant &agrave; son travail, remarque qu''il doit d''abord prendre de l''essence. Il se rend donc &agrave; la station service la plus proche</em>".</p>
<p>On ne s''int&eacute;resse &agrave; ce niveau de description qu''aux scenarii "principaux" ou "nominaux", sans tenir compte des cas d''exception ou d''&eacute;chec.</p>
<p>Enfin, et de m&ecirc;me que pour le d&eacute;coupage fonctionnel, <strong>on n''&eacute;met &agrave; ce niveau aucune hypoth&egrave;se </strong>quant aux moyens informatiques ou manuels adopt&eacute;s pour r&eacute;aliser le processus m&eacute;tier.</p>','<p>Cette activit&eacute; aboutit &agrave; la production:</p>
<ul>
<li>De <strong>scenarii conceptuels structur&eacute;s</strong>,</li>
<li>D''un <strong>diagramme de s&eacute;quences</strong> reprenant les scenarii sous un angle plus formel (mais sans aucune extrapolation)</li>
</ul>',NULL,NULL,NULL,'2009-03-20 18:48:39','2009-03-20 18:48:39','Description conceptuelle du processus métier',266846998,'','');
INSERT INTO "process_patterns" VALUES(136429206,'David Juras, Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On veut identifier une classification des acteurs (acteurs externes/internes et principal/secondaire) des processus m&eacute;tier, &agrave; partir de la description de ceux-ci.</p>','<ul>
<li>D&eacute;finition d''une classification claire des acteurs m&eacute;tier et de leurs interactions avec les processus m&eacute;tier</li>
<li>&Eacute;claire l''organisation des processus m&eacute;tier et permet d''identifier toutes les interactions</li>
</ul>',NULL,'<p>On s''appuie sur les descriptions des processus m&eacute;tier pour identifier les diff&eacute;rents acteurs du syst&egrave;me. Deux cat&eacute;gories d''acteurs sont envisageables :</p>
<ol>
<li>L''acteur principal ou secondaire</li>
<li>L''acteur interne ou externe</li>
</ol>
<p>Parmi les combinaisons possibles, on doit identifier pour le syst&egrave;me <strong>au moins un acteur principal externe</strong>, c''est-&agrave;-dire qu''un acteur doit forc&eacute;ment b&eacute;n&eacute;ficier du r&eacute;sultat de l''application.</p>
<p>La classification des acteurs peut se d&eacute;duire des r&eacute;ponses aux questions suivantes :</p>
<p>&nbsp;</p>
<hr />
<table border="0">
<tbody>
<tr>
<th>Type de question</th> <th>Type d''acteur correspondant</th>
</tr>
<tr>
<td>Qui b&eacute;n&eacute;ficie de l''utilisation du syst&egrave;me ?</td>
<td>Principal</td>
</tr>
<tr>
<td>Qui interagit avec le syst&egrave;me sans que le b&eacute;n&eacute;fice final du processus m&eacute;tier lui soit destin&eacute; ?</td>
<td>Secondaire</td>
</tr>
<tr>
<td>Qui utilise le processus m&eacute;tier ?</td>
<td>Interne</td>
</tr>
<tr>
<td>Qui est d&eacute;clencheur du processus m&eacute;tier ?</td>
<td>Externe</td>
</tr>
</tbody>
</table>
<hr />
<p>&nbsp;</p>
<p>On notera que dans le cas d''&eacute;v&eacute;nements d&eacute;clench&eacute;s par des contraintes d''ordre temporel, on pourra assimiler l''acteur externe &agrave; une "horloge syst&egrave;me".</p>','<p>Une <strong>classification des acteurs des processus m&eacute;tier</strong></p>',NULL,NULL,NULL,'2009-03-20 18:50:22','2009-03-25 09:21:12','Identifier les acteurs des processus métier',266846998,'<p><strong>Exemple de la pompe &agrave; essence</strong></p>
<p>En fonction des processus m&eacute;tier, une m&ecirc;me personne physique peut endosser diff&eacute;rents r&ocirc;les. Par exemple, un usager voulant utiliser une pompe &agrave; essence est &agrave; la fois un acteur principal externe (il d&eacute;cide d''avoir recours aux services d''une pompe &agrave; essence) et acteur principal interne (il se sert lui-m&ecirc;me) au cours d''un m&ecirc;me processus m&eacute;tier.</p>
<p>En revanche, un usager en d&eacute;placement aux &eacute;tats-unis ne sera parfois qu''acteur principal externe : dans certaines stations service, il suffit d''entrer dans une station service, et c''est un pompiste qui sert le client. Dans ce cas, le pompiste est un acteur interne (c''est lui qui utilise le syst&egrave;me, c''est-&agrave;-dire la pompe &agrave; essence), mais secondaire : en effet, il ne per&ccedil;oit pas de b&eacute;n&eacute;fice direct du processus, dont le but premier est de remplir le r&eacute;servoir &agrave; essence de la voiture.</p>
<p>&nbsp;</p>
<p><strong>R&eacute;alisation de l''&eacute;tat des lieux</strong></p>
<p>Consid&eacute;rons le processus m&eacute;tier consistant &agrave; r&eacute;aliser l''&eacute;tat des lieux. On identifie les acteurs suivants : l''expert commissionn&eacute; par l''agence immobili&egrave;re, l''agence immobili&egrave;re et les locataires (entrants ou sortants).</p>
<ul>
<li>Bien que l''expert r&eacute;alise effectivement l''&eacute;tat des lieux, il n''est pas le premier b&eacute;n&eacute;ficiaire du processus m&eacute;tier, et fournit au contraire un service &agrave; l''agence immobili&egrave;re. L''expert peut donc &ecirc;tre consid&eacute;r&eacute; comme un acteur <strong>interne</strong> (c''est lui qui "manipule" le processus m&eacute;tier) et <strong>secondaire </strong>(il n''en tire pas un b&eacute;n&eacute;fice direct).</li>
<li>L''agence immobili&egrave;re organise l''&eacute;tat des lieux, mais &agrave; la demande des locataires entrants ou sortants. Elle est donc un acteur <strong>externe</strong> (non impliqu&eacute; dans la r&eacute;alisation effective, physique, du processus m&eacute;tier) et <strong>secondaire</strong> (elle ne tire pas de valeur de l''&eacute;tat des lieux).</li>
<li>Les locataires ne sont pas des acteurs "physiques" du processus m&eacute;tier, mais d&eacute;clenchent celui-ci. Ils sont donc des acteurs <strong>externes</strong> et <strong>principaux</strong>.</li>
</ul>','');
INSERT INTO "process_patterns" VALUES(136429207,'David Juras, Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On cherche &agrave; affiner la d&eacute;composition des processus m&eacute;tier, afin d''aboutir <em>in fine</em> &agrave; des processus m&eacute;tier composant (PMC).</p>','<ul>
<li>Un d&eacute;coupage du m&eacute;tier qui se rapproche du niveau activit&eacute; des acteurs du syst&egrave;me (utilisateurs), qui prenne en compte les cas alternatifs,</li>
<li>Un d&eacute;coupage du syst&egrave;me en sous-ensembles dont le d&eacute;veloppement pour s''int&eacute;grer dans un <strong>micro-cycle</strong>.</li>
</ul>',NULL,'<p>On fait intervenir les <strong>acteurs internes</strong> afin de raffiner les processus m&eacute;tier. Comme on l''a vu pr&eacute;c&eacute;demment, ceux-ci ont pour responsabili&eacute; de r&eacute;aliser effectivement, physiquement le processus m&eacute;tier. On &eacute;tudie donc leur interaction avec le processus m&eacute;tier.</p>
<p>Dans un premier temps, on consid&egrave;re le d&eacute;clenchement du processus m&eacute;tier par l''acteur externe : cet &eacute;v&eacute;nement constitue la <strong>pr&eacute;condition du premier &eacute;change</strong> entre acteur interne et processus m&eacute;tier. Inversement, la r&eacute;ponse du processus m&eacute;tier vers l''acteur externe constitue la <strong>postcondition du dernier &eacute;change</strong> entre acteur interne et processus m&eacute;tier.</p>
<p>Dans un deuxi&egrave;me temps, on d&eacute;crit les &eacute;changes entre acteur(s) interne(s) et processus m&eacute;tier, selon la m&ecirc;me approche que lors de la description des &eacute;change entre acteur(s) externe(s) et processus m&eacute;tier. L''interaction entre acteur(s) interne(s) et processus m&eacute;tier constitue donc un encha&icirc;nement de s&eacute;quences selon le mod&egrave;le suivant :</p>
<ol>
<li>Une <strong>demande de service</strong> de la part d''un acteur interne aupr&egrave;s du processus m&eacute;tier fournisseur de service,</li>
<li>La <strong>production d''une valeur</strong>, de la part du processus m&eacute;tier, destin&eacute;e &agrave; l''acteur en ayant fait la demande.</li>
<li>Une nouvelle demande de service...</li>
</ol>
<p>Enfin, la d&eacute;composition du m&eacute;tier fait intervenir les <strong>scenarii alternatifs</strong>, c''est-&agrave;-dire les situations plus rares ou optionnelles (mais pas les cas d''erreur !).</p>','<p>L''activit&eacute; produit :</p>
<p>Des <strong>scenarii structur&eacute;s</strong>, <strong>nominaux et alternatifs</strong>, selon la forme pr&eacute;sent&eacute;e ci dessus,</p>
<p>Des <strong>diagrammes de s&eacute;quences UML</strong> reprenant les scenarii sous un angle plus formel (toujours sans extrapolation)</p>',NULL,NULL,NULL,'2009-03-20 18:53:19','2009-03-21 21:28:14','Décomposition du processus métier',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>On consid&egrave;re le processus m&eacute;tier "R&eacute;aliser un &eacute;tat des lieux". Comme mentionn&eacute; plus t&ocirc;t, ce processus est r&eacute;alis&eacute; exclusivement par l''expert commissionn&eacute; par l''agence immobili&egrave;re, seul acteur interne de notre syst&egrave;me.</p>
<p>La pr&eacute;condition de cette d&eacute;composition du m&eacute;tier est la suivante :</p>
<p><em>"L''expert a re&ccedil;u, de la part de l''agence immobili&egrave;re, l''ancien &eacute;tat des lieux, les cl&eacute;s du logement ainsi que le nom des futurs ou anciens locataires. Il s''est rendu au logement et le parcourt en pr&eacute;sence de ces derniers."</em></p>
<p>L''analyse des scenarii produits au cours de cette activit&eacute; permet de dresser le diagramme de s&eacute;quences ci-dessous. En bref, l''expert va, au cours de l''&eacute;tat des lieux, mettre &agrave; jour la description des anciens dommages, cr&eacute;er de nouvelles descriptions de dommages et les renseigner.</p>
<p><img src="../../images/SeqDiagram_PM.png" alt="" width="359" height="284" /></p>
<p>La postcondition de cette d&eacute;composition du m&eacute;tier est la suivante :</p>
<p><em>"L''expert a rempli l''&eacute;tat des lieux. Il peut donc soit remettre, soit reprendre les cl&eacute;s aux locataires."</em></p>
<p><br />On rappelle que le processus m&eacute;tier suivant consiste &agrave; transmettre les donn&eacute;es &agrave; l''agence immobili&egrave;re.</p>','');
INSERT INTO "process_patterns" VALUES(136429208,'Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On veut identifier, au sein de la d&eacute;composition du processus m&eacute;tier, des <strong>processus m&eacute;tier composants</strong>, qui pourront &ecirc;tre d&eacute;velopp&eacute;s en un <strong>micro-cycle</strong>.</p>','<ul>
<li>Description du niveau activit&eacute; utilisateur du syst&egrave;me</li>
<li>Permet de r&eacute;partir le travail entre groupes de d&eacute;veloppement</li>
</ul>',NULL,'<p>&Agrave; partir de la <strong>d&eacute;composition du processus m&eacute;tier</strong>, on identifie les <strong>processus m&eacute;tier composant</strong> du syst&egrave;me. Un processus m&eacute;tier composant correspond &agrave; un <strong>&eacute;change ininterruptible</strong> (dans le cadre d''un d&eacute;roulement nominal du sc&eacute;nario) entre l''acteur interne et le processus m&eacute;tier. G&eacute;n&eacute;ralement, les s&eacute;quences d''&eacute;change identifi&eacute;es lors de la premi&egrave;re instance de d&eacute;composition du processus m&eacute;tier correspondent &agrave; des processus m&eacute;tier composant. En revanche, s''il s''av&egrave;re que l''&eacute;change puisse &ecirc;tre encore raffin&eacute;, il est pr&eacute;f&eacute;rable de reprendre l''activit&eacute; <strong>D&eacute;composition du processus m&eacute;tier</strong> pour d&eacute;composer l''&eacute;change en question.</p>','<p>Les processus m&eacute;tier composant sont ais&eacute;ment identifi&eacute;s gr&acirc;ce aux diagrammes de s&eacute;quences issus de la d&eacute;composition du processus m&eacute;tier. On attend donc comme r&eacute;sultat de cette activit&eacute; les diagrammes de s&eacute;quences de d&eacute;composition du processus m&eacute;tier, sur lesquels sont identifi&eacute;s les processus m&eacute;tier composant (voir le cas d''application pour un exemple de repr&eacute;sentation).</p>',NULL,NULL,NULL,'2009-03-20 18:55:17','2009-03-21 21:27:37','Identifier les processus métier composant',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>Il s''est tout d''abord av&eacute;r&eacute; que la premi&egrave;re d&eacute;composition du m&eacute;tier &eacute;tait incompl&egrave;te. En effet, le premier &eacute;change entre l''expert et le processus m&eacute;tier (initialement "Identifier et mettre &agrave; jour les anciens dommages") peut &ecirc;tre raffin&eacute; en "Obtenir les descriptions des anciens dommages" et "Mettre &agrave; jour la description des anciens dommages".</p>
<p>Le diagramme de s&eacute;quences ci-dessous montre la nouvelle d&eacute;composition du m&eacute;tier.</p>
<p><img src="../../images/SeqDiagram_PM2.png" alt="" width="283" height="301" /></p>
<p>&nbsp;</p>
<p>Cette d&eacute;composition stabilis&eacute;e, il est trivial d''identifier les processus m&eacute;tier composant, nomm&eacute;s dans les bo&icirc;tes rouges.</p>
<p><img src="../../images/SeqDiagram.png" alt="" width="391" height="312" /></p>','');
INSERT INTO "process_patterns" VALUES(136429209,'Guillaume Godet-Bar, David Juras ','<p>Activit&eacute;</p>',NULL,'','<p>On veut identifier, &agrave; partir de la description des processus m&eacute;tier composant, les Objets M&eacute;tier Entit&eacute; du syst&egrave;me.</p>','<ul>
<li>Permet d''identifier les concepts centraux, qui seront utilis&eacute;s dans les phases ult&eacute;rieures du d&eacute;veloppement,</li>
<li>Permet de d&eacute;crire les concepts m&eacute;tier selon un formalisme lisible pour l''ensemble des acteurs du d&eacute;veloppement.</li>
</ul>',NULL,'<p>Lors de l''<strong>organisation des processus m&eacute;tier composant</strong>, un ensemble de cas d''utilisation ont &eacute;t&eacute; identifi&eacute;s. Il s''agit &agrave; pr&eacute;sent d''identifier les concepts centraux qui permettront de d&eacute;velopper ces cas d''utilisation dans les phases ult&eacute;rieures. Ces concepts centraux sont mod&eacute;lis&eacute;s sous la forme d''Objets M&eacute;tier Entit&eacute; (voir solution produit).</p>
<p>Les Objets M&eacute;tier peuvent &ecirc;tre associ&eacute;s au travers d''une relation de d&eacute;pendance appel&eacute;e "Utilise" (voir la solution produit pour les r&egrave;gles d''association).</p>
<p>On ne se pr&eacute;occupe pas &agrave; ce niveau de mod&eacute;lisation des attributs des Objets M&eacute;tier Entit&eacute; identifi&eacute;s, ni des cardinalit&eacute;s des relations. Les concepts secondaires ou &agrave; fin niveau de granularit&eacute; ne sont pas non plus d&eacute;crits.</p>','<p>L''activit&eacute; permet de produire une cartographie d''Objets M&eacute;tier Entit&eacute;, rassembl&eacute;s autour de l''Objet M&eacute;tier Processus.</p>
<p>Cette cartographie se base sur les concepts suivants :</p>
<ul>
<li>L''<strong>Objet M&eacute;tier Processus</strong>, d&eacute;crit par ailleurs,</li>
<li>plusieurs <strong>Objets M&eacute;tier Entit&eacute;</strong>, d&eacute;crivant les concepts centraux du processus m&eacute;tier et utilis&eacute;s par l''Objet M&eacute;tier Processus pour r&eacute;aliser les cas d''utilisation,</li>
<li>des <strong>relations d''utilisation</strong>, construites selon la logique suivante :       
<ul>
<li>Un <strong>Objet M&eacute;tier Processus</strong> peut utiliser <strong>plusieurs Objets M&eacute;tier Entit&eacute;</strong>,</li>
<li>Un<strong> Objet M&eacute;tier Entit&eacute;</strong> peut utiliser <strong>plusieurs Objets M&eacute;tier Entit&eacute;</strong>.</li>
</ul>
</li>
</ul>
<p>Il est en g&eacute;n&eacute;ral d&eacute;conseill&eacute; de d&eacute;crire des relations d''utilisation r&eacute;flexives (c''est-&agrave;-dire, un Objet M&eacute;tier Entit&eacute; s''utilisant lui-m&ecirc;me). D''autre part, il n''est pas n&eacute;cessaire d''exprimer de multiplicit&eacute; &agrave; ce niveau de mod&eacute;lisation.</p>',NULL,NULL,NULL,'2009-03-20 21:47:56','2009-03-22 20:55:06','Description de la cartographie des Objets Métier',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>Les pr&eacute;c&eacute;dentes activit&eacute;s ont permis de faire ressortir deux concepts centraux pour la r&eacute;alisation d''un &eacute;tat des lieux : l''&eacute;tat des lieux lui-m&ecirc;me (c''est-&agrave;-dire, l''ensemble des donn&eacute;es d&eacute;crivant l''instance d''&eacute;tat des lieux, telles que l''adresse du logement visit&eacute;, le nom des locataires etc.), et le dommage (ou plus pr&eacute;cis&eacute;ment, la description du dommage). L''exemple ci-dessous repr&eacute;sente les Objets M&eacute;tier Processus et Entit&eacute; de notre cas d''&eacute;tude :</p>
<p><img src="../../images/CartoOMAvCollab.png" alt="" width="447" height="227" /></p>','<p>&nbsp;</p>
<p>&nbsp;</p>');
INSERT INTO "process_patterns" VALUES(136429210,'Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On veut identifier, &agrave; partir de la description de la sp&eacute;cification externe de l''interaction, les Objets Interactionnels (Processus et Entit&eacute;) du syst&egrave;me.</p>','<ul>
<li>Permet d''identifier les concepts centraux de l''interaction, qui seront utilis&eacute;s dans les phases ult&eacute;rieures du d&eacute;veloppement,</li>
<li>Permet de d&eacute;crire les concepts interactionnels selon un formalisme lisible pour l''ensemble des acteurs du d&eacute;veloppement.</li>
</ul>',NULL,'<p>&Agrave; partir de la sp&eacute;cification externe de l''interaction, il s''agit d''abord d''identifier l''Objet Interactionnel Processus, autour duquel s''articule la <strong>cartographie des Objets Interactionnels</strong>.</p>
<p>L''<strong>Objet Interactionnel Processus</strong> a pour responsabilit&eacute; d''appliquer les contraintes interactionnelles de l''application. G&eacute;n&eacute;ralement, cette responsabilit&eacute; consiste &agrave; initialiser l''espace interactif de l''application : sc&egrave;ne tridimensionnelle, sc&egrave;ne multimodale etc., ainsi que les Objets Interactionnels Entit&eacute; qui peupleront cet espace. L''Objet Interactionnel Processus doit &eacute;galement garantir l''application de contraintes interactionnelles.</p>
<p>Les <strong>Objets Interactionnels Entit&eacute;</strong> correspondent aux concepts centraux de l''interaction, dans le cadre de la r&eacute;alisation du processus m&eacute;tier.</p>
<p>De plus, les Objets Interactionnels peuvent &ecirc;tre associ&eacute;s au travers d''une relation de d&eacute;pendance appel&eacute;e "Utilise" (voir la solution produit pour les r&egrave;gles d''association).</p>
<p>On ne se pr&eacute;occupe pas &agrave; ce niveau de mod&eacute;lisation des attributs des Objets Interactionnels Entit&eacute; identifi&eacute;s, ni des cardinalit&eacute;s des relations. Les concepts secondaires ou &agrave; fin niveau de granularit&eacute; ne sont pas non plus d&eacute;crits.</p>','<p>L''activit&eacute; permet de produire une cartographie d''Objets Interactionnels Entit&eacute;, rassembl&eacute;s autour de l''Objet Interactionnel Processus.</p>
<p>Cette cartographie se base sur les concepts suivants :</p>
<ul>
<li>L''<strong>Objet Interactionnel Processus</strong>,</li>
<li>plusieurs <strong>Objets Interactionnels Entit&eacute;</strong>, d&eacute;crivant les concepts centraux de l''interaction et utilis&eacute;s par l''Objet Interactionnel Processus pour constituer l''espace interactif,</li>
<li>des <strong>relations d''utilisation</strong>, construites selon la logique suivante :         
<ul>
<li>Un <strong>Objet Interactionnel Processus</strong> peut utiliser <strong>plusieurs Objets Interactionnels Entit&eacute;</strong>,</li>
<li>Un<strong> Objet Interactionnel Entit&eacute;</strong> peut utiliser <strong>plusieurs Objets Interactionnels Entit&eacute;</strong>.</li>
</ul>
</li>
</ul>
<p>Il est en g&eacute;n&eacute;ral d&eacute;conseill&eacute; de d&eacute;crire des relations d''utilisation r&eacute;flexives (c''est-&agrave;-dire, un Objet M&eacute;tier Interactionnel s''utilisant lui-m&ecirc;me). D''autre part, il n''est pas n&eacute;cessaire d''exprimer de multiplicit&eacute; &agrave; ce niveau de mod&eacute;lisation.</p>',NULL,NULL,NULL,'2009-03-20 21:48:38','2009-03-23 09:24:52',' Description de la cartographie des Objets Interactionnels ',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>On pr&eacute;sente ci-dessous la cartographie des Objets Interactionnels, d&eacute;duite notamment des scenarii projet&eacute;s concrets (voir l''activit&eacute; correspondante).</p>
<p>Cette cartographie nous permet d''&eacute;claircir la notion de "contrainte interactionnelle", g&eacute;r&eacute;e par l''Objet Interactionnel Processus : dans notre cas d''&eacute;tude, une contrainte typique consiste &agrave; garantir que les notes vocales sont bien rattach&eacute;es &agrave; un marqueur de dommages. En effet, les Objets Interactionnels Entit&eacute; &eacute;tant par nature autonomes, ni l''Objet Interactionnel <strong>Note vocale</strong>, ni l''Objet Interactionnel <strong>Marqueur</strong>, ne peut g&eacute;rer ce type de contrainte.</p>
<p><img src="../../images/CartoOI.png" alt="" width="428" height="295" /></p>
<p>&nbsp;</p>','');
INSERT INTO "process_patterns" VALUES(136429211,'Guillaume Godet-Bar','<p>Activit&eacute;</p>',NULL,'','<p>Une fois obtenues les descriptions des espaces m&eacute;tier et interactionnel, il s&rsquo;agit de d&eacute;crire les relations qu&rsquo;ils entretiennent.</p>','<p>&bull;&nbsp;&nbsp;&nbsp; Utilisation d&rsquo;un m&ecirc;me formalisme pour la mise en relation des espaces<br />&bull;&nbsp;&nbsp;&nbsp; Permet l&rsquo;instrumentation (g&eacute;n&eacute;ration et v&eacute;rification de coh&eacute;rence) pour les phases ult&eacute;rieures</p>',NULL,'<p><strong>&Eacute;valuation de l&rsquo;impact m&eacute;tier-interaction</strong></p>
<p>On v&eacute;rifie si la d&eacute;finition de l&rsquo;interaction propos&eacute;e par les sp&eacute;cialistes IHM et les ergonomes logiciel ne permettrait pas d&rsquo;envisager une &eacute;volution du m&eacute;tier au travers de transferts de comp&eacute;tence de l&rsquo;interaction vers le m&eacute;tier. Le cas &eacute;ch&eacute;ant, le sp&eacute;cialiste GL ajoute les Objets M&eacute;tier idoines &agrave; la Cartographie des Objets M&eacute;tier.</p>
<p><em><strong>IMPORTANT : Cette &eacute;volution peut entra&icirc;ner un impact sur l&rsquo;ensemble du projet.</strong></em></p>
<p>&nbsp;</p>
<p><strong>Description des relations de repr&eacute;sentation OI/OM</strong></p>
<p>Les sp&eacute;cialistes GL et IHM se concertent pour d&eacute;crire les liens de repr&eacute;sentation (association &laquo; represent&raquo;) reliant l&rsquo;espace m&eacute;tier et l&rsquo;espace interactionnel. Cette description formelle (voir solution produit) permet notamment de g&eacute;n&eacute;rer le squelette des Objets Interactionnels et Objets M&eacute;tier de niveau Analyse. Des v&eacute;rifications de coh&eacute;rence entre les trois pans du mod&egrave;le global {Cartographie des Objets Interactionnels, Mod&egrave;le de mise en relation, Cartographie des Objets M&eacute;tier} ont lieu par la suite.</p>
<p>&nbsp;</p>
<p><strong>Description des liens entre &eacute;v&eacute;nements m&eacute;tier et interactionnels</strong></p>
<p>Une fois les liens repr&eacute;sent&eacute;s, les sp&eacute;cialistes doivent d&eacute;crire, de mani&egrave;re informelle, les &eacute;v&eacute;nements de chaque espace entra&icirc;nant un impact sur l&rsquo;espace voisin. Typiquement, l&rsquo;instanciation d&rsquo;Objets M&eacute;tier peut d&eacute;clencher l&rsquo;instanciation puis l&rsquo;affichage de nouveaux Objets Interactionnels.</p>','<p>L''activit&eacute; produit un <strong>Mod&egrave;le de mise en relation</strong>, dans lequel Objets M&eacute;tier Entit&eacute; et Objets Interactionnels Entit&eacute; idoines sont associ&eacute;s au travers d''une relation "Repr&eacute;sente". Toutefois, tous les Objets Interactionnels Entit&eacute; ne sont pas forc&eacute;ment associ&eacute;s aux Objets M&eacute;tier Entit&eacute;, et vice versa. De plus, un Objet M&eacute;tier Entit&eacute; peut &ecirc;tre repr&eacute;sent&eacute; par plusieurs Objets Interactionnels Entit&eacute; (voir cas d''application).</p>',NULL,NULL,NULL,'2009-03-20 21:49:37','2009-03-23 13:17:50','Connexion des espaces métier et interactionnel',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>Le mod&egrave;le ci-dessous pr&eacute;sente deux points essentiels de l''activit&eacute; :</p>
<ul>
<li>Tout d''abord, l''&eacute;tude de l''impact de l''interaction sur le m&eacute;tier a fait ressortir la n&eacute;cessit&eacute; de d&eacute;velopper le concept de <strong>Logement</strong> sous forme d''Objet M&eacute;tier Entit&eacute;,</li>
<li>ensuite, on retrouve dans ce diagramme diff&eacute;rentes relations "Repr&eacute;sente".</li>
</ul>
<p><img src="../../images/OMOI.png" alt="" width="410" height="239" /></p>
<p>&nbsp;</p>
<p>Les relations "Repr&eacute;sente" permettent de dresser les liens entre &eacute;v&eacute;nements suivants, dont l''extrait suivant :</p>
<ul>
<li><strong>Repr&eacute;sentation Plan3D &gt; Logement</strong> :
<ul>
<li>L''instanciation du logement (qui devra int&eacute;grer le plan d''architecte) permet de construire le plan 3D du logement,</li>
</ul>
</li>
<li><strong>Repr&eacute;sentation Marqueur &gt; Dommage :</strong>
<ul>
<li>La cr&eacute;ation d''un nouvel objet marqueur va cr&eacute;er une nouvelle instance de dommage,</li>
<li>L''action de verrouiller le marqueur va valider le dommage, qui sera alors enregistr&eacute; dans la base de donn&eacute;es de l''agence immobili&egrave;re,</li>
</ul>
</li>
<li><strong>Repr&eacute;sentation Note vocale &gt; Dommage :</strong>
<ul>
<li>La cr&eacute;ation d''une nouvelle note vocale enregistrera le contenu de la note dans l''objet dommage</li>
</ul>
</li>
</ul>','');
INSERT INTO "process_patterns" VALUES(136429212,'David Juras, Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On cherche &agrave; identifier les processus m&eacute;tier composant informatis&eacute;s, ainsi que les processus m&eacute;tier composant manuels.</p>','<ul>
<li>Une formalisation claire des activit&eacute;s des diff&eacute;rents acteurs du syst&egrave;me, ainsi que de leur encha&icirc;nement,</li>
<li>Permet de valider la r&eacute;partition des processus m&eacute;tier composant entre acteurs internes.</li>
</ul>',NULL,'<p>L''ensemble des acteurs des groupes de d&eacute;veloppement doivent identifier les processus m&eacute;tier composant informatis&eacute;s ainsi que les processus m&eacute;tier composant manuels. Les premiers seront finalement analys&eacute;s du point de vue logiciel puis impl&eacute;ment&eacute;s, tandis que les seconds resteront intouch&eacute;s.</p>
<p>Un &eacute;l&eacute;ment cl&eacute; de cette activit&eacute; concerne la validation de l''organisation des acteurs internes. En effet, bien que les PMC aient &eacute;t&eacute; d&eacute;crits en fonction d''acteurs internes identifi&eacute;s lors de l''&eacute;tude pr&eacute;alable, il est in&eacute;vitable que l''interaction des acteurs internes avec les PMCs soit initialement influenc&eacute;e par les solutions existantes (manuelles ou informatis&eacute;es). Par cons&eacute;quent, il est crucial que l''ensemble de l''&eacute;quipe de d&eacute;veloppement, et en partie les ergonomes, valident l''organisation des acteurs internes. Le cas &eacute;ch&eacute;ant, il pourra &ecirc;tre n&eacute;cessaire de revoir la d&eacute;composition du m&eacute;tier d&eacute;finie lors de sp&eacute;cification conceptuelle des besoins.</p>','<p>La d&eacute;composition en PMC manuels et informatis&eacute;e peut &ecirc;tre repr&eacute;sent&eacute;e par un <strong>diagramme d''activit&eacute;s</strong> faisant intervenir les acteurs internes ainsi que les diff&eacute;rents types de PMC. Toute contrainte temporelle de type "tous les matins" ou "toutes les fins de semaine" doit &ecirc;tre mod&eacute;lis&eacute;e par un acteur interne "horloge".</p>
<p>On diff&eacute;renciera clairement les processus m&eacute;tier composant informatis&eacute;s de ceux manuels par des couleurs distinctes. On &eacute;tablira &eacute;galement une <strong>liste des processus m&eacute;tier composant informatis&eacute;s</strong> <strong>&agrave; d&eacute;velopper</strong>. Cette liste permettra &agrave; l''ensemble de l''&eacute;quipe de d&eacute;veloppement, ainsi qu''&agrave; l''organisation, de suivre la progression du d&eacute;veloppement. Au fil du temps, les PMC r&eacute;alis&eacute;s pourront &ecirc;tre retir&eacute;s de cette liste pour &ecirc;tre ajout&eacute;s &agrave; une <strong>liste des PMC d&eacute;velopp&eacute;s</strong>.</p>',NULL,NULL,NULL,'2009-03-20 21:50:29','2009-03-22 17:00:03','Décomposition organisationnelle des PMC',266846998,'','');
INSERT INTO "process_patterns" VALUES(136429213,'Guillaume Godet-Bar','<p>Activit&eacute;</p>',NULL,'','<p>Formuler au niveau PMC l''activit&eacute; utilisateur</p>','<ul>
<li>Permet de d&eacute;crire les &eacute;changes entre les utilisateurs (acteurs internes) et le syst&egrave;me selon une approche abstraite, orient&eacute;e interaction homme-machine.</li>
</ul>',NULL,'<p>&Agrave; partir des mod&egrave;les de t&acirc;ches utilisateur (ou bien la description des PMC, le cas &eacute;ch&eacute;ant), le sp&eacute;cialiste IHM et l&rsquo;ergonome envisagent la mise en &oelig;uvre des buts de l&rsquo;utilisateur, au cours de l&rsquo;utilisation du syst&egrave;me projet&eacute;, en prenant en compte le contexte de la t&acirc;che (lieu, conditions ext&eacute;rieures/int&eacute;rieures etc.) ainsi que le profil de l&rsquo;utilisateur. Il peut ainsi &ecirc;tre n&eacute;cessaire de d&eacute;crire plusieurs scenarii correspondant &agrave; un m&ecirc;me sous-arbre de t&acirc;ches, mais destin&eacute;s &agrave; des utilisateurs ou des contextes diff&eacute;rents.</p>
<p>Les <strong>scenarii projet&eacute;s abstraits de l&rsquo;interaction</strong> sont &eacute;galement une premi&egrave;re occasion pour le sp&eacute;cialiste IHM de d&eacute;crire, selon le choix d''interaction r&eacute;alis&eacute; lors de la sp&eacute;cification conceptuelle, une interaction en r&eacute;alit&eacute; mixte.</p>
<p>D&rsquo;autre part, les scenarii projet&eacute;s abstraits ne d&eacute;crivent pas les modalit&eacute;s ou techniques d&rsquo;interaction envisag&eacute;es pour la r&eacute;alisation des buts. Seuls les objets (ou entit&eacute;s) physiques et num&eacute;riques n&eacute;cessaires &agrave; l&rsquo;interaction apparaissent dans ces scenarii. Ils constituent ainsi une premi&egrave;re &eacute;bauche des Objets Interactionnels, d&eacute;crits ult&eacute;rieurement.</p>
<p>On notera que cette description du contexte d&rsquo;usage, des profils utilisateur etc. est conforme au cycle de conception centr&eacute; utilisateur d&eacute;fini par l&rsquo;ISO 13407.</p>
<p>&nbsp;</p>','<p>Les <strong>scenarii projet&eacute;s abstraits</strong> consistent essentiellement en des formulaires pr&eacute;cisant les utilisateurs (acteurs internes) impliqu&eacute;s, les pr&eacute;- et postconditions, &eacute;ventuellement, ainsi que le sc&eacute;nario lui-m&ecirc;me.</p>',NULL,NULL,NULL,'2009-03-22 11:31:43','2009-03-23 09:12:55','Élaboration des scenarii projetés abstraits de l''interaction',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>On pr&eacute;sente ci-dessous un extrait de sc&eacute;nario, correspondant &agrave; la t&acirc;che "Ajouter une description de dommage" :</p>
<table border="1" frame="hsides" rules="rows">
<tbody>
<tr>
<td><strong>Acteur(s): </strong></td>
<td>Expert</td>
</tr>
<tr>
<td><strong>Postcondition : </strong></td>
<td>Le dommage est observ&eacute; et sa description est enregistr&eacute;e dans l''&eacute;tat des lieux</td>
</tr>
<tr>
<td colspan="2">
<p>(...) L''Expert entre dans une <em>pi&egrave;ce </em>du logement. La position de l''Expert est indiqu&eacute;e sur le <em>plan du logement</em>. Le pr&eacute;c&eacute;dent &eacute;tat des lieux n''indique ni <em>dommage ni usure</em> &agrave; &eacute;valuer dans cette pi&egrave;ce. Il parcourt la pi&egrave;ce et constate une t&acirc;che sombre sur l''un des murs. Il d&eacute;crit le dommage, sa position sur le plan du logement et rel&egrave;ve plusieurs <em>m&eacute;dias</em> (photographie ou vid&eacute;o) du dommage, ainsi que son contexte (...)</p>
</td>
</tr>
</tbody>
</table>','');
INSERT INTO "process_patterns" VALUES(136429214,'Guillaume Godet-Bar','<p>Activit&eacute; optionnelle</p>',NULL,'','<p>On veut traduire les diff&eacute;rents processus m&eacute;tier composant en une organisation hi&eacute;rarchique de t&acirc;ches utilisateurs.</p>','<ul>
<li>Adapte les scenarii consensuels des processus m&eacute;tier composant sous une forme plus adapt&eacute;e &agrave; l''&eacute;laboration de la sp&eacute;cification externe de l''interaction.</li>
</ul>',NULL,'<p>La description des mod&egrave;les de t&acirc;ches consiste essentiellement &agrave; r&eacute;organiser les donn&eacute;es issues de processus m&eacute;tier composant sous une forme plus adapt&eacute;e &agrave; la conception de l''interaction homme-machine. Cette activit&eacute; est <strong>optionnelle</strong> : en effet, il n''est pas n&eacute;cessaire de la r&eacute;aliser si les scenarii des processus m&eacute;tier et processus m&eacute;tier composant sont suffisamment explicites pour percevoir les diff&eacute;rentes possibilit&eacute;s d''interaction de l''utilisateur avec le syst&egrave;me.</p>
<p>Parmi l''ensemble des formalismes de repr&eacute;sentation des mod&egrave;les de t&acirc;ches, nous sugg&eacute;rons d''utiliser <strong>ConcurrTaskTrees</strong> de Patern&oacute;. Ce formalisme a notamment pour avantages de permettre la repr&eacute;sentation de diff&eacute;rents niveaux d''abstraction des t&acirc;ches utilisateurs et d''utiliser des op&eacute;rateurs d''encha&icirc;nement simples (op&eacute;rateurs LOTOS). Ce formalisme est &eacute;galement suffisamment lisible pour servir de support de collaboration avec les ergonomes.</p>
<p>La description des mod&egrave;les de t&acirc;ches consiste &agrave; reprendre l''ensemble des processus m&eacute;tier composant issus du processus m&eacute;tier pour les structurer sous forme d''<strong>une arborescence de t&acirc;ches abstraites et t&acirc;ches manuelles</strong>. Il est &agrave; noter que, bien que les PMC manuels et PMC informatis&eacute;s aient &eacute;t&eacute; identifi&eacute;s, il n''est pas pour l''instant souhaitable de d&eacute;tailler les t&acirc;ches informatis&eacute;es (sous forme de t&acirc;ches d''interaction, t&acirc;ches syst&egrave;mes et t&acirc;ches utilisateur).</p>
<p>D''autre part, les mod&egrave;les de t&acirc;che doivent d&eacute;crire l''encha&icirc;nement entre les t&acirc;ches abstraites doit &ecirc;tre d&eacute;fini (s&eacute;quencement, parall&egrave;lisme, d&eacute;clenchement conditionnel etc.). Il est &eacute;galement n&eacute;cessaire de d&eacute;terminer les <strong>t&acirc;ches critiques</strong> et <strong>t&acirc;ches fr&eacute;quentes</strong>.</p>','<p>L''activit&eacute; produit <strong>un ou plusieurs arbres de t&acirc;ches CTT</strong> repr&eacute;sentant l''interaction des utilisateurs avec le syst&egrave;me, &agrave; haut niveau d''abstraction.</p>',NULL,NULL,NULL,'2009-03-22 11:41:23','2009-03-22 15:50:37','Description des modèles de tâches',266846998,'','');
INSERT INTO "process_patterns" VALUES(136429215,'David Juras, Guillaume Godet-Bar ','<p>Activit&eacute;</p>',NULL,'','<p>On cherche &agrave; identifier les cas d''utilisation li&eacute;s aux processus m&eacute;tier composant, ainsi qu''&agrave; les organiser sous forme d''Objets M&eacute;tier Processus.</p>','<ul>
<li>Permet de g&eacute;n&eacute;raliser les pratiques relev&eacute;es dans les processus m&eacute;tier composant, sous forme de cas d''utilisation</li>
</ul>',NULL,'<p>Le processus m&eacute;tier et processus m&eacute;tier composant informatis&eacute;s sont &eacute;tudi&eacute;s selon la logique suivante :</p>
<ul>
<li>Le processus m&eacute;tier est d&eacute;sormais consid&eacute;r&eacute; comme un "Objet M&eacute;tier Processus" r&eacute;alisant un certain nombre de cas d''utilisation,</li>
<li>Chaque processus m&eacute;tier composant informatis&eacute; (PMC) doit &ecirc;tre mod&eacute;lis&eacute; par un cas d''utilisation. &Agrave; cette fin, on v&eacute;rifie pour chaque PMC s''il peut &ecirc;tre soit directement g&eacute;n&eacute;ralis&eacute; sous forme de cas d''utilisation, soit inclus dans des cas d''utilisation plus g&eacute;n&eacute;raux, ou bien &eacute;tendus par d''autres cas d''utilisation. &Agrave; noter qu''il s''agit ici de d&eacute;crire exhaustivement les fonctionnalit&eacute;s du futur syst&egrave;me.</li>
</ul>
<p>&nbsp;</p>','<p>L''activit&eacute; produit une description d''<strong>Objet M&eacute;tier Processus</strong> contenant un ensemble de <strong>cas d''utilisation</strong>.</p>',NULL,NULL,NULL,'2009-03-22 15:47:04','2009-03-22 21:32:34','Organisation des processus métier composant',266846998,'<p><img src="../../images/UseCases.png" alt="" width="539" height="327" /></p>','');
INSERT INTO "process_patterns" VALUES(136429216,'Guillaume Godet-Bar','<p>Activit&eacute;</p>',NULL,'','<p>On veut d&eacute;crire l''interaction concr&egrave;te de l''utilisateur (acteur interne) avec le futur syst&egrave;me.</p>','<ul>
<li>Permet aux ergonomes et sp&eacute;cialistes IHM de r&eacute;sumer l''ensemble de leurs contributions de sp&eacute;cification externe de l''interaction au sein de scenarii d&eacute;crivant l''utilisation concr&egrave;te du futur syst&egrave;me.</li>
</ul>',NULL,'<p>&Agrave; partir de l&rsquo;ensemble des produits regroup&eacute;s dans le &laquo; Dossier de l&rsquo;interaction &raquo;, on effectue une synth&egrave;se des choix interactionnels sous la forme d&rsquo;une mise &agrave; jour des scenarii projet&eacute;s abstraits. Il s&rsquo;agit notamment de pr&eacute;ciser la repr&eacute;sentation des concepts manipul&eacute;s par l&rsquo;utilisateur, les modalit&eacute;s et techniques d&rsquo;interaction employ&eacute;es ainsi que les classes de support pour l&rsquo;interaction mises &agrave; contribution.</p>
<p style="padding-left: 30px;"><strong>Coordination: </strong></p>
<ul>
<li>L&rsquo;ergonome doit v&eacute;rifier que l&rsquo;ensemble des points abord&eacute;s dans chaque sc&eacute;nario respecte les recommandations ergonomiques formul&eacute;es lors de &laquo; L&rsquo;&eacute;tude des activit&eacute;s de l&rsquo;utilisateur &raquo;. Il doit &eacute;galement formuler de nouvelles recommandations ergonomiques visant &agrave; am&eacute;liorer l&rsquo;int&eacute;gration des &eacute;l&eacute;ments du &laquo; Dossier de l&rsquo;interaction &raquo;. Cette activit&eacute; constitue pour l&rsquo;ergonome une premi&egrave;re occasion d&rsquo;envisager les tests utilisateurs mis en place par la suite.</li>
</ul>','<p>Les <strong>scenarii projet&eacute;s concrets</strong> consistent en des formulaires pr&eacute;cisant les utilisateurs (acteurs internes) impliqu&eacute;s, les pr&eacute;- et postconditions, &eacute;ventuellement, les classes de dispositifs et les artefacts interactionnels impliqu&eacute;s dans l''interaction, ainsi que le sc&eacute;nario lui-m&ecirc;me.</p>',NULL,NULL,NULL,'2009-03-22 22:05:14','2009-03-23 09:12:33','Élaboration des scenarii projetés concrets de l''interaction',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>On pr&eacute;sente ci-dessous la version concr&egrave;te du sc&eacute;nario pr&eacute;sent&eacute; dans le patron <strong>&Eacute;laboration des scenarii projet&eacute;s abstraits de l''interaction</strong> (correspondant &agrave; la t&acirc;che "Ajouter une description de dommage") :</p>
<table border="1" frame="hsides" rules="rows">
<tbody>
<tr>
<td><strong>Acteur(s): </strong></td>
<td>Expert</td>
</tr>
<tr>
<td><strong>Postcondition : </strong></td>
<td>Le dommage est observ&eacute; et sa description est enregistr&eacute;e dans l''&eacute;tat des lieux</td>
</tr>
<tr>
<td><strong>Dispositifs de support : </strong></td>
<td>Dispositif tactile mobile, Dispositif de vision augment&eacute;e, Dispositif d''entr&eacute;e vocale, Syst&egrave;me de positionnement</td>
</tr>
<tr>
<td><strong>Artefacts interactionnels : </strong></td>
<td>Plan 3D, Marqueur, Note vocale<br /></td>
</tr>
<tr>
<td colspan="2">
<p>(...) L''Expert entre dans une <em>pi&egrave;ce </em>du logement. Sa position est indiqu&eacute;e sur son <em>Dispositif mobile tactile</em>, repr&eacute;sentant le <em>Plan 3D</em> du logement. Le pr&eacute;c&eacute;dent &eacute;tat des lieux correspondant &agrave; la pi&egrave;ce est automatiquement charg&eacute; &agrave; son entr&eacute;e dans la pi&egrave;ce (d&eacute;tection r&eacute;alis&eacute;e par le <em>Syst&egrave;me de positionnement</em>). Gr&acirc;ce &agrave; son <em>Dispositif de vision augment&eacute;e</em>, l''Expert constate qu''aucun <em>Marqueur </em>ne signale de dommage.</p>
<p>Il parcourt la pi&egrave;ce et remarque une t&acirc;che sombre sur l''un des murs. Il cr&eacute;&eacute;e un nouveau <em>Marqueur de dommage</em>, &agrave; l''aide d''une commande vocale, puis le positionne, l''oriente et d&eacute;finit sa taille gr&acirc;ce au <em>Dispositif mobile tactile </em>qui lui permet de placer pr&eacute;cis&eacute;ment le <em>Marqueur</em>. Enfin, il <em>verrouille</em> le <em>Marqueur</em> et d&eacute;crit le dommage en cr&eacute;ant une <em>Note vocale</em> (&agrave; l''aide du <em>Dispositif d''entr&eacute;e vocale</em>). Cette <em>Note vocale</em> est rattach&eacute;e au <em>Marqueur</em> et pourra &ecirc;tre consult&eacute;e lors du prochain &eacute;tat des lieux. (...)</p>
</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>','');
INSERT INTO "process_patterns" VALUES(136429217,'Guillaume Godet-Bar','<p>Activit&eacute;</p>',NULL,'','<p>On veut s&eacute;lectionner des classes de dispositifs adapt&eacute;es aux artefacts interactionnels et techniques d''interactions &eacute;labor&eacute;s au cours de la <strong>sp&eacute;cification externe de l''interaction</strong>.</p>','<ul>
<li>Propose d''exploiter une mod&eacute;lisation facilitant le choix de dispositifs "non standards", notamment pour une interaction en r&eacute;alit&eacute; mixte.</li>
</ul>',NULL,'<p>Cette activit&eacute; optionnelle n&rsquo;est valable que pour les interfaces post-WIMP sortant du tryptique clavier-&eacute;cran-souris. Elle vise &agrave; la construction d&rsquo;une interface complexe (par opposition aux interfaces de type formulaire), &eacute;ventuellement r&eacute;partie sur plusieurs surfaces, &eacute;ventuellement r&eacute;pondant &agrave; et &eacute;mettant sur plusieurs modalit&eacute;s. On notera que, par classe de support, on entend les types de dispositif permettant l&rsquo;utilisation des modalit&eacute;s ou combinaisons de modalit&eacute;s pour l&rsquo;interaction d&eacute;crites dans les activit&eacute;s <strong>Description des techniques d&rsquo;interaction</strong> et <strong>Description des artefacts interactionnels</strong>. En revanche, les choix techniques quant aux classes de support pour l&rsquo;interaction n&rsquo;entrent pas dans les pr&eacute;rogatives des sp&eacute;cialistes de la branche fonctionnelle.</p>
<p>On utilise le mod&egrave;le ASUR pour la repr&eacute;sentation des classes de dispositifs. Cette mod&eacute;lisation a l''avantage de s''appuyer sur une repr&eacute;sentation des dispositifs d''entr&eacute;e et de sortie, ainsi que sur la repr&eacute;sentation d''&eacute;l&eacute;ments physiques sous forme d''&eacute;l&eacute;ments virtuels dans le syst&egrave;me.</p>
<p>Dans un premier temps, il est pr&eacute;f&eacute;rable de repr&eacute;senter d''abord les artefacts interactionnels d&eacute;j&agrave; identifi&eacute;s. Si le type d''interaction envisag&eacute; est en r&eacute;alit&eacute; mixte, on mod&eacute;lisera &eacute;galement les objets physiques reconnus par le syst&egrave;me. Par exemple, si l''interaction envisag&eacute;e doit projeter sur un cube physique une carte virtuelle, ces deux &eacute;l&eacute;ments devront &ecirc;tre mis en relation dans le diagramme ASUR (voir solution produit).</p>
<p>Puis, en fonction des techniques d''interaction envisag&eacute;es, de d&eacute;terminer quel(s) type(s) d''adaptateur(s) en entr&eacute;e serai(en)t le(s) plus adapt&eacute;(s) pour r&eacute;aliser cette interaction. Par exemple, s''il a &eacute;t&eacute; &eacute;tabli qu''un artefact interactionnel devrait &ecirc;tre manipul&eacute; directement, on pourra envisager d''utiliser des dispositifs tactiles ou bien de reconnaissance de geste (cam&eacute;ra, par exemple).</p>
<p style="padding-left: 30px;"><strong>Coordination :</strong></p>
<ul>
<li>L&rsquo;ergonome confronte les pr&eacute;conisations du <strong>Dossier des prescriptions ergonomiques</strong> aux choix de classes de dispositif effectu&eacute;s par le sp&eacute;cialiste IHM. Il s&rsquo;agit notamment de valider la correspondance des profils utilisateur (capacit&eacute;s physiques, perceptives, cognitives), les contextes d&rsquo;utilisation et les classes de support pour l&rsquo;interaction choisies.</li>
</ul>
<p>&nbsp;</p>','<p>Les diagrammes ASUR sont constitu&eacute;s des concepts suivants :</p>
<ul>
<li><img src="../../images/Ain.png" alt="" width="39" height="39" />: des adaptateurs en entr&eacute;e, c''est-&agrave;-dire des dispositifs ou parties de dispositifs permettant l''entr&eacute;e de donn&eacute;es,</li>
<li><img src="../../images/Aout.png" alt="" width="37" height="37" />: des adaptateurs en sortie, c''est-&agrave;-dire des dispositifs ou parties de dispositifs &eacute;mettant des donn&eacute;es,</li>
<li><img src="../../images/User.png" alt="" width="42" height="46" /> : des utilisateurs,</li>
<li><img src="../../images/Phys_obj.png" alt="" width="36" height="37" /> : des objets physiques, <strong>focus de la t&acirc;che,</strong></li>
<li><img src="../../images/RTool.png" alt="" width="34" height="37" /> : des objets physiques, <strong>utilis&eacute;s comme outils dans le cadre de la t&acirc;che</strong>,</li>
<li><strong><img src="../../images/Obj.png" alt="" width="42" height="41" /></strong> : des objets num&eacute;riques, <strong>focus de la t&acirc;che</strong>,</li>
<li><img src="../../images/STool.png" alt="" width="46" height="43" /> : des objets num&eacute;riques, <strong>utilis&eacute;s comme outils dans le cadre de la t&acirc;che</strong>,</li>
<li><img src="../../images/SInfo.png" alt="" width="41" height="37" /> : des artefacts num&eacute;riques, <strong>repr&eacute;sentant des retours d''information </strong>(par exemple, un curseur affich&eacute; sur un &eacute;cran repr&eacute;sentant la position point&eacute;e du doigt par un utilisateur)</li>
</ul>
<p>&nbsp;</p>
<p>Ces diff&eacute;rents concepts peuvent &ecirc;tre associ&eacute;s gr&acirc;ce aux relations suivantes :</p>
<ul>
<li><img src="../../images/ObjRepresentation.png" alt="" width="81" height="13" />: des relations de repr&eacute;sentation (par exemple, un pointeur repr&eacute;sente le doigt de l''utilisateur),</li>
<li><img src="../../images/PhysicalConn.png" alt="" width="64" height="18" /> : des relations "r&eacute;elles", telles que la proximit&eacute; physique, l''inclusion de dispositifs (par exemple, un syst&egrave;me d''entr&eacute;e tactile et une surface d''affichage sont combin&eacute;s dans une table digitale),</li>
<li><img src="../../images/DataTransfer.png" alt="" width="77" height="13" />: des transferts de donn&eacute;es d''une entit&eacute; vers une autre (typiquement, de l''utilisateur vers un adaptateur en entr&eacute;e, ou bien d''un adaptateur en sortie vers l''utilsateur, voire entre un adaptateur en entr&eacute;e et un objet num&eacute;rique, etc.)</li>
</ul>',NULL,NULL,NULL,'2009-03-22 22:08:30','2009-03-23 12:34:04','Choix des classes de support pour l’interaction',266846998,'<p><strong>R&eacute;alisation d''un &eacute;tat des lieux</strong></p>
<p>Les descriptions des artefacts interactionnels et des techniques d''interaction ont mis en &eacute;vidence :</p>
<ul>
<li>Le besoin de repr&eacute;senter les dommages sous forme de <strong>Marqueurs</strong>. Ces marqueurs doivent appara&icirc;tre de fa&ccedil;on &eacute;vidente &agrave; l''utilisateur, c''est pourquoi on peut envisager d''utiliser un <strong>Dispositif de vision augment&eacute;e</strong>, qui superposerait la repr&eacute;sentation des marqueurs sur les dommages physiques,</li>
<li>le besoin d''avoir recours &agrave; un <strong>Syst&egrave;me de positionnement</strong>, localisant d''une part l''utilisateur dans le logement, d''autre part la direction de son regard,</li>
<li>le besoin de repr&eacute;senter la position de l''utilisateur dans le logement, d''une part afin de lui permettre d''organiser plus facilement son inspection, d''autre part pour mettre le positionnement des marqueurs virtuels (voir ci-dessus) dans le logement physique. On utilisera pour ce faire un <strong>Plan 3D</strong>, repr&eacute;sentation tridimensionnelle du logement. Ce plan 3D (ainsi que les marqueurs) sera repr&eacute;sent&eacute; sur un <strong>Affichage mobile</strong>,</li>
<li>le besoin d''associer facilement des &eacute;l&eacute;ments multim&eacute;dias, tels que des <strong>Notes vocales</strong>, aux marqueurs. Ces notes vocales seront acquises &agrave; l''aide d''un <strong>dispositif d''entr&eacute;e vocale </strong>(microphone, par exemple). D''autre part, les commandes de cr&eacute;ation, de verrouillage et de destruction des marqueurs seront donn&eacute;es via ce dispositif,</li>
<li>le besoin de manipuler facilement l''orientation, la taille et la position exacte des marqueurs dans la repr&eacute;sentation virtuelle du logement. On utilisera un dispositif d''<strong>entr&eacute;e tactile</strong>, associ&eacute; &agrave; l''affichage mobile afin de permettre la manipulation directe.</li>
</ul>
<p>Ces diff&eacute;rents dispositifs, ainsi que les flux de donn&eacute;es qu''ils entretiennent avec les autres &eacute;l&eacute;ments du syst&egrave;me, sont repr&eacute;sent&eacute;s dans le diagramme ASUR ci-dessous. &Agrave; noter qu''afin de simplifier ce diagramme, les &eacute;changes de donn&eacute;es entre l''utilisateur (Expert) et les dispositifs ne sont pas repr&eacute;sent&eacute;s (pour la simple raison que tous les dispositifs sont sollicit&eacute;s par l''utilisateur).</p>
<p><img src="../../images/ASUR.png" alt="" width="473" height="301" /></p>','');
INSERT INTO "process_patterns" VALUES(136429224,'Guillaume Godet-Bar','<p>&nbsp;</p>
<p>C''est une activit&eacute;</p>',NULL,'','','',NULL,'','',NULL,NULL,NULL,'2009-04-01 11:29:38','2009-04-01 11:29:38','Un patron racine',266847005,'','');
INSERT INTO "process_patterns" VALUES(136429225,'Guillaume Godet-Bar','',NULL,'','','',NULL,'','',NULL,NULL,NULL,'2009-04-01 11:31:55','2009-04-01 11:31:55','Un deuxième patron',266847005,'','');
CREATE TABLE "pattern_systems" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "author" varchar(255), "name" varchar(255), "root_pattern_id" varchar(255), "created_at" datetime, "updated_at" datetime, "participant_id" integer, "characteristics" text, "update_field" text);
INSERT INTO "pattern_systems" VALUES(266846998,'Guillaume Godet-Bar, David Juras','Symphony augmentée pour la conception des systèmes de réalité mixte','136429198','2009-03-20 18:08:35','2009-04-01 10:04:50',NULL,'<p>La m&eacute;thode Symphony augment&eacute;e poss&egrave;de les caract&eacute;ristiques suivantes :</p>
<ul>
<li>la m&eacute;thode est <em>dirig&eacute;e</em> par les <em>processus m&eacute;tier</em>, c''est-&agrave;-dire que ce sont les processus m&eacute;tier qui d&eacute;finissent le d&eacute;coupage fonctionnel de l''application,</li>
<li>la m&eacute;thode est <em>centr&eacute;e</em> sur l''<em>utilisateur</em>, c''est-&agrave;-dire que l''on cherche &agrave; adapter le syst&egrave;me aux pratiques des utilisateurs (&agrave; l''inverse des approches dirig&eacute;es par les fonctions, qui privil&eacute;gient le regroupement logique de fonctionnalit&eacute;s),</li>
<li>La m&eacute;thode est <em>it&eacute;rative</em> et <em>incr&eacute;mentale</em>, c''est-&agrave;-dire que le syst&egrave;me est construit <em>progressivement</em>, bloc par bloc (ou, plus pr&eacute;cis&eacute;ment, processus m&eacute;tier par processus m&eacute;tier). Il est &eacute;galement possible de reprendre les activit&eacute;s de d&eacute;veloppement du syst&egrave;me, par exemple afin de raffiner certains aspects, voire de refl&eacute;ter dans le syst&egrave;me de nouvelles compr&eacute;hensions des probl&eacute;matiques du m&eacute;tier.</li>
</ul>
<p>&nbsp;</p>
<p>D''autre part, la m&eacute;thode Symphony est soumise &agrave; deux types de cycle de d&eacute;veloppement:</p>
<ul>
<li>Le <strong>macro-cycle</strong>, correspondant au temps n&eacute;cessaire pour d&eacute;velopper et impl&eacute;menter l''ensemble d''un processus m&eacute;tier</li>
<li>Le <strong>micro-cycle</strong>, correspondant au temps n&eacute;cessaire pour d&eacute;velopper et impl&eacute;menter un sous-ensemble de fonctions d''un processus m&eacute;tier.</li>
</ul>
<p>&nbsp;</p>
<p>Le temps affect&eacute; &agrave; chaque type de cycle sera fonction d''une part des risques associ&eacute;s au d&eacute;veloppement du projet, d''autre part des ressources humaines affect&eacute;es au d&eacute;veloppement. Les principes suivants doivent &ecirc;tre suivis, afin de garantir un d&eacute;roulement optimal du projet :</p>
<ol>
<li><em>Un macro-cycle contient un certain nombre de micro-cycles. Le dernier micro-cycle d''un macro-cycle d&eacute;clenche l''int&eacute;gration des diff&eacute;rents &eacute;l&eacute;ments logiciels d&eacute;velopp&eacute;s. Il est donc n&eacute;cessaire de pr&eacute;voir un temps d''int&eacute;gration &agrave; la fin du macro-cycle,</em></li>
<li><em>Le nombre de micro-cycles doit &ecirc;tre d&eacute;termin&eacute; avant le lancement d''un macro-cycle de d&eacute;veloppement. En revanche, il est pr&eacute;f&eacute;rable de ne pas modifier la dur&eacute;e des micro-cycles durant le projet.</em></li>
</ol>
<p>&nbsp;</p>
<p>La fin de chaque cycle est marqu&eacute;e par une pr&eacute;sentation devant l''ensemble de l''&eacute;quipe (ou d''un sous-ensemble de l''&eacute;quipe) des &eacute;l&eacute;ments logiciels (fonctionnels). L''organisation pourra &ecirc;tre convi&eacute;e &agrave; cette pr&eacute;sentation, selon que le bloc fonctionnel pr&eacute;sent&eacute; impl&eacute;mente un processus m&eacute;tier (<em>d&eacute;livrable externe</em>) ou un processus m&eacute;tier composant (<em>d&eacute;livrable interne</em>).</p>
<p>&nbsp;</p>
<p>Les r&eacute;unions de pr&eacute;sentation sont &eacute;galement l''occasion de mettre &agrave; plat, pour l''ensemble de l''&eacute;quipe de d&eacute;veloppement, les probl&egrave;mes rencontr&eacute;s lors du d&eacute;veloppement, pour chaque sous-ensemble d&eacute;velopp&eacute;. Des mesures doivent &ecirc;tre prises pour traiter les probl&egrave;mes en cours avant d''envisager les prochains sous-ensembles &agrave; d&eacute;velopper. Toutefois, l''aphorisme "<em>le mieux est l''ennemi du bien"</em> doit pr&eacute;valoir au cours de ces r&eacute;unions. Celles-ci ne doivent pas durer plus de deux heures : les points trait&eacute;s doivent &ecirc;tre g&eacute;n&eacute;raux et/ou li&eacute;s aux autres groupes de d&eacute;veloppement ; il n''est donc pas n&eacute;cessaire de traiter les probl&egrave;mes particuliers de d&eacute;veloppement lors des r&eacute;unions de pr&eacute;sentation.</p>
<p>&nbsp;</p>
<p>Il est &agrave; noter qu''en fonction de la taille de l''&eacute;quipe de d&eacute;veloppement, plusieurs micro-cycles peuvent &ecirc;tre entrepris en parall&egrave;le, voire plusieurs macro-cycles. Dans ce dernier cas, il reste pr&eacute;f&eacute;rable de synchroniser les fins de cycles afin d''am&eacute;nager des temps d''int&eacute;gration.</p>','<h3>Mercredi 1er Avril</h3>
<p>
<ul>
<li>Ajout d''une aide &agrave; la navigation (breadcrumb) en haut de page</li>
</ul>
<div><br /></div>
</p>
<h3>Lundi 22 Mars (Mise &agrave; jour : 14h30)<br /></h3>
<ul>
<li>Fin de l''int&eacute;gration des patrons sur le syst&egrave;me. Quelques clarifications mineures pourront subvenir ult&eacute;rieurement.</li>
</ul>
<p>&nbsp;</p>
<h3>Dimanche 21 Mars</h3>
<ul>
<li>L''ensemble des patrons ont &eacute;t&eacute; int&eacute;gr&eacute;s dans l''atelier. Quelques points (d&eacute;tails de m&eacute;thodologie, cas d''application) de la fin de la phase de sp&eacute;cification organisationnelle et interactionnelle seront pr&eacute;cis&eacute;s dans la matin&eacute;e de lundi.</li>
</ul>
<p>&nbsp;</p>
<h3>Samedi 21 Mars</h3>
<ul>
<li>Ajout de zones hypertextes sur les repr&eacute;sentations des d&eacute;marches, menant directement au patron s&eacute;lectionn&eacute;.</li>
</ul>
<p>&nbsp;</p>
<h3>Vendredi 20 Mars (Mise &agrave; jour : 12h45)<br /></h3>
<ul>
<li>Le patron "Phase de sp&eacute;cification conceptuelle des besoins", ainsi que l''ensemble des patrons li&eacute;s, sont d&eacute;crits. La "Phase de sp&eacute;cification organisationnelle et interactionnelle" devrait &ecirc;tre compl&eacute;t&eacute;e dans l''apr&egrave;s-midi.</li>
</ul>
<h3><br /></h3>
<h3>Jeudi 19 Mars</h3>
<ul>
<li>ATTENTION ! Le patron "D&eacute;composition en processus m&eacute;tier composant" est en cours de finalisation. Sa solution produit ne doit donc pas &ecirc;tre (encore) prise en compte. Ce patron et plusieurs autres seront finalis&eacute;s dans la matin&eacute;e du 20/03. En vous remerciant de votre compr&eacute;hension.</li>
<li>Des d&eacute;tails sur les diff&eacute;rents patrons, ainsi que diff&eacute;rentes fonctionnalit&eacute;s, seront ajout&eacute;s au fil de l''exp&eacute;rience. N''h&eacute;sitez pas &agrave; consulter r&eacute;guli&egrave;rement cette page pour suivre l''&eacute;volution !</li>
</ul>
<p>&nbsp;</p>
<p>Contact : Guillaume.Godet-Bar@imag.fr</p>');
INSERT INTO "pattern_systems" VALUES(266847005,'Guillaume Godet-Bar, David Juras','Système de test','','2009-04-01 11:28:53','2009-04-01 11:28:53',NULL,'','');
CREATE TABLE "use_patterns" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "source_pattern_id" integer, "target_pattern_id" integer, "created_at" datetime, "updated_at" datetime);
INSERT INTO "use_patterns" VALUES(14,33,14,'2009-03-17 08:48:01','2009-03-18 20:54:04');
INSERT INTO "use_patterns" VALUES(35,33,35,'2009-03-18 09:11:25','2009-03-18 20:01:23');
INSERT INTO "use_patterns" VALUES(36,35,36,'2009-03-18 09:34:42','2009-03-18 19:36:08');
INSERT INTO "use_patterns" VALUES(37,33,37,'2009-03-18 14:56:14','2009-03-19 07:30:30');
INSERT INTO "use_patterns" VALUES(39,37,39,'2009-03-18 14:59:45','2009-03-18 14:59:45');
INSERT INTO "use_patterns" VALUES(40,14,40,'2009-03-18 20:54:47','2009-03-19 10:22:25');
INSERT INTO "use_patterns" VALUES(41,35,41,'2009-03-18 22:46:17','2009-03-19 15:17:23');
INSERT INTO "use_patterns" VALUES(42,40,42,'2009-03-19 12:28:09','2009-03-19 12:28:09');
INSERT INTO "use_patterns" VALUES(43,35,43,'2009-03-19 15:32:07','2009-03-19 15:32:07');
INSERT INTO "use_patterns" VALUES(44,35,44,'2009-03-20 09:14:49','2009-03-20 09:14:49');
INSERT INTO "use_patterns" VALUES(45,37,45,'2009-03-20 13:23:17','2009-03-20 13:23:17');
INSERT INTO "use_patterns" VALUES(46,37,46,'2009-03-20 13:23:45','2009-03-20 13:23:45');
INSERT INTO "use_patterns" VALUES(47,37,47,'2009-03-20 13:26:20','2009-03-20 13:26:20');
INSERT INTO "use_patterns" VALUES(48,37,48,'2009-03-20 13:46:40','2009-03-20 13:46:40');
INSERT INTO "use_patterns" VALUES(136429199,136429198,136429199,'2009-03-20 18:37:02','2009-03-20 18:37:02');
INSERT INTO "use_patterns" VALUES(136429200,136429198,136429200,'2009-03-20 18:38:56','2009-03-20 18:38:56');
INSERT INTO "use_patterns" VALUES(136429201,136429200,136429201,'2009-03-20 18:40:21','2009-03-20 18:40:21');
INSERT INTO "use_patterns" VALUES(136429202,136429198,136429202,'2009-03-20 18:42:10','2009-03-20 18:43:51');
INSERT INTO "use_patterns" VALUES(136429203,136429202,136429203,'2009-03-20 18:45:15','2009-03-20 18:45:15');
INSERT INTO "use_patterns" VALUES(136429204,136429199,136429204,'2009-03-20 18:47:15','2009-03-20 18:47:15');
INSERT INTO "use_patterns" VALUES(136429205,136429200,136429205,'2009-03-20 18:48:39','2009-03-20 18:48:39');
INSERT INTO "use_patterns" VALUES(136429206,136429204,136429206,'2009-03-20 18:50:22','2009-03-20 18:50:22');
INSERT INTO "use_patterns" VALUES(136429207,136429200,136429207,'2009-03-20 18:53:19','2009-03-20 18:53:19');
INSERT INTO "use_patterns" VALUES(136429208,136429200,136429208,'2009-03-20 18:55:17','2009-03-20 18:55:17');
INSERT INTO "use_patterns" VALUES(136429209,136429202,136429209,'2009-03-20 21:47:56','2009-03-20 21:47:56');
INSERT INTO "use_patterns" VALUES(136429210,136429202,136429210,'2009-03-20 21:48:38','2009-03-20 21:48:38');
INSERT INTO "use_patterns" VALUES(136429211,136429202,136429211,'2009-03-20 21:49:37','2009-03-20 21:49:37');
INSERT INTO "use_patterns" VALUES(136429212,136429202,136429212,'2009-03-20 21:50:29','2009-03-20 21:50:29');
INSERT INTO "use_patterns" VALUES(136429213,136429203,136429213,'2009-03-22 11:31:43','2009-03-22 22:01:21');
INSERT INTO "use_patterns" VALUES(136429214,136429202,136429214,'2009-03-22 11:41:23','2009-03-22 11:41:23');
INSERT INTO "use_patterns" VALUES(136429215,136429202,136429215,'2009-03-22 15:47:04','2009-03-22 15:47:04');
INSERT INTO "use_patterns" VALUES(136429216,136429203,136429216,'2009-03-22 22:05:14','2009-03-22 22:22:19');
INSERT INTO "use_patterns" VALUES(136429217,136429203,136429217,'2009-03-22 22:08:30','2009-03-22 22:10:55');
CREATE TABLE "context_patterns" ("source_pattern_id" integer, "target_pattern_id" integer);
INSERT INTO "context_patterns" VALUES(70140977,136429197);
INSERT INTO "context_patterns" VALUES(136429199,136429198);
INSERT INTO "context_patterns" VALUES(136429200,136429198);
INSERT INTO "context_patterns" VALUES(136429201,136429200);
INSERT INTO "context_patterns" VALUES(136429202,136429198);
INSERT INTO "context_patterns" VALUES(136429203,136429202);
INSERT INTO "context_patterns" VALUES(136429204,136429199);
INSERT INTO "context_patterns" VALUES(136429205,136429200);
INSERT INTO "context_patterns" VALUES(136429205,136429204);
INSERT INTO "context_patterns" VALUES(136429206,136429204);
INSERT INTO "context_patterns" VALUES(136429207,136429200);
INSERT INTO "context_patterns" VALUES(136429208,136429200);
INSERT INTO "context_patterns" VALUES(136429208,136429207);
INSERT INTO "context_patterns" VALUES(136429209,136429202);
INSERT INTO "context_patterns" VALUES(136429211,136429202);
INSERT INTO "context_patterns" VALUES(136429211,136429209);
INSERT INTO "context_patterns" VALUES(136429211,136429210);
INSERT INTO "context_patterns" VALUES(136429212,136429202);
INSERT INTO "context_patterns" VALUES(136429213,136429203);
INSERT INTO "context_patterns" VALUES(136429214,136429202);
INSERT INTO "context_patterns" VALUES(136429215,136429202);
INSERT INTO "context_patterns" VALUES(136429210,136429202);
INSERT INTO "context_patterns" VALUES(136429216,136429203);
INSERT INTO "context_patterns" VALUES(136429217,136429203);
INSERT INTO "context_patterns" VALUES(136429225,136429224);
CREATE TABLE "participations" ("participant_id" integer, "process_pattern_id" integer, "created_at" datetime, "updated_at" datetime);
INSERT INTO "participations" VALUES(795762445,136429198,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762446,136429198,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429198,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762448,136429198,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762445,136429199,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762446,136429199,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429199,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762448,136429199,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762445,136429200,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762446,136429200,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429200,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762448,136429200,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762446,136429201,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429201,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762448,136429201,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762445,136429202,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762446,136429202,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429202,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762448,136429202,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762446,136429203,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429203,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762447,136429204,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762448,136429204,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762448,136429205,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762448,136429206,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762448,136429207,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762448,136429208,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762445,136429209,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762448,136429209,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762446,136429210,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429210,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762445,136429212,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762448,136429212,'2009-03-20 18:13:03','2009-03-20 18:13:03');
INSERT INTO "participations" VALUES(795762446,136429213,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429213,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762446,136429214,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762445,136429211,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762446,136429211,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429214,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762445,136429215,'2009-03-20 18:12:07','2009-03-20 18:12:07');
INSERT INTO "participations" VALUES(795762446,136429212,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429212,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762446,136429216,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429216,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762446,136429217,'2009-03-20 18:12:30','2009-03-20 18:12:30');
INSERT INTO "participations" VALUES(795762447,136429217,'2009-03-20 18:12:45','2009-03-20 18:12:45');
INSERT INTO "participations" VALUES(795762449,136429220,'2009-03-31 15:16:33','2009-03-31 15:16:33');
INSERT INTO "participations" VALUES(795762449,136429221,'2009-03-31 15:16:33','2009-03-31 15:16:33');
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
COMMIT;
