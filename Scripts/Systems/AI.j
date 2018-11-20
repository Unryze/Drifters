	function AIUnit takes nothing returns unit
		return GetUnit( "AI" )
	endfunction
	
	function AITarget takes nothing returns unit
		return GetUnit( "Target" )
	endfunction

	function AICoord takes string Axis returns real
		local real Coord
		if Axis == "X" then
			set Coord = GetUnitX( AIUnit( ) )
	elseif Axis == "Y" then
			set Coord = GetUnitY( AIUnit( ) )
		endif

		return Coord
	endfunction

	function AIItemFilter takes nothing returns boolean
		if GetFilterItem( ) != null and GetWidgetLife( GetFilterItem( ) ) > 0 and IsItemVisible( GetFilterItem( ) ) then
			if GetItemType( GetFilterItem( ) ) == ITEM_TYPE_POWERUP or HasEmptyItemSlot( AIUnit( ) ) then
				call IssueTargetOrder( AIUnit( ), "smart", GetFilterItem( ) )
				return true
			endif
		endif

		return false
	endfunction

	function AIFilterEnemyConditions takes nothing returns boolean
		if UnitLife( GetFilterUnit( ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( AIUnit( ) ) ) then
			call SaveUnitHandle( HashTable, MUIHandle( ), StringHash( "Target" ), GetFilterUnit( ) )
		endif

		return false
	endfunction

	function AILoop takes nothing returns nothing
		call SaveInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ), LoadInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ) ) + 1 )

		if LoadInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ) ) == 5 then
			call IssuePointOrder( AIUnit( ), "attack", GetRandomReal( -1900., 1900. ), GetRandomReal( -110., 180. ) )
			call SaveInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ), 0 )
		endif

		if OrderId2String( GetUnitCurrentOrder( AIUnit( ) ) ) != null or OrderId2String( GetUnitCurrentOrder( AIUnit( ) ) ) == null then
			if AITarget( ) == null then
				call GroupEnumUnitsInRange( EnumUnits( ), GetUnitX( AIUnit( ) ), GetUnitY( AIUnit( ) ), 800, Condition( function AIFilterEnemyConditions ) )
			endif

			if AITarget( ) == null then
				call SaveRectHandle( HashTable, MUIHandle( ), StringHash( "ItemRect" ), Rect( AICoord( "X" ) - 800, AICoord( "Y" ) - 800, AICoord( "X" ) + 800, AICoord( "Y" ) + 800 ) )
				call EnumItemsInRect( LoadRectHandle( HashTable, MUIHandle( ), StringHash( "ItemRect" ) ), Condition( function AIItemFilter ), null )
				call RemoveRect( LoadRectHandle( HashTable, MUIHandle( ), StringHash( "ItemRect" ) ) )
				call RemoveSavedHandle( HashTable, MUIHandle( ), StringHash( "ItemRect" ) )
			else
				call IssueTargetOrder( AIUnit( ), "attack", 	  AITarget( ) )
				call IssueTargetOrder( AIUnit( ), "purge", 		  AITarget( ) )
				call IssueTargetOrder( AIUnit( ), "drain", 		  AITarget( ) )
				call IssueTargetOrder( AIUnit( ), "curse", 		  AITarget( ) )
				call IssuePointOrder(  AIUnit( ), "shockwave", 	  GetUnitX( AITarget( ) ), GetUnitY( AITarget( ) ) )
				call IssuePointOrder(  AIUnit( ), "blizzard", 	  GetUnitX( AITarget( ) ), GetUnitY( AITarget( ) ) )
				call IssuePointOrder(  AIUnit( ), "inferno", 	  GetUnitX( AITarget( ) ), GetUnitY( AITarget( ) ) )
				call IssuePointOrder(  AIUnit( ), "carrionswarm", GetUnitX( AITarget( ) ), GetUnitY( AITarget( ) ) )
				call IssueImmediateOrder( AIUnit( ), "stomp" )
				call IssueImmediateOrder( AIUnit( ), "roar" )

				if ( IsUnitType( AITarget( ), UNIT_TYPE_HERO ) == false and UnitLife( AITarget( ) ) >= 500 ) or IsUnitType( AITarget( ), UNIT_TYPE_HERO ) then
					call IssueImmediateOrder( AIUnit( ), "thunderclap" )
					call IssueTargetOrder( AIUnit( ), "cripple", 	 AITarget( ) )
					call IssueTargetOrder( AIUnit( ), "hex", 		 AITarget( ) )
					call IssueTargetOrder( AIUnit( ), "banish", 	 AITarget( ) )
					call IssuePointOrder(  AIUnit( ), "breathoffire", GetUnitX( AITarget( ) ), GetUnitY( AITarget( ) ) )
					call IssuePointOrder(  AIUnit( ), "earthquake",   GetUnitX( AITarget( ) ), GetUnitY( AITarget( ) ) )
				endif

				if UnitLife( LoadUnitHandle( HashTable, MUIHandle( ), StringHash( "Target" ) ) ) <= 0 or DistanceBetweenUnits( AIUnit( ), AITarget( ) ) >= 850 then
					call RemoveSavedHandle( HashTable, MUIHandle( ), StringHash( "Target" ) )
				endif

				if GetUnitStatePercentage( AIUnit( ), UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE ) <= 20 then
					if GetPlayerTeam( GetOwningPlayer( AIUnit( ) ) ) == 0 then
						call IssuePointOrder( AIUnit( ), "move", -4288., -576. )
					else
						call IssuePointOrder( AIUnit( ), "move",  4288., -576. )
					endif
				endif
			endif
		endif
	endfunction

	function StartAI takes unit LocHero returns nothing
		if LoadBoolean( HashTable, GetHandleId( LocHero ), StringHash( "AIStarted" ) ) == false then
			if GetAIDifficulty( GetOwningPlayer( LocHero ) ) == AI_DIFFICULTY_NEWBIE then
				call SetPlayerHandicapXP( GetOwningPlayer( LocHero ), 1.5 )
		elseif GetAIDifficulty( GetOwningPlayer( LocHero ) ) == AI_DIFFICULTY_NORMAL then
				call SetPlayerHandicapXP( GetOwningPlayer( LocHero ), 2 )
		elseif GetAIDifficulty( GetOwningPlayer( LocHero ) ) == AI_DIFFICULTY_INSANE then
				call SetPlayerHandicapXP( GetOwningPlayer( LocHero ), 3 )
			endif

			call SaveBoolean( HashTable, GetHandleId( LocHero ), StringHash( "AIStarted" ), true )
			call IssuePointOrder( LocHero, "attack", GetRandomReal( -1900., 1900. ), GetRandomReal( -1200., 200. ) )

			call SaveTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer1" ), CreateTimer( ) )
			call SaveUnitHandle( HashTable, GetHandleId( LoadTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer1" ) ) ), StringHash( "AI" ), LocHero )
			call TimerStart( LoadTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer1" ) ), 1, true, function AILoop )
		endif
	endfunction

