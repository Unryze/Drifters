	function ToonoShikiSpellQ takes nothing returns nothing
		local integer LocTime = MUIInteger( 0 )

		if StopSpell( MUIHandle( ), 0 ) == false then
			call SaveInteger( HashTable, MUIHandle( ), 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, MUIHandle( ), 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call PlaySoundWithVolume( LoadSound( "NanayaQ1" ), 100, 0 )
			endif

			if LocTime == 30 then
				call SaveLocationHandle( HashTable, MUIHandle( ), 107, CreateLocation( MUILocation( 102 ), MUIDistance( 102, 103 ) * .5, MUIAngle( 102, 103 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SaveStr( HashTable, MUIHandle( ), StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( MUIHandle( ), 103, -200, .5, .01, 0, DashEff( ) )
				call AoEDamage( MUIHandle( ), MUILocation( 107 ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell four" )
				call ClearAllData( MUIHandle( ) )
			endif
		endif
	endfunction

	function ToonoShikiSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )

		if StopSpell( HandleID, 0 ) == false then
			if LoadInteger( HashTable, HandleID, 110 ) < 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoW1" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) + 1 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 350, GetUnitFacing( MUIUnit( 100 ) ) ) )
			call AddEffect( "Effects\\Nanaya\\Sensa1.mdl", 2, MUILocation( 102 ), GetUnitFacing( MUIUnit( 100 ) ) + GetRandomReal( -45, 45 ), 0 )
			call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 200, 200, 255, 255 )
			call KillUnit( LoadUnit( "DummyUnit" ) )
			call AoEDamage( HandleID, MUILocation( 107 ), 350, "AoE", "Physical", MUILevel( ) * 5 + MUIPower( ) * 0.033, true, "", 0 )
			call RemoveLocation( MUILocation( 102 ) )
			call RemoveLocation( MUILocation( 107 ) )

			if LoadInteger( HashTable, HandleID, 110 ) >= 30 then
				call SetUnitAnimation( MUIUnit( 100 ), "stand" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoE2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call SetUnitTimeScale( MUIUnit( 100 ), 2.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.25, MUILocation( 102 ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) + 50, .2, .01, false, false, "origin", DashEff( ) )
				call DestroyEffect( AddSpecialEffectLoc( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", MUILocation( 102 ) ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "ToonoE1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell five" )
			endif

			if LocTime == 70 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 60, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ) - 180, 300, .25, .01, false, false, "origin", DashEff( ) )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 500 + MUILevel( ) * 75 + MUIPower( ) )
				call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) + 45, 0 )
				call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) - 45, 0 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 90 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

		if StopSpell( HandleID, 0 ) == false and LocTime < 160 then	

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoR1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 250, .1, .015, false, false, "origin", DashEff( ) )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel five" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call FaceLocation( MUIUnit( 100 ), MUILocation( 103 ), 0 )
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", 1.5, MUILocation( 102 ), 0, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.5, MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddMultipleEffects( 5, "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 103 ), 0, 0, 255, 255, 255, 255 )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 150, .2, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 325 + MUILevel( ) * 32.5 + MUIPower( ) * 0.20 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 40 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 250, .1, .01, false, false, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 60 then
				call PlaySoundWithVolume( LoadSound( "ToonoR2" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
			endif
			
			if LocTime == 110 then
				call SetUnitTimeScale( MUIUnit( 100 ), 3 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", 1.5, MUILocation( 102 ), 0, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.25, MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 750 + MUILevel( ) * 60 + MUIPower( ) * 0.25 )
				call MakeUnitAirborne( MUIUnit( 100 ), 800, 2000 )
				call MakeUnitAirborne( MUIUnit( 101 ), 800, 2000 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), 200, .4, .01, false, false, "origin", "" )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 200, .4, .01, false, false, "origin", "" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

		endif

		if LocTime == 160 then
			call PlaySoundWithVolume( LoadSound( "ToonoR3" ), 100, 0 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
			call AddEffect( "GeneralEffects\\ValkDust150.mdl", 1.5, MUILocation( 102 ), 0, 45 )
			call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 900, 99999 )
			call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.25, MUILocation( 103 ), MUIAngle( 102, 103 ) + 180, 45 )
			call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 900, 99999 )
			call SetUnitFlyHeight( MUIUnit( 100 ), 0, 3000 )
			call SetUnitFlyHeight( MUIUnit( 101 ), 0, 3000 )
			call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 103, 102 ), 200, .25, .01, false, false, "origin", "" )
			call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 200, .25, .01, false, false, "origin", "" )
			call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 750 + MUILevel( ) * 60 + MUIPower( ) * 0.25 )
			call SetUnitAnimation( MUIUnit( 100 ), "spell channel four" )
			call RemoveLocation( MUILocation( 102 ) )
			call RemoveLocation( MUILocation( 103 ) )
		endif
		
		if LocTime == 200 then
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
			call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 2, MUILocation( 103 ), 0, 0 )
			set i = 1
			
			loop
				exitwhen i > 8
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( .5, 2 ), MUILocation( 102 ), GetRandomReal( 0, 360 ), 0 )
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( .5, 2 ), MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
				set i = i + 1
			endloop

			call AoEDamage( HandleID, MUILocation( 103 ), 600, "AoE", "Physical", 500 + MUILevel( ) * 40 + MUIPower( ) * 0.50, false, "Stun", 1 )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ToonoShikiSpellT takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoE2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
			endif

			if LocTime == 90 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "ToonoT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 200, MUIAngle( 102, 103 ) ) )
				call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
				call SetUnitFacing( MUIUnit( 100 ), MUIAngle( 102, 103 ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), 250, .4, .01, false, false, "origin", DashEff( ) )
				call AddMultipleEffects( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, MUILocation( 103 ), 270, 0, 255, 255, 255, 255 )
				
				loop
					exitwhen i > 8
					call AddEffect( "GeneralEffects\\ValkDust.mdl", .8 + i * 2 / 10, MUILocation( 107 ), 0, 0 )
					set i = i + 1
				endloop

				set i = 1

				loop
					exitwhen i > 17
					call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
					call DisplaceUnitWithArgs( LoadUnit( "DummyUnit" ), GetUnitFacing( LoadUnit( "DummyUnit" ) ), GetRandomReal( 200, 800 ), .1, .01, 0 )
					set i = i + 1
				endloop

				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 3000 + MUILevel( ) * 300 + MUIPower( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
				call SaveReal( HashTable, HandleID, 110, 0 )
			endif
			
			if LocTime == 130 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A02X' then
			call PlaySoundWithVolume( LoadSound( "ToonoD1" ), 100, 0 )
		endif

		if GetSpellAbilityId( ) == 'A02U' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A02V' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call TimerStart( LoadMUITimer( LocPID ), .025, true, function ToonoShikiSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A02W' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellE )
		endif

		if GetSpellAbilityId( ) == 'A02Y' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellR )
		endif

		if GetSpellAbilityId( ) == 'A02Z' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellT )
		endif

		return false
	endfunction	

	function HeroInit2 takes nothing returns nothing
		call SaveSound( "ToonoD1", "Toono\\SpellD1.mp3" )
		call SaveSound( "ToonoW1", "Toono\\SpellW1.mp3" )
		call SaveSound( "ToonoE1", "Toono\\SpellE1.mp3" )
		call SaveSound( "ToonoE2", "Toono\\SpellE2.mp3" )
		call SaveSound( "ToonoR1", "Toono\\SpellR1.mp3" )
		call SaveSound( "ToonoR2", "Toono\\SpellR2.mp3" )
		call SaveSound( "ToonoR3", "Toono\\SpellR3.mp3" )
		call SaveSound( "ToonoT1", "Toono\\SpellT1.mp3" )
		call SaveSound( "ToonoT2", "Toono\\SpellT2.mp3" )
		
		call SaveTrig( "ToonoShikiSpells" )
		call GetUnitEvent( LoadTrig( "ToonoShikiSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ToonoShikiSpells" ), Condition( function ToonoShikiSpells ) )
	endfunction	

