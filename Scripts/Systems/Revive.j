	function ReviveSystemTriggerFunction3 takes nothing returns nothing
		call DestroyEffect( LoadEffectHandle( HashTable, MUIHandle( ), 1 ) )
		call ReviveHero( MUIUnit( 0 ), -11000, 10000, true )
		call SetUnitFlyHeight( MUIUnit( 0 ), 0, 2000 )

		if GetLocalPlayer( ) == GetOwningPlayer( MUIUnit( 0 ) ) then
			call ClearSelection( )
			call PanCameraToTimed( -11000, 10000, .2 )
			call SelectUnit( MUIUnit( 0 ), true )
		endif
		
		if GetPlayerController( GetOwningPlayer( MUIUnit( 0 ) ) ) == MAP_CONTROL_COMPUTER then
			call IssuePointOrder( MUIUnit( 0 ), "attack", GetRandomReal( -1900., 1900. ), GetRandomReal( -1200., 200. ) )
		endif

		call PauseTimer( GetExpiredTimer( ) )
		call FlushChildHashtable( HashTable, MUIHandle( ) )
		call DestroyTimer( GetExpiredTimer( ) )
	endfunction

	function ReviveSystemAction takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsUnitType( GetDyingUnit( ), UNIT_TYPE_HERO ) and GetPlayerSlotState( GetTriggerPlayer( ) ) == PLAYER_SLOT_STATE_PLAYING and LocPID < 12 then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 0, GetTriggerUnit( ) )
			call SaveEffectHandle( HashTable, HandleID, 1, AddSpecialEffect( "GeneralEffects\\UnitEffects\\DeathIndicator.mdl", GetUnitX( GetDyingUnit( ) ), GetUnitY( GetDyingUnit( ) ) + 300 ) )	
			call TimerStart( LoadMUITimer( LocPID ), 4, false, function ReviveSystemTriggerFunction3 )
		endif
	endfunction

