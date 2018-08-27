	function SaberArtoriaSpellD takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaD1" ), 100, 0 )
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call CCUnit( MUIUnit( 100 ), 2.1, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell One" )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaD2" ), 100, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), .5 )
			endif

			if LocTime == 100 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
			endif

			if LocTime == 200 then
				call UnitRemoveAbility( MUIUnit( 100 ), 'B04J' )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ1" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ2" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .5, "Stun" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw Two" )
			endif

			if LocTime == 15 then
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl" )
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 400, "AoE", "Physical", 125 + MUILevel( ) * 25 + MUIPower( ) * 0.5 + 2 * LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ), true, "", 0 )
			endif

			if LocTime == 35 then
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, GetUnitFacing( MUIUnit( 100 ) ), "Spell" )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 200, "AoE", "Physical", 125 + MUILevel( ) * 25 + MUIPower( ) * 0.5 + 2 * LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ), true, "", 0 )
			endif

			if LocTime == 40 then
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .35, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw One" )
			endif

			if LocTime == 15 then
				call CCUnit( MUIUnit( 101 ), 1, "Silence" )
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW2" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl" )

				if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
					call AoEDisplaceXY( HandleID, GetReal( "CasterX" ), GetReal( "CasterY" ), -200, .25, .01, 0, DashEff( ) )
					call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 300, "AoE", "Physical", 300 + MUILevel( ) * 50 + MUIPower( ) * 1 + 2 * LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ), false, "", 0 )
				else
					call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), -( GetReal( "Distance" ) - 200 ), .25, .01, false, true, "origin", DashEff( ) )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 150 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
					call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 300, "AoE", "Physical", 150 + MUILevel( ) * 25 + MUIPower( ) * 0.5, false, "Silence", 1 )
				endif
			endif

			if LocTime == 25 then
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellE takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
		else
			call RemoveUnit( MUIUnit( 101 ) )
		endif

		if LocTime == 1 then
			call PlaySoundWithVolume( LoadSound( "SaberArtoriaE1" ), 100, 0 )
			call CCUnit( MUIUnit( 100 ), .35, "Stun" )
			call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
			call SetUnitAnimation( MUIUnit( 100 ), "Spell Seven" )
		endif
		
		if LocTime == 10 then
			call PlaySoundWithVolume( LoadSound( "SaberArtoriaE2" ), 100, 0 )
		endif

		if LocTime == 25 then
			call PauseUnit( MUIUnit( 100 ), false )
			call SetUnitTimeScale( MUIUnit( 100 ), 1 )
			call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
			call SaveUnitHandle( HashTable, HandleID, 101, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u001', GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ) ) )
			call MUISaveEffect( 104, "Effects\\SaberArtoria\\Whirlwind.mdl", 101 )
			call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), .1, 1, .01, 400, "" )
		endif

		if LocTime > 25 then
			call SaveReal( HashTable, HandleID, StringHash( "Distance" ), GetReal( "Distance" ) + 15 )
			call CreateXY( GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 15, GetReal( "Angle" ), "Effect" )
			call SetUnitPosition( MUIUnit( 101 ), GetReal( "EffectX" ), GetReal( "EffectY" ) )

			if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 300, "AoE", "Physical", MUILevel( ) * 50 + MUIPower( ) + LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ), false, "Stun", 1 )
			else
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 300, "AoE", "Physical", MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
			endif

			if GetReal( "Distance" ) >= 1250. or UnitLife( MUIUnit( 100 ) ) <= 0 then
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call DestroyEffect( MUIEffect( 104 ) )
				call RemoveUnit( MUIUnit( 101 ) )
				call PauseTimer( GetExpiredTimer( ) )
				call FlushChildHashtable( HashTable, HandleID )
				call DestroyTimer( GetExpiredTimer( ) )
			endif
		endif
	endfunction

	function SaberArtoriaSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), 2.6, "Stun" )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberArtoria\\HolyEnergy.mdl", MUIUnit( 100 ), "chest" ) )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Walk Stand Spin" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2.5 )
			endif

			if LocTime == 50 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, true, "origin", DashEff( ) )
			endif

			if LocTime == 60 or LocTime == 90 or LocTime == 120 or LocTime == 150 or LocTime == 180 or LocTime == 210 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ2" ), 100, 0 )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR2" ), 100, 0 )
			endif

			if LocTime == 250 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW2" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 150 + MUIPower( ) )
				call AddEffectXY( "Effects\\SaberArtoria\\HolyExplosion.mdl", 1, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0 )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A04R' )

				if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
					call CCUnit( MUIUnit( 101 ), 1, "Stun" )
					call AddEffectXY( "Effects\\SaberArtoria\\ExcaliburLinear.mdl", 1, GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Angle" ), 0 )
					call ScaleUnit( LoadUnit( "DummyUnit" ), .5 )
					call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 400, "AoE", "Physical", LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ), false, "Stun", 1 )
					call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				endif

				loop
					exitwhen i > 4
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( 2, 3 ), GetReal( "TargetX" ), GetReal( "TargetY" ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellT takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaT1" ), 100, 0 )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( MUIUnit( 100 ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( MUIUnit( 100 ) ) )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call CCUnit( MUIUnit( 100 ), 1.1, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Slam One" )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberArtoria\\GoldGlow.mdl", MUIUnit( 100 ), "weapon" ) )
				call MUIDummyXY( 125, 'u001', GetReal( "CasterX" ), GetReal( "CasterY" ), 0 )
				call ScaleUnit( MUIUnit( 125 ), .25 )
				call MUISaveEffect( 104, "Effects\\SaberArtoria\\ExcaliburBeam.mdl", 125 )
				call MUIDummyXY( 126, 'u001', GetReal( "CasterX" ), GetReal( "CasterY" ), 0 )
				call MUISaveEffect( 105, "Effects\\SaberArtoria\\GoldChanting.mdl", 126 )
			endif

			if LocTime == 1 or LocTime == 10 then
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
			endif
			
			if LocTime == 50 then
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Slam Two" )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaT2" ), 100, 0 )
				call DestroyEffect( MUIEffect( 104 ) )
				call DestroyEffect( MUIEffect( 105 ) )
				call AddEffectXY( "Effects\\SaberArtoria\\ExcaliburLinear.mdl", 1, GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Angle" ), 0 )
			endif

			if LocTime >= 100 then
				call SaveReal( HashTable, HandleID, StringHash( "Distance" ), GetReal( "Distance" ) + 100 )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Distance" ), GetReal( "Angle" ), "Move" )
				call SaveReal( HashTable, HandleID, 112, ( LoadReal( HashTable, HandleID, 112 ) + 1 ) )

				if LoadReal( HashTable, HandleID, 112 ) >= 4 then
					call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 2, GetReal( "MoveX" ), GetReal( "MoveY" ), 0, 0 )
					call SaveReal( HashTable, HandleID, 112, 0 )
				endif

				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "MoveX" ), GetReal( "MoveY" ) ) )
				call AoEDamageXY( HandleID, GetReal( "MoveX" ), GetReal( "MoveY" ), 500, "AoE", "Physical", MUILevel( ) * 300 + MUIPower( ) + LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ), false, "Slow", 1 )

				if GetReal( "Distance" ) >= 3000 then
					call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction	

	function SaberArtoriaSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A04R' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellD )
		endif
		
		if GetSpellAbilityId( ) == 'A02D' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A02E' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellW )
		endif

		if GetSpellAbilityId( ) == 'A02G' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellE )
		endif

		if GetSpellAbilityId( ) == 'A02K' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellR )
		endif

		if GetSpellAbilityId( ) == 'A02L' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellT )
		endif

		return false
	endfunction		

	function HeroInit12 takes nothing returns nothing
		call SaveSound( "SaberArtoriaD1", "SaberArtoria\\SpellD1.mp3" )
		call SaveSound( "SaberArtoriaD2", "SaberArtoria\\SpellD2.mp3" )
		call SaveSound( "SaberArtoriaQ1", "SaberArtoria\\SpellQ1.mp3" )
		call SaveSound( "SaberArtoriaQ2", "SaberArtoria\\SpellQ2.mp3" )
		call SaveSound( "SaberArtoriaW1", "SaberArtoria\\SpellW1.mp3" )
		call SaveSound( "SaberArtoriaW2", "SaberArtoria\\SpellW2.mp3" )
		call SaveSound( "SaberArtoriaE1", "SaberArtoria\\SpellE1.mp3" )
		call SaveSound( "SaberArtoriaE2", "SaberArtoria\\SpellE2.mp3" )
		call SaveSound( "SaberArtoriaR1", "SaberArtoria\\SpellR1.mp3" )
		call SaveSound( "SaberArtoriaR2", "SaberArtoria\\SpellR2.mp3" )
		call SaveSound( "SaberArtoriaT1", "SaberArtoria\\SpellT1.mp3" )
		call SaveSound( "SaberArtoriaT2", "SaberArtoria\\SpellT2.mp3" )

		call SaveTrig( "SaberArtoriaSpells" )
		call GetUnitEvent( LoadTrig( "SaberArtoriaSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberArtoriaSpells" ), Condition( function SaberArtoriaSpells ) )
	endfunction	

