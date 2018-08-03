	function AIItemFilter takes nothing returns boolean
		if IsItemVisible( GetFilterItem( ) ) and GetWidgetLife( GetFilterItem( ) ) > 0 then
			call SaveItemHandle( HashTable, MUIHandle( ), StringHash( "FindItem" ), GetFilterItem( ) )
		endif

		return true
	endfunction

	function AIHasEmptyInventorySlot takes unit u returns boolean
		return UnitItemInSlot( u, 0 ) == null or UnitItemInSlot( u, 1 ) == null or UnitItemInSlot( u, 2 ) == null or UnitItemInSlot( u, 3 ) == null or UnitItemInSlot( u, 4 ) == null or UnitItemInSlot( u, 5 ) == null
	endfunction

	function AIFilterEnemyConditions takes nothing returns boolean
		return UnitLife( GetFilterUnit( ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 0 ) ) )
	endfunction

	function AIHeroMoveLoop takes nothing returns nothing
		call IssuePointOrder( MUIUnit( 0 ), "attack", GetRandomReal( -1900., 1900. ), GetRandomReal( -110., 180. ) )
	endfunction

	function LoadFoundItem takes nothing returns item
		return LoadItemHandle( HashTable, MUIHandle( ), StringHash( "FindItem" ) )
	endfunction

	function AILoop takes nothing returns nothing
		if OrderId2String( GetUnitCurrentOrder( MUIUnit( 0 ) ) ) != null or OrderId2String( GetUnitCurrentOrder( MUIUnit( 0 ) ) ) == null then
			call SaveGroupHandle( HashTable, MUIHandle( ), 1001, CreateGroup( ) )
			call GroupEnumUnitsInRange( LoadGroupHandle( HashTable, MUIHandle( ), 1001 ), GetUnitX( MUIUnit( 0 ) ), GetUnitY( MUIUnit( 0 ) ), 800, Condition( function AIFilterEnemyConditions ) )
			call SaveUnitHandle( HashTable, MUIHandle( ), 101, FirstOfGroup( LoadGroupHandle( HashTable, MUIHandle( ), 1001 ) ) )
			call DestroyGroup( LoadGroupHandle( HashTable, MUIHandle( ), 1001 ) )
			call RemoveSavedHandle( HashTable, MUIHandle( ), 1001 )

			if MUIUnit( 101 ) == null then
				call SaveRectHandle( HashTable, MUIHandle( ), 1000, Rect( GetUnitX( MUIUnit( 0 ) ) - 800, GetUnitY( MUIUnit( 0 ) ) - 800, GetUnitX( MUIUnit( 0 ) ) + 800, GetUnitY( MUIUnit( 0 ) ) + 800 ) )
				call EnumItemsInRect( LoadRectHandle( HashTable, MUIHandle( ), 1000 ), Condition( function AIItemFilter ), null )
				call RemoveRect( LoadRectHandle( HashTable, MUIHandle( ), 1000 ) )
				call RemoveSavedHandle( HashTable, MUIHandle( ), 1000 )

				if LoadFoundItem( ) != null and ( GetItemType( LoadFoundItem( ) ) == ITEM_TYPE_POWERUP or AIHasEmptyInventorySlot( MUIUnit( 0 ) ) ) then
					call IssueTargetOrder( MUIUnit( 0 ), "smart", LoadFoundItem( ) )
					call RemoveSavedHandle( HashTable, MUIHandle( ), StringHash( "FindItem" ) )
				endif
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

				call RemoveSavedHandle( HashTable, MUIHandle( ), 101 )

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

			call SaveTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer2" ), CreateTimer( ) )
			call SaveUnitHandle( HashTable, GetHandleId( LoadTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer2" ) ) ), 0, LocHero )
			call TimerStart( LoadTimerHandle( HashTable, GetHandleId( LocHero ), StringHash( "AITimer2" ) ), 10,  true, function AIHeroMoveLoop )
		endif
	endfunction

