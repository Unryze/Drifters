	function KuchikiByakuyaSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell" )
				call CCUnit( GetUnit( "Source" ), .35, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ1" ), 90, 0 )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( GetUnit( "Source" ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( GetUnit( "Source" ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
			endif

			if LocTime == 15 then
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), 50, GetReal( "Angle" ), "Source" )
				call SaveLightningHandle( HashTable, HandleID, StringHash( "Lightning" ), AddLightningEx( "BLUB", true, GetReal( "CasterX" ), GetReal( "CasterY" ), 100, GetReal( "EffectX" ), GetReal( "EffectY" ), 100 ) )
			endif

			if LocTime >= 15 then
				call SaveReal( HashTable, HandleID, StringHash( "Distance" ), GetReal( "Distance" ) + 50 )
				if GetReal( "Distance" ) <= 1250 then
					call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Distance" ), GetReal( "Angle" ), "Effect" )
					call AddEffectXY( "Effects\\Byakuya\\Lightning.mdl", 1., GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 90 )
					call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 100, 0 )
					call AddEffectXY( "Effects\\Byakuya\\LightningWind.mdl", 1., GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 90 )
					call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 100, 0 )
					call MoveLightningEx( LoadLightningHandle( HashTable, HandleID, StringHash( "Lightning" ) ), true, GetReal( "CasterX" ), GetReal( "CasterY" ), 100, GetReal( "EffectX" ), GetReal( "EffectY" ), 100 )
					call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 250, "AoE", "Physical", 250 + GetPower( 1. ), false, "", 0 )
				endif
			endif

			if GetReal( "Distance" ) >= 2500 then
				call DestroyLightning( LoadLightningHandle( HashTable, HandleID, StringHash( "Lightning" ) ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call GetDummyXY( "Dummy1", 'u001', GetReal( "SpellX" ), GetReal( "SpellY" ), 0 )
				call SaveEffect( "Effect1" , "GeneralEffects\\Plasma.mdl", "Dummy1" )
				call ScaleUnit( GetUnit( "Dummy1" ), 1.5 )
				call SetUnitVertexColor( GetUnit( "Dummy1" ), 225, 39, 95, 255 )
				call PlaySoundWithVolume( LoadSound( "ByakuyaW1" ), 90, 0 )
				call CCUnit( GetUnit( "Source" ), .3, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell Slam" )
				call IssueImmediateOrder( GetUnit( "Source" ), "stop" )
			endif

			if GetIteration( LocTime, 10 ) then
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 450, "AoE", "Physical", GetPower( .05 ), true, "Slow", .05 )
			endif

			if LocTime == 100 then
				call DestroyEffect( GetEffect( "Effect1" ) )
				call KillUnit( GetUnit( "Dummy1" ) )
				call PlaySoundWithVolume( LoadSound( "ByakuyaQ2" ), 90, 0 )
				call AddEffectXY( "Effects\\Byakuya\\SakuraExplosion.mdl", 1.5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Spark_Pink.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, .5, .01, 0, DashEff( ) )
				call SaveBoolean( HashTable, HandleID, StringHash( "IsUpdated" ), false )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 450, "AoE", "Physical", GetPower( .5 ), true, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )
		local real	  LocCount  = LoadReal( HashTable, HandleID, 1 )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), .85, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ByakuyaE1" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "morph" )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
			endif

			if LocTime == 50 then
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ) ) )
				call GetDummyXY( "Dummy1", 'u001', GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "Angle" ) )
				call ScaleUnit( GetUnit( "Dummy1" ), 2 )
				call SaveEffect( "Effect1", "Effects\\Byakuya\\Bankai.mdl", "Dummy1" )
			endif	

			if LocTime == 100 then
				call DestroyEffect( GetEffect( "Effect1" ) )
				call PlaySoundWithVolume( LoadSound( "ByakuyaE2" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell two" )
				call GetDummyXY( "Dummy2", 'u001', GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "Angle" ) )
				call ScaleUnit( GetUnit( "Dummy2" ), 1.5 )
				call SaveEffect( "Effect2", "Effects\\Byakuya\\Senkei.mdl", "Dummy2" )
			endif

			if LocTime == 150 then
				call SetUnitAnimation( GetUnit( "Source" ), "spell channel one" )
			endif

			if LocTime >= 150 and LocTime <= 300 then
				call SaveReal( HashTable, HandleID, 1, LocCount + 1 )

				if LocCount == 2 then
					call SaveReal( HashTable, HandleID, 1, 0 )
					call SaveReal( HashTable, HandleID, StringHash( "TargetX" ), GetUnitX( GetUnit( "Target" ) ) )
					call SaveReal( HashTable, HandleID, StringHash( "TargetY" ), GetUnitY( GetUnit( "Target" ) ) )
					call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", GetPower( .02 ) )
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
				call DestroyEffect( GetEffect( "Effect2" ) )
				call PlaySoundWithVolume( LoadSound( "ByakuyaE3" ), 100, 0 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "chest" ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\Spark_Pink.mdl", GetUnit( "Target" ), "origin" ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\Deadspirit Asuna.mdl", GetUnit( "Target" ), "origin" ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellR takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 1 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaR1" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), 1.7, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell three" )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaR2" ), 100, 0 )
			endif

			if LocTime == 60 then
				call SetUnitAnimation( GetUnit( "Source" ), "spell four" )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) - 400, .5, .01, false, false, "origin", DashEff( ) )
			endif

			if LocTime == 110 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaR3" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell one" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
			endif

			if LocTime == 120 then
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddMultipleEffectsXY( 2, "Effects\\Byakuya\\PinkSlash.mdl", 4, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0, 255, 255, 255, 255 )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) + 400, .4, .01, false, false, "origin", DashEff( ) )
			endif

			if LocTime == 160 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call AddEffectXY( "Effects\\Byakuya\\SakuraExplosion.mdl", 1.5, GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 0, 0 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Spark_Pink.mdl", GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ) ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "chest" ) )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 0, 0 )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .5 )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 3000 + GetPower( 1. ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ByakuyaSpells takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A040' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A042' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellW )
		endif

		if GetSpellAbilityId( ) == 'A043' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellE )
		endif

		if GetSpellAbilityId( ) == 'A044' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellR )
		endif
	endfunction		

	function HeroInit6 takes nothing returns nothing
		call SaveSound( "ByakuyaQ1", "Byakuya\\SpellQ1.mp3" )
		call SaveSound( "ByakuyaQ2", "Byakuya\\SpellQ2.mp3" )
		call SaveSound( "ByakuyaW1", "Byakuya\\SpellW1.mp3" )
		call SaveSound( "ByakuyaE1", "Byakuya\\SpellE1.mp3" )
		call SaveSound( "ByakuyaE2", "Byakuya\\SpellE2.mp3" )
		call SaveSound( "ByakuyaE3", "Byakuya\\SpellE3.mp3" )
		call SaveSound( "ByakuyaR1", "Byakuya\\SpellR1.mp3" )
		call SaveSound( "ByakuyaR2", "Byakuya\\SpellR2.mp3" )
		call SaveSound( "ByakuyaR3", "Byakuya\\SpellR3.mp3" )
		call TriggerAddAction( LoadTrig( "AllHeroSpells" ), function ByakuyaSpells )
	endfunction	

