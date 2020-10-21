-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema articles3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema articles3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `articles3` DEFAULT CHARACTER SET utf8 ;
USE `articles3` ;

-- -----------------------------------------------------
-- Table `articles3`.`droit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles3`.`droit` (
  `iddroit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `droit_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`iddroit`),
  UNIQUE INDEX `droit_name_UNIQUE` (`droit_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `articles3`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles3`.`users` (
  `idusers` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `thename` VARCHAR(45) NULL,
  `thepwd` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL COMMENT 'Le binaire permet au mot de passe d\'être sensible à la casse (minuscule, majuscule)',
  `droit_iddroit` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE INDEX `thename_UNIQUE` (`thename` ASC),
  INDEX `fk_users_droit1_idx` (`droit_iddroit` ASC),
  CONSTRAINT `fk_users_droit1`
    FOREIGN KEY (`droit_iddroit`)
    REFERENCES `articles3`.`droit` (`iddroit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `articles3`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles3`.`articles` (
  `idarticles` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titre` VARCHAR(150) NOT NULL,
  `texte` TEXT NOT NULL,
  `thedate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `users_idusers` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idarticles`),
  UNIQUE INDEX `titre_UNIQUE` (`titre` ASC),
  INDEX `fk_articles_users_idx` (`users_idusers` ASC),
  CONSTRAINT `fk_articles_users`
    FOREIGN KEY (`users_idusers`)
    REFERENCES `articles3`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `articles3`.`theimages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles3`.`theimages` (
  `idtheimages` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `thetitle` VARCHAR(150) NULL,
  `thename` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idtheimages`),
  UNIQUE INDEX `thename_UNIQUE` (`thename` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `articles3`.`articles_has_theimages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles3`.`articles_has_theimages` (
  `articles_idarticles` INT UNSIGNED NOT NULL,
  `theimages_idtheimages` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`articles_idarticles`, `theimages_idtheimages`),
  INDEX `fk_articles_has_theimages_theimages1_idx` (`theimages_idtheimages` ASC),
  INDEX `fk_articles_has_theimages_articles1_idx` (`articles_idarticles` ASC),
  CONSTRAINT `fk_articles_has_theimages_articles1`
    FOREIGN KEY (`articles_idarticles`)
    REFERENCES `articles3`.`articles` (`idarticles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articles_has_theimages_theimages1`
    FOREIGN KEY (`theimages_idtheimages`)
    REFERENCES `articles3`.`theimages` (`idtheimages`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `articles3`.`rubriques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles3`.`rubriques` (
  `idrubriques` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `letitre` VARCHAR(120) NOT NULL,
  `letexte` VARCHAR(500) NULL,
  `rubriques_idrubriques` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`idrubriques`),
  INDEX `fk_rubriques_rubriques1_idx` (`rubriques_idrubriques` ASC),
  CONSTRAINT `fk_rubriques_rubriques1`
    FOREIGN KEY (`rubriques_idrubriques`)
    REFERENCES `articles3`.`rubriques` (`idrubriques`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `articles3`.`articles_has_rubriques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `articles3`.`articles_has_rubriques` (
  `articles_idarticles` INT UNSIGNED NOT NULL,
  `rubriques_idrubriques` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`articles_idarticles`, `rubriques_idrubriques`),
  INDEX `fk_articles_has_rubriques_rubriques1_idx` (`rubriques_idrubriques` ASC),
  INDEX `fk_articles_has_rubriques_articles1_idx` (`articles_idarticles` ASC),
  CONSTRAINT `fk_articles_has_rubriques_articles1`
    FOREIGN KEY (`articles_idarticles`)
    REFERENCES `articles3`.`articles` (`idarticles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articles_has_rubriques_rubriques1`
    FOREIGN KEY (`rubriques_idrubriques`)
    REFERENCES `articles3`.`rubriques` (`idrubriques`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

--
-- Base de données :  `articles`
--

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`idarticles`, `titre`, `texte`, `thedate`, `users_idusers`) VALUES
(1, 'Pourquoi le boson de Higgs est-il si important ?', 'Le boson de Higgs, via le « mécanisme de Brout-Englert-Higgs » (BEH) et son champ scalaire, est la clé de voûte du modèle standard. Celui-ci combine les équations du modèle électrofaible décrivant les forces électromagnétiques et la radioactivité bêta avec celles de la chromodynamique quantique (QCD) décrivant protons et neutrons, mais laisse à l\'écart la relativité générale d\'Einstein. Au début, les équations qui allaient devenir la base de ces théories modernes de la physique des particules, les équations de Yang-Mills que l\'on retrouve notamment au coeur du modèle électrofaible, aboutissaient à un gros problème. \r\n\r\nElles semblaient interdire aux particules médiatrices de la force nucléaire faible (des bosons cousins du photon) d\'avoir des masses, celle-ci devait donc avoir une portée infinie, ce qui est en forte contraction avec toutes les observations.\r\n\r\nLe recours au mécanisme BEH a permis de donner une masse aux bosons W et Z de ce modèle, résolvant du même coup des problèmes de renormalisation liés à l\'apparition de quantités infinies dans les calculs alors que l\'observation en donne des mesures finies.\r\n\r\nMesurer le boson de Higgs, c\'est tester le modèle standard\r\nBien avant sa découverte au Cern en 2012, le boson de Higgs était déjà bien connu par des calculs dans le cadre du modèle standard, conduisant à des prédictions vérifiées depuis les années 1970 et, surtout, 1980. Sa masse restait cependant énigmatique et quelques théories permettaient de s\'en passer plus ou moins pour construire le modèle standard... ou indiquaient qu\'il n\'existait pas.\r\n\r\nEn revanche, plusieurs des théories allant au-delà du modèle standard, notamment celles qui expliqueraient la nature de l\'énergie noire et de la matière noire, impliquent que le comportement et la nature du boson de Higgs diffèrent de ce qu\'en dit le modèle standard. Il était donc important de vérifier son existence, de manière à consolider et préciser les prédictions du modèle standard, de sorte de pouvoir repérer des phénomènes qui lui échappent, voire ouvrir la porte sur une nouvelle physique.', '2020-09-27 19:16:27', 2),
(2, 'Les enseignes Casino forment les caissières à l’évolution de leur métier', 'Le métier de caissière dans la grande distribution apparaît voué à évoluer voire à disparaître dans certaines cas. Les enseignes Casino pour leur part préparent la nouvelle étape par un plan de formation ad hoc. 10 engagements dans le programme CAPC’est ce qu’elles ont présenté à l’occasion d’une conférence de presse le 23 septembre organisée ...', '2020-09-27 19:17:48', 1),
(3, 'La Chine emprunte à ses politiques au Xinjiang pour siniser encore davantage le Tibet', 'Après le Xinjiang, le Tibet : les autorités chinoises ont mis en place dans la région autonome tibétaine un programme de formations professionnelles et de transfert de main-d’œuvre qui adopte certaines des méthodes musclées déployées ces dernières années auprès des Ouïgours. Les deux régions, qui n’ont d’autonome que le nom, sont dirigées d’une main de fer par le parti communiste, et le Tibet est interdit d’accès aux journalistes étrangers.\r\n\r\nLors d’un sommet réuni en urgence sur le Tibet fin août sur fond de tensions à la frontière avec l’Inde, le président chinois Xi Jinping a rehaussé le niveau d’alerte le concernant par d’inquiétantes formules : il a appelé à faire du Tibet une « forteresse imprenable de stabilité », à « relancer l’offensive contre les éléments séparatistes », et à « siniser le bouddhisme tibétain ».\r\n\r\nLe nouveau programme, mis en œuvre en 2019, aurait rempli 90 % de ses objectifs dans les sept premiers mois de l’année 2020, touchant environ 500 000 « travailleurs ruraux en surplus », dont environ 50 000 ont été « transférés » vers des emplois de services ou industriels à l’intérieur du Tibet, et environ 3 000 en dehors, selon un compte rendu officiel du gouvernement régional. Les bénéficiaires de ces politiques sont aussi incités à placer le cas échéant leurs terres dans des coopératives, dont ils deviendraient des « actionnaires », afin de pouvoir se salarier.\r\n\r\nLa population de la région autonome tibétaine est de 3,5 millions, dont 90 % de Tibétains en excluant les forces armées chinoises et les saisonniers. Les « travailleurs ruraux en surplus » ciblés par le nouveau programme désignent des paysans ou des éleveurs dont les activités sont considérées comme insuffisantes pour faire s’enrichir leur foyer. Nombre de jeunes Tibétains, une population jugée comme d’autant plus turbulente aux yeux de l’Etat chinois que les monastères en absorbent de moins en moins, entrent dans cette catégorie.', '2020-09-27 19:18:46', 4),
(4, 'Un recours collectif en référé-liberté est déposé contre la fermeture totale des bars et restaurants à Marseille et Aix', 'Jusqu’où iront les restrictions imposées pour freiner l’épidémie de Covid-19 ? Alors que les mesures annoncées mercredi par le ministre de la santé, Olivier Véran, commencent à se mettre en place territoire par territoire, un collectif de médecins a réclamé, dimanche 27 septembre, la mise en place immédiate de « mesures drastiques » pour éviter une deuxième vague qui serait « bien plus difficile à gérer pour les hôpitaux et les services de réanimation que la première ». De son côté, Olivier Véran n’a pas exclu des limitations de circulation pendant les vacances de Toussaint.\r\n\r\nSelon la nouvelle cartographie de l’épidémie présentée mercredi, Marseille et la Guadeloupe sont classées en zone d’« alerte maximale ». Onze métropoles, dont Paris et la petite couronne, sont classées en « alerte renforcée ». Et tous les départements sont en situation de « vulnérabilité ». L’épidémie liée au nouveau coronavirus en France est dans « une phase ascendante », selon Santé publique France. Et, parmi les points « inquiétants », l’agence sanitaire relève la « circulation de plus en plus forte » du virus chez les personnes âgées.', '2020-09-27 19:19:30', 3),
(5, 'Cour suprême : \"La campagne présidentielle américaine passe au second plan\"', 'Alors que le premier débat télévisé entre Donald Trump et Joe Biden doit se tenir mardi soir, la nomination de la juge conservatrice Amy Coney Barrett à la Cour suprême a soudainement fait passer la campagne présidentielle au second plan de l’actualité politique américaine. Interview de Jean-Éric Branaa, chercheur, et auteur d\'une biographie de l’ancien vice-président de Barack Obama.\r\n\r\nÀ un peu plus d’un mois de l’élection présidentielle américaine du 3 novembre, la course à la Maison Blanche semble s’être figée avec le décès de la doyenne de la Cour suprême, Ruth Bader Ginsburg, et la nomination, samedi 26 septembre, d’Amy Coney Barrett, proposée par Donald Trump pour la remplacer.\r\n\r\nPourtant, le président sortant et son adversaire démocrate, Joe Biden, doivent débattre pour la première fois sur Fox News, mardi 29 septembre, mais les chaînes d’information tournent en boucle sur la probable future juge conservatrice à la Cour suprême et le processus de confirmation à venir au Sénat.', '2020-09-27 19:19:59', 2),
(6, 'Libre circulation: l\'UE salue le refus suisse de lui tourner le dos', '\"C\'est un grand jour pour les relations entre l\'Union européenne et la Suisse. Nous saluons les résultats du vote populaire et nous nous réjouissons de poursuivre notre étroite collaboration. Le peuple helvétique s\'est prononcé en envoyant un message clair: ensemble, nous avons un bel avenir devant nous\", a tweeté le président du Conseil européen, Charles Michel.', '2020-09-27 19:20:33', 4),
(7, 'Les avocats du barreau d’Alger en grève pour « une justice indépendante »', 'Plusieurs dizaines d’avocats ont organisé dimanche 27 septembre un sit-in à la Cour d’Alger avant de se mettre en grève pendant une semaine pour réclamer une « justice indépendante » et « le respect des droits de la défense », selon des journalistes de l’AFP. Vêtus de leurs robes noires et portant des masques sanitaires, les manifestants ont entonné l’hymne national et brandi le drapeau algérien en reprenant certains slogans du « Hirak », le mouvement de protestation antirégime, comme « Etat civil et non militaire » ou encore « le peuple veut une justice indépendante ».\r\n\r\nParallèlement, les avocats ont également décidé d’observer une grève d’une semaine de leurs activités, à compter de dimanche, dans tous les tribunaux dépendants de la Cour d’Alger. Ce mouvement a été provoqué par un récent incident au cours duquel le bâtonnier de l’ordre des avocats d’Alger a été, selon des protestataires, « humilié » par un juge de la Cour d’Alger.', '2020-09-27 19:21:15', 1),
(8, 'Pourquoi le vote par courrier complique la présidentielle américaine', '« Fraude », « désastre », « arnaque »… voici comment Donald Trump envisage l’impact du vote postal sur l’élection présidentielle de 2020. Car en raison de l’épidémie de Covid-19, vingt-trois Etats sur les cinquante que compte le pays ont facilité le vote par courrier. Près de 84 % des Américains pourraient donc voter ainsi.\r\n\r\nAlors que l’enjeu d’un vote à distance était d’abord sanitaire, les déclarations incendiaires de Donald Trump en ont fait un enjeu partisan : les républicains s’en prennent désormais aux mail-in ballots (les « bulletins par correspondance »), tandis que les démocrates, eux, appellent à voter massivement par courrier. La bataille d’opinion fait rage alors que les études existantes, pourtant, tendant à montrer ce vote est plutôt sûr et neutre.\r\n\r\nMais au-delà du duel politique, le vote par correspondance fait planer l’incertitude sur les résultats de la présidentielle. Les règles varient en effet d’un Etat à l’autre, dépouiller des votes par correspondance prend du temps et des retards de courrier sont à craindre : le scrutin intervient alors que les services postaux sont en difficulté après des restructurations lancées par leur nouveau patron, Louis DeJoy, un proche de Donald Trump.', '2020-09-27 19:21:44', 3),
(9, 'Meurtre de Mbaye Wade à Liège: un suspect inculpé d\'assassinat, l\'autre de meurtre', 'Deux individus ont été interpellés vendredi matin dans le cadre du meurtre de Mbaye Wade, survenu le 18 septembre à Liège. Ils sont passés aux aveux et l\'auteur des coups a remis l\'arme du crime aux enquêteurs. Les deux hommes sont ceux qui apparaissaient sur les images de vidéosurveillances diffusées jeudi par la police. Les deux suspects ont été interrogés samedi après-midi par le juge d\'instruction chargé de l\'affaire, qui a inculpé l\'auteur des coups d\'assassinat, soit de meurtre avec préméditation. Son complice, qui l\'a rejoint une demi-heure après le crime, a quant à lui, été inculpé de meurtre.\r\n\r\nIls avaient déjà été entendus par la police vendredi et l\'auteur des coups avait expliqué que le jour des faits, il avait un rendez-vous privé avec la victime, qu\'il rencontrait pour la deuxième fois. Il a précisé que la situation s\'était envenimée et qu\'une dispute avait éclaté entre eux. Il a ajouté qu\'il avait, dans l\'action, sorti un couteau et frappé mortellement Mbaye Wade.\r\n\r\nL\'individu a ensuite contacté le second suspect, qui est venu le rejoindre sur les lieux du crime. Les deux hommes ont alors volé plusieurs objets de valeur avant de prendre la fuite, laissant le corps sans vie de la victime dans la chambre d\'ami de l\'habitation. Le parquet a précisé qu\'il ne s\'agit pas d\'un crime homophobe car l\'auteur est lui-même homosexuel. Plusieurs centaines de personnes s\'étaient rassemblées samedi matin à 09h30 devant le funérarium de Robermont où une cérémonie en l\'honneur de Mbaye Wade s\'est tenue. Plusieurs avocats, le gouverneur de la province de Liège, le collège provincial, des conseillers, ses collègues, sa famille et des personnalités du MR comme la première échevine de la Ville de Liège Christine Defraigne et la députée provinciale Katty Firquet, lui ont rendu un dernier hommage.', '2020-09-27 19:22:50', 2),
(10, 'Tensions au Bélarus : des dizaines d\'arrestations lors d\'une nouvelle marche de l\'opposition', '(Belga) La police bélarusse a arrêté des dizaines de personnes lors d\'une nouvelle manifestation de l\'opposition rassemblant quelque 50.000 personnes dimanche contre le président Alexandre Loukachenko, qui a prêté serment de manière inattendue cette semaine, malgré un mouvement de contestation sans précédent.\r\n\r\nQuelque 50.000 personnes défilaient sous la pluie à Minsk, selon des journalistes de l\'AFP sur place, soit moins que les quelque 100.000 personnes dénombrées les semaines précédentes. Au moins quarante personnes ont déjà été arrêtées, selon le groupe de défense des droits humains Viasna. Selon ce même groupe, la police a utilisé du gaz lacrymogène à Gomel, deuxième ville du pays, et des grenades assourdissantes à Moguilev (est). Dans le centre de Minsk, des véhicules blindés ont été déployés et plusieurs stations de métro ont été fermées. Le Palais de l\'Indépendance, où siège M. Loukachenko et où des rassemblements massifs ont convergé dernièrement, était hérissé de barrières et lourdement gardé par la police anti-émeutes. Plusieurs places centrales et des centres commerciaux où des manifestants se sont réfugiés par le passé ont également été fermés. M. Loukachenko est confronté depuis la présidentielle du 9 août à une contestation inédite, des dizaines de milliers de personnes sortant dans la rue chaque dimanche à Minsk pour dénoncer sa réélection jugée frauduleuse, en dépit de la répression du mouvement. \"Nous sommes des millions\", a affirmé la rivale de M. Loukachenko, Svetlana Tikhanovskaïa, dans un message publié dimanche sur les réseaux sociaux pour soutenir les manifestants lors du \"50ème jour de nos manifestations\". \"Nous allons gagner\", a-t-elle assuré, rappelant la nature \"pacifique\" du mouvement. Ces rassemblements surviennent après qu\'Alexandre Loukachenko a prêté serment mercredi pour un sixième mandat, provoquant de nouvelles manifestations le jour même. La cérémonie au palais présidentiel n\'avait pas été annoncée et s\'est déroulée en catimini. Le gouvernement allemand a jugé que \"le secret\" entourant la cérémonie d\'investiture était \"révélateur\" des faiblesses du régime et que faute de \"légitimité démocratique\", Berlin ne reconnaissait pas la réélection de M. Loukachenko. Le président français Emmanuel Macron doit effectuer pour sa part de lundi à mercredi sa première visite en Lituanie et en Lettonie, deux Etats baltes qui espèrent son appui face à la crise politique au Belarus voisin et aux pressions russes. L\'UE a indiqué ne pas reconnaître la légitimité de M. Loukachenko, tout comme les Etats-Unis. M. Loukachenko, qui accuse les Occidentaux d\'avoir fomenté la protestation, a promis une vague réforme constitutionnelle pour répondre à cette crise politique mais il a exclu tout dialogue avec les détracteurs du régime qu\'il pilote depuis 1994. Il a demandé l\'aide de son homologue russe Vladimir Poutine, qui a promis un soutien sécuritaire à Minsk si nécessaire et promis au Bélarus un prêt de 1,5 milliard de dollars. Le régime bélarusse a emprisonné de nombreux cadres du Conseil de coordination de l\'opposition crée par Mme Tikhanovskaïa. D\'autres ont dû fuir leur pays. (Belga)', '2020-09-27 19:23:31', 4),
(11, 'Europe: l\'Azerbaïdjan et l\'Arménie au bord de la GUERRE depuis ce dimanche matin', 'L\'Arménie et l\'Azerbaïdjan étaient au bord de la guerre dimanche, des combats meurtriers ayant éclaté entre les forces azerbaïdjanaises et la région séparatiste du Nagorny Karabakh soutenue par Erevan, capitale arménienne.\r\n\r\nLes belligérants ont fait état de victimes militaires et civiles. Selon la partie arménienne, une femme et un enfant ont été tués. Deux hélicoptères et trois drones azerbaïdjanais ont été abattus, a par ailleurs indiqué le ministère arménien de la Défense, qui soutient les séparatistes.\r\n\r\nLe Nagorny Karabakh est un région sécessionniste d\'Azerbaïdjan, peuplée majoritairement d\'Arméniens et soutenue par l\'Arménie. Elle a été le théâtre d\'une guerre au début des années 1990 ayant fait 30.000 morts et, depuis, les autorités azerbaïdjanaises veulent en reprendre le contrôle, par la force si nécessaire, alors que des pourparlers de paix sont dans l\'impasse depuis de longues années. Des combats opposent régulièrement séparatistes et Azerbaïdjanais, ainsi que Erevan et Bakou. En 2016, de graves heurts armés avaient failli dégénérer en guerre au Karabakh, et des combats ont aussi opposé en juillet 2020 Arméniens et Azerbaïdjanais à leur frontière.', '2020-09-27 19:24:08', 3),
(12, 'Incendies en Australie', 'Cette étude est le résultat d\'une collaboration internationale, impliquant trois laboratoires de l\'Institut Pierre Simon Laplace. Elle vient d\'être publiée dans la la nouvelle revue du groupe Springer Nature Communication Earth and Environment. Sergey Khaykin, premier auteur de l\'article et chercheur au Latmos /IPSL, revient sur cette découverte et explique comment les incendies des forêts australiennes ont pu avoir un impact sur la stratosphère.\r\n\r\nUn phénomène atmosphérique spectaculaire associé à des feux de forêt très intenses consiste en des orages appelés Pyrocumulonimbus (PyroCb). Ces orages violents, portés par la chaleur des feux de forêt, peuvent générer de puissants courants ascendants, envoyant des panaches de particules de suie et de glace dans la stratosphère.', '2020-09-27 19:25:00', 2),
(16, 'Le rappeur bruxellois Benny B tend la main aux victimes de violences conjugales dans une nouvelle chanson', 'Mettre ces monstres face à leur propre image. Ils ne pourront plus se cacher. Ils vont se reconnaître dans ce texte. Mais ils vont aussi savoir que maintenant tout le monde sait comment et qui ils sont. C’est à la justice de les juger. Mais aucune excuse ne justifie des coups, des blessures et un meurtre. Un monstre est un monstre. Comment voulez-vous qu’une victime accepte des excuses quand elle a été humiliée, violentée, agressée, violée pendant des années ? Et quand elle a été tuée… Comment voulez-vous qu’il y ait un pardon ? Je comprends que la famille et les proches des victimes puissent avoir des moments de haine et vouloir autre chose que la simple incarcération d’un monstre. Ce texte peut aussi aider les victimes à ne plus se sentir seules.', '2020-09-27 19:26:30', 4),
(17, 'Carbone & Silicium est la bande dessinée cyberpunk de la rentrée 2020', 'Mathieu Bablet a déjà commencé à se faire un nom dans la bande dessinée grâce à La Belle Mort en 2011, puis à Adrastée en 2013 et à Shangri-La en 2016. En cette rentrée littéraire de septembre 2020, Mathieu Bablet livre une BD de science-fiction de haut niveau, apte à marquer de son empreinte le cyberpunk français.\r\n\r\nC’est d’abord en raison de l’ambition de l’auteur avec ce qui est un véritable pavé : 272 pages bien remplies — clairement, il s’agit d’un bel objet, qu’on garde précieusement, voire que l’on expose fièrement. L’épaisseur de la BD vient avec un souci de la précision, un travail d’orfèvre tant sur les traits que la mise en scène. La colorisation minutieuse, variée, expressive, est l’un des points forts tant les couleurs participent à « raconter » l’histoire (comme toujours avec les œuvres de Mathieu Bablet).', '2020-09-27 19:27:01', 3),
(18, 'Cours Laravel 8 – la sécurité – l’authentification', 'L’authentification constitue une tâche fréquente. En effet il y a souvent des parties d’un site qui ne doivent être accessibles qu’à certains utilisateurs, ne serait-ce que l’administration. La solution proposée par Laravel est d’une grande simplicité parce que tout est déjà préparé comme nous allons le voir dans ce chapitre.\r\n\r\nAu fil de l’avolution de Laravel ce domaine a connu plusieurs fois des changements. Ainsi avec Laravel 6 est apparu une nouveauté. Précédemment il y avait la commande php artisan make:auth pour générer les vues. Cette commande a disparu au profit d’un package à installer (laravel/ui). Mais les changements continuent parce que désormais on nous dit d’utiliser Jetstream. Je vais donc orienter mon cours sur ce nouveau package.', '2020-09-27 19:27:39', 3),
(19, 'Les États-Unis renforcent encore les restrictions commerciales avec le plus gros fabricant de puces chinois', 'La guerre commerciale entre les États-Unis et la Chine est loin d\'être terminée. L\'administration Trump cible les géants de la tech chinoise. Et aujourd\'hui, une nouvelle étape vient d\'être franchie.\r\nLes États-Unis n’ont pas perdu de temps à bloquer les ventes du plus grand fabricant de puces chinois. Selon Reuters et le Wall Street Journal, le Département du Commerce vient d’ajouter Semiconductor Manufacturing International Corporation (SMIC) à sa liste noire, bloquant ainsi toute interaction entre les fournisseurs américains et la firme chinoise. Les sociétés américaines doivent désormais obtenir une licence d’exportation individuelle pour faire des affaires avec SMIC et celles-ci vont être très rares.\r\n\r\nLes États-Unis bannissent désormais le fabricant de puces SMIC\r\nLe Département du Commerce a déclaré ce bannissement commercial suite à des déclarations concernant le fait que les technologies de SMIC pourraient être utilisées dans des opérations militaires chinoises. Un contractuel de la défense américaine, SOS International, affirmait il y a peu que SMIC avait travaillé avec les deux plus grandes entreprises de défense de Chine et que des chercheurs universitaires en lien avec l’armée travaillaient sur des projets basés sur les technologies de SMIC.', '2020-09-27 19:28:53', 2),
(20, 'Sénatoriales 2020 : retrouvez les résultats des élections', 'Près de la moitié des sièges du Sénat étaient à pourvoir, dimanche 27 septembre, dans 58 départements de métropole, un département et quatre collectivités d’outre-mer. En raison de l’épidémie de Covid-19, le renouvellement de six des douze sénateurs représentant les Français établis hors de France a été reporté à septembre 2021.\r\n\r\nLe scrutin a clos à 17 h 30. Les premiers résultats qui ont commencé à tomber, dans les départements les moins peuplés, font apparaître une prime aux sortants, avec notamment plusieurs LR et centristes, majoritaires au Sénat, réélus dès le premier tour.\r\n\r\nLe renouvellement par moitié du Sénat tous les trois ans se joue à l’échelle du département. Cette année sont concernés 172 sièges sur 348, soit les élus de 58 départements de métropole compris entre l’Ain et l’Indre et entre le Bas-Rhin et le Territoire de Belfort, hors Ile-de-France. Outre-mer sont aussi renouvelés les sénateurs de la Guyane et de 4 collectivités (Wallis et Futuna, Saint-Barthélemy, Saint-Martin, Polynésie française). 117 sortants se représentaient.', '2020-09-27 19:29:16', 3);

--
-- Déchargement des données de la table `articles_has_rubriques`
--

INSERT INTO `articles_has_rubriques` (`articles_idarticles`, `rubriques_idrubriques`) VALUES
(6, 18),
(6, 19),
(10, 19),
(6, 20),
(6, 24),
(10, 24);

--
-- Déchargement des données de la table `droit`
--

INSERT INTO `droit` (`iddroit`, `droit_name`) VALUES
(1, 'Administrat.eur.rice'),
(2, 'Rédact.eur.rice');

--
-- Déchargement des données de la table `rubriques`
--

INSERT INTO `rubriques` (`idrubriques`, `letitre`, `letexte`, `rubriques_idrubriques`) VALUES
(18, 'Belgique', NULL, 0),
(19, 'Monde', NULL, 0),
(20, 'Économie', NULL, 0),
(21, 'Sports', NULL, 0),
(22, 'Culture', NULL, 0),
(23, 'Opinions', NULL, 0),
(24, 'Politique', NULL, 0);

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`idusers`, `thename`, `thepwd`, `droit_iddroit`) VALUES
(1, 'Patrick', 'Patrick', 2),
(2, 'Christiane', 'Christiane', 1),
(3, 'Karima', 'Karima', 2),
(4, 'Joe', 'Joe', 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
