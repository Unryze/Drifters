	function ReviveSystemTriggerFunction3 takes nothing returns nothing
		call DestroyEffect( LoadEffectHandle( HashTable, MUIHandle( ), StringHash( "DeathEffect" ) ) )
		call ReviveHero( GetUnit( "RevivingUnit" ), -11000, 10000, true )
		call SetUnitFlyHeight( GetUnit( "RevivingUnit" ), 0, 0 )

		if GetLocalPlayer( ) == GetOwningPlayer( GetUnit( "RevivingUnit" ) ) then
			call ClearSelection( )
			call PanCameraToTimed( -11000, 10000, .2 )
			call SelectUnit( GetUnit( "RevivingUnit" ), true )
		endif
		
		if GetPlayerController( GetOwningPlayer( GetUnit( "RevivingUnit" ) ) ) == MAP_CONTROL_COMPUTER then
			call IssuePointOrder( GetUnit( "RevivingUnit" ), "attack", GetRandomReal( -1900., 1900. ), GetRandomReal( -1200., 200. ) )
		endif

		call TimerPause( GetExpiredTimer( ) )
		call FlushChildHashtable( HashTable, MUIHandle( ) )
	endfunction

	function ReviveSystemAction takes nothing returns nothing
		local integer KillingID = GetPlayerId( GetOwningPlayer( GetKillingUnit( ) ) )
		local integer DyingID 	= GetPlayerId( GetOwningPlayer( GetDyingUnit( ) ) )
		local integer HandleID

		if IsUnitType( GetDyingUnit( ), UNIT_TYPE_HERO ) and GetPlayerSlotState( Player( DyingID ) ) == PLAYER_SLOT_STATE_PLAYING and Player( DyingID ) != Player( PLAYER_NEUTRAL_AGGRESSIVE ) and Player( DyingID ) != Player( PLAYER_NEUTRAL_PASSIVE ) then 
			set HandleID = NewMUITimer( DyingID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "RevivingUnit" ), GetDyingUnit( ) )
			call SaveEffectHandle( HashTable, HandleID, StringHash( "DeathEffect" ), AddSpecialEffect( "GeneralEffects\\UnitEffects\\DeathIndicator.mdl", GetUnitX( GetDyingUnit( ) ), GetUnitY( GetDyingUnit( ) ) + 300 ) )	
			call TimerStart( LoadMUITimer( DyingID ), 4, false, function ReviveSystemTriggerFunction3 )
			
			if IsUnitAlly( GetKillingUnit( ), Player( DyingID ) ) != true then
				if GetOwningPlayer( GetKillingUnit( ) ) != Player( PLAYER_NEUTRAL_AGGRESSIVE ) then
					call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, GetPlayerName( Player( KillingID ) ) + "|c008080c0 has killed|r " + GetPlayerName( Player( DyingID ) ) + "!" )
					call SaveInteger( HashTable, GetHandleId( GetKillingUnit( ) ), StringHash( "KillCount" ), LoadInteger( HashTable, GetHandleId( GetKillingUnit( ) ), StringHash( "KillCount" ) ) + 1 )
					call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), LoadInteger( HashTable, GetHandleId( Player( KillingID ) ), 0 ) + 1, 1 ) )
					call MultiboardSetItemValue( GetMBItem( ), I2S( LoadInteger( HashTable, GetHandleId( GetKillingUnit( ) ), StringHash( "KillCount" ) ) ) )
					call ReleaseMBItem( )
				endif

				call SaveInteger( HashTable, GetHandleId( GetDyingUnit( ) ), StringHash( "DeathCount" ), LoadInteger( HashTable, GetHandleId( GetDyingUnit( ) ), StringHash( "DeathCount" ) ) + 1 )
				call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), LoadInteger( HashTable, GetHandleId( Player( DyingID ) ), 0 ) + 1, 2 ) )
				call MultiboardSetItemValue( GetMBItem( ), I2S( LoadInteger( HashTable, GetHandleId( GetDyingUnit( ) ), StringHash( "DeathCount" ) ) ) )
				call ReleaseMBItem( )
			endif
		endif
	endfunction

