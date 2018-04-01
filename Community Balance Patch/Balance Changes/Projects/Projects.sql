UPDATE Projects
Set FreeBuildingClassIfFirst = 'BUILDINGCLASS_LABORATORY'
WHERE Type = 'PROJECT_MANHATTAN_PROJECT';

UPDATE Projects
Set FreePolicyIfFirst = 'POLICY_MANHATTAN_PROJECT'
WHERE Type = 'PROJECT_MANHATTAN_PROJECT';

UPDATE Projects
Set FreePolicyIfFirst = 'POLICY_FIRST_ON_MOON'
WHERE Type = 'PROJECT_APOLLO_PROGRAM';

UPDATE Projects
Set Cost = '1500'
WHERE Type = 'PROJECT_APOLLO_PROGRAM';

UPDATE Projects
Set Cost = '1500'
WHERE Type = 'PROJECT_MANHATTAN_PROJECT';

INSERT INTO Policies
	(Type, Description, IncludesOneShotFreeUnits, GoldenAgeTurns, IsDummy)
VALUES
	('POLICY_FIRST_ON_MOON', 'TXT_KEY_POLICY_FIRST_ON_MOON', 1, 10, 1),
	('POLICY_MANHATTAN_PROJECT', 'TXT_KEY_POLICY_MANHATTAN_PROJECT', 1, 0, 1);

INSERT INTO Policy_FreeUnitClasses
	(PolicyType, UnitClassType, Count)
VALUES
	('POLICY_FIRST_ON_MOON', 'UNITCLASS_SCIENTIST', 1),
	('POLICY_MANHATTAN_PROJECT', 'UNITCLASS_ATOMIC_BOMB', 1);

-- Processes

INSERT INTO Processes
	(Type, Description, Help, Strategy, TechPrereq, IconAtlas, PortraitIndex)
VALUES
	('PROCESS_CULTURE', 'TXT_KEY_PROCESS_CULTURE', 'TXT_KEY_PROCESS_CULTURE_HELP', 'TXT_KEY_PROCESS_CULTURE_STRATEGY', 'TECH_DRAMA', 'COMMUNITY_ATLAS', 43),
	('PROCESS_FOOD', 'TXT_KEY_PROCESS_FOOD', 'TXT_KEY_PROCESS_FOOD_HELP', 'TXT_KEY_PROCESS_FOOD_STRATEGY', 'TECH_AGRICULTURE', 'COMMUNITY_ATLAS', 32),
	('PROCESS_DEFENSE', 'TXT_KEY_PROCESS_DEFENSE', 'TXT_KEY_PROCESS_DEFENSE_HELP', 'TXT_KEY_PROCESS_DEFENSE_STRATEGY', 'TECH_ARCHERY', 'COMMUNITY_2_ATLAS', 8);

UPDATE Processes
Set DefenseValue = '10'
WHERE Type = 'PROCESS_DEFENSE';

INSERT INTO Process_Flavors
	(ProcessType, FlavorType, Flavor)
VALUES
	('PROCESS_CULTURE', 'FLAVOR_CULTURE', 5),
	('PROCESS_FOOD', 'FLAVOR_GROWTH', 5),
	('PROCESS_DEFENSE', 'FLAVOR_CITY_DEFENSE', 5);

INSERT INTO Process_ProductionYields
	(ProcessType, YieldType, Yield)
VALUES
	('PROCESS_CULTURE', 'YIELD_CULTURE', 20),
	('PROCESS_FOOD', 'YIELD_FOOD', 20);