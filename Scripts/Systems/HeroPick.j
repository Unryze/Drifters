	function FillHeroPickInfo takes integer HeroIndex, integer HeroID, real HeroScale, string ModelName returns nothing
		call SaveInteger( HashTable, GetHandleId( HashTable ), HeroIndex, HeroID )
		call SaveReal( HashTable, GetHandleId( HashTable ), HeroIndex, HeroScale )
		call SaveStr( HashTable, GetHandleId( HashTable ), HeroIndex, "Characters\\" + ModelName + "\\" )
		call SaveStr( HashTable, GetHandleId( HashTable ), HeroIndex + 4000, LoadStr( HashTable, GetHandleId( HashTable ), HeroIndex ) + "ReplaceableTextures\\CommandButtons\\BTN" + ModelName + "Icon.blp" )
		call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalHeroes" ), HeroIndex )
	endfunction

	function InitHeroPickData takes nothing returns nothing
		local integer i 	   = 1
		local integer SysIconX = -2600
		local integer SysIconY = 6200
		local integer SysHeroX = 700
		local integer SysHeroY = 6200

		call FillHeroPickInfo( 1,  'H000', 1.4, "Nanaya"	)
		call FillHeroPickInfo( 2,  'H001', 1.4, "Toono"		)
		call FillHeroPickInfo( 3,  'H002', 1.5, "Ryougi"	)
		call FillHeroPickInfo( 4,  'H003', 2.2, "SaberAlter" 	)
		call FillHeroPickInfo( 5,  'H004', 2.4, "SaberNero" 	)
		call FillHeroPickInfo( 6,  'H005', 2.2, "Byakuya" 	)
		call FillHeroPickInfo( 7,  'H006', 1.5, "Akame" 	)
		call FillHeroPickInfo( 8,  'H007', 2.4, "Scathach" 	)
		call FillHeroPickInfo( 9,  'H008', 1.8, "Akainu" 	)
		call FillHeroPickInfo( 10, 'H009', 3.0, "Reinforce" 	)
		call FillHeroPickInfo( 11, 'H00A', 2.4, "Arcueid" 	)
		call FillHeroPickInfo( 12, 'H00B', 2.0, "SaberArtoria"  )
		call FillHeroPickInfo( 13, 'H00B', 2.0, "RubyRouse" 	)
		call SaveUnitHandle( HashTable, GetHandleId( HashTable ), 8000, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u005', -1800, 5525, 270 ) )
		call ScaleUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 8000 ), 2.5 )
		call SaveEffectHandle( HashTable, GetHandleId( HashTable ), 8001, AddSpecialEffectTarget( "HeroSelectionSystem\\HeroSelectionEffect.mdl", LoadUnitHandle( HashTable, GetHandleId( HashTable ), 8000 ), "origin" ) )
		call SaveEffectHandle( HashTable, GetHandleId( HashTable ), 8002, AddSpecialEffectTarget( "HeroSelectionSystem\\HeroSelectionBackground.mdl", LoadUnitHandle( HashTable, GetHandleId( HashTable ), 8000 ), "origin" ) )

		loop
			exitwhen i > LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalHeroes" ) )

			if i == 6 or i == 11 then
				set SysIconX = -2600
				set SysIconY = SysIconY - 100
				set SysHeroX = 700
				set SysHeroY = SysHeroY - 150
			endif

			call SaveUnitHandle( HashTable, GetHandleId( HashTable ), 1000 + i, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u006', SysIconX, SysIconY, 270 ) )
			call SetUnitVertexColor( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 1000 + i ), 255, 255, 255, 0 )
			call SetUnitUserData( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 1000 + i ), i )
			call SaveEffectHandle( HashTable, GetHandleId( HashTable ), 2000 + i, AddSpecialEffect( LoadStr( HashTable, GetHandleId( HashTable ), i ) + "Icon.mdl", SysIconX, SysIconY ) )
			call SaveUnitHandle( HashTable, GetHandleId( HashTable ), i, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), LoadInteger( HashTable, GetHandleId( HashTable ), i ), SysHeroX, SysHeroY, 270 ) )
			call SetUnitInvulnerable( LoadUnitHandle( HashTable, GetHandleId( HashTable ), i ), true )
			set SysIconX = SysIconX + 100
			set SysHeroX = SysHeroX + 150
			set i = i + 1
		endloop
	endfunction

	function InitHeroTrig takes integer LocID returns nothing
		if LoadBoolean( HashTable, GetHandleId( CameraSet ), 6000 + LocID ) == false then
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), 6000 + LocID, true ) 
			call ExecuteFunc( "HeroInit" + I2S( LocID ) )
		endif
	endfunction

	function MoveHeroToTeamLocation takes integer LocID, integer HeroID returns nothing
		if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "PlayersPicked" ) ) < LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalPlayers" ) ) then
			call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "PlayersPicked" ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "PlayersPicked" ) ) + 1 )
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), LocID, true ) // Disabling Camera Lock For Player( LocID )
		endif

		if GetPlayerTeam( Player( LocID ) ) == 0 then // IsSelected saving for each team
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), 1000 + HeroID, true )
		else
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), 2000 + HeroID, true )
		endif

		if LoadBoolean( HashTable, GetHandleId( CameraSet ), StringHash( "IsSameHero" ) ) then
			call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), HeroID ) )
			call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 1000 + HeroID ) )
		endif

		call InitHeroTrig( HeroID )
		call SaveUnitHandle( HashTable, GetHandleId( Player( LocID ) ), 0, CreateUnit( Player( LocID ), LoadInteger( HashTable, GetHandleId( HashTable ), HeroID ), -11000, 10000, 270 ) )
		call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), LoadInteger( HashTable, GetHandleId( Player( LocID ) ), 0 ) + 1, 0 ) )
		call MultiboardSetItemStyle( GetMBItem( ), true, true )
		call MultiboardSetItemIcon( GetMBItem( ), LoadStr( HashTable, GetHandleId( HashTable ), HeroID + 4000 ) )

		if GetPlayerController( Player( LocID ) ) == MAP_CONTROL_USER then
			call SetPlayerName( Player( LocID ), GetPlayerName( Player( LocID ) ) + " [ " + GetHeroProperName( LoadUnitHandle( HashTable, GetHandleId( Player( LocID ) ), 0 ) ) + " ]" )
			if GetLocalPlayer( ) == Player( LocID ) then
				call CameraSetupSetField( CameraSet, CAMERA_FIELD_ANGLE_OF_ATTACK, 305, 0 )
				call CameraSetupApplyForceDuration( CameraSet, true, 0 )
				call SaveReal( HashTable, GetHandleId( CameraSet ), StringHash( "CameraDistance" ), 3000 )
				call PanCameraToTimed( GetUnitX( LoadUnitHandle( HashTable, GetHandleId( Player( LocID ) ), 0 ) ), GetUnitY( LoadUnitHandle( HashTable, GetHandleId( Player( LocID ) ), 0 ) ), 0 )
				call ClearSelection( )
				call SelectUnit( LoadUnitHandle( HashTable, GetHandleId( Player( LocID ) ), 0 ), true )
			endif
		else
			call StartAI( LoadUnitHandle( HashTable, GetHandleId( Player( LocID ) ), 0 ) )
			call MultiboardSetItemValue( GetMBItem( ), GetPlayerName( Player( LocID ) ) )
			call SetPlayerName( Player( LocID ), GetTeamColour( LocID ) + "Bot|r [ " + GetHeroProperName( LoadUnitHandle( HashTable, GetHandleId( Player( LocID ) ), 0 ) ) + " ]" )
		endif

		call ReleaseMBItem( )
	endfunction

	function ComputerHeroSelection takes nothing returns nothing
		local integer i = 0
		local integer HeroID = GetRandomInt( 1, LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalHeroes" ) ) )

		if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "PlayersPicked" ) ) == LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalPlayers" ) ) then
			call DestroyEffect( LoadEffectHandle( HashTable, GetHandleId( HashTable ), 8001 ) )
			call DestroyEffect( LoadEffectHandle( HashTable, GetHandleId( HashTable ), 8002 ) )
			call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 8000 ) )

			loop
				exitwhen i > 9

				if GetPlayerSlotState( Player( i ) ) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController( Player( i ) ) == MAP_CONTROL_COMPUTER then
					loop
						exitwhen LoadBoolean( HashTable, GetHandleId( CameraSet ), 1000 + HeroID ) == false and LoadBoolean( HashTable, GetHandleId( CameraSet ), 2000 + HeroID ) == false
						set HeroID = GetRandomInt( 1, LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalHeroes" ) ) )
					endloop

					call MoveHeroToTeamLocation( i, HeroID )
				endif

				set i = i + 1
			endloop

			set i = 1

			loop
				exitwhen i > LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalHeroes" ) )
				call DestroyEffect( LoadEffectHandle( HashTable, GetHandleId( HashTable ), 2000 + i ) )
				call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 1000 + i ) )
				call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), i ) )
				set i = i + 1
			endloop

			if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalPlayers" ) ) > 1 then
				call FlushChildHashtable( HashTable, GetHandleId( HashTable ) )
			endif

			call DisableTrigger( LoadTrig( "HeroSelectionTrig" ) )
		endif
	endfunction 

	function HeroSelectionAction takes nothing returns nothing
		local integer TeamID	 = GetPlayerTeam( GetTriggerPlayer( ) )
		local integer ID 		 = GetPlayerId( GetTriggerPlayer( ) )
		local integer UnitData 	 = GetUnitUserData( GetTriggerUnit( ) )
		local string  LocEffect1 = ""

		if LoadBoolean( HashTable, GetHandleId( CameraSet ), ID ) == false and GetUnitTypeId( GetTriggerUnit( ) ) == 'u006' then //IsSelected 
			if GetLocalPlayer( ) != GetTriggerPlayer( ) then
				set LocEffect1 = ""
			else
				set LocEffect1 = LoadStr( HashTable, GetHandleId( HashTable ), UnitData ) + "Skin00.mdl"
				call ClearSelection( )
				call SelectUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), UnitData ), true )
			endif

			call DestroyEffect( LoadEffectHandle( HashTable, GetHandleId( HashTable ), 5000 + ID ) )
			call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 3000 + ID ) )
			call SaveUnitHandle( HashTable, GetHandleId( HashTable ), 3000 + ID, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u005', -1800, 5525, 270 ) )
			call SetUnitTimeScale( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 3000 + ID ), 1.5 )
			call ScaleUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 3000 + ID ), LoadReal( HashTable, GetHandleId( HashTable ), UnitData ) )
			call SaveEffectHandle( HashTable, GetHandleId( HashTable ), 5000 + ID, AddSpecialEffectTarget( LocEffect1, LoadUnitHandle( HashTable, GetHandleId( HashTable ), 3000 + ID ), "origin" ) )

			if LoadUnitHandle( HashTable, GetHandleId( HashTable ), 4000 + ID ) != LoadUnitHandle( HashTable, GetHandleId( HashTable ), UnitData ) then
				call SaveUnitHandle( HashTable, GetHandleId( HashTable ), 4000 + ID, LoadUnitHandle( HashTable, GetHandleId( HashTable ), UnitData ) )
			else
				if ( LoadBoolean( HashTable, GetHandleId( CameraSet ), 1000 + UnitData ) == false and TeamID == 0 ) or ( LoadBoolean( HashTable, GetHandleId( CameraSet ), 2000 + UnitData ) == false and TeamID == 1 ) then //IsSelected checking
					call DestroyEffect( LoadEffectHandle( HashTable, GetHandleId( HashTable ), 5000 + ID ) )
					call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( HashTable ), 3000 + ID ) )
					call MoveHeroToTeamLocation( ID, UnitData )
					call ComputerHeroSelection( )
				else
					call DisplayTextToPlayer( GetTriggerPlayer( ), 0, 0, "|c0000ffffHero already selected by your ally!" )
				endif
			endif
		endif
	endfunction	

