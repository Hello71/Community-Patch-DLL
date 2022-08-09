-- DELETE ENTRIES

-- Delete hangovers
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_BOMBARDMENT_1';
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_BOMBARDMENT_2';
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_BOMBARDMENT_3';
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_AIR_AMBUSH_1';
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_AIR_AMBUSH_2';
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_BOARDING_PARTY_1';
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_BOARDING_PARTY_2';
DELETE FROM UnitPromotions_Domains WHERE PromotionType = 'PROMOTION_BOARDING_PARTY_3';

DELETE FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_INSTA_HEAL';
DELETE FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_REPAIR';

DELETE FROM UnitPromotions_PostCombatRandomPromotion WHERE NewPromotion = 'PROMOTION_RECRUITMENT';
DELETE FROM UnitPromotions_PostCombatRandomPromotion WHERE NewPromotion = 'PROMOTION_HEROISM';

-- Remove Promotions from specific Land UnitCombats
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_SIEGE' AND PromotionType = 'PROMOTION_BARRAGE_1';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_SIEGE' AND PromotionType = 'PROMOTION_BARRAGE_2';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_SIEGE' AND PromotionType = 'PROMOTION_BARRAGE_3';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_SIEGE' AND PromotionType = 'PROMOTION_ACCURACY_1';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_SIEGE' AND PromotionType = 'PROMOTION_ACCURACY_2';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_SIEGE' AND PromotionType = 'PROMOTION_ACCURACY_3';
-- Remove Promotions from specific Naval UnitCombats
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_NAVALRANGED' AND PromotionType = 'PROMOTION_MORALE';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_NAVALRANGED' AND PromotionType = 'PROMOTION_RANGE';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_NAVALMELEE'  AND PromotionType = 'PROMOTION_MORALE';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_NAVALMELEE'  AND PromotionType = 'PROMOTION_MOBILITY';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_NAVALMELEE'  AND PromotionType = 'PROMOTION_SENTRY';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_NAVALMELEE'  AND PromotionType = 'PROMOTION_LOGISTICS';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_SUBMARINE'   AND PromotionType = 'PROMOTION_MORALE';
-- Remove Promotions from specific Air UnitCombats
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_BOMBER'  AND PromotionType = 'PROMOTION_AIR_REPAIR';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_BOMBER'  AND PromotionType = 'PROMOTION_BOMBARDMENT_1';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_BOMBER'  AND PromotionType = 'PROMOTION_BOMBARDMENT_2';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_BOMBER'  AND PromotionType = 'PROMOTION_BOMBARDMENT_3';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_FIGHTER' AND PromotionType = 'PROMOTION_AIR_AMBUSH_1';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_FIGHTER' AND PromotionType = 'PROMOTION_AIR_AMBUSH_2';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_FIGHTER' AND PromotionType = 'PROMOTION_AIR_TARGETING_1';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_FIGHTER' AND PromotionType = 'PROMOTION_AIR_TARGETING_2';

-- Move Anti-Fighter into UnitPromotions_UnitCombats
DELETE FROM UnitPromotions_UnitClasses WHERE PromotionType = 'PROMOTION_ANTI_FIGHTER';

-- UPDATE ENTRIES

-- Fix for Astronomy/Compass change
UPDATE UnitPromotions_Terrains SET PassableTech = 'TECH_COMPASS' WHERE PromotionType = 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY';

-- Replace Targeting with +10% Combat Strength versus land and sea units.
UPDATE UnitPromotions_Domains SET Modifier = '10' WHERE PromotionType = 'PROMOTION_TARGETING_1';
UPDATE UnitPromotions_Domains SET Modifier = '10' WHERE PromotionType = 'PROMOTION_TARGETING_2';
UPDATE UnitPromotions_Domains SET Modifier = '10' WHERE PromotionType = 'PROMOTION_TARGETING_3';
-- Air Promotions -- Update Air Targeting to Hit Water Domain (PROMOTION_AIR_TARGETING_3 not working at all here)
UPDATE UnitPromotions_Domains SET Modifier = '15' WHERE PromotionType = 'PROMOTION_AIR_TARGETING_1';
UPDATE UnitPromotions_Domains SET Modifier = '15' WHERE PromotionType = 'PROMOTION_AIR_TARGETING_2';

