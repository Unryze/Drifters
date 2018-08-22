	function SaberNeroSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroQ1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call AddEffect( "GeneralEffects\\Dash\\Effect1.mdl", 1, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .5, .01, false, true, "origin", DashEff( ) )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
			endif

			if LocTime == 50 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 200, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call AddMultipleEffects( 2, "Effects\\SaberNero\\FireCut.mdl", 2.5, MUILocation( 107 ), GetUnitFacing( MUIUnit( 100 ) ), 0, 255, 255, 255, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 102, 200, .3, .01, 0, DashEff( ) )
				call AoEDamage( HandleID, MUILocation( 107 ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
			endif

			if LocTime == 60 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberNeroSpellW takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroW1" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "attack slam" )
			endif

			if LocTime == 40 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\LightningStrike1.mdl", MUILocation( 102 ) ) )
				call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 2, MUILocation( 102 ), 0, 0 )

				loop
					exitwhen i > 4
					call AddEffect( "GeneralEffects\\ValkDust.mdl", GetRandomReal( 2, 3 ), MUILocation( 102 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call AoEDisplace( HandleID, 102, 200, .25, .01, 0, DashEff( ) )
				call AoEDamage( HandleID, MUILocation( 102 ), 450, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberNeroSpellE takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroE1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), ( MUIDistance( 102, 103 ) - 150 ), .1, .015, false, true, "origin", DashEff( ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Three" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 35 or LocTime == 70 or LocTime == 105 or LocTime == 140 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 10 )
				call FaceLocation( MUIUnit( 100 ), MUILocation( 103 ), 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\RedAftershock.mdl", MUILocation( 103 ) ) )
				call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl", MUIUnit( 101 ), "chest" ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 170 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 200, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call AddEffect( "GeneralEffects\\MoonWrath.mdl", 4, MUILocation( 103 ), 0, 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 0, 255, 255 )
				call AddEffect( "GeneralEffects\\ApocalypseCowStomp.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 0, 255, 255 )

				loop
					exitwhen i > 4
					call AddEffect( "GeneralEffects\\ValkDust.mdl", GetRandomReal( 2, 3 ), MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call AoEDamage( HandleID, MUILocation( 103 ), 400, "AoE", "Physical", MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberNeroSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroR1" ), 100, 0 )
				call SaveReal( HashTable, HandleID, 110, 800 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell One" )
				call InitSpiral( HandleID, 103, 300, 15, 800, "Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl" )
			endif

			if LocTime < 80 then
				call SpiralMovement( HandleID )
			endif
			
			if LocTime == 80 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) / 3, 1, .01, false, false, "origin", DashEff( ) )
			endif
			
			if LocTime == 130 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), ( MUIDistance( 102, 103 ) * .6 ), .6, .01, 600 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "attack slam" )
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", 2, MUILocation( 102 ), 0, 45 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1., MUILocation( 102 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call RemoveLocation( MUILocation( 102 ) )
			endif
			
			if LocTime == 185 then
				call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 6, MUILocation( 103 ), 0, 0 )

				loop
					exitwhen i > 4
					call AddEffect( "GeneralEffects\\ValkDust50.mdl", 6, MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				set i = 1

				loop
					exitwhen i > 12
					call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 200, 30 * I2R( i ) ) )
					call SaveUnit( "DummyUnit", CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u008', MUILocation( 107 ), 0 ) )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 0, 255 )
					call RemoveLocation( MUILocation( 107 ) )

					call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 400, 30 * I2R( i ) ) )
					call SaveUnit( "DummyUnit", CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u008', MUILocation( 107 ), 0 ) )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 0, 255 )
					call RemoveLocation( MUILocation( 107 ) )

					call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 600, 30 * I2R( i ) ) )
					call SaveUnit( "DummyUnit", CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u008', MUILocation( 107 ), 0 ) )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 0, 255 )
					call RemoveLocation( MUILocation( 107 ) )
					set i = i + 1
				endloop

				call AoEDisplace( HandleID, 103, 200, 1., .01, 1000, DashEff( ) )
				call AoEDamage( HandleID, MUILocation( 103 ), 800, "AoE", "Physical", 2000 + MUILevel( ) * 125 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberNeroSpellT takes nothing returns nothing
		local real 			i 	= 1.
		local integer HandleID  = MUIHandle( )
		local integer LocTime 	= MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw Two" )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .25, .01, false, false, "origin", "" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 50 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 60 )
				call PlaySoundWithVolume( LoadSound( "SaberNeroT1" ), 100, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw One" )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\LightningStrike1.mdl", MUILocation( 103 ) ) )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 103 ), 0, 0 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 100 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
				call AddMultipleEffects( 3, "Effects\\SaberNero\\FireCut.mdl", 2.5, MUILocation( 103 ), GetUnitFacing( MUIUnit( 100 ) ), 0, 255, 255, 255, 255 )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 500, 1, .01, false, false, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 120 then
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 60 )
			endif

			if LocTime == 140 then
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Four" )
			endif

			if LocTime == 180 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Channel Slam" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 102 ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), 800, .2, .01, false, true, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 220 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
				call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 4., MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				set i = 1

				loop
					exitwhen i > 10
					call AddEffect( "GeneralEffects\\BlinkNew.mdl", .25 * i, MUILocation( 103 ), 36 * i, 0 )
					call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 0, 255 )
					set i = i + 1.
				endloop

				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 180 + MUIPower( ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function SaberNeroSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A038' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A039' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellW )
		endif

		if GetSpellAbilityId( ) == 'A03A' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellE )
		endif

		if GetSpellAbilityId( ) == 'A03B' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellR )
		endif

		if GetSpellAbilityId( ) == 'A03C' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellT )
		endif
		
		return false
	endfunction	

	function HeroInit5 takes nothing returns nothing
		call SaveSound( "SaberNeroQ1", "SaberNero\\SpellQ1.mp3" )
		call SaveSound( "SaberNeroW1", "SaberNero\\SpellW1.mp3" )
		call SaveSound( "SaberNeroE1", "SaberNero\\SpellE1.mp3" )
		call SaveSound( "SaberNeroR1", "SaberNero\\SpellR1.mp3" )
		call SaveSound( "SaberNeroT1", "SaberNero\\SpellT1.mp3" )

		call SaveTrig( "SaberNeroSpells" )
		call GetUnitEvent( LoadTrig( "SaberNeroSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberNeroSpells" ), Condition( function SaberNeroSpells ) )
	endfunction	

