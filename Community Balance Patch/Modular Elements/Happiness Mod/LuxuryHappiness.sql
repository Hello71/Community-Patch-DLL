	-- Luxury happiness divisor. % of techs researched increases pop required over time.

	INSERT INTO Defines (
	Name, Value)
	SELECT 'BALANCE_HAPPINESS_POPULATION_DIVISOR', '0'
	WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LUXURY_HAPPINESS' AND Value= 0 );
	
	INSERT INTO Defines (
	Name, Value)
	SELECT 'BALANCE_HAPPINESS_POPULATION_DIVISOR', '15'
	WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LUXURY_HAPPINESS' AND Value= 1 );

-- Maximum bonus from luxuries.

	INSERT INTO Defines (
	Name, Value)
	SELECT 'BALANCE_HAPPINESS_LUXURY_MAXIMUM', '0'
	WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LUXURY_HAPPINESS' AND Value= 0 );

	INSERT INTO Defines (
	Name, Value)
	SELECT 'BALANCE_HAPPINESS_LUXURY_MAXIMUM', '4'
	WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LUXURY_HAPPINESS' AND Value= 1 );

-- Divisor bonus for luxuries.

	INSERT INTO Defines (
	Name, Value)
	SELECT 'BALANCE_HAPPINESS_LUXURY_BASE', '6';

-- REALLY IMPORTANT VALUE
-- % Increase of luxury pop needed as you research technologies. Set upper/lower limits on the % increase here.

	INSERT INTO Defines (
	Name, Value)
	SELECT 'BALANCE_HAPPINESS_ERA_BASE_INCREASE', '0'
	WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LUXURY_HAPPINESS' AND Value= 1 );
	
	INSERT INTO Defines (
	Name, Value)
	SELECT 'BALANCE_HAPPINESS_ERA_MAX_INCREASE', '150'
	WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LUXURY_HAPPINESS' AND Value= 1 );

	UPDATE Resources
	SET Happiness = '1'
	WHERE Happiness = '4' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_LUXURY_HAPPINESS' AND Value= 1 );