-- Reduce anti-sub power a little
UPDATE UnitPromotions_UnitClasses SET Modifier = '33', Attack = '33' WHERE PromotionType = 'PROMOTION_ANTI_SUBMARINE_I';
UPDATE UnitPromotions_UnitClasses SET Modifier = '75', Attack = '75' WHERE PromotionType = 'PROMOTION_ANTI_SUBMARINE_II';

UPDATE UnitPromotions_UnitCombatMods SET Modifier = 50  WHERE PromotionType = 'PROMOTION_ANTI_TANK';
UPDATE UnitPromotions_UnitCombatMods SET Modifier = 33  WHERE PromotionType = 'PROMOTION_FORMATION_1' AND UnitCombatType = 'UNITCOMBAT_MOUNTED';
UPDATE UnitPromotions_UnitCombatMods SET Modifier = 33  WHERE PromotionType = 'PROMOTION_FORMATION_2' AND UnitCombatType = 'UNITCOMBAT_MOUNTED';
UPDATE UnitPromotions_UnitCombatMods SET Modifier = 100 WHERE PromotionType = 'PROMOTION_ANTI_AIR';
UPDATE UnitPromotions_UnitCombatMods SET Modifier = 100 WHERE PromotionType = 'PROMOTION_ANTI_AIR_II';
UPDATE UnitPromotions_UnitCombatMods SET Modifier = 50  WHERE PromotionType = 'PROMOTION_AIR_AMBUSH_1';
UPDATE UnitPromotions_UnitCombatMods SET Modifier = 50  WHERE PromotionType = 'PROMOTION_AIR_AMBUSH_2';

-- INSERT NEW ENTRIES
INSERT INTO UnitPromotions
	(Type, Description, Help, Sound, ReconChange, LostWithUpgrade, PortraitIndex, IconAtlas, PediaType, PediaEntry)
VALUES
  	('PROMOTION_RECON_SHORT_RANGE', 'TXT_KEY_PROMOTION_RECON_SHORT_RANGE', 'TXT_KEY_PROMOTION_RECON_SHORT_RANGE_HELP', 'AS2D_IF_LEVELUP', -2, 1, 59, 'ABILITY_ATLAS', 'PEDIA_AIR', 'TXT_KEY_PEDIA_PROMOTION_RECON_SHORT_RANGE'),
    ('PROMOTION_RECON_LONG_RANGE', 'TXT_KEY_PROMOTION_RECON_LONG_RANGE', 'TXT_KEY_PROMOTION_RECON_LONG_RANGE_HELP', 'AS2D_IF_LEVELUP', 2, 1, 59, 'ABILITY_ATLAS', 'PEDIA_AIR', 'TXT_KEY_PEDIA_PROMOTION_RECON_LONG_RANGE');

INSERT INTO UnitPromotions_YieldFromKills
	(PromotionType, YieldType, Yield)
VALUES
	('PROMOTION_ENSLAVEMENT', 'YIELD_PRODUCTION', 150),
	('PROMOTION_PIRACY', 'YIELD_GOLD', 100),
	('PROMOTION_PRIZE_RULES', 'YIELD_GOLD', 300);

INSERT INTO UnitPromotions_UnitCombatMods
	(PromotionType, UnitCombatType, Modifier)
VALUES
	('PROMOTION_ANTI_FIGHTER', 'UNITCOMBAT_FIGHTER', 33),
	('PROMOTION_KNOCKOUT_II', 'UNITCOMBAT_SIEGE', 25),
	('PROMOTION_KNOCKOUT_I', 'UNITCOMBAT_GUN', 25),
	('PROMOTION_RESPECT', 'UNITCOMBAT_MELEE', 15),
	('PROMOTION_RESPECT', 'UNITCOMBAT_GUN', 15),
	('PROMOTION_MODERN_RANGED_PENALTY_I', 'UNITCOMBAT_ARMOR', -50),
	('PROMOTION_ANTI_AIR_II', 'UNITCOMBAT_FIGHTER', 100),
	('PROMOTION_ASSIZE_OF_ARMS', 'UNITCOMBAT_MOUNTED', 20),
	('PROMOTION_ASSIZE_OF_ARMS', 'UNITCOMBAT_ARMOR', 20);

