	function SaberArtoriaSpellD takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaD1" ), 100, 0 )
				call SaveReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ), 0 )
				call CCUnit( GetUnit( "Source" ), 2.1, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell One" )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaD2" ), 100, 0 )
				call SetUnitTimeScale( GetUnit( "Source" ), .5 )
			endif

			if LocTime == 100 then
				call SetUnitTimeScale( GetUnit( "Source" ), 1 )
			endif

			if LocTime == 200 then
				call UnitRemoveAbility( GetUnit( "Source" ), 'B008' )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ1" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ2" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), .5, "Stun", false )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Throw Two" )
			endif

			if LocTime == 15 then
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl" )
				call AoEDamageXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 400, "AoE", "Physical", 125 + GetPower( .5 ) + 2 * LoadReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ) ), true, "", 0 )
			endif

			if LocTime == 35 then
				call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 300, GetUnitFacing( GetUnit( "Source" ) ), "Spell" )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 200, "AoE", "Physical", 125 + GetPower( .5 ) + 2 * LoadReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ) ), true, "", 0 )
			endif

			if LocTime == 40 then
				call SaveReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ), 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW1" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), .35, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Throw One" )
			endif

			if LocTime == 15 then
				call CCUnit( GetUnit( "Target" ), 1, "Silence", true )
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW2" ), 100, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl" )

				if LoadReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ) ) > 0 then
					call AoEDisplaceXY( HandleID, GetReal( "CasterX" ), GetReal( "CasterY" ), -200, .25, .01, 0, DashEff( ) )
					call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 300, "AoE", "Physical", 300 + GetPower( 1. ) + 2 * LoadReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ) ), false, "", 0 )
				else
					call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), -( GetReal( "Distance" ) - 200 ), .25, .01, false, true, "origin", DashEff( ) )
					call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 150 + GetPower( .5 ) )
					call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 300, "AoE", "Physical", 150 + GetPower( .5 ), false, "Silence", 1 )
				endif
			endif

			if LocTime == 25 then
				call SaveReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ), 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellE takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )
		else
			call RemoveUnit( GetUnit( "Dummy1" ) )
		endif

		if LocTime == 1 then
			call PlaySoundWithVolume( LoadSound( "SaberArtoriaE1" ), 100, 0 )
			call CCUnit( GetUnit( "Source" ), .35, "Stun", false )
			call SetUnitTimeScale( GetUnit( "Source" ), 1.5 )
			call SetUnitAnimation( GetUnit( "Source" ), "Spell Seven" )
		endif
		
		if LocTime == 10 then
			call PlaySoundWithVolume( LoadSound( "SaberArtoriaE2" ), 100, 0 )
		endif

		if LocTime == 25 then
			call SetUnitTimeScale( GetUnit( "Source" ), 1 )
			call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Dummy1" ), CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u001', GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "Angle" ) ) )
			call SaveEffect( "Effect1", "Effects\\SaberArtoria\\Whirlwind.mdl", "Dummy1" )
			call AoEDisplaceXY( HandleID, GetUnitX( GetUnit( "Dummy1" ) ), GetUnitY( GetUnit( "Dummy1" ) ), .1, 1, .01, 400, "" )
		endif

		if LocTime > 25 then
			call SaveReal( HashTable, HandleID, StringHash( "Distance" ), GetReal( "Distance" ) + 15 )
			call CreateXY( GetUnitX( GetUnit( "Dummy1" ) ), GetUnitY( GetUnit( "Dummy1" ) ), 15, GetReal( "Angle" ), "Effect" )
			call SetUnitPosition( GetUnit( "Dummy1" ), GetReal( "EffectX" ), GetReal( "EffectY" ) )

			if LoadReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ) ) > 0 then
				call AoEDamageXY( HandleID, GetUnitX( GetUnit( "Dummy1" ) ), GetUnitY( GetUnit( "Dummy1" ) ), 300, "AoE", "Physical", GetPower( 1. ) + LoadReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ) ), false, "Stun", 1 )
			else
				call AoEDamageXY( HandleID, GetUnitX( GetUnit( "Dummy1" ) ), GetUnitY( GetUnit( "Dummy1" ) ), 300, "AoE", "Physical", GetPower( 1. ), false, "", 0 )
			endif

			if GetReal( "Distance" ) >= 1250. or UnitLife( GetUnit( "Source" ) ) <= 0 then
				call SaveReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ), 0 )
				call DestroyEffect( GetEffect( "Effect1" ) )
				call RemoveUnit( GetUnit( "Dummy1" ) )
				call TimerPause( GetExpiredTimer( ) )
				call FlushChildHashtable( HashTable, HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellR takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR1" ), 100, 0 )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( GetUnit( "Source" ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( GetUnit( "Source" ) ) )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call CCUnit( GetUnit( "Source" ), 1.1, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Slam One" )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberArtoria\\GoldGlow.mdl", GetUnit( "Source" ), "weapon" ) )
				call GetDummyXY( "Dummy1", 'u001', GetReal( "CasterX" ), GetReal( "CasterY" ), 0 )
				call ScaleUnit( GetUnit( "Dummy1" ), .25 )
				call SaveEffect( "Effect1", "Effects\\SaberArtoria\\ExcaliburBeam.mdl", "Dummy1" )
				call GetDummyXY( "Dummy2" , 'u001', GetReal( "CasterX" ), GetReal( "CasterY" ), 0 )
				call SaveEffect( "Effect2", "Effects\\SaberArtoria\\GoldChanting.mdl", "Dummy2" )
			endif

			if LocTime == 1 or LocTime == 10 then
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
			endif
			
			if LocTime == 50 then
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Slam Two" )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR2" ), 100, 0 )
				call DestroyEffect( GetEffect( "Effect1" ) )
				call DestroyEffect( GetEffect( "Effect2" ) )
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
				call AoEDamageXY( HandleID, GetReal( "MoveX" ), GetReal( "MoveY" ), StringHash( "Mitigated" ), "AoE", "Physical", GetPower( 1. ) + LoadReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ) ), false, "Slow", 1 )

				if GetReal( "Distance" ) >= 3000 then
					call SaveReal( HashTable, GetHandleId( GetUnit( "Source" ) ), StringHash( "Mitigated" ), 0 )
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction	

	function SaberArtoriaSpells takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A073' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellD )
		endif
		
		if GetSpellAbilityId( ) == 'A011' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A012' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellW )
		endif

		if GetSpellAbilityId( ) == 'A014' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellE )
		endif

		if GetSpellAbilityId( ) == 'A016' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellR )
		endif
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
		call TriggerAddAction( LoadTrig( "AllHeroSpells" ), function SaberArtoriaSpells )
	endfunction	

