-- Delete things we replace below
DELETE FROM Improvement_TechYieldChanges;
DELETE FROM Improvement_TechFreshWaterYieldChanges;
DELETE FROM Improvement_TechNoFreshWaterYieldChanges;

-- Farm
-- Now buildable on all flat tiles except desert and snow, OR flat fresh water tiles
UPDATE Improvements
SET RequiresFlatlands = 1, RequiresFlatlandsOrFreshWater = 0
WHERE Type = 'IMPROVEMENT_FARM';

DELETE FROM Improvement_ValidTerrains
WHERE ImprovementType = 'IMPROVEMENT_FARM' AND TerrainType = 'TERRAIN_DESERT';

-- +1 Food per 2 adjacent farms
INSERT INTO Improvement_YieldAdjacentTwoSameType
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FARM', 'YIELD_FOOD', 1);

-- +1 Food on fresh water
INSERT INTO Improvement_FreshWaterYields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FARM', 'YIELD_FOOD', 1);

-- Trading Post: now Village
UPDATE Improvements
SET NoTwoAdjacent = 1
WHERE Type = 'IMPROVEMENT_TRADING_POST';

INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_TRADING_POST', 'YIELD_CULTURE', 1);

UPDATE Improvement_Yields
SET Yield = 2
WHERE ImprovementType = 'IMPROVEMENT_TRADING_POST' AND YieldType = 'YIELD_GOLD';

-- +Prod/Gold when built on trade route/city connection
INSERT INTO Improvement_RouteYieldChanges
	(ImprovementType, RouteType, YieldType, Yield)
VALUES
	('IMPROVEMENT_TRADING_POST', 'ROUTE_ROAD', 'YIELD_GOLD', 1),
	('IMPROVEMENT_TRADING_POST', 'ROUTE_ROAD', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_TRADING_POST', 'ROUTE_RAILROAD', 'YIELD_GOLD', 2),
	('IMPROVEMENT_TRADING_POST', 'ROUTE_RAILROAD', 'YIELD_PRODUCTION', 2);

-- Lumber Mill
-- +1 Prod/Gold per 2 adjacent lumber mills
INSERT INTO Improvement_YieldAdjacentTwoSameType
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_LUMBERMILL', 'YIELD_GOLD', 1),
	('IMPROVEMENT_LUMBERMILL', 'YIELD_PRODUCTION', 1);

INSERT INTO Improvement_ValidFeatures
	(ImprovementType, FeatureType)
VALUES
	('IMPROVEMENT_LUMBERMILL', 'FEATURE_JUNGLE');

INSERT INTO Improvement_FeatureYieldChanges
	(ImprovementType, FeatureType, YieldType, Yield)
VALUES
	('IMPROVEMENT_LUMBERMILL', 'FEATURE_JUNGLE', 'YIELD_PRODUCTION', -1),
	('IMPROVEMENT_LUMBERMILL', 'FEATURE_JUNGLE', 'YIELD_GOLD', 1);

-- Fort
INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FORT', 'YIELD_CULTURE_LOCAL', 1);

UPDATE Improvements
SET
	NoTwoAdjacent = 1,
	OutsideBorders = 0,
	BuildableOnResources = 0,
	MakesPassable = 1,
	DestroyedWhenPillaged = 0
WHERE Type = 'IMPROVEMENT_FORT';

-- Citadel
INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_CITADEL', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_CITADEL', 'YIELD_SCIENCE', 1);

UPDATE Improvements
SET NoTwoAdjacent = 1, MakesPassable = 1
WHERE Type = 'IMPROVEMENT_CITADEL';

-- Other GPTIs
UPDATE Improvement_Yields
SET Yield = 6
WHERE ImprovementType = 'IMPROVEMENT_ACADEMY' AND YieldType = 'YIELD_SCIENCE';

UPDATE Improvement_Yields
SET Yield = 6
WHERE ImprovementType = 'IMPROVEMENT_CUSTOMS_HOUSE' AND YieldType = 'YIELD_GOLD';

UPDATE Improvement_Yields
SET Yield = 6
WHERE ImprovementType = 'IMPROVEMENT_MANUFACTORY' AND YieldType = 'YIELD_PRODUCTION';