INSERT INTO UnitPromotions_CombatModPerAdjacentUnitCombat
	(PromotionType, UnitCombatType, Modifier, Attack, Defense)
VALUES
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_MELEE', 15, 0, 0),
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_RECON', 15, 0, 0),
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_ARCHER', 15, 0, 0),
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_SIEGE', 15, 0, 0),
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_MOUNTED', 15, 0, 0),
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_GUN', 15, 0, 0),
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_ARMOR', 15, 0, 0),
	('PROMOTION_ADJACENT_BONUS', 'UNITCOMBAT_HELICOPTER', 15, 0, 0),
	('PROMOTION_ENCIRCLEMENT', 'UNITCOMBAT_NAVALMELEE', 0, 10, 0),
	('PROMOTION_ENCIRCLEMENT', 'UNITCOMBAT_CARRIER', 0, 10, 0),
	('PROMOTION_ENCIRCLEMENT', 'UNITCOMBAT_NAVALRANGED', 0, 10, 0),
	('PROMOTION_ENCIRCLEMENT', 'UNITCOMBAT_SUBMARINE', 0, 10, 0),
	('PROMOTION_BREACHER', 'UNITCOMBAT_NAVALMELEE',0, 0, 10),
	('PROMOTION_BREACHER', 'UNITCOMBAT_CARRIER',0, 0, 10),
	('PROMOTION_BREACHER', 'UNITCOMBAT_NAVALRANGED',0, 0, 10),
	('PROMOTION_BREACHER', 'UNITCOMBAT_SUBMARINE',0, 0, 10);

INSERT INTO UnitPromotions_UnitClasses
	(PromotionType, UnitClassType, Modifier)
VALUES
	('PROMOTION_ANTI_AIR', 'UNITCLASS_GUIDED_MISSILE', 100),
	('PROMOTION_ANTI_AIR', 'UNITCLASS_HELICOPTER_GUNSHIP', 0),
	('PROMOTION_ANTI_AIR_II', 'UNITCLASS_GUIDED_MISSILE', 100),
	('PROMOTION_ANTI_AIR_II', 'UNITCLASS_HELICOPTER_GUNSHIP', 0),
	('PROMOTION_ANTI_HELICOPTER', 'UNITCLASS_HELICOPTER_GUNSHIP', 150);

INSERT INTO UnitPromotions_Features
	(PromotionType, FeatureType, DoubleMove)
VALUES
	('PROMOTION_WOODLAND_TRAILBLAZER_I', 'FEATURE_JUNGLE', 1),
	('PROMOTION_WOODLAND_TRAILBLAZER_I', 'FEATURE_FOREST', 1);
--INSERT INTO UnitPromotions_Features
--	(PromotionType, FeatureType, ExtraMove)
--VALUES
--	('PROMOTION_ROUGH_TERRAIN_HALF_TURN', 'FEATURE_FOREST', '1'),
--	('PROMOTION_ROUGH_TERRAIN_HALF_TURN', 'FEATURE_JUNGLE', '1'),
--	('PROMOTION_ROUGH_TERRAIN_HALF_TURN', 'FEATURE_MARSH', '1'),
--	('PROMOTION_ROUGH_TERRAIN_HALF_TURN', 'FEATURE_FLOOD_PLAINS', '1');

INSERT INTO UnitPromotions_Terrains
	(PromotionType, TerrainType, DoubleMove, HalfMove)
VALUES
	('PROMOTION_WOODLAND_TRAILBLAZER_II', 'TERRAIN_DESERT', 1, 0),
	('PROMOTION_WOODLAND_TRAILBLAZER_II', 'TERRAIN_SNOW', 1, 0),
	('PROMOTION_OCEAN_HALF_MOVES', 'TERRAIN_OCEAN', 0, 1);

INSERT INTO UnitPromotions_PostCombatRandomPromotion
	(PromotionType, NewPromotion)
