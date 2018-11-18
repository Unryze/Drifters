	function CheckForCC takes nothing returns nothing
		local integer LocData = GetUnitData( MUIUnit( 0 ), StringHash( GetStr( "CCType" ) ) )

		if LocData > 0 then
			call SetUnitData( MUIUnit( 0 ), StringHash( GetStr( "CCType" ) ), LocData - 1 )
		else
			if GetStr( "CCType" ) == "Stun" then
				call UnitRemoveAbility( MUIUnit( 0 ), 'B005' )
			endif
			
			if GetStr( "CCType" ) == "Silence" then
				call UnitRemoveAbility( MUIUnit( 0 ), 'B004' )
			endif

			if GetStr( "CCType" ) == "Slow" then
				call UnitRemoveAbility( MUIUnit( 0 ), 'Bslo' )
			endif

			call TimerPause( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, MUIHandle( ) )
		endif
	endfunction 
	
	function CCUnit takes unit LocUnit, real LocReal, string CCType, boolean IsReduced returns nothing
		local integer LocPID = GetPlayerId( GetOwningPlayer( LocUnit ) )
		local integer HandleID

		if CCType == "Stun" or CCType == "Silence" or CCType == "Slow" then
			if IsReduced == true then
				// set LocReal = LocReal / CCMitigation
			endif

			call SetUnitData( LocUnit, StringHash( CCType ), R2I( LocReal * 100 ) + GetUnitData( LocUnit, StringHash( CCType ) ) )

			if CCType == "Stun" then
				if GetUnitAbilityLevel( LocUnit, 'B005' ) == 0 then
					set HandleID = NewMUITimer( LocPID )
					call UnitShareVision( LocUnit, Player( PLAYER_NEUTRAL_PASSIVE ), true )
					call IssueTargetOrder( CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u004', GetUnitX( LocUnit ), GetUnitY( LocUnit ), 0 ), "firebolt", LocUnit )
					call SaveStr( HashTable, HandleID, StringHash( "CCType" ), CCType )
					call SaveUnitHandle( HashTable, HandleID, 0, LocUnit )
					call TimerStart( LoadMUITimer( LocPID ), .01, true, function CheckForCC )
				endif
			endif

			if CCType == "Silence" then
				if GetUnitAbilityLevel( LocUnit, 'B004' ) == 0 then
					set HandleID = NewMUITimer( LocPID )
					call UnitShareVision( LocUnit, Player( PLAYER_NEUTRAL_PASSIVE ), true )
					call IssueTargetOrder( CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u004', GetUnitX( LocUnit ), GetUnitY( LocUnit ), 0 ), "soulburn", LocUnit )
					call SaveStr( HashTable, HandleID, StringHash( "CCType" ), CCType )
					call SaveUnitHandle( HashTable, HandleID, 0, LocUnit )
					call TimerStart( LoadMUITimer( LocPID ), .01, true, function CheckForCC )
				endif
			endif

			if CCType == "Slow" then
				if GetUnitAbilityLevel( LocUnit, 'Bslo' ) == 0 then
					set HandleID = NewMUITimer( LocPID )
					call UnitShareVision( LocUnit, Player( PLAYER_NEUTRAL_PASSIVE ), true )
					call IssueTargetOrder( CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u004', GetUnitX( LocUnit ), GetUnitY( LocUnit ), 0 ), "slow", LocUnit )
					call SaveStr( HashTable, HandleID, StringHash( "CCType" ), CCType )
					call SaveUnitHandle( HashTable, HandleID, 0, LocUnit )
					call TimerStart( LoadMUITimer( LocPID ), .01, true, function CheckForCC )
				endif
			endif
		endif
	endfunction	