UPDATE Improvement_Yields
SET Yield = 4
WHERE ImprovementType = 'IMPROVEMENT_HOLY_SITE' AND YieldType = 'YIELD_FAITH';

INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_CUSTOMS_HOUSE', 'YIELD_FOOD', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_HOLY_SITE', 'YIELD_CULTURE', 5),
	('IMPROVEMENT_HOLY_SITE', 'YIELD_TOURISM', 3),
	('IMPROVEMENT_EMBASSY', 'YIELD_GOLD', 2),
	('IMPROVEMENT_EMBASSY', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_EMBASSY', 'YIELD_SCIENCE', 2);

-- +Prod/Gold when built on trade route/city connection
INSERT INTO Improvement_RouteYieldChanges
	(ImprovementType, RouteType, YieldType, Yield)
VALUES
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_ROAD', 'YIELD_GOLD', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_ROAD', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_RAILROAD', 'YIELD_GOLD', 4),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'ROUTE_RAILROAD', 'YIELD_PRODUCTION', 4);

-- Embassy can be built anywhere
-- This is needed because it doesn't have a MakesValid criteria otherwise
INSERT INTO Improvement_ValidTerrains
	(ImprovementType, TerrainType)
VALUES
	('IMPROVEMENT_EMBASSY', 'TERRAIN_GRASS'),
	('IMPROVEMENT_EMBASSY', 'TERRAIN_PLAINS'),
	('IMPROVEMENT_EMBASSY', 'TERRAIN_DESERT'),
	('IMPROVEMENT_EMBASSY', 'TERRAIN_TUNDRA'),
	('IMPROVEMENT_EMBASSY', 'TERRAIN_SNOW');

-- Landmark
INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_LANDMARK', 'YIELD_CULTURE', 3),
	('IMPROVEMENT_LANDMARK', 'YIELD_GOLD', 3);

-- Happiness on built
UPDATE Improvements
SET HappinessOnConstruction = 3
WHERE Type = 'IMPROVEMENT_LANDMARK';

-- +1 Culture/Gold per era
INSERT INTO Improvement_YieldPerEra
	(ImprovementType, YieldType, Yield)
VALUES
	-- ('IMPROVEMENT_LANDMARK', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_LANDMARK', 'YIELD_GOLD', 1);

-- Oil Well and Offshore Platform
INSERT INTO Improvement_Yields
	(ImprovementType, YieldType, Yield)
VALUES
	('IMPROVEMENT_WELL', 'YIELD_GOLD', 7),
	('IMPROVEMENT_OFFSHORE_PLATFORM', 'YIELD_GOLD', 4);

-- Barb camp gives defense
UPDATE Improvements
SET DefenseModifier = 25
WHERE Type = 'IMPROVEMENT_BARBARIAN_CAMP';

INSERT INTO Improvement_TechYieldChanges
	(ImprovementType, TechType, YieldType, Yield)
VALUES
	('IMPROVEMENT_FARM', 'TECH_CIVIL_SERVICE', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FARM', 'TECH_FERTILIZER', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FARM', 'TECH_ROBOTICS', 'YIELD_FOOD', 3),
	('IMPROVEMENT_CAMP', 'TECH_GUILDS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CAMP', 'TECH_GUNPOWDER', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CAMP', 'TECH_RIFLING', 'YIELD_GOLD', 1),
	('IMPROVEMENT_CAMP', 'TECH_REFRIGERATION', 'YIELD_GOLD', 2),
	('IMPROVEMENT_MINE', 'TECH_STEEL', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_MINE', 'TECH_STEAM_POWER', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_MINE', 'TECH_COMBUSTION', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_MINE', 'TECH_ROBOTICS', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_TRADING_POST', 'TECH_GUILDS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_TRADING_POST', 'TECH_RAILROAD', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_QUARRY', 'TECH_STEAM_POWER', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_QUARRY', 'TECH_MACHINERY', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_QUARRY', 'TECH_DYNAMITE', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_PASTURE', 'TECH_CIVIL_SERVICE', 'YIELD_FOOD', 2),
	('IMPROVEMENT_PASTURE', 'TECH_FERTILIZER', 'YIELD_GOLD', 2),
	('IMPROVEMENT_PASTURE', 'TECH_ROBOTICS', 'YIELD_FOOD', 3),
	('IMPROVEMENT_PLANTATION', 'TECH_CHEMISTRY', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'TECH_PLASTIC', 'YIELD_GOLD', 1),
	('IMPROVEMENT_PLANTATION', 'TECH_ECONOMICS', 'YIELD_GOLD', 1),
	('IMPROVEMENT_FISHING_BOATS', 'TECH_COMPASS', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FISHING_BOATS', 'TECH_NAVIGATION', 'YIELD_FOOD', 1),
	('IMPROVEMENT_FISHING_BOATS', 'TECH_REFRIGERATION', 'YIELD_FOOD', 2),
	('IMPROVEMENT_LUMBERMILL', 'TECH_METALLURGY', 'YIELD_GOLD', 1),
	('IMPROVEMENT_LUMBERMILL', 'TECH_METALLURGY', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_LUMBERMILL', 'TECH_COMBUSTION', 'YIELD_GOLD', 1),
	('IMPROVEMENT_LUMBERMILL', 'TECH_COMBUSTION', 'YIELD_PRODUCTION', 1),
	('IMPROVEMENT_WELL', 'TECH_PLASTIC', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_WELL', 'TECH_ELECTRONICS', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_FORT', 'TECH_CHEMISTRY', 'YIELD_SCIENCE', 2),
	('IMPROVEMENT_FORT', 'TECH_MILITARY_SCIENCE', 'YIELD_CULTURE_LOCAL', 2),
	('IMPROVEMENT_FORT', 'TECH_STEALTH', 'YIELD_SCIENCE', 4),
	('IMPROVEMENT_FORT', 'TECH_ELECTRONICS', 'YIELD_CULTURE_LOCAL', 4),
	('IMPROVEMENT_MANUFACTORY', 'TECH_METAL_CASTING', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_MANUFACTORY', 'TECH_FERTILIZER', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_MANUFACTORY', 'TECH_COMBINED_ARMS', 'YIELD_PRODUCTION', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_PHYSICS', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_SCIENTIFIC_THEORY', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_ROCKETRY', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_ACADEMY', 'TECH_NUCLEAR_FISSION', 'YIELD_SCIENCE', 3),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_BANKING', 'YIELD_GOLD', 3),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_RAILROAD', 'YIELD_FOOD', 3),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_RAILROAD', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_ARCHITECTURE', 'YIELD_FOOD', 3),
	('IMPROVEMENT_CUSTOMS_HOUSE', 'TECH_REFRIGERATION', 'YIELD_GOLD', 3),
	('IMPROVEMENT_CITADEL', 'TECH_CHEMISTRY', 'YIELD_SCIENCE', 2),
	('IMPROVEMENT_CITADEL', 'TECH_MILITARY_SCIENCE', 'YIELD_PRODUCTION', 2),
	('IMPROVEMENT_CITADEL', 'TECH_STEALTH', 'YIELD_SCIENCE', 4),
	('IMPROVEMENT_CITADEL', 'TECH_ELECTRONICS', 'YIELD_PRODUCTION', 4),
	('IMPROVEMENT_LANDMARK', 'TECH_SATELLITES', 'YIELD_CULTURE', 2),
	('IMPROVEMENT_HOLY_SITE', 'TECH_ACOUSTICS', 'YIELD_FAITH', 4),
	('IMPROVEMENT_HOLY_SITE', 'TECH_ARCHAEOLOGY', 'YIELD_CULTURE', 4),
	('IMPROVEMENT_HOLY_SITE', 'TECH_FLIGHT', 'YIELD_TOURISM', 4),
	('IMPROVEMENT_EMBASSY', 'TECH_CIVIL_SERVICE', 'YIELD_GOLD', 1),
	('IMPROVEMENT_EMBASSY', 'TECH_PRINTING_PRESS', 'YIELD_CULTURE', 1),
	('IMPROVEMENT_EMBASSY', 'TECH_MILITARY_SCIENCE', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_EMBASSY', 'TECH_ATOMIC_THEORY', 'YIELD_GOLD', 1),
	('IMPROVEMENT_EMBASSY', 'TECH_ATOMIC_THEORY', 'YIELD_SCIENCE', 1),
	('IMPROVEMENT_EMBASSY', 'TECH_TELECOM', 'YIELD_CULTURE', 1);
