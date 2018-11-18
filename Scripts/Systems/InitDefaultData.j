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
		call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TimerMaximumCount" ), 1000 )
		call SaveBoolean( HashTable, GetHandleId( CameraSet ), StringHash( "IsSameHero" ), false )
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
			call SetPlayerAbilityAvailable( Player( ID ), 'Amrf', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A004', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A005', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A006', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A012', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A014', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A016', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A018', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A019', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A021', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A022', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A025', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A026', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A028', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A029', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A031', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A034', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A035', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A037', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A038', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A039', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A042', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A043', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A044', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A047', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A048', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A049', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A050', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A052', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A053', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A054', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A055', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A056', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A057', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A059', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A061', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A060', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A064', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A065', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A066', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A068', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A069', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A070', false )
			call SetPlayerAbilityAvailable( Player( ID ), 'A072', false )
			call SetPlayerState( Player( ID ), PLAYER_STATE_GIVES_BOUNTY, 1 )
			set ID = ID + 1
		endloop
	endfunction

	function InitSetPlayerName takes nothing returns nothing
		local integer ID = 0
		local string  LocalName

		loop
			exitwhen ID > 9

			if GetPlayerSlotState( Player( ID ) ) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController( Player( ID ) ) == MAP_CONTROL_COMPUTER then
				call SetPlayerName( Player( ID ), "Bot " + I2S( ID + 1 ) )
			endif

			set ID = ID + 1
		endloop
	endfunction

