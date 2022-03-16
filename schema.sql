DROP TABLE IF EXISTS `meta`;
DROP TABLE IF EXISTS `stats`;
DROP TABLE IF EXISTS `membership`;
DROP TABLE IF EXISTS `groups`;
DROP TABLE IF EXISTS `agents`;

CREATE TABLE `meta` (
  `schemaver` INTEGER NOT NULL,
);
INSERT INTO `meta` VALUES ( 2 );

CREATE TABLE `agents` (
  `idagents` INTEGER NOT NULL,
  `name` varchar(16) NOT NULL,
  `faction` varchar(3) DEFAULT NULL,
  `apdiff` BIGINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`idagents`, `name`),
  UNIQUE (`idagents`),
  UNIQUE (`name`)
);

CREATE TABLE `groups` (
  `idgroups` INTEGER NOT NULL,
  `name` varchar(45) NOT NULL,
  `url` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`idgroups`,`name`),
  UNIQUE (`name`),
  UNIQUE (`idgroups`),
  UNIQUE (`url`)
);
INSERT INTO `groups` VALUES (1,'all',1),(2,'smurfs',2),(3,'frogs',3);

CREATE TABLE `membership` (
  `idagents` INTEGER NOT NULL,
  `idgroups` INTEGER NOT NULL,
  PRIMARY KEY (`idagents`,`idgroups`),
  CONSTRAINT `FK_agents` FOREIGN KEY (`idagents`) REFERENCES `agents` (`idagents`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_groups` FOREIGN KEY (`idgroups`) REFERENCES `groups` (`idgroups`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `stats` (
  `idagents` INTEGER NOT NULL,
  `date` date NOT NULL,
  `level` BIGINT unsigned DEFAULT NULL,
  `ap` BIGINT unsigned DEFAULT NULL,
  `lifetime_ap` BIGINT unsigned DEFAULT NULL,
  `recursions` BIGINT unsigned DEFAULT NULL,
  `explorer` BIGINT unsigned DEFAULT NULL,
  `discoverer` BIGINT unsigned DEFAULT NULL,
  `seer` BIGINT unsigned DEFAULT NULL,
  `recon` BIGINT unsigned DEFAULT NULL,
  `scout` BIGINT unsigned DEFAULT NULL,
  `trekker` BIGINT unsigned DEFAULT NULL,
  `builder` BIGINT unsigned DEFAULT NULL,
  `connector` BIGINT unsigned DEFAULT NULL,
  `mind-controller` BIGINT unsigned DEFAULT NULL,
  `illuminator` BIGINT unsigned DEFAULT NULL,
  `recharger` BIGINT unsigned DEFAULT NULL,
  `liberator` BIGINT unsigned DEFAULT NULL,
  `pioneer` BIGINT unsigned DEFAULT NULL,
  `engineer` BIGINT unsigned DEFAULT NULL,
  `purifier` BIGINT unsigned DEFAULT NULL,
  `guardian` BIGINT unsigned DEFAULT NULL,
  `specops` BIGINT unsigned DEFAULT NULL,
  `missionday` BIGINT unsigned DEFAULT NULL,
  `nl-1331-meetups` BIGINT unsigned DEFAULT NULL,
  `cassandra-neutralizer` BIGINT unsigned DEFAULT NULL,
  `hacker` BIGINT unsigned DEFAULT NULL,
  `translator` BIGINT unsigned DEFAULT NULL,
  `sojourner` BIGINT unsigned DEFAULT NULL,
  `recruiter` BIGINT unsigned DEFAULT NULL,
  `magnusbuilder` BIGINT unsigned DEFAULT NULL,
  `collector` BIGINT unsigned DEFAULT NULL,
  `binder` BIGINT unsigned DEFAULT NULL,
  `country-master` BIGINT unsigned DEFAULT NULL,
  `neutralizer` BIGINT unsigned DEFAULT NULL,
  `disruptor` BIGINT unsigned DEFAULT NULL,
  `salvator` BIGINT unsigned DEFAULT NULL,
  `smuggler` BIGINT unsigned DEFAULT NULL,
  `link-master` BIGINT unsigned DEFAULT NULL,
  `controller` BIGINT unsigned DEFAULT NULL,
  `field-master` BIGINT unsigned DEFAULT NULL,
  `prime_challenge` BIGINT unsigned DEFAULT NULL,
  `stealth_ops` BIGINT unsigned DEFAULT NULL,
  `opr_live` BIGINT unsigned DEFAULT NULL,
  `ocf` BIGINT unsigned DEFAULT NULL,
  `intel_ops` BIGINT unsigned DEFAULT NULL,
  `ifs` BIGINT unsigned DEFAULT NULL,
  `dark_xm_threat` BIGINT unsigned DEFAULT NULL,
  `myriad_hack` BIGINT unsigned DEFAULT NULL,
  `aurora_glyph` BIGINT unsigned DEFAULT NULL,
  `umbra_deploy` BIGINT unsigned DEFAULT NULL,
  `didact_field` BIGINT unsigned DEFAULT NULL,
  `drone_explorer` BIGINT unsigned DEFAULT NULL,
  `drone_distance` BIGINT unsigned DEFAULT NULL,
  `drone_recalls` BIGINT unsigned DEFAULT NULL,
  `drone_sender` BIGINT unsigned DEFAULT NULL,
  `maverick` BIGINT unsigned DEFAULT NULL,
  `scout_controller` BIGINT unsigned DEFAULT NULL,
  `crafter` BIGINT unsigned DEFAULT NULL,
  `bb_combatant` BIGINT unsigned DEFAULT NULL,
  `hack_the_world202104` BIGINT unsigned DEFAULT NULL,
  `epoch` BIGINT unsigned DEFAULT NULL,
  `matryoshka_links` BIGINT unsigned DEFAULT NULL,
  `operation_sentinel` BIGINT unsigned DEFAULT NULL,
  `second_sunday` BIGINT unsigned DEFAULT NULL,
  `eos_imprint` BIGINT unsigned DEFAULT NULL,
  `flag` TINYINT DEFAULT NULL,
  `min-ap` BIGINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`idagents`,`date`),
  CONSTRAINT `FK_idagents` FOREIGN KEY (`idagents`) REFERENCES `agents` (`idagents`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
