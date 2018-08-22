	function KuchikiByakuyaSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local real LocDistance  = LoadReal( HashTable, HandleID, 30 )
		local real LocFacing	= LoadReal( HashTable, HandleID, 31 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ2" ), 90, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )			
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 150, MUIAngle( 102, 103 ) ) )
				call SaveReal( HashTable, HandleID, 30, 1250 )
				call SaveReal( HashTable, HandleID, 31, MUIAngle( 102, 103 ) )
				call MUIDummy( 106, 'u001', 107, MUIAngle( 107, 103 ) )
				call MUISaveEffect( 104, "Effects\\Byakuya\\Senbonzakura.mdl", 106 )
				call ScaleUnit( MUIUnit( 106 ), 1.5 )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ1" ), 90, 0 )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			if LocTime > 25 then
				if IsUnitType( MUIUnit( 106 ), UNIT_TYPE_DEAD ) != true then
					call SaveLocationHandle( HashTable, HandleID, 115, GetUnitLoc( MUIUnit( 106 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 116, CreateLocation( MUILocation( 115 ), 20, LocFacing ) )
					call SaveReal( HashTable, HandleID, 30, LocDistance - 25 )
					call SetUnitPositionLoc( MUIUnit( 106 ), MUILocation( 116 ) )
					call AoEDamage( HandleID, MUILocation( 115 ), 250, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )

					if LocDistance <= 25 then
						call KillUnit( MUIUnit( 106 ) )
						call DestroyEffect( MUIEffect( 104 ) )
					endif

					call RemoveLocation( MUILocation( 115 ) )
					call RemoveLocation( MUILocation( 116 ) )
				else
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaW1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			if LocTime == 5 or LocTime == 10 or LocTime == 15 or LocTime == 20 or LocTime == 25 or LocTime == 30 or LocTime == 35 or LocTime == 40 then
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 100, 45 * ( LocTime / 5 ) ) )
				call SetUnitPositionLoc( MUIUnit( 101 ), MUILocation( 102 ) )
				call SaveUnit( "DummyUnit", CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u009', MUILocation( 103 ), MUIAngle( 103, 102 ) ) )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .9 - I2R( LocTime * 2 ) / 100 )
				call ScaleUnit( LoadUnit( "DummyUnit" ), 3 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 20000 )
			endif

			if LocTime == 50 then
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 245 + MUILevel( ) * 65 + MUIPower( ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\Spark_Pink.mdl", MUILocation( 102 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\Deadspirit Asuna.mdl", MUILocation( 102 ) ) )
			endif

			if LocTime == 80 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call MUIDummy( 101, 'u001', 103, 0 )
				call MUISaveEffect( 104, "GeneralEffects\\Plasma.mdl", 101 )
				call ScaleUnit( MUIUnit( 101 ), 1.5 )
				call SetUnitVertexColor( MUIUnit( 101 ), 225, 39, 95, 255 )
				call PlaySoundWithVolume( LoadSound( "ByakuyaE1" ), 90, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			if LocTime == 5 or LocTime == 10 or LocTime == 15 or LocTime == 20 or LocTime == 25 or LocTime == 30 or LocTime == 35 or LocTime == 40 or LocTime == 45 or LocTime == 50 then
				call AoEDamage( HandleID, MUILocation( 103 ), 450, "AoE", "Physical", MUILevel( ) * 3 + MUIPower( ) * 0.05, true, "Slow", .25 )
			endif

			if LocTime == 100 then
				call DestroyEffect( MUIEffect( 104 ) )
				call KillUnit( MUIUnit( 101 ) )
				call AddEffect( "Effects\\Byakuya\\SakuraExplosion.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\Spark_Pink.mdl", MUILocation( 103 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 103 ) ) )
				call AoEDisplace( HandleID, 103, 300, .5, .01, 0, DashEff( ) )
				call SaveBoolean( HashTable, HandleID, StringHash( "IsUpdated" ), false )
				call AoEDamage( HandleID, MUILocation( 103 ), 450, "AoE", "Physical", MUILevel( ) * 40 + MUIPower( ) * 0.50, true, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local real	  LocCount  = LoadReal( HashTable, HandleID, 1 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PauseUnit( MUIUnit( 100 ), true )
				call PlaySoundWithVolume( LoadSound( "ByakuyaR2" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "morph" )
			endif
			
			if LocTime == 50 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 120, CreateLocation( MUILocation( 102 ), 200, MUIAngle( 103, 102 ) ) )
				call MUIDummy( 125, 'u001', 120, MUIAngle( 103, 102 ) )
				call ScaleUnit( MUIUnit( 125 ), 2 )
				call MUISaveEffect( 104, "Effects\\Byakuya\\Bankai.mdl", 125 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 120 ) )
			endif			

			if LocTime == 75 then
				call PauseUnit( MUIUnit( 100 ), false )
			endif

			if LocTime == 100 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call DestroyEffect( MUIEffect( 104 ) )
				call PlaySoundWithVolume( LoadSound( "ByakuyaR1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call SaveUnitHandle( HashTable, HandleID, 106, CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u00A', MUILocation( 102 ), 0 ) )
				call SetUnitTimeScale( MUIUnit( 106 ), 3 )
				call RemoveLocation( MUILocation( 102 ) )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaE1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
			endif

			if LocTime >= 150 and LocTime <= 300 then
				call SaveReal( HashTable, HandleID, 1, LocCount + 1 )

				if LocCount == 2 then
					call SaveReal( HashTable, HandleID, 1, 0 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 4 + MUIPower( ) * 0.02 )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )

					loop
						exitwhen i > 3
						call SaveLocationHandle( HashTable, HandleID, 122, CreateLocation( MUILocation( 102 ), 1200, GetRandomReal( 0, 360 ) ) )
						call AddEffect( "Effects\\Byakuya\\SenkeiSword.mdl", 2, MUILocation( 122 ), MUIAngle( 122, 103 ), 0 )
						call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .25 )
						call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 100, 99999 )
						call LinearDisplacement( LoadUnit( "DummyUnit" ), MUIAngle( 122, 103 ), MUIDistance( 122, 103 ) - 50, .25, .01, false, true, "", "" )
						call RemoveLocation( MUILocation( 122 ) )
						set i = i + 1
					endloop
				endif
			endif

			if LocTime == 300 then
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ2" ), 100, 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\Spark_Pink.mdl", MUILocation( 103 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\Deadspirit Asuna.mdl", MUILocation( 103 ) ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellT takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaT3" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Alternate One" )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 2., MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 400, .4, .01, false, false, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 80 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaT2" ), 100, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
			endif

			if LocTime == 120 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SetUnitAnimation( MUIUnit( 100 ), "spell four" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 400, .5, .01, false, false, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 170 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 102 ), 0, 0 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 180 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddMultipleEffects( 2, "Effects\\Byakuya\\PinkSlash.mdl", 4, MUILocation( 103 ), MUIAngle( 102, 103 ), 0, 255, 255, 255, 255 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) + 400, .6, .01, false, false, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 250 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddEffect( "Effects\\Byakuya\\SakuraExplosion.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\Spark_Pink.mdl", MUILocation( 103 ) ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 103 ), 0, 0 )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .5 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 3000 + MUILevel( ) * 300 + MUIPower( ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ByakuyaSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A03E' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A03D' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellW )
		endif

		if GetSpellAbilityId( ) == 'A03G' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellE )
		endif	
	
		if GetSpellAbilityId( ) == 'A03H' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellR )
		endif
		
		if GetSpellAbilityId( ) == 'A03I' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellT )
		endif

		return false
	endfunction		

	function HeroInit6 takes nothing returns nothing
		call SaveSound( "ByakuyaQ1", "Byakuya\\SpellQ1.mp3" )
		call SaveSound( "ByakuyaQ2", "Byakuya\\SpellQ2.mp3" )
		call SaveSound( "ByakuyaW1", "Byakuya\\SpellW1.mp3" )
		call SaveSound( "ByakuyaE1", "Byakuya\\SpellE1.mp3" )
		call SaveSound( "ByakuyaR1", "Byakuya\\SpellR1.mp3" )
		call SaveSound( "ByakuyaR2", "Byakuya\\SpellR2.mp3" )
		call SaveSound( "ByakuyaT1", "Byakuya\\SpellT1.mp3" )
		call SaveSound( "ByakuyaT2", "Byakuya\\SpellT2.mp3" )
		call SaveSound( "ByakuyaT3", "Byakuya\\SpellT3.mp3" )

		call SaveTrig( "ByakuyaSpells" )
		call GetUnitEvent( LoadTrig( "ByakuyaSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ByakuyaSpells" ), Condition( function ByakuyaSpells ) )
	endfunction	

