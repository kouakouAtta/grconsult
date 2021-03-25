-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  ven. 19 mars 2021 à 09:20
-- Version du serveur :  10.4.10-MariaDB
-- Version de PHP :  7.4.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `grconsult`
--

-- --------------------------------------------------------

--
-- Structure de la table `apropos`
--

DROP TABLE IF EXISTS `apropos`;
CREATE TABLE IF NOT EXISTS `apropos` (
  `aproposId` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(45) NOT NULL,
  `sousTitre` varchar(45) NOT NULL,
  `text` longtext NOT NULL,
  PRIMARY KEY (`aproposId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `banniere`
--

DROP TABLE IF EXISTS `banniere`;
CREATE TABLE IF NOT EXISTS `banniere` (
  `banniereId` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`banniereId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `clientsetprestataires`
--

DROP TABLE IF EXISTS `clientsetprestataires`;
CREATE TABLE IF NOT EXISTS `clientsetprestataires` (
  `clientsEtPrestatairesId` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(191) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `titre` varchar(45) DEFAULT NULL,
  `slogan` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`clientsEtPrestatairesId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cnd_participation`
--

DROP TABLE IF EXISTS `cnd_participation`;
CREATE TABLE IF NOT EXISTS `cnd_participation` (
  `cndParticipationId` int(11) NOT NULL AUTO_INCREMENT,
  `montant` varchar(100) NOT NULL,
  `remise` int(11) NOT NULL,
  `niveau` int(11) NOT NULL,
  `profession` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `formationId` int(11) NOT NULL,
  PRIMARY KEY (`cndParticipationId`),
  UNIQUE KEY `formationId` (`formationId`),
  UNIQUE KEY `profession` (`profession`,`niveau`),
  KEY `niveau` (`niveau`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `commune`
--

DROP TABLE IF EXISTS `commune`;
CREATE TABLE IF NOT EXISTS `commune` (
  `communeId` int(11) NOT NULL,
  `nomCommune` varchar(45) DEFAULT NULL,
  `villeId` int(11) NOT NULL,
  PRIMARY KEY (`communeId`,`villeId`),
  KEY `fk_commune_ville1_idx` (`villeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commune`
--

INSERT INTO `commune` (`communeId`, `nomCommune`, `villeId`) VALUES
(1, 'COCODY', 1),
(2, 'YOPOUGON', 1),
(3, 'ADJAME', 1),
(4, 'BINGERVILLE', 1),
(5, 'TREICHVILLE', 1),
(6, 'MARCORY', 1),
(7, 'HABITAT', 2);

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `contactId` int(11) NOT NULL AUTO_INCREMENT,
  `telephone` varchar(20) DEFAULT NULL,
  `fixe` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `horaires` varchar(191) DEFAULT NULL,
  `contactLocalisatonAdresseId` int(11) NOT NULL,
  PRIMARY KEY (`contactId`,`contactLocalisatonAdresseId`),
  KEY `fk_contact_contactLocalisatonAdresse1_idx` (`contactLocalisatonAdresseId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `contact`
--

INSERT INTO `contact` (`contactId`, `telephone`, `fixe`, `email`, `horaires`, `contactLocalisatonAdresseId`) VALUES
(1, '(+225)0595407894', '22015889 ', 'infos@grconsult.ci', 'Ouvert Du Lundi au vendredi: 8h-18h', 1),
(2, '(+225)0785407894', '22355887 ', 'infos@grconsult.ci', 'Ouvert Du Lundi au vendredi: 8h-18h', 2);

-- --------------------------------------------------------

--
-- Structure de la table `contactform`
--

DROP TABLE IF EXISTS `contactform`;
CREATE TABLE IF NOT EXISTS `contactform` (
  `contactFormId` int(11) NOT NULL AUTO_INCREMENT,
  `nomUser` varchar(45) NOT NULL,
  `EmailUser` varchar(45) NOT NULL,
  `sujet` varchar(45) NOT NULL,
  `Message` longtext NOT NULL,
  PRIMARY KEY (`contactFormId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `contactform`
--

INSERT INTO `contactform` (`contactFormId`, `nomUser`, `EmailUser`, `sujet`, `Message`) VALUES
(1, 'atta abraham', 'kouakouw.kouakou@gmail.com', 'TEST', 'atta merci pour ce test'),
(2, 'attatio', 'kouakouw.kouakou@gmail.com', 'TEST2', 'c\'est bon mon frère');

-- --------------------------------------------------------

--
-- Structure de la table `contactlocalisatonadresse`
--

DROP TABLE IF EXISTS `contactlocalisatonadresse`;
CREATE TABLE IF NOT EXISTS `contactlocalisatonadresse` (
  `contactLocalisatonAdresseId` int(11) NOT NULL,
  `quartier` varchar(45) NOT NULL,
  `description` longtext NOT NULL,
  `villeId` int(11) NOT NULL,
  `paysId` int(11) NOT NULL,
  `communeId` int(11) NOT NULL,
  PRIMARY KEY (`contactLocalisatonAdresseId`,`villeId`,`paysId`,`communeId`),
  KEY `fk_contactLocalisatonAdresse_ville1_idx` (`villeId`,`paysId`),
  KEY `fk_contactLocalisatonAdresse_commune1_idx` (`communeId`),
  KEY `paysId` (`paysId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `contactlocalisatonadresse`
--

INSERT INTO `contactlocalisatonadresse` (`contactLocalisatonAdresseId`, `quartier`, `description`, `villeId`, `paysId`, `communeId`) VALUES
(1, 'Akouedo', 'Akouedo Est, route de Bingerville (non loin de la pharmacie Jules Verne) immeuble ONEP BS, 3ème étage, porte n°2 à gauche', 1, 1, 1),
(2, 'angré terminus 81/82', 'Angré terminus 81/82 , en face du supermarché King Cash. Route 7ième tranche', 1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `formation`
--

DROP TABLE IF EXISTS `formation`;
CREATE TABLE IF NOT EXISTS `formation` (
  `formationId` int(11) NOT NULL,
  `libelle` varchar(45) NOT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `lieu` varchar(45) DEFAULT NULL,
  `dateCreation` date DEFAULT NULL,
  `typeFormationId` int(11) NOT NULL,
  PRIMARY KEY (`formationId`,`typeFormationId`),
  KEY `fk_formation_typeFormation_idx` (`typeFormationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `galerie`
--

DROP TABLE IF EXISTS `galerie`;
CREATE TABLE IF NOT EXISTS `galerie` (
  `galerieId` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `formationId` int(11) NOT NULL,
  PRIMARY KEY (`galerieId`,`formationId`),
  KEY `fk_galerie_formation1_idx` (`formationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `mediaId` int(11) NOT NULL,
  `scrName` varchar(45) DEFAULT NULL,
  `dateCreation` varchar(45) DEFAULT NULL,
  `typeMadiaId` int(11) NOT NULL,
  `galerieId` int(11) NOT NULL,
  PRIMARY KEY (`mediaId`,`typeMadiaId`,`galerieId`),
  KEY `fk_media_typeMadia1_idx` (`typeMadiaId`),
  KEY `fk_media_galerie1_idx` (`galerieId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `module`
--

DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `moduleId` int(11) NOT NULL,
  `libelle` varchar(45) NOT NULL,
  `contenu` longtext DEFAULT NULL,
  `formationId` int(11) NOT NULL,
  PRIMARY KEY (`moduleId`,`formationId`),
  KEY `fk_module_formation1_idx` (`formationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `niveau`
--

DROP TABLE IF EXISTS `niveau`;
CREATE TABLE IF NOT EXISTS `niveau` (
  `niveauId` int(11) NOT NULL,
  `libelle` varchar(20) NOT NULL,
  PRIMARY KEY (`niveauId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `paysId` int(11) NOT NULL,
  `codeFr` varchar(10) DEFAULT NULL,
  `codeEn` varchar(10) DEFAULT NULL,
  `libelleEn` varchar(45) DEFAULT NULL,
  `libelleFr` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`paysId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`paysId`, `codeFr`, `codeEn`, `libelleEn`, `libelleFr`) VALUES
(1, 'CI', 'CI', 'IVORY COST', 'CÖTE D\'IVOIRE');

-- --------------------------------------------------------

--
-- Structure de la table `permission`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `permissionId` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`permissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `permissionrole`
--

DROP TABLE IF EXISTS `permissionrole`;
CREATE TABLE IF NOT EXISTS `permissionrole` (
  `permissionId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`permissionId`,`roleId`,`userId`),
  KEY `fk_permission_has_role_role1_idx` (`roleId`),
  KEY `fk_permission_has_role_permission1_idx` (`permissionId`),
  KEY `fk_permissionRole_user1_idx` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `prestationservice`
--

DROP TABLE IF EXISTS `prestationservice`;
CREATE TABLE IF NOT EXISTS `prestationservice` (
  `prestationServiceId` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(45) NOT NULL,
  `image` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`prestationServiceId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `prestationservice`
--

INSERT INTO `prestationservice` (`prestationServiceId`, `libelle`, `image`) VALUES
(1, 'MUTUALITE / VIE ASSOCIATIVE', 'flaticon-collaboration'),
(2, 'ACCOMPAGNEMENT JURIDIQUE', 'flaticon-handshake'),
(3, 'COMPTABILITE ET FISCALILITE', 'flaticon-money'),
(4, 'COACHING / ENTREPRENARIAT', 'flaticon-search-engine'),
(5, 'FORMATIONS', 'flaticon-insurance'),
(6, 'MARKETING STRATEGY', 'flaticon-rating');

-- --------------------------------------------------------

--
-- Structure de la table `profession`
--

DROP TABLE IF EXISTS `profession`;
CREATE TABLE IF NOT EXISTS `profession` (
  `professionId` int(11) NOT NULL,
  `libelle` int(11) NOT NULL,
  PRIMARY KEY (`professionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `roleId` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `section`
--

DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `sectionId` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(191) DEFAULT NULL,
  `text` longtext NOT NULL,
  `prestationServiceId` int(11) NOT NULL,
  PRIMARY KEY (`sectionId`) USING BTREE,
  KEY `prestationServiceId` (`prestationServiceId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `section`
--

INSERT INTO `section` (`sectionId`, `libelle`, `text`, `prestationServiceId`) VALUES
(1, 'CONSTITUTION', 'Etude de faisabilité, sensibilisations, mise en place des organes dirigeants, rédaction des textes statutaires,organisation d\'assemblée générale, établissement du dossier pour obtention de l\'agrément aupès des organes habilités', 1),
(2, 'ASSISTANCE EN GESTION', 'Mise en place de la gestion du système de santé(mutuelles sociales); Suivi administratif juridique et financier (rédation d\'actes juridiques, suivi comptable et fiscal);Evaluation et suivi du système interne de gestion', 1),
(3, 'COACHING EN DÉVELOPPEMENT', 'stratégies de développemnt, de négociation et marketing, développement du capital humain', 1),
(4, 'Conseils et consultations juridiques', '', 2),
(5, 'Analyse et rédaction d’actes juridiques et veille juridique', '', 2),
(6, 'Création de société(établissement du dossier pour la création, suivi des démarches auprès du cepici', '', 2),
(7, 'Recouvrement amiable et judiciaire', '', 2),
(8, 'Etats financiers', '', 3),
(9, 'Suivi comptable et fiscal', '', 3),
(10, 'Déclarations comptables, fiscales et sociales', '', 3),
(11, 'Coaching individuel', '', 4),
(12, 'Coaching d’équipe', '', 4),
(13, 'Initiation à l’entreprenariat et stratégies de développement', '', 4),
(14, 'Mutualité, protection et sécurité sociale, ressources humaines,développemnt personnel', '', 5),
(15, 'Marketing, management, communication, gestion, finance, informatique et TIC', '', 5),
(16, 'Droit, comptabilité, fiscalité, audit, entreprenariat, assistanat de direction,secrétariat, informatique et digital etc.', '', 5),
(17, 'Team bulding, séminaires, conférences, ateliers etc.', '', 5);

-- --------------------------------------------------------

--
-- Structure de la table `slides`
--

DROP TABLE IF EXISTS `slides`;
CREATE TABLE IF NOT EXISTS `slides` (
  `slidesId` int(15) NOT NULL,
  `image` varchar(191) NOT NULL,
  `titre` varchar(125) NOT NULL,
  `libelle` varchar(100) NOT NULL,
  `libelleBtnService` varchar(45) NOT NULL,
  `UrlBtnService` text NOT NULL,
  `DateCreation` datetime NOT NULL DEFAULT current_timestamp(),
  `DateModification` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `slides`
--

INSERT INTO `slides` (`slidesId`, `image`, `titre`, `libelle`, `libelleBtnService`, `UrlBtnService`, `DateCreation`, `DateModification`) VALUES
(1, 'slide1.jpeg', 'MUTUALITE', 'Le relationnel au coeur du développment', 'Nos services', 'prestations-service', '2021-03-18 23:49:01', '2021-03-18 00:00:00'),
(2, 'slide2.jpeg', 'ASSISTANCE', 'Nous vous accompagnons pour un développement social durable', 'Nos services', 'prestations-service', '2021-03-18 23:49:01', '2021-03-18 00:00:00'),
(3, 'slide3.png', 'CONSEIL', 'Nous vous aidons à développer votre entreprise', 'Nos services', 'prestations-service', '2021-03-18 23:49:01', '2021-03-18 00:00:00'),
(4, 'slide4.jpeg', 'FORMATION', 'Votre succès est notre priorité', 'Nos services', 'prestations-service', '2021-03-18 23:49:01', '2021-03-18 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `statut`
--

DROP TABLE IF EXISTS `statut`;
CREATE TABLE IF NOT EXISTS `statut` (
  `statutId` int(11) NOT NULL,
  `libelle` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `typeformation`
--

DROP TABLE IF EXISTS `typeformation`;
CREATE TABLE IF NOT EXISTS `typeformation` (
  `typeFormationId` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`typeFormationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table des types de formation(formation présencielle, en ligne)';

-- --------------------------------------------------------

--
-- Structure de la table `typemadia`
--

DROP TABLE IF EXISTS `typemadia`;
CREATE TABLE IF NOT EXISTS `typemadia` (
  `typeMadiaId` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`typeMadiaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='table des types de media (images ou vidéo)';

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userId` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `prenoms` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(45) NOT NULL,
  `token` varchar(100) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

DROP TABLE IF EXISTS `ville`;
CREATE TABLE IF NOT EXISTS `ville` (
  `villeId` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `paysId` int(11) NOT NULL,
  PRIMARY KEY (`villeId`,`paysId`),
  KEY `fk_ville_pays1_idx` (`paysId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `ville`
--

INSERT INTO `ville` (`villeId`, `libelle`, `paysId`) VALUES
(1, 'ABIDJAN', 1),
(2, 'YAMOUSSOUKRO', 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commune`
--
ALTER TABLE `commune`
  ADD CONSTRAINT `fk_commune_ville1` FOREIGN KEY (`villeId`) REFERENCES `ville` (`villeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `fk_contact_contactLocalisatonAdresse1` FOREIGN KEY (`contactLocalisatonAdresseId`) REFERENCES `contactlocalisatonadresse` (`contactLocalisatonAdresseId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `contactlocalisatonadresse`
--
ALTER TABLE `contactlocalisatonadresse`
  ADD CONSTRAINT `contactlocalisatonadresse_ibfk_1` FOREIGN KEY (`paysId`) REFERENCES `pays` (`paysId`),
  ADD CONSTRAINT `contactlocalisatonadresse_ibfk_2` FOREIGN KEY (`villeId`) REFERENCES `ville` (`villeId`),
  ADD CONSTRAINT `fk_contactLocalisatonAdresse_commune1` FOREIGN KEY (`communeId`) REFERENCES `commune` (`communeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `formation`
--
ALTER TABLE `formation`
  ADD CONSTRAINT `fk_formation_typeFormation` FOREIGN KEY (`typeFormationId`) REFERENCES `typeformation` (`typeFormationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `galerie`
--
ALTER TABLE `galerie`
  ADD CONSTRAINT `fk_galerie_formation1` FOREIGN KEY (`formationId`) REFERENCES `formation` (`formationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `fk_media_galerie1` FOREIGN KEY (`galerieId`) REFERENCES `galerie` (`galerieId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_media_typeMadia1` FOREIGN KEY (`typeMadiaId`) REFERENCES `typemadia` (`typeMadiaId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `module`
--
ALTER TABLE `module`
  ADD CONSTRAINT `fk_module_formation1` FOREIGN KEY (`formationId`) REFERENCES `formation` (`formationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `permissionrole`
--
ALTER TABLE `permissionrole`
  ADD CONSTRAINT `fk_permissionRole_user1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_permission_has_role_permission1` FOREIGN KEY (`permissionId`) REFERENCES `permission` (`permissionId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_permission_has_role_role1` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `section_ibfk_1` FOREIGN KEY (`prestationServiceId`) REFERENCES `prestationservice` (`prestationServiceId`);

--
-- Contraintes pour la table `ville`
--
ALTER TABLE `ville`
  ADD CONSTRAINT `fk_ville_pays1` FOREIGN KEY (`paysId`) REFERENCES `pays` (`paysId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
