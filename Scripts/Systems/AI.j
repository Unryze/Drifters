	function AIItemFilter takes nothing returns boolean
		if GetWidgetLife( GetFilterItem( ) ) > 0 and IsItemVisible( GetFilterItem( ) ) and GetFilterItem( ) != null then
			if GetItemType( GetFilterItem( ) ) == ITEM_TYPE_POWERUP or HasEmptyItemSlot( MUIUnit( 0 ) ) then
				call IssueTargetOrder( MUIUnit( 0 ), "smart", GetFilterItem( ) )
				return true
			endif
		endif

		return false
	endfunction

	function AIFilterEnemyConditions takes nothing returns boolean
		if UnitLife( GetFilterUnit( ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 0 ) ) ) then
			call SaveUnitHandle( HashTable, MUIHandle( ), 101, GetFilterUnit( ) )
		endif

		return false
	endfunction

	function AILoop takes nothing returns nothing
		call SaveInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ), LoadInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ) ) + 1 )

		if LoadInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ) ) == 5 then
			call IssuePointOrder( MUIUnit( 0 ), "attack", GetRandomReal( -1900., 1900. ), GetRandomReal( -110., 180. ) )
			call SaveInteger( HashTable, MUIHandle( ), StringHash( "MoveTime" ), 0 )
		endif

		if OrderId2String( GetUnitCurrentOrder( MUIUnit( 0 ) ) ) != null or OrderId2String( GetUnitCurrentOrder( MUIUnit( 0 ) ) ) == null then
			if MUIUnit( 101 ) == null then
				call GroupEnumUnitsInRange( EnumUnits( ), GetUnitX( MUIUnit( 0 ) ), GetUnitY( MUIUnit( 0 ) ), 800, Condition( function AIFilterEnemyConditions ) )
			endif

			if MUIUnit( 101 ) == null then
				call SaveRectHandle( HashTable, MUIHandle( ), 1000, Rect( GetUnitX( MUIUnit( 0 ) ) - 800, GetUnitY( MUIUnit( 0 ) ) - 800, GetUnitX( MUIUnit( 0 ) ) + 800, GetUnitY( MUIUnit( 0 ) ) + 800 ) )
				call EnumItemsInRect( LoadRectHandle( HashTable, MUIHandle( ), 1000 ), Condition( function AIItemFilter ), null )
				call RemoveRect( LoadRectHandle( HashTable, MUIHandle( ), 1000 ) )
				call RemoveSavedHandle( HashTable, MUIHandle( ), 1000 )
			else
				call IssueTargetOrder( MUIUnit( 0 ), "attack", 		 MUIUnit( 101 ) )
				call IssueTargetOrder( MUIUnit( 0 ), "purge", 		 MUIUnit( 101 ) )
				call IssueTargetOrder( MUIUnit( 0 ), "drain", 		 MUIUnit( 101 ) )
				call IssueTargetOrder( MUIUnit( 0 ), "curse", 		 MUIUnit( 101 ) )
				call IssuePointOrder(  MUIUnit( 0 ), "shockwave", 	 GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) )
				call IssuePointOrder(  MUIUnit( 0 ), "blizzard", 	 GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) )
				call IssuePointOrder(  MUIUnit( 0 ), "inferno", 	 GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) )
				call IssuePointOrder(  MUIUnit( 0 ), "carrionswarm", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) )
				call IssueImmediateOrder( MUIUnit( 0 ), "stomp" )
				call IssueImmediateOrder( MUIUnit( 0 ), "roar" )

				if ( IsUnitType( MUIUnit( 101 ), UNIT_TYPE_HERO ) == false and UnitLife( MUIUnit( 101 ) ) >= 500 ) or IsUnitType( MUIUnit( 101 ), UNIT_TYPE_HERO ) then
					call IssueImmediateOrder( MUIUnit( 0 ), "thunderclap" )
					call IssueTargetOrder( MUIUnit( 0 ), "cripple", 	 MUIUnit( 101 ) )
					call IssueTargetOrder( MUIUnit( 0 ), "hex", 		 MUIUnit( 101 ) )
					call IssueTargetOrder( MUIUnit( 0 ), "banish", 		 MUIUnit( 101 ) )
					call IssuePointOrder(  MUIUnit( 0 ), "breathoffire", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) )
					call IssuePointOrder(  MUIUnit( 0 ), "earthquake", 	 GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) )
				endif

				if UnitLife( LoadUnitHandle( HashTable, MUIHandle( ), 101 ) ) <= 0 or DistanceBetweenUnits( MUIUnit( 0 ), MUIUnit( 101 ) ) >= 850 then
					call RemoveSavedHandle( HashTable, MUIHandle( ), 101 )
				endif

				if GetUnitStatePercentage( MUIUnit( 0 ), UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE ) <= 20 then
					if GetPlayerTeam( GetOwningPlayer( MUIUnit( 0 ) ) ) == 0 then
						call IssuePointOrder( MUIUnit( 0 ), "move", -4288., -576. )
					else
						call IssuePointOrder( MUIUnit( 0 ), "move",  4288., -576. )
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
			call SaveUnitHandle( HashTable, GetHandleId( LoadTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer1" ) ) ), 0, LocHero )
			call TimerStart( LoadTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer1" ) ), 1, true, function AILoop )
		endif
	endfunction

