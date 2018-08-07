	function NanayaShikiSpellDFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02P'
	endfunction

	function NanayaShikiSpellDFunction2 takes nothing returns nothing
		call PlaySoundWithVolume( LoadSound( "NanayaD1" ), 90, 0 )
	endfunction

	function NanayaShikiSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02M'
	endfunction

	function NanayaShikiSpellQFunction2 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
				call PlaySoundWithVolume( LoadSound( "NanayaQ1" ), 100, 0 )
			endif

			if LocTime == 30 then
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), MUIDistance( 102, 103 ) * .5, MUIAngle( 102, 103 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffect( "Effects\\Nanaya\\LinearSlash1.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 103, -200, .5, .01, 0, DashEff( ) )
				if GetUnitAbilityLevel( MUIUnit( 100 ), 'B001' ) > 0 then
					call AoEDamage( HandleID, MUILocation( 107 ), 400, "AoE", "Physical", ( 250 + MUILevel( ) * 50 + MUIPower( ) ) * 1.5, false, "Stun", 1 )
				else
					call AoEDamage( HandleID, MUILocation( 107 ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
				endif
				call UnitRemoveAbility( MUIUnit( 100 ), 'B001' )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function NanayaShikiSpellQFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaShikiSpellQFunction2 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction 

	function NanayaShikiSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02N'
	endfunction

	function NanayaShikiSpellWFunction2 takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if StopSpell( HandleID, 0 ) == false then
			if LoadInteger( HashTable, HandleID, 110 ) < 1 then
				call PlaySoundWithVolume( LoadSound( "NanayaW1" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) + 1 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 350, GetUnitFacing( MUIUnit( 100 ) ) ) )
			call AddEffect( "Effects\\Nanaya\\Sensa1.mdl", 2, MUILocation( 102 ), GetUnitFacing( MUIUnit( 100 ) ) + GetRandomReal( -45, 45 ), 0 )
			call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 255, 255 )
			call KillUnit( LoadUnit( "DummyUnit" ) )
			if GetUnitAbilityLevel( MUIUnit( 100 ), 'B001' ) > 0 then
				call AoEDamage( HandleID, MUILocation( 107 ), 350, "AoE", "Physical", ( MUILevel( ) * 5 + MUIPower( ) * 0.033 ) * 1.5, true, "", 0 )
			else
				call AoEDamage( HandleID, MUILocation( 107 ), 350, "AoE", "Physical", MUILevel( ) * 5 + MUIPower( ) * 0.033, true, "", 0 )
			endif
			call RemoveLocation( MUILocation( 102 ) )
			call RemoveLocation( MUILocation( 107 ) )

			if LoadInteger( HashTable, HandleID, 110 ) >= 30 then
				call UnitRemoveAbility( MUIUnit( 100 ), 'B001' )
				call SetUnitAnimation( MUIUnit( 100 ), "stand" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function NanayaShikiSpellWFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .025, true, function NanayaShikiSpellWFunction2 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			call DestroyTimer( LoadMUITimer( LocPID ) )
		endif
	endfunction

	function NanayaShikiSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02O'
	endfunction

	function NanayaShikiSpellEFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
		
		if LocTime == 1 then
			call PauseUnit( MUIUnit( 100 ), true )
			call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
			call PlaySoundWithVolume( LoadSound( "NanayaR2" ), 90, 0 )
		endif

		if GetUnitAbilityLevel( MUIUnit( 100 ), 'B001' ) > 0 then
			if StopSpell( HandleID, 0 ) == false and LocTime < 125 then
				if LocTime == 25 then
					call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 150, MUIAngle( 102, 103 ) ) )
					call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
					call SetUnitFacing( MUIUnit( 100 ), MUIAngle( 103, 102 ) )
					call SetUnitAnimation( MUIUnit( 100 ), "spell two alternate" )
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 102 ) ) )
					call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
					call RemoveLocation( MUILocation( 102 ) )
					call RemoveLocation( MUILocation( 103 ) )
					call RemoveLocation( MUILocation( 107 ) )
				endif

				if LocTime == 50 then
					call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
					call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call PauseUnit( MUIUnit( 100 ), true )
					call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
					call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
					call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.5, MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
					call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
					call MakeUnitAirborne( MUIUnit( 101 ), 800, 4000 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1000 + MUILevel( ) * 100 + MUIPower( ) )
					call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 300, .4, .01, false, false, "origin", "" )
					call RemoveLocation( MUILocation( 102 ) )
					call RemoveLocation( MUILocation( 103 ) )
				endif

				if LocTime == 75 then
					call PlaySoundWithVolume( LoadSound( "NanayaE1" ), 100, 0 )
					call MakeUnitAirborne( MUIUnit( 100 ), 600, 4000 )
					call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 200, MUIAngle( 103, 102 ) ) )
					call PauseUnit( MUIUnit( 100 ), true )
					call SetUnitAnimation( MUIUnit( 100 ), "spell throw three" )
					call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
					call SetUnitFacing( MUIUnit( 100 ), MUIAngle( 102, 103 ) )
					call RemoveLocation( MUILocation( 102 ) )
					call RemoveLocation( MUILocation( 103 ) )
					call RemoveLocation( MUILocation( 107 ) )
				endif
			endif

			if LocTime == 125 then
				call PlaySoundWithVolume( LoadSound( "NanayaE2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.25, MUILocation( 103 ), MUIAngle( 102, 103 ) + 180, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 800, 99999 )
				call SetUnitFlyHeight( MUIUnit( 101 ), 0, 2000 )
				call SetUnitFlyHeight( MUIUnit( 100 ), 0, 99999 )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 400, .4, .01, false, false, "origin", "" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 150 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 103 ), 0, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw two" )
				call AoEDamage( HandleID, MUILocation( 103 ), 500, "AoE", "Physical", 250 + MUILevel( ) * 25 + MUIPower( ) * 0.5, false, "Stun", 1 )
				call UnitRemoveAbility( MUIUnit( 100 ), 'B001' )
				call ClearAllData( HandleID )
			endif
		else
			if StopSpell( HandleID, 0 ) == false then
				if LocTime == 50 then
					call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
					call CCUnit( MUIUnit( 101 ), 1, "Stun" )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1000 + MUILevel( ) * 100 + MUIPower( ) )
					call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 300, MUIAngle( 102, 103 ) ) )
					call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
					call SetUnitFacing( MUIUnit( 100 ), MUIAngle( 102, 103 ) )
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 102 ) ) )
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
					call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
					call AddEffect( "Effects\\Nanaya\\LinearSlash1.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) + 45, 0 )
					call AddEffect( "Effects\\Nanaya\\LinearSlash1.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) - 45, 0 )
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction

	function NanayaShikiSpellEFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaShikiSpellEFunction2 )
	endfunction 

	function NanayaShikiSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02Q'
	endfunction

	function NanayaShikiSpellRFunction2 takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "NanayaT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A02P' )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 200, .25, .015, false, true, "origin", DashEff( ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call FaceLocation( MUIUnit( 100 ), MUILocation( 103 ), 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 25 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call FaceLocation( MUIUnit( 100 ), MUILocation( 103 ), 0 )
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", 1.5, MUILocation( 103 ), 0, 45 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.5, MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 103 ), 0, 45 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw four" )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 103, 102 ), 300, 1, .01, false, false, "origin", DashEff( ) )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 600, 1, .01, false, false, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 125 then
				call PlaySoundWithVolume( LoadSound( "NanayaT2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", 1.5, MUILocation( 102 ), 0, 45 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.25, MUILocation( 102 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw five" )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 200, 1, .01, 400 )

				set i = 1

				loop
					exitwhen i > 15
					call SaveUnit( "DummyUnit", CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u007', MUILocation( 102 ), MUIAngle( 102, 103 ) ) )
					call DisplaceUnitWithArgs( LoadUnit( "DummyUnit" ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 200, 1 + .1 * I2R( i ), .02, 400 )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitAnimation( LoadUnit( "DummyUnit" ), "spell throw five" )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 255, 255, ( 255-( 15 * i ) ) )
					set i = i + 1
				endloop

				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 225 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "NanayaR2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 150, MUIAngle( 102, 103 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
				call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
				call SetUnitFacing( MUIUnit( 100 ), MUIAngle( 102, 103 ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), 400, .35, .01, false, false, "origin", DashEff( ) )
				call AddMultipleEffects( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, MUILocation( 103 ), 270, 0, 255, 255, 255, 255 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.25, MUILocation( 107 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.25, MUILocation( 103 ), 0, 0 )

				set i = 1

				loop
					exitwhen i > 4
					call AddEffect( "Effects\\Nanaya\\LinearSlash2.mdl", 3, MUILocation( 103 ), MUIAngle( 102, 103 ) + Pow( -1, I2R( i ) ) * 30, 0 )
					set i = i + 1
				endloop

				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 4000 + MUILevel( ) * 300 + MUIPower( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif

			if LocTime == 260 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function NanayaShikiSpellRFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaShikiSpellRFunction2 )
	endfunction

	function NanayaShikiSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02R'
	endfunction

	function NanayaShikiSpellTFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )

		if StopSpell( HandleID, 0 ) == false then
			if IsCounted == true then
				call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			endif
			
			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A02P' )
				call SetUnitAnimation( MUIUnit( 100 ), "stand" )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "NanayaT3" ), 100, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), .25 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one alternate" )
			endif
			
			if LocTime == 90 then
				call SetUnitTimeScale( MUIUnit( 100 ), 0 )
				call MUIDummy( 106, 'u001', 102, MUIAngle( 102, 103 ) )
				call MUISaveEffect( 104, "Effects\\Nanaya\\Knife.mdl", 106 )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call SetUnitFlyHeight( MUIUnit( 106 ), 100, 99999 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call SaveBoolean( HashTable, HandleID, 10, false )
			endif

			if IsCounted == false then
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, GetUnitLoc( MUIUnit( 106 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 107 ), MUIDistance( 103, 107 ) * .1, MUIAngle( 107, 103 ) ) )
				call SetUnitPositionLoc( MUIUnit( 106 ), MUILocation( 109 ) )
				call FaceLocation( MUIUnit( 106 ), MUILocation( 103 ), 0 )
				
				if MUIDistance( 103, 109 ) <= 75 then
					call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 114, CreateLocation( MUILocation( 103 ), 150, MUIAngle( 103, 102 ) ) )
					call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.25, MUILocation( 102 ), 0, 0 )
					call DestroyEffect( MUIEffect( 104 ) )
					call RemoveUnit( MUIUnit( 106 ) )
					call MakeUnitAirborne( MUIUnit( 100 ), 200, 99999 )
					call SetUnitPathing( MUIUnit( 100 ), false )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
					call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 103 ) )
					call SaveUnitHandle( HashTable, HandleID, 20, CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u007', MUILocation( 114 ), MUIAngle( 102, 103 ) ) )
					call SetUnitAnimation( MUIUnit( 20 ), "spell slam three" )
					call SetUnitVertexColor( MUIUnit( 20 ), 255, 255, 255, 180 )
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 102 ) ) )
					call RemoveLocation( MUILocation( 102 ) )
					call RemoveLocation( MUILocation( 103 ) )
					call SaveBoolean( HashTable, HandleID, 10, true )
				endif

				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
				call RemoveLocation( MUILocation( 109 ) )
			endif
			
			if LocTime == 130 then
				call RemoveUnit( MUIUnit( 20 ) )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SetUnitFlyHeight( MUIUnit( 100 ), 0, 99999 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 114, 103 ), 300, .4, .01, false, false, "origin", DashEff( ) )
				call AddEffect( "GeneralEffects\\BloodEffect1.mdl", 1, MUILocation( 103 ), 0, 0 )
				call AddMultipleEffects( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, MUILocation( 103 ), 270, 0, 255, 255, 255, 255 )
				call AddEffect( "Effects\\Nanaya\\LinearSlash1.mdl", 3, MUILocation( 103 ), MUIAngle( 102, 103 ) + 45, 0 )
				call AddEffect( "Effects\\Nanaya\\LinearSlash1.mdl", 3, MUILocation( 103 ), MUIAngle( 102, 103 ), 0 )
				call AddEffect( "Effects\\Nanaya\\LinearSlash1.mdl", 3, MUILocation( 103 ), MUIAngle( 102, 103 ) - 45, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 114 ) )
			endif
			
			if LocTime == 160 then
				call CCUnit( MUIUnit( 101 ), 2, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 6000 + MUILevel( ) * 400 + MUIPower( ) )
			endif
			
			if LocTime == 180 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function NanayaShikiSpellTFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveBoolean( HashTable, HandleID, 10, true )
		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaShikiSpellTFunction2 )
	endfunction

	function HeroInit1 takes nothing returns nothing
		call SaveSound( "NanayaD1", "Nanaya\\SpellD1.mp3" )
		call SaveSound( "NanayaQ1", "Nanaya\\SpellQ1.mp3" )
		call SaveSound( "NanayaW1", "Nanaya\\SpellW1.mp3" )
		call SaveSound( "NanayaE1", "Nanaya\\SpellE1.mp3" )
		call SaveSound( "NanayaE2", "Nanaya\\SpellE2.mp3" )
		call SaveSound( "NanayaR1", "Nanaya\\SpellR1.mp3" )
		call SaveSound( "NanayaR2", "Nanaya\\SpellR2.mp3" )
		call SaveSound( "NanayaT1", "Nanaya\\SpellT1.mp3" )
		call SaveSound( "NanayaT2", "Nanaya\\SpellT2.mp3" )
		call SaveSound( "NanayaT3", "Nanaya\\SpellT3.mp3" )

		call SaveTrig( "NanayaTrigD" )
		call GetUnitEvent( LoadTrig( "NanayaTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "NanayaTrigD" ), Condition( function NanayaShikiSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "NanayaTrigD" ), function NanayaShikiSpellDFunction2 )		

		call SaveTrig( "NanayaTrigQ" )
		call GetUnitEvent( LoadTrig( "NanayaTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "NanayaTrigQ" ), Condition( function NanayaShikiSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "NanayaTrigQ" ), function NanayaShikiSpellQFunction3 )

		call SaveTrig( "NanayaTrigW" )
		call GetUnitEvent( LoadTrig( "NanayaTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "NanayaTrigW" ), Condition( function NanayaShikiSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "NanayaTrigW" ), function NanayaShikiSpellWFunction3 )

		call SaveTrig( "NanayaTrigE" )
		call GetUnitEvent( LoadTrig( "NanayaTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "NanayaTrigE" ), Condition( function NanayaShikiSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "NanayaTrigE" ), function NanayaShikiSpellEFunction3 )

		call SaveTrig( "NanayaTrigR" )
		call GetUnitEvent( LoadTrig( "NanayaTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "NanayaTrigR" ), Condition( function NanayaShikiSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "NanayaTrigR" ), function NanayaShikiSpellRFunction3 )

		call SaveTrig( "NanayaTrigT" )
		call GetUnitEvent( LoadTrig( "NanayaTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "NanayaTrigT" ), Condition( function NanayaShikiSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "NanayaTrigT" ), function NanayaShikiSpellTFunction3 )
	endfunction	

