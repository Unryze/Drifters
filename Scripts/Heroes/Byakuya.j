	function KuchikiByakuyaSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ2" ), 90, 0 )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( MUIUnit( 100 ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( MUIUnit( 100 ) ) )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call CCUnit( MUIUnit( 100 ), .35, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell" )
			endif

			if LocTime == 15 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ1" ), 90, 0 )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), 150, GetReal( "Angle" ), "Effect" )
				call MUIDummyXY( 106, 'u001', GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ) )
				call MUISaveEffect( 104, "Effects\\Byakuya\\Senbonzakura.mdl", 106 )
				call SetUnitPathing( MUIUnit( 106 ), false )
			endif

			if LocTime >= 15 then
				call SaveReal( HashTable, HandleID, StringHash( "Distance" ), GetReal( "Distance" ) + 25 )
				call SetUnitXAndY( MUIUnit( 106 ), GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Distance" ), GetReal( "Angle" ) )
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 106 ) ), GetUnitY( MUIUnit( 106 ) ), 250, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )

				if GetReal( "Distance" ) >= 1250 then
					call KillUnit( MUIUnit( 106 ) )
					call DestroyEffect( MUIEffect( 104 ) )
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
				call CCUnit( MUIUnit( 100 ), .9, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
			endif

			if GetIteration( LocTime, 5 ) and LocTime <= 40 then
				call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 100, 45 * ( LocTime / 5 ), "Effect" )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call SetUnitPosition( MUIUnit( 101 ), GetReal( "TargetX" ), GetReal( "TargetY" ) )
				call SaveUnit( "DummyUnit", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u009', GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ) ) )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .9 - I2R( LocTime * 2 ) / 100 )
				call ScaleUnit( LoadUnit( "DummyUnit" ), 3 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 20000 )
			endif

			if LocTime == 50 then
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 245 + MUILevel( ) * 65 + MUIPower( ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Spark_Pink.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Deadspirit Asuna.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
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
				call MUIDummyXY( 101, 'u001', GetReal( "SpellX" ), GetReal( "SpellY" ), 0 )
				call MUISaveEffect( 104, "GeneralEffects\\Plasma.mdl", 101 )
				call ScaleUnit( MUIUnit( 101 ), 1.5 )
				call SetUnitVertexColor( MUIUnit( 101 ), 225, 39, 95, 255 )
				call PlaySoundWithVolume( LoadSound( "ByakuyaE1" ), 90, 0 )
				call CCUnit( MUIUnit( 100 ), .3, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			if GetIteration( LocTime, 10 ) then
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 450, "AoE", "Physical", MUILevel( ) * 3 + MUIPower( ) * 0.05, true, "Slow", .05 )
			endif

			if LocTime == 100 then
				call DestroyEffect( MUIEffect( 104 ) )
				call KillUnit( MUIUnit( 101 ) )
				call AddEffectXY( "Effects\\Byakuya\\SakuraExplosion.mdl", 1.5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Spark_Pink.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, .5, .01, 0, DashEff( ) )
				call SaveBoolean( HashTable, HandleID, StringHash( "IsUpdated" ), false )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 450, "AoE", "Physical", MUILevel( ) * 40 + MUIPower( ) * 0.50, true, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellR takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local real	  LocCount  = LoadReal( HashTable, HandleID, 1 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .85, "Stun" )
				call PlaySoundWithVolume( LoadSound( "ByakuyaR2" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "morph" )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
			endif

			if LocTime == 50 then
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call MUIDummyXY( 125, 'u001', GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ) )
				call ScaleUnit( MUIUnit( 125 ), 2 )
				call MUISaveEffect( 104, "Effects\\Byakuya\\Bankai.mdl", 125 )
			endif	

			if LocTime == 100 then
				call DestroyEffect( MUIEffect( 104 ) )
				call PlaySoundWithVolume( LoadSound( "ByakuyaR1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call MUIDummyXY( 106, 'u001', GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ) )
				call ScaleUnit( MUIUnit( 106 ), 1.5 )
				call MUISaveEffect( 104, "Effects\\Byakuya\\Senkei.mdl", 106 )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaE1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
			endif

			if LocTime >= 150 and LocTime <= 300 then
				call SaveReal( HashTable, HandleID, 1, LocCount + 1 )

				if LocCount == 2 then
					call SaveReal( HashTable, HandleID, 1, 0 )
					call SaveReal( HashTable, HandleID, StringHash( "TargetX" ), GetUnitX( MUIUnit( 101 ) ) )
					call SaveReal( HashTable, HandleID, StringHash( "TargetY" ), GetUnitY( MUIUnit( 101 ) ) )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 4 + MUIPower( ) * 0.02 )
					call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), 1200, GetRandomReal( 0, 360 ), "Effect" )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Distance" ), DistanceBetweenAxis( GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call AddEffectXY( "Effects\\Byakuya\\SenkeiSword.mdl", 2, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .25 )
					call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 100, 99999 )
					call LinearDisplacement( LoadUnit( "DummyUnit" ), GetReal( "Angle" ), GetReal( "Distance" ) - 50, .25, .01, false, true, "", "" )
				endif
			endif

			if LocTime == 300 then
				call DestroyEffect( MUIEffect( 104 ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ2" ), 100, 0 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\Spark_Pink.mdl", MUIUnit( 101 ), "origin" ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\Deadspirit Asuna.mdl", MUIUnit( 101 ), "origin" ) )
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
				call CCUnit( MUIUnit( 100 ), 1.7, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaT2" ), 100, 0 )
			endif

			if LocTime == 60 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell four" )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 400, .5, .01, false, false, "origin", DashEff( ) )
			endif
			
			if LocTime == 110 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaT1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
			endif
			
			if LocTime == 120 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddMultipleEffectsXY( 2, "Effects\\Byakuya\\PinkSlash.mdl", 4, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0, 255, 255, 255, 255 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) + 400, .4, .01, false, false, "origin", DashEff( ) )
			endif
			
			if LocTime == 160 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call AddEffectXY( "Effects\\Byakuya\\SakuraExplosion.mdl", 1.5, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 0, 0 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Spark_Pink.mdl", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 0, 0 )
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
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
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
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
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

