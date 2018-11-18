	function ReviveSystemTriggerFunction3 takes nothing returns nothing
		call DestroyEffect( LoadEffectHandle( HashTable, MUIHandle( ), 1 ) )
		call ReviveHero( MUIUnit( 0 ), -11000, 10000, true )
		call SetUnitFlyHeight( MUIUnit( 0 ), 0, 0 )

		if GetLocalPlayer( ) == GetOwningPlayer( MUIUnit( 0 ) ) then
			call ClearSelection( )
			call PanCameraToTimed( -11000, 10000, .2 )
			call SelectUnit( MUIUnit( 0 ), true )
		endif
		
		if GetPlayerController( GetOwningPlayer( MUIUnit( 0 ) ) ) == MAP_CONTROL_COMPUTER then
			call IssuePointOrder( MUIUnit( 0 ), "attack", GetRandomReal( -1900., 1900. ), GetRandomReal( -1200., 200. ) )
		endif

		call TimerPause( GetExpiredTimer( ) )
		call FlushChildHashtable( HashTable, MUIHandle( ) )
	endfunction

	function ReviveSystemAction takes nothing returns boolean
		local integer KillingID = GetPlayerId( GetOwningPlayer( GetKillingUnit( ) ) )
		local integer DyingID 	= GetPlayerId( GetOwningPlayer( GetDyingUnit( ) ) )
		local integer HandleID

		if IsUnitType( GetDyingUnit( ), UNIT_TYPE_HERO ) and GetPlayerSlotState( Player( DyingID ) ) == PLAYER_SLOT_STATE_PLAYING and Player( DyingID ) != Player( PLAYER_NEUTRAL_AGGRESSIVE ) and Player( DyingID ) != Player( PLAYER_NEUTRAL_PASSIVE ) then 
			set HandleID = NewMUITimer( DyingID )
			call SaveUnitHandle( HashTable, HandleID, 0, GetDyingUnit( ) )
			call SaveEffectHandle( HashTable, HandleID, 1, AddSpecialEffect( "GeneralEffects\\UnitEffects\\DeathIndicator.mdl", GetUnitX( GetDyingUnit( ) ), GetUnitY( GetDyingUnit( ) ) + 300 ) )	
			call TimerStart( LoadMUITimer( DyingID ), 4, false, function ReviveSystemTriggerFunction3 )
			
			if IsUnitAlly( GetKillingUnit( ), Player( DyingID ) ) != true then
				if GetOwningPlayer( GetKillingUnit( ) ) != Player( PLAYER_NEUTRAL_AGGRESSIVE ) then
					call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, GetPlayerName( Player( KillingID ) ) + "|c008080c0 has killed|r " + GetPlayerName( Player( DyingID ) ) + "!" )
					call SaveInteger( HashTable, GetHandleId( GetKillingUnit( ) ), 100, LoadInteger( HashTable, GetHandleId( GetKillingUnit( ) ), 100 ) + 1 )
					call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), LoadInteger( HashTable, GetHandleId( Player( KillingID ) ), 0 ) + 1, 1 ) )
					call MultiboardSetItemValue( GetMBItem( ), I2S( LoadInteger( HashTable, GetHandleId( GetKillingUnit( ) ), 100 ) ) )
					call ReleaseMBItem( )
				endif

				call SaveInteger( HashTable, GetHandleId( GetDyingUnit( ) ), 101, LoadInteger( HashTable, GetHandleId( GetDyingUnit( ) ), 101 ) + 1 )
				call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), LoadInteger( HashTable, GetHandleId( Player( DyingID ) ), 0 ) + 1, 2 ) )
				call MultiboardSetItemValue( GetMBItem( ), I2S( LoadInteger( HashTable, GetHandleId( GetDyingUnit( ) ), 101 ) ) )
				call ReleaseMBItem( )
			endif
		endif
		
		return false
	endfunction

