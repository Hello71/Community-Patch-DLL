-- Clausewitz's Legacy

UPDATE Policies
SET WarWearinessModifier = '50'
WHERE Type = 'POLICY_NEW_ORDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET RazingSpeedBonus = '100'
WHERE Type = 'POLICY_NEW_ORDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET Level = '2'
WHERE Type = 'POLICY_NEW_ORDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Cult of Personality 

UPDATE Policies
SET NumFreeGreatPeople = '1'
WHERE Type = 'POLICY_CULT_PERSONALITY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET IncludesOneShotFreeUnits = '1'
WHERE Type = 'POLICY_CULT_PERSONALITY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Elite Forces
UPDATE Policies
SET ExpModifier = '50'
WHERE Type = 'POLICY_ELITE_FORCES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET FreeExperience = '15'
WHERE Type = 'POLICY_ELITE_FORCES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET WoundedUnitDamageMod = '0'
WHERE Type = 'POLICY_ELITE_FORCES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Fortified Borders

DELETE FROM Policy_BuildingClassHappiness
WHERE PolicyType = 'POLICY_FORTIFIED_BORDERS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET DefenseHappinessMod = '-20'
WHERE Type = 'POLICY_FORTIFIED_BORDERS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Futurism
UPDATE Policies
SET EventTourism = '2'
WHERE Type = 'POLICY_FUTURISM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

DELETE FROM Policy_TourismOnUnitCreation
WHERE PolicyType = 'POLICY_FUTURISM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Industrial Espionage (now Lebensraum)
UPDATE Policies
SET StealTechFasterModifier = '0'
WHERE Type = 'POLICY_INDUSTRIAL_ESPIONAGE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET CitadelBoost = '1'
WHERE Type = 'POLICY_INDUSTRIAL_ESPIONAGE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Lightning Warfare

-- Militarism

DELETE FROM Policy_BuildingClassHappiness
WHERE PolicyType = 'POLICY_MILITARISM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET Level = '3'
WHERE Type = 'POLICY_MILITARISM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Mobilization
UPDATE Policies
SET UnitUpgradeCostMod = '-33'
WHERE Type = 'POLICY_MOBILIZATION' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Police State

-- Third Alternative

UPDATE Policy_CapitalYieldChanges
SET Yield = '10'
WHERE PolicyType = 'POLICY_THIRD_ALTERNATIVE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Total War
UPDATE Policies
SET FreeExperience = '0'
WHERE Type = 'POLICY_TOTAL_WAR' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET WorkerSpeedModifier = '25'
WHERE Type = 'POLICY_TOTAL_WAR' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- United Front
UPDATE Policies
SET MilitaryUnitGiftExtraInfluence = '30'
WHERE Type = 'POLICY_UNITED_FRONT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET CityStateUnitFrequencyModifier = '200'
WHERE Type = 'POLICY_UNITED_FRONT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- Autarky

DELETE FROM Policy_BuildingClassHappiness
WHERE PolicyType = 'POLICY_UNIVERSAL_HEALTHCARE_A' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET InternalTradeGold = '10'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_A' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET Help = 'TXT_KEY_POLICY_UNIVERSAL_HEALTHCARE_A_HELP'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_A' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET Description = 'TXT_KEY_POLICY_UNIVERSAL_HEALTHCARE_A'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_A' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

UPDATE Policies
SET Civilopedia = 'TXT_KEY_POLICY_UNIVERSAL_HEALTHCARE_TEXT_A'
WHERE Type = 'POLICY_UNIVERSAL_HEALTHCARE_A' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );


-- Building Class Changes

INSERT INTO Policy_BuildingClassYieldChanges
	(PolicyType, BuildingClassType, YieldType, YieldChange)
VALUES
	('POLICY_MOBILIZATION', 'BUILDINGCLASS_WALLS', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'BUILDINGCLASS_CASTLE', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'BUILDINGCLASS_ARSENAL', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'BUILDINGCLASS_MILITARY_BASE', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'BUILDINGCLASS_BOMB_SHELTER', 'YIELD_SCIENCE', 3),
	('POLICY_FORTIFIED_BORDERS', 'BUILDINGCLASS_CONSTABLE', 'YIELD_PRODUCTION', 5),
	('POLICY_FORTIFIED_BORDERS', 'BUILDINGCLASS_POLICE_STATION', 'YIELD_PRODUCTION', 5);

INSERT INTO Policy_BuildingClassCultureChanges
	(PolicyType, BuildingClassType, CultureChange)
VALUES
	('POLICY_FORTIFIED_BORDERS', 'BUILDINGCLASS_CONSTABLE', 3),
	('POLICY_FORTIFIED_BORDERS', 'BUILDINGCLASS_POLICE_STATION', 3);


INSERT INTO Policy_BuildingClassHappiness
	(PolicyType, BuildingClassType, Happiness)
VALUES
	('POLICY_POLICE_STATE', 'BUILDINGCLASS_POLICE_STATION', 1);

-- Improvement Changes

INSERT INTO Policy_ImprovementYieldChanges
	(PolicyType, ImprovementType, YieldType, Yield)
VALUES
	('POLICY_MOBILIZATION', 'IMPROVEMENT_CITADEL', 'YIELD_SCIENCE', 3);

-- Border Growth Changes

INSERT INTO Policy_YieldFromBorderGrowth
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_INDUSTRIAL_ESPIONAGE', 'YIELD_CULTURE', 10),
	('POLICY_INDUSTRIAL_ESPIONAGE', 'YIELD_GOLDEN_AGE_POINTS', 10);

-- Promotions
INSERT INTO UnitPromotions_UnitCombats
	(PromotionType, UnitCombatType)
VALUES
	('PROMOTION_LIGHTNING_WARFARE', 'UNITCOMBAT_GUN');

-- Free Buildings

INSERT INTO Policy_FreeBuilding
	(PolicyType, BuildingClassType, Count)
VALUES
	('POLICY_MILITARISM', 'BUILDINGCLASS_AIRPORT', 200);

-- Unit Bonuses
INSERT INTO Policy_UnitCombatProductionModifiers
	(PolicyType, UnitCombatType, ProductionModifier)
VALUES
	('POLICY_MILITARISM', 'UNITCOMBAT_BOMBER', 25),
	('POLICY_MILITARISM', 'UNITCOMBAT_FIGHTER', 25);

-- Trade Routes
INSERT INTO Policy_YieldChangeTradeRoute
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_UNIVERSAL_HEALTHCARE_A', 'YIELD_PRODUCTION', 3);

-- Capital 
INSERT INTO Policy_CapitalYieldChanges
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_THIRD_ALTERNATIVE', 'YIELD_PRODUCTION', 10),
	('POLICY_THIRD_ALTERNATIVE', 'YIELD_GOLD', 10),
	('POLICY_THIRD_ALTERNATIVE', 'YIELD_FAITH', 10),
	('POLICY_THIRD_ALTERNATIVE', 'YIELD_CULTURE', 10);

INSERT INTO Policy_ImprovementYieldChanges
	(PolicyType, ImprovementType, YieldType, Yield)
VALUES
	('POLICY_MOBILIZATION', 'IMPROVEMENT_TERRACE_FARM', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_EKI', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_KUNA', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_ENCAMPMENT_SHOSHONE', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_POLDER', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_CHATEAU', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_KASBAH', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_BRAZILWOOD_CAMP', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_MOAI', 'YIELD_SCIENCE', 3),
	('POLICY_MOBILIZATION', 'IMPROVEMENT_FEITORIA', 'YIELD_SCIENCE', 3);