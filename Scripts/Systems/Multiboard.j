	function MultiBoardCreationFunction1 takes nothing returns nothing
		local integer MID = 0
		local integer PID = 0

		call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|c00ff0000Welcome to Anime Character Fight|r
		|c00ff0000Wish you an amazing victory: |r|c0000ffffor a sweet defeat : )|r" )

		call SaveMultiboardHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Multiboard" ), CreateMultiboard( ) )
		call MultiboardSetRowCount( GetMultiboard( ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "MPosition" ) ) + 1 )
		call MultiboardSetColumnCount( GetMultiboard( ), 4 )
		call MultiboardSetTitleText( GetMultiboard( ), "     Round|c00FFFFFF: X|r Time|c00FFFFFF: " + "0:0:0|r     " )
		call MultiboardDisplay( GetMultiboard( ), true )

		loop
			exitwhen MID > LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "MPosition" ) )
			call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 0 ) )
			call MultiboardSetItemWidth( GetMBItem( ), LoadInteger( HashTable, GetHandleId( HashTable ), 0 ) / 100. )
			call MultiboardSetItemStyle( GetMBItem( ), true, false )
			call ReleaseMBItem( )

			call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 1 ) )
			call MultiboardSetItemWidth( GetMBItem( ), 1 / 100. )
			call MultiboardSetItemStyle( GetMBItem( ), true, false )
			call ReleaseMBItem( )

			call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 2 ) )
			call MultiboardSetItemWidth( GetMBItem( ), 1 / 100. )
			call MultiboardSetItemStyle( GetMBItem( ), true, false )
			call ReleaseMBItem( )
			
			call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 3 ) )
			call MultiboardSetItemWidth( GetMBItem( ), 1 / 100. )
			call MultiboardSetItemStyle( GetMBItem( ), true, false )
			call ReleaseMBItem( )

			if MID != 0 then
				if GetPlayerSlotState( Player( PID ) ) != PLAYER_SLOT_STATE_PLAYING then
					loop
						exitwhen GetPlayerSlotState( Player( PID ) ) == PLAYER_SLOT_STATE_PLAYING
						set PID = PID + 1
					endloop
				endif

				call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 0 ) )
				call MultiboardSetItemValue( GetMBItem( ), GetTeamColour( PID ) + GetPlayerName( Player( PID ) ) + "|r" )
				call ReleaseMBItem( )

				call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 1 ) )
				call MultiboardSetItemValue( GetMBItem( ), "0" )
				call ReleaseMBItem( )
				
				call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 2 ) )
				call MultiboardSetItemValue( GetMBItem( ), "0" )
				call ReleaseMBItem( )
				
				call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), MID, 3 ) )
				call MultiboardSetItemValue( GetMBItem( ), "0" )
				call ReleaseMBItem( )
				set PID = PID + 1
			endif

			set MID = MID + 1
		endloop

		call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), 0, 0 ) )
		call MultiboardSetItemValue( GetMBItem( ), "|cffffcc00Players" )
		call ReleaseMBItem( )

		call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), 0, 1 ) )
		call MultiboardSetItemValue( GetMBItem( ), "|cffffcc00K|r" )
		call ReleaseMBItem( )

		call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), 0, 2 ) )
		call MultiboardSetItemValue( GetMBItem( ), "|cffffcc00D|r" )
		call ReleaseMBItem( )

		call SaveMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ), MultiboardGetItem( GetMultiboard( ), 0, 3 ) )
		call MultiboardSetItemValue( GetMBItem( ), "|cffffcc00A|r" )
		call ReleaseMBItem( )

		call MultiboardDisplay( GetMultiboard( ), true )
	endfunction
	
	function StoreTime takes string Type, integer Time returns nothing
		call SaveInteger( HashTable, MUIHandle( ), StringHash( Type ), Time )
	endfunction

	function InGameTimerAction takes nothing returns nothing
		if GetInt( "Seconds" ) == 59 then
			call StoreTime( "Seconds", 0 )
			call StoreTime( "Minutes", GetInt( "Minutes" ) + 1 )
		else
			call StoreTime( "Seconds", GetInt( "Seconds" ) + 1 )
		endif		

		if GetInt( "Minutes" ) == 59 then
			call StoreTime( "Minutes", 0 )
			call StoreTime( "Hours", GetInt( "Hours" ) + 1 )
		endif

		call MultiboardSetTitleText( GetMultiboard( ), "     Round|c00FFFFFF: X|r Time|c00FFFFFF: " + I2S( GetInt( "Hours" ) ) + ":" + I2S( GetInt( "Minutes" ) ) + ":" + I2S( GetInt( "Seconds" ) ) + "|r     " )
	endfunction	

	function ModeDialogAction takes nothing returns nothing
		local integer i = 0

		loop
			exitwhen i > 8

			if GetClickedButton( ) == LoadButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button" + I2S( i ) ) ) then
				call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID" + I2S( i ) ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID" + I2S( i ) ) ) + 1 )
			endif

			set i = i + 1
		endloop
	endfunction

	function KillSelectionTimerExpireAction takes nothing returns nothing
		local integer MaxVotes 	 = 0
		local integer TotalVotes = 0
		local integer MaxVotesID = 0
		local integer index 	 = 0
		local boolean VotesTied  = false

		call DialogShow( GetDialog( ), false )
		call DialogClear( GetDialog( ) )
		call DialogDestroy( GetDialog( ) )
		call TimerDialogDisplay( LoadTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ) ), false )
		call DestroyTimerDialog( LoadTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ) ) )
		call MultiboardDisplay( GetMultiboard( ), true )

		loop
			exitwhen index > 8

			if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID" + I2S( index ) ) ) > 0 then
				set TotalVotes = TotalVotes + 1
			endif

			if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID" + I2S( index ) ) ) == MaxVotes then
				set VotesTied = true
			endif

			if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID" + I2S( index ) ) ) > MaxVotes then
				set MaxVotes = LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID" + I2S( index ) ) )
				set MaxVotesID = index
				set VotesTied = false
			endif

			set index = index + 1
		endloop
		
		if MaxVotesID == 0 then
			call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "RoundLimit" ), 20 * GetRandomInt( 1, 7 ) )
		else
			call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "RoundLimit" ), 20 * MaxVotesID )
		endif

		if VotesTied == true or TotalVotes <= 0 then
			
		endif

		if TotalVotes > 0 then
			call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|cffffcc00Chosen|r |c0000ffff[Round Limit]|r |cffffcc00:|r|c0000ffff" + I2S( LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "RoundLimit" ) ) ) + "|r" )
		endif

		call EnableTrigger( LoadTrig( "HeroSelectionTrig" ) )
		call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|c0000ffffHero Selection has been activated!|r" )
		call MultiboardDisplay( GetMultiboard( ), false )
		call MultiboardDisplay( GetMultiboard( ), true )
		call TimerStart( CreateTimer( ), 1, true, function InGameTimerAction )
	endfunction

	function KillSelectionAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|c0000ffffAttention to All Players!

		You have 5 seconds to choose desirable Kill Limit|r" )

		call SaveTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ), CreateTimerDialog( LoadTimerHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Timer0" ) ) ) )
		call TimerDialogSetTitle( LoadTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ) ), "|c00ffff00Kill Limit Selection" )
		call TimerDialogDisplay( LoadTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ) ), true )
		call TimerStart( LoadTimerHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Timer0" ) ), 5, false, function KillSelectionTimerExpireAction )
		call DialogSetMessage( GetDialog( ), "Select Kill Limit" )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button0" ), DialogAddButton( GetDialog( ), "Random", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button1" ), DialogAddButton( GetDialog( ), "20 Kills [1 vs 1]", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button2" ), DialogAddButton( GetDialog( ), "40 Kills", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button3" ), DialogAddButton( GetDialog( ), "60 Kills [2 vs 2]", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button4" ), DialogAddButton( GetDialog( ), "80 Kills", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button5" ), DialogAddButton( GetDialog( ), "100 Kills [3 vs 3]", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button6" ), DialogAddButton( GetDialog( ), "120 Kills", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button7" ), DialogAddButton( GetDialog( ), "140 Kills [4 vs 4]", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button8" ), DialogAddButton( GetDialog( ), "Unlimited Kills", 0 ) )
		call DialogShow( GetDialog( ), true )
	endfunction	

	function ModeSelectionFunction2 takes nothing returns nothing
		if GetClickedButton( ) == LoadButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button10" ) ) then
			call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID10" ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID10" ) ) + 1 )
		endif

		if GetClickedButton( ) == LoadButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button11" ) ) then
			call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID11" ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID11" ) ) + 1 )
		endif
	endfunction	

	function ModeSelectionFunction3 takes nothing returns nothing
		call DialogShow( GetDialog( ), false )
		call DialogClear( GetDialog( ) )
		call TimerDialogDisplay( LoadTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ) ), false )
		call MultiboardDisplay( GetMultiboard( ), true )
		call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|cffffcc00Same Hero Mode Results:
		For:|r |c0000ffff" + I2S( LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID10" ) ) ) + "|r |cffffcc00Against:|r |c0000ffff" + I2S( LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID11" ) ) ) + "|r" )

		if LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID10" ) ) > LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "ButtonID11" ) ) then
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), StringHash( "IsSameHero" ), true )
			call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|c0000FF00Same Hero Mode Enabled!|r" )
		else
			call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|c00ff0000Same Hero Mode Disabled!|r" )
		endif

		call TimerStart( LoadTimerHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Timer0" ) ), 1, false, function KillSelectionAction )
	endfunction	

	function ModeSelectionFunction1 takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetLocalPlayer( ), 0, 0, 5, "|c00FFFF00Hero Selection is disabled
		To enable it:
		Choose desirable kills and mode|r" )

		call SaveTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ), CreateTimerDialog( LoadTimerHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Timer0" ) ) ) )
		call TimerDialogSetTitle( LoadTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ) ), "|c00ffff00Mode Selection" )
		call TimerDialogDisplay( LoadTimerDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "TimerDialog1" ) ), true )
		call DialogSetMessage( GetDialog( ), "Same Hero Mode" )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button10" ), DialogAddButton( GetDialog( ), "|c0000FF00Enable|r", 0 ) )
		call SaveButtonHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Button11" ), DialogAddButton( GetDialog( ), "|c00ff0000Disable|r", 0 ) )
		call DialogShow( GetDialog( ), true )
		call TimerStart( LoadTimerHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Timer0" ) ), 5, false, function ModeSelectionFunction3 )
	endfunction

