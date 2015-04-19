-- Attila
DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET LandBarbarianConversionPercent = '100'
WHERE Type = 'TRAIT_RAZE_AND_HORSES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET RazeSpeedModifier = '0'
WHERE Type = 'TRAIT_RAZE_AND_HORSES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'All Mounted Melee Units receive the Flank Attack promotion, and all Mounted Ranged Units the Withdraw Before Melee promotion. Barbarian units defeated inside Encampments join your side.'
WHERE Tag = 'TXT_KEY_TRAIT_RAZE_AND_HORSES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'The barbarians in this Encampment have joined your army!'
WHERE Tag = 'TXT_KEY_NOTIFICATION_BARB_CAMP_CONVERTS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

DELETE FROM Civilization_FreeTechs
WHERE TechType = 'TECH_ANIMAL_HUSBANDRY' AND CivilizationType = 'CIVILIZATION_HUNS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Trait_ImprovementYieldChanges
WHERE TraitType = 'TRAIT_RAZE_AND_HORSES' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Make Horse Archer cost Horse
INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
SELECT 'UNIT_HUN_HORSE_ARCHER', 'RESOURCE_HORSE', '1'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );
		
-- Eki

INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_EKI', 'Improvement', 'Eki';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.75,  'ART_DEF_IMPROVEMENT_EKI', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'eki_built.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.75,  'ART_DEF_IMPROVEMENT_EKI', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'eki_built.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 0.75,  'ART_DEF_IMPROVEMENT_EKI', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'pl_ind_polder.fxsxml', 1;

-- Battering Ram - Move to Catapult

UPDATE Units
SET Class = 'UNITCLASS_CATAPULT'
WHERE Type = 'UNIT_HUN_BATTERING_RAM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT 'UNIT_HUN_BATTERING_RAM' , 'PROMOTION_COVER_2'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Units
SET PrereqTech = 'TECH_ARCHERY'
WHERE Type = 'UNIT_HUN_BATTERING_RAM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Civilization_UnitClassOverrides
Set UnitClassType = 'UNITCLASS_CATAPULT'
WHERE UnitType = 'UNIT_HUN_BATTERING_RAM' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Battering Rams are a Hunnic unique unit replacing the Catapult. Battering Rams are available earlier than Catapults, and are cheaper. Use Battering Rams to knock down the defenses of a city. They have the Cover I and II promotions to keep them safe from ranged units; attack them with melee units to defeat them.'
WHERE Tag = 'TXT_KEY_UNIT_HUN_BATTERING_RAM_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );
	
-- Horse Archer -- Break Off, Make Upgrade for Chariot Archer

UPDATE Units
SET Class = 'UNITCLASS_HORSE_ARCHER'
WHERE Type = 'UNIT_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET PrereqTech = 'TECH_MATHEMATICS'
WHERE Type = 'UNIT_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET ObsoleteTech = 'TECH_PHYSICS'
WHERE Type = 'UNIT_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET RangedCombat = '11'
WHERE Type = 'UNIT_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET Combat = '7'
WHERE Type = 'UNIT_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Unit_Flavors
SET Flavor = '5'
WHERE UnitType = 'UNIT_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_HUN_HORSE_ARCHER'  AND PromotionType = 'PROMOTION_ACCURACY_1' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT 'UNIT_HUN_HORSE_ARCHER', 'PROMOTION_ROUGH_TERRAIN_ENDS_TURN'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'The fearsome cavalry of the Classical world, renowned for its skill in archery, and its mastery of horsemanship. Units like these were the scourge of Eurasia during the nomadic conquests of the 4th-15th centuries AD. Utilizing powerful composite bows, these mounted archers honed their skills while hunting, and they had no trouble carrying over these skills into warfare. It is widely believed that the use of mounted archers greatly influenced the future military considerations of both European and Asian kingdoms, as a greater emphasis on cavalry units arose following nomadic incursions during this period.'
WHERE Tag = 'TXT_KEY_CIV5_HUN_HORSE_ARCHER_TEXT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );
	
UPDATE Language_en_US
SET Text = 'A fast Ranged Unit used for hit-and-run attacks. Highly effective on flat ground, but slowed significantly when entering rough terrain. Requires 1 [ICON_RES_HORSE] Horse.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_HUN_HORSE_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Horse Archers are fast ranged units, deadly on open terrain. Like the Chariot Archer, they cannot move through rough terrain without a movement penalty. As a mounted unit, the Horse Archer is vulnerable to Spearmen.'
WHERE Tag = 'TXT_KEY_UNIT_HUN_HORSE_ARCHER_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Changes to other units in this line.