VALUES
	('PROMOTION_BUSHIDO', 'PROMOTION_RIGHTEOUSNESS'),
	('PROMOTION_BUSHIDO', 'PROMOTION_COURAGE'),
	('PROMOTION_BUSHIDO', 'PROMOTION_BENEVOLENCE'),
	('PROMOTION_BUSHIDO', 'PROMOTION_RESPECT'),
	('PROMOTION_BUSHIDO', 'PROMOTION_SINCERITY'),
	('PROMOTION_BUSHIDO', 'PROMOTION_BUSHIDO_HONOR'),
	('PROMOTION_BUSHIDO', 'PROMOTION_LOYALTY'),
	('PROMOTION_BUSHIDO', 'PROMOTION_SELF_CONTROL');

INSERT INTO UnitPromotions_CivilianUnitType
	(PromotionType, UnitType)
VALUES
	('PROMOTION_FALLOUT_REDUCTION', 'UNIT_WORKER'),
	('PROMOTION_FALLOUT_IMMUNITY', 'UNIT_WORKER'),
	('PROMOTION_PRISONER_WAR', 'UNIT_WORKER'),
	('PROMOTION_ICE_BREAKERS', 'UNIT_WORKBOAT'),
	('PROMOTION_ICE_BREAKERS', 'UNIT_WORKER'),
	('PROMOTION_ICE_BREAKERS', 'UNIT_ARCHAEOLOGIST'),
	('PROMOTION_FASTER_GENERAL', 'UNIT_GREAT_GENERAL'),
	('PROMOTION_FASTER_GENERAL', 'UNIT_MONGOLIAN_KHAN'),
	('PROMOTION_BETTER_LEADERSHIP', 'UNIT_GREAT_GENERAL'),
	('PROMOTION_BETTER_LEADERSHIP', 'UNIT_MONGOLIAN_KHAN'),
	('PROMOTION_BETTER_LEADERSHIP', 'UNIT_GREAT_ADMIRAL');

INSERT INTO UnitPromotions_UnitCombats
	(PromotionType, UnitCombatType)
