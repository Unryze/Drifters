	function InitVariables takes nothing returns nothing
		local integer i = 0

		call SaveSound( "BloodFlow1", "General\\BloodFlow1.mp3" )
		call SaveSound( "KickSound1", "General\\KickSound1.mp3" )
		call SaveSound( "GlassShatter1", "General\\GlassShatter1.mp3" )
		call SaveSound( "SlamSound1", "General\\SlamSound.mp3" )
		call SaveReal( HashTable, GetHandleId( CameraSet ), StringHash( "CameraDistance" ), 1000 )
		call SaveReal( HashTable, GetHandleId( CameraSet ), StringHash( "MinX" ), -11008. )
		call SaveReal( HashTable, GetHandleId( CameraSet ), StringHash( "MaxX" ),  11008. )
		call SaveReal( HashTable, GetHandleId( CameraSet ), StringHash( "MinY" ), -11520. )
		call SaveReal( HashTable, GetHandleId( CameraSet ), StringHash( "MaxY" ),  11008. )
		call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "MPosition" ), 0 )
		call SaveBoolean( HashTable, GetHandleId( CameraSet ), StringHash( "IsSameHero" ), false )
		call SaveGroupHandle( HashTable, GetHandleId( CameraSet ), StringHash( "DamagedGroup" ), CreateGroup( ) )
		call SaveGroupHandle( HashTable, GetHandleId( CameraSet ), StringHash( "GlobalGroup" ), CreateGroup( ) )
		call SaveDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "ModeDialog" ), DialogCreate( ) )
		call SaveStr( HashTable, GetHandleId( CameraSet ), StringHash( "Letters" ), "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" )
		call SaveTimerHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Timer0" ), CreateTimer( ) )

		loop
			exitwhen i > 9
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), i, false ) // IsSelected
			call SaveUnit( I2S( i ), CreateUnit( Player( i ), 'u000', 8000, 8000, 270 ) )
			set i = i + 1
		endloop
	endfunction

	function InitPlayerData takes nothing returns nothing
		local integer ID = 0
		call PanCameraToTimed( -1800., 5900., 0 )

		loop
			exitwhen ID > 9
			call SetPlayerAbilityAvailable( Player( ID ), 'A054', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'Amrf', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02E', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02G', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02K', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02L', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03Q', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A048', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02N', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02O', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02Q', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02R', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02V', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02W', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02Y', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02Z', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03M', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03N', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03O', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03P', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03D', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03G', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03H', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03I', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A039', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03A', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03B', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03C', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04H', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04I', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04J', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04K', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A032', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A034', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A036', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A037', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03S', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03U', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03V', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03W', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03X', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A049', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04C', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04B', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04D', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04E', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03Y', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03Z', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A040', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A042', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A043', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A044', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04Q', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A052', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A01Y', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A026', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A027', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02A', false )
			call SetPlayerState( Player( ID ), PLAYER_STATE_GIVES_BOUNTY, 1 )
			set ID = ID + 1
		endloop
	endfunction

	function InitSetPlayerName takes nothing returns nothing
		local integer ID = 0
		local string  LocalName

		loop
			exitwhen ID > 9

			if GetPlayerSlotState( Player( ID ) ) == PLAYER_SLOT_STATE_PLAYING then
				if GetPlayerController( Player( ID ) ) == MAP_CONTROL_COMPUTER then
					set LocalName = "Bot " + I2S( ID + 1 )
				else
					set LocalName = GetPlayerName( Player( ID ) )
				endif

				set LocalName = GetTeamColour( ID ) + SubString( LocalName, 0, StringLength( LocalName ) ) + "|r"
				call SetPlayerName( Player( ID ), LocalName )
			endif

			set ID = ID + 1
		endloop
	endfunction