UPDATE Units
SET GoodyHutUpgradeUnitClass = 'UNITCLASS_HORSE_ARCHER'
WHERE Type = 'UNIT_CHARIOT_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET GoodyHutUpgradeUnitClass = 'UNITCLASS_HORSE_ARCHER'
WHERE Type = 'UNIT_EGYPTIAN_WARCHARIOT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_HORSE_ARCHER'
WHERE UnitType = 'UNIT_CHARIOT_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET ObsoleteTech = 'TECH_MATHEMATICS'
WHERE Type = 'UNIT_CHARIOT_ARCHER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET ObsoleteTech = 'TECH_PHYSICS'
WHERE Type = 'UNIT_EGYPTIAN_WARCHARIOT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_HORSE_ARCHER'
WHERE UnitType = 'UNIT_EGYPTIAN_WARCHARIOT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET GoodyHutUpgradeUnitClass = 'UNITCLASS_MOUNTED_BOWMAN'
WHERE Type = 'UNIT_INDIAN_WARELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET Class = 'UNITCLASS_HORSE_ARCHER'
WHERE Type = 'UNIT_INDIAN_WARELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_MOUNTED_BOWMAN'
WHERE UnitType = 'UNIT_INDIAN_WARELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Civilization_UnitClassOverrides
Set UnitClassType = 'UNITCLASS_HORSE_ARCHER'
WHERE UnitType = 'UNIT_INDIAN_WARELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET ObsoleteTech = 'TECH_PHYSICS'
WHERE Type = 'UNIT_INDIAN_WARELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Boudicca -- Boost Ceilidh Hall -- Move to Classical, add faith
UPDATE Buildings
SET PrereqTech = 'TECH_CONSTRUCTION'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET BuildingClass = 'BUILDINGCLASS_COLOSSEUM'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings 
SET Help = 'TXT_KEY_BUILDING_CEILIDH_HALL_HELP'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

INSERT INTO Language_en_US (Tag, Text)
SELECT 'TXT_KEY_BUILDING_CEILIDH_HALL_HELP', 'Reduces [ICON_HAPPINESS_3] Boredom slightly.'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '2'
WHERE BuildingType = 'BUILDING_CEILIDH_HALL' AND YieldType = 'YIELD_CULTURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET Happiness = '0'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_MUSICIAN'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Buildings
SET SpecialistCount = '1'
WHERE Type = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Civilization_BuildingClassOverrides
SET BuildingClassType = 'BUILDINGCLASS_COLOSSEUM'
WHERE BuildingType = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Building_ClassesNeededInCity
WHERE BuildingType = 'BUILDING_CEILIDH_HALL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );
	
UPDATE Language_en_US
SET Text = 'The Ceilidh Hall is a Classical-era building unique to the Celts, replacing the Colosseum. Reduces [ICON_HAPPINESS_3] Boredom slightly and increases city [ICON_CULTURE] Culture and [ICON_PEACE] Faith. Provides 1 Musician Specialist slot, and contains a slot for a Great Work of Music.'
WHERE Tag = 'TXT_KEY_BUILDING_CEILIDH_HALL_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );
	
UPDATE Language_en_US
SET Text = '+2 [ICON_PEACE] Faith per city with an adjacent unimproved Forest. Bonus increases to +4 [ICON_PEACE] Faith in Cities with 3 or more adjacent unimproved Forest tiles.'
WHERE Tag = 'TXT_KEY_TRAIT_FAITH_FROM_NATURE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Dido -- Delete African Forest Elephant
UPDATE Language_en_US
SET Text = 'Cities produce a large sum of [ICON_GOLD] Gold when founded, and coastal Cities also gain a free Harbor. Units may cross mountains after a Great General is earned, taking 20 HP damage if they end a turn on one.'
WHERE Tag = 'TXT_KEY_TRAIT_PHOENICIAN_HERITAGE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Units
WHERE Type = 'UNIT_CARTHAGINIAN_FOREST_ELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_CARTHAGINIAN_FOREST_ELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_AITypes
WHERE UnitType = 'UNIT_CARTHAGINIAN_FOREST_ELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_ClassUpgrades
WHERE UnitType = 'UNIT_CARTHAGINIAN_FOREST_ELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_CARTHAGINIAN_FOREST_ELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Unit_Flavors
WHERE UnitType = 'UNIT_CARTHAGINIAN_FOREST_ELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM UnitGameplay2DScripts
WHERE UnitType = 'UNIT_CARTHAGINIAN_FOREST_ELEPHANT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Gustavus Adolphus -- Remove Hakkepillita, add unique Public School
DELETE FROM Units
WHERE Type = 'UNIT_SWEDISH_HAKKAPELIITTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_SWEDISH_HAKKAPELIITTA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Remove Sweden Tundra bias

DELETE FROM Civilization_Start_Region_Priority
WHERE CivilizationType = 'CIVILIZATION_SWEDEN' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );



