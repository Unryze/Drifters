	function DecideWinnersAction takes nothing returns nothing
		local integer index	= 0

		loop
			exitwhen index > 9

			if GetPlayerSlotState( Player( index ) ) == PLAYER_SLOT_STATE_PLAYING then
				if GetPlayerTeam( Player( index ) ) == LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TeamID" ) ) then
					call RemovePlayer( Player( index ), PLAYER_GAME_RESULT_VICTORY )
				else
					call RemovePlayer( Player( index ), PLAYER_GAME_RESULT_DEFEAT )
				endif
			endif

			set index = index + 1
		endloop

		call EndGame( true )
	endfunction

	function PrepareFinishGameAction takes integer LocTeam returns nothing
		call DisplayTextToPlayer( GetLocalPlayer( ), 0, 0, "Team: " + I2S( 1 + LocTeam ) + " has won the game!" )
		call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TeamID" ), LocTeam )
		call TimerStart( CreateTimer( ), 10, false, function DecideWinnersAction )
	endfunction

	function WinGameEndFunction1 takes nothing returns nothing
		if LoadInteger( HashTable, GetHandleId( HashTable ), StringHash( "TeamOneRoundsWon" ) ) >= LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "RoundLimit" ) ) then
			call PrepareFinishGameAction( 0 )
		endif

		if LoadInteger( HashTable, GetHandleId( HashTable ), StringHash( "TeamTwoRoundsWon" ) ) >= LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "RoundLimit" ) ) then
			call PrepareFinishGameAction( 1 )
		endif
	endfunction

	function RegisterPlayerLeaveAction takes nothing returns nothing
		local integer 	ID 				= 0
		local integer	PlayerID		= GetPlayerId( GetTriggerPlayer( ) )
		local integer	TeamID			= GetPlayerTeam( GetTriggerPlayer( ) )
		local integer	LocRecievedGold	= GetPlayerState( GetTriggerPlayer( ), PLAYER_STATE_RESOURCE_GOLD ) / ( LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TeamPlayers" + I2S( TeamID ) ) ) - 1 )

		call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), LoadInteger( HashTable, GetHandleId( Player( PlayerID ) ), 0 ) + 1, 0 ) )
		call MultiboardSetItemValue( GetMBItem( ), "- Left -|r" )
		call ReleaseMBItem( )

		call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalPlayers" ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalPlayers" ) ) - 1 )
		call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TeamPlayers" + I2S( TeamID ) ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TeamPlayers" + I2S( TeamID ) ) ) - 1 )
		call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, GetPlayerName( Player( PlayerID ) )  + " has left the game!" )
		call RemoveUnit( LoadUnitHandle( HashTable, GetHandleId( Player( PlayerID ) ), 0 ) )
		call RemoveSavedHandle( HashTable, GetHandleId( Player( PlayerID ) ), 0 )
		call RemovePlayer( GetTriggerPlayer( ), PLAYER_GAME_RESULT_DEFEAT )

		loop
			exitwhen ID > 9

			if GetPlayerSlotState( Player( ID ) ) == PLAYER_SLOT_STATE_PLAYING and IsPlayerAlly( GetTriggerPlayer( ), Player( ID ) ) then
				call SetPlayerState( Player( ID ), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState( Player( ID ), PLAYER_STATE_RESOURCE_GOLD ) + LocRecievedGold )
			endif

			set ID = ID + 1
		endloop

		call DisplayTextToPlayer( GetLocalPlayer( ), 0, 0, "Each player in Team " + I2S( TeamID + 1 ) + " has received |cffffcc00" + I2S( LocRecievedGold ) + "|r gold from a leaver." )

		if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TeamPlayers" + I2S( TeamID ) ) ) == 0 then

			if TeamID == 0 then
				set ID = 1
			else
				set ID = 0
			endif

			call PrepareFinishGameAction( ID )
		endif
	endfunction 