VALUES
	('PROMOTION_BUSHIDO', 'UNITCOMBAT_MELEE'),
	('PROMOTION_BUSHIDO', 'UNITCOMBAT_GUN'),
	('PROMOTION_BUSHIDO', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_BUSHIDO', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_CHARGE_II', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_CHARGE_II', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_FORMATION_2', 'UNITCOMBAT_MELEE'),
	('PROMOTION_FORMATION_2', 'UNITCOMBAT_GUN'),
	('PROMOTION_FORMATION_2', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_FORMATION_2', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_WOODLAND_TRAILBLAZER_I', 'UNITCOMBAT_RECON'),
	('PROMOTION_WOODLAND_TRAILBLAZER_II', 'UNITCOMBAT_RECON'),
	('PROMOTION_WOODLAND_TRAILBLAZER_III', 'UNITCOMBAT_RECON'),
	('PROMOTION_ANTI_AIR_II', 'UNITCOMBAT_GUN'),
	('PROMOTION_ANTI_AIR_II', 'UNITCOMBAT_FIGHTER'),
	('PROMOTION_MARCH', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_MEDIC', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_MEDIC_II', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_MEDIC', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_MEDIC_II', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_ARSENALE', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_ARSENALE', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_ARSENALE', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_ARSENALE', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_ACCURACY_4', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_ACCURACY_4', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_BARRAGE_4', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_BARRAGE_4', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_SHOCK_4', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_SHOCK_4', 'UNITCOMBAT_MELEE'),
	('PROMOTION_SHOCK_4', 'UNITCOMBAT_GUN'),
	('PROMOTION_SHOCK_4', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_DRILL_4', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_DRILL_4', 'UNITCOMBAT_MELEE'),
	('PROMOTION_DRILL_4', 'UNITCOMBAT_GUN'),
	('PROMOTION_DRILL_4', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_TARGETING_4', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_TARGETING_4', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_BOMBARDMENT_4', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_COASTAL_RAIDER_4', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_COASTAL_RAIDER_1', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_COASTAL_RAIDER_2', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_COASTAL_RAIDER_3', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_COASTAL_RAIDER_4', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_BOARDING_PARTY_4', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_BOARDING_PARTY_4', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_MOBILITY', 'UNITCOMBAT_MELEE'),
	('PROMOTION_MOBILITY', 'UNITCOMBAT_GUN'),
	('PROMOTION_INDIRECT_FIRE', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_INDIRECT_FIRE', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_AMBUSH_2', 'UNITCOMBAT_MELEE'),
	('PROMOTION_AMBUSH_2', 'UNITCOMBAT_GUN'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_RECON'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_MELEE'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_GUN'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_HELICOPTER'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_MORALE_EVENT', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_SPLASH', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_SPLASH_II', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_SKIRMISHER_MOBILITY', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_SKIRMISHER_POWER', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_SKIRMISHER_MARCH', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_SKIRMISHER_SENTRY', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_SIEGE_I', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_SIEGE_II', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_SIEGE_III', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_FIELD_I', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_FIELD_II', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_FIELD_III', 'UNITCOMBAT_SIEGE'),
	('PROMOTION_SCOUT_XP_PILLAGE', 'UNITCOMBAT_RECON'),
	('PROMOTION_SCOUT_XP_SPOTTING', 'UNITCOMBAT_RECON'),
	('PROMOTION_SCOUT_GOODY_BONUS', 'UNITCOMBAT_RECON'),
	('PROMOTION_ANTIAIR_LAND_I', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_ANTIAIR_LAND_I', 'UNITCOMBAT_GUN'),
	('PROMOTION_ANTIAIR_LAND_I', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_ANTIAIR_LAND_I', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_ANTIAIR_LAND_II', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_ANTIAIR_LAND_II', 'UNITCOMBAT_GUN'),
	('PROMOTION_ANTIAIR_LAND_II', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_ANTIAIR_LAND_II', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_ANTIAIR_LAND_III', 'UNITCOMBAT_ARCHER'),
	('PROMOTION_ANTIAIR_LAND_III', 'UNITCOMBAT_GUN'),
	('PROMOTION_ANTIAIR_LAND_III', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_ANTIAIR_LAND_III', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_SPLASH', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_BETTER_BOMBARDMENT', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_COASTAL_TERROR', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_COVER_1', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_COVER_2', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_NAVAL_SENTRY', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_NAVAL_SENTRY_II', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_NAVAL_SENTRY_II', 'UNITCOMBAT_NAVALRANGED'),
	('PROMOTION_NAVAL_SENTRY_II', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_NAVAL_SENTRY_II', 'UNITCOMBAT_SUBMARINE'),
	('PROMOTION_NAVAL_SIEGE', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_ENCIRCLEMENT', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_BREACHER', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_DAMAGE_REDUCTION', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_PRESS_GANGS', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_PIRACY', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_BLITZ', 'UNITCOMBAT_NAVALMELEE'), 
	('PROMOTION_MINELAYER', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_ANTI_FIGHTER', 'UNITCOMBAT_FIGHTER'),
	('PROMOTION_INTERCEPTION_II', 'UNITCOMBAT_GUN'),
	('PROMOTION_INTERCEPTION_III', 'UNITCOMBAT_GUN'),
	('PROMOTION_INTERCEPTION_IV', 'UNITCOMBAT_GUN'),
	('PROMOTION_INTERCEPTION_I', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_INTERCEPTION_II', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_INTERCEPTION_III', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_INTERCEPTION_IV', 'UNITCOMBAT_CARRIER'),
	('PROMOTION_INTERCEPTION_I', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_INTERCEPTION_II', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_INTERCEPTION_III', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_INTERCEPTION_IV', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_EVASION_I', 'UNITCOMBAT_BOMBER'),
	('PROMOTION_EVASION_II', 'UNITCOMBAT_BOMBER'),
	('PROMOTION_AIR_TARGETING_3', 'UNITCOMBAT_BOMBER'),
	('PROMOTION_ANTI_AIR', 'UNITCOMBAT_FIGHTER'),
	('PROMOTION_ALHAMBRA', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_IKLWA', 'UNITCOMBAT_MELEE'),
	('PROMOTION_IKLWA', 'UNITCOMBAT_GUN'),
	('PROMOTION_ANTI_SUBMARINE_I', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_ANTI_SUBMARINE_II', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_SEE_INVISIBLE_SUBMARINE', 'UNITCOMBAT_NAVALMELEE'),
	('PROMOTION_EVERLASTING_YOUTH', 'UNITCOMBAT_MELEE'),
	('PROMOTION_EVERLASTING_YOUTH', 'UNITCOMBAT_GUN'),
	('PROMOTION_EVERLASTING_YOUTH', 'UNITCOMBAT_MOUNTED'),
	('PROMOTION_EVERLASTING_YOUTH', 'UNITCOMBAT_ARMOR'),
	('PROMOTION_EVERLASTING_YOUTH', 'UNITCOMBAT_RECON');
-- Change all helicopter promotions to Archer (because helicopters are now archers)
UPDATE UnitPromotions_UnitCombats SET UnitCombatType = 'UNITCOMBAT_ARCHER' WHERE UnitCombatType = 'UNITCOMBAT_HELICOPTER';

INSERT INTO UnitPromotions_Terrains
	(PromotionType, TerrainType, Attack, Defense, DoubleHeal)
VALUES
	('PROMOTION_LONGBOAT', 'TERRAIN_COAST', '15', '15', '1');
--INSERT INTO UnitPromotions_Terrains
--	(PromotionType, TerrainType, ExtraMove)
--VALUES
--	('PROMOTION_ROUGH_TERRAIN_HALF_TURN', 'TERRAIN_HILL', '1');

INSERT INTO UnitPromotions_Domains
	(PromotionType, DomainType, Modifier)
VALUES
	('PROMOTION_NAVAL_MISFIRE', 'DOMAIN_SEA', -20),
	('PROMOTION_AIR_MISFIRE', 'DOMAIN_LAND', 15),
	('PROMOTION_AIR_MISFIRE', 'DOMAIN_SEA', 15),
	('PROMOTION_SIEGE_INACCURACY', 'DOMAIN_LAND', -33),
	('PROMOTION_NAVAL_INACCURACY', 'DOMAIN_LAND', -25),
	('PROMOTION_BETTER_BOMBARDMENT', 'DOMAIN_LAND', 50),
	('PROMOTION_TARGETING_1', 'DOMAIN_LAND', 10),
	('PROMOTION_TARGETING_2', 'DOMAIN_LAND', 10),
	('PROMOTION_TARGETING_3', 'DOMAIN_LAND', 10),
	('PROMOTION_AIR_TARGETING_1', 'DOMAIN_LAND', 15),
	('PROMOTION_AIR_TARGETING_2', 'DOMAIN_LAND', 15),
	('PROMOTION_AIR_TARGETING_3', 'DOMAIN_LAND', 25),
	('PROMOTION_AIR_TARGETING_3', 'DOMAIN_SEA', 25);
	
INSERT INTO UnitPromotions_YieldFromScouting
	(PromotionType, YieldType, Yield)
VALUES
	('PROMOTION_RECON_BANDEIRANTES', 'YIELD_GOLD', 3),
	('PROMOTION_RECON_BANDEIRANTES', 'YIELD_SCIENCE', 3),
	('PROMOTION_RECON_BANDEIRANTES', 'YIELD_CULTURE', 3);

INSERT INTO UnitPromotions_CivilianUnitType
	(PromotionType, UnitType)
VALUES
	('PROMOTION_SACRED_STEPS', 'UNIT_WORKER'),
	('PROMOTION_SACRED_STEPS', 'UNIT_MISSIONARY'),
	('PROMOTION_SACRED_STEPS', 'UNIT_INQUISITOR'),
	('PROMOTION_SACRED_STEPS', 'UNIT_SPAIN_INQUISITOR'),
	('PROMOTION_SACRED_STEPS', 'UNIT_SETTLER'),
	('PROMOTION_SACRED_STEPS', 'UNIT_PIONEER'),
	('PROMOTION_SACRED_STEPS', 'UNIT_COLONIST'),
	('PROMOTION_SACRED_STEPS', 'UNIT_WORKBOAT');