-- Selassie -- Peace Treaty Bonuss
UPDATE Traits
SET GoldenAgeFromVictory = '10'
WHERE Type = 'TRAIT_BONUS_AGAINST_TECH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Combat bonus (+20%) when fighting units from a Civilization with more Cities than Ethiopia. When you complete a favorable Peace Treaty, a [ICON_GOLDEN_AGE] Golden Age begins.'
WHERE Tag = 'TXT_KEY_TRAIT_BONUS_AGAINST_TECH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '1'
WHERE BuildingType = 'BUILDING_STELE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_CITY_HAPPINESS' AND Value= 1 );
 
-- Theodora -- Basilica UB (Replace Dromon)
DELETE FROM Civilization_UnitClassOverrides
WHERE UnitType = 'UNIT_BYZANTINE_DROMON' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Choose one more Belief than normal when you found a Religion. A free Great Prophet appears near your [ICON_CAPITAL] Capital when you research Theology.'
WHERE Tag = 'TXT_KEY_TRAIT_EXTRA_BELIEF' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET FreeUnit = 'UNITCLASS_PROPHET'
WHERE Type = 'TRAIT_EXTRA_BELIEF' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Traits
SET FreeUnitPrereqTech = 'TECH_THEOLOGY'
WHERE Type = 'TRAIT_EXTRA_BELIEF' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Cataphract Lasts Longer
UPDATE Units
SET ObsoleteTech = 'TECH_GUNPOWDER'
WHERE Type = 'UNIT_BYZANTINE_CATAPHRACT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- William -- Change Polder (more gold, less food) -- New Trait
UPDATE Traits
SET LuxuryHappinessRetention = '0'
WHERE Type = 'TRAIT_LUXURY_RETENTION' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Improvements
SET Lakeside = '1'
WHERE Type = 'IMPROVEMENT_POLDER' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Improvement_Yields
SET Yield = '2'
WHERE ImprovementType = 'IMPROVEMENT_POLDER' AND YieldType = 'YIELD_FOOD' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Receives +3 [ICON_CULTURE] Culture for every Luxury Resource you Import from other Civilizations and City-States, and +3 [ICON_GOLD] Gold for every Luxury Resource you export to other Civilizations.'
WHERE Tag = 'TXT_KEY_TRAIT_LUXURY_RETENTION' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'A Polder can be built on Flood Plains, Marshes, or adjacent to Lakes. It boosts food output immediately, and provides additional yields once later techs are researched.'
WHERE Tag = 'TXT_KEY_CIV5_IMPROVEMENTS_POLDER_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Maria Theresa -- Coffee House +2 Production, +2 Food.
UPDATE Buildings
SET BuildingProductionModifier = '15'
WHERE Type = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Building_YieldChanges
SET Yield = '3'
WHERE BuildingType = 'BUILDING_COFFEE_HOUSE' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Language_en_US
SET Text = '+25% [ICON_GREAT_PEOPLE] Great People generation in this City. +15% [ICON_PRODUCTION] Production when constructing Buildings.'
WHERE Tag = 'TXT_KEY_BUILDING_COFFEE_HOUSE_HELP' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Maya -- Move Pyramid to Agriculture, Bring GP back to Calendar (makes so much more sense!)

UPDATE Buildings
SET PrereqTech = 'TECH_AGRICULTURE'
WHERE Type = 'BUILDING_MAYA_PYRAMID' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

UPDATE Traits
SET PrereqTech = 'TECH_CALENDAR'
WHERE Type = 'TRAIT_LONG_COUNT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'After researching the Calendar, receive a bonus Great Person at the end of every Maya Long Count cycle (every 394 years). Each bonus person can only be chosen once.'
WHERE Tag = 'TXT_KEY_TRAIT_LONG_COUNT' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

-- Buff Atlatl, move to Classical Age

UPDATE Units
SET GoodyHutUpgradeUnitClass = 'UNITCLASS_CROSSBOWMAN'
WHERE Type = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_CROSSBOWMAN'
WHERE UnitType = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Civilization_UnitClassOverrides
Set UnitClassType = 'UNITCLASS_COMPOSITE_BOWMAN'
WHERE UnitType = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET PrereqTech = 'TECH_MATHEMATICS'
WHERE Type = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Units
SET ObsoleteTech = 'TECH_RIFLING'
WHERE Type = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Units
SET Class = 'UNITCLASS_COMPOSITE_BOWMAN'
WHERE Type = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Units
SET Combat = '5'
WHERE Type = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Units
SET RangedCombat = '11'
WHERE Type = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_UNITS' AND Value= 1 );

UPDATE Unit_Flavors
SET Flavor = '15'
WHERE UnitType = 'UNIT_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Only the Maya may build this unit. It is available sooner than the Composite Bowman, which it replaces, and can attack twice.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_MAYAN_ATLATLIST' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'The Atlatlist is the Mayan unique unit, replacing the Composite Bowman. Atlatlists are both cheaper than a Composite Bowman, available earlier, and can attack twice. This advantage allows your archers to engage in hit-and-run skirmish tactics.'
WHERE Tag = 'TXT_KEY_UNIT_MAYAN_ATLATLIST_STRATEGY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LEADERS' AND Value= 1 );
