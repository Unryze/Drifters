	function SaberArtoriaSpellDFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A04R'
	endfunction	

	function SaberArtoriaSpellDFunction2 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaD1" ), 100, 0 )
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
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

	function SaberArtoriaSpellDFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellDFunction2 )
	endfunction

	function SaberArtoriaSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02D'
	endfunction	

	function SaberArtoriaSpellQFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			if MUIInteger( 110 ) > 0 then
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetFilterUnit( ), "chest" ) )
			endif

			call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl", GetFilterUnit( ), "chest" ) )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 125 + MUILevel( ) * 25 + MUIPower( ) * 0.5 + 2 * LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) )
		endif

		return true
	endfunction	

	function SaberArtoriaSpellQFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ1" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 300, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw Two" )
			endif

			if LocTime == 15 then
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 102 ), 400, Filter( function SaberArtoriaSpellQFunction2 ) )
			endif
			
			if LocTime == 35 then
				call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) + 1 )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 200, Filter( function SaberArtoriaSpellQFunction2 ) )
			endif

			if LocTime == 40 then
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellQFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellQFunction3 )
	endfunction	

	function SaberArtoriaSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02E'
	endfunction	

	function SaberArtoriaSpellWFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
				call LinearDisplacement( GetFilterUnit( ), MUIAngle( 102, 103 ), -( MUIDistance( 102, 103 ) - 200 ), .25, .01, false, true, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 300 + MUILevel( ) * 50 + MUIPower( ) * 1 + 2 * LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) )
			else
				call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 150 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
			endif

			call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl", GetFilterUnit( ), "chest" ) )
		endif

		return true
	endfunction	

	function SaberArtoriaSpellWFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw One" )
			endif

			if LocTime == 15 then
				call SilenceUnit( MUIUnit( 100 ) )
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW2" ), 100, 0 )

				if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
					call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 300, Filter( function SaberArtoriaSpellWFunction2 ) )
				else
					call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), -( MUIDistance( 102, 103 ) - 200 ), .25, .01, false, true, "origin", DashEff( ) )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 150 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
					call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 300, Filter( function SaberArtoriaSpellWFunction2 ) )
				endif
			endif

			if LocTime == 25 then
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellWFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellWFunction3 )
	endfunction	

	function SaberArtoriaSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02G'
	endfunction

	function SaberArtoriaSpellEFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) and IsUnitInGroup( GetFilterUnit( ), LoadGroupHandle( HashTable, MUIHandle( ), 111 ) ) == false then
			if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
				call StunUnit( GetFilterUnit( ), 1 )
			endif
			call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "AoE", "Physical", MUILevel( ) * 50 + MUIPower( ) + LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) )
			call DisplaceUnitWithArgs( GetFilterUnit( ), 0, 0, 1, .01, 400 )
			call GroupAddUnit( LoadGroupHandle( HashTable, MUIHandle( ), 111 ), GetFilterUnit( ) )
		endif

		return true
	endfunction

	function SaberArtoriaSpellEFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
		else
			call RemoveUnit( MUIUnit( 101 ) )
		endif

		if LocTime == 1 then
			call PlaySoundWithVolume( LoadSound( "SaberArtoriaE1" ), 100, 0 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call PauseUnit( MUIUnit( 100 ), true )
			call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
			call SetUnitAnimation( MUIUnit( 100 ), "Spell Seven" )
			call SaveUnitHandle( HashTable, HandleID, 101, CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u001', MUILocation( 102 ), MUIAngle( 102, 103 ) ) )
			call ScaleUnit( MUIUnit( 104 ), 2 )
		endif
		
		if LocTime == 10 then
			call PlaySoundWithVolume( LoadSound( "SaberArtoriaE2" ), 100, 0 )
		endif

		if LocTime == 25 then
			call PauseUnit( MUIUnit( 100 ), false )
			call SetUnitTimeScale( MUIUnit( 100 ), 1 )
			call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			call MUISaveEffect( 104, "Effects\\SaberArtoria\\Whirlwind.mdl", 101 )
		endif

		if LocTime > 25 then
			call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 15 )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), LoadReal( HashTable, HandleID, 110 ), MUIAngle( 102, 103 ) ) )
			call SetUnitPositionLoc( MUIUnit( 101 ), MUILocation( 107 ) )
			call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 300, Filter( function SaberArtoriaSpellEFunction2 ) )
			call RemoveLocation( MUILocation( 107 ) )

			if LoadReal( HashTable, HandleID, 110 ) >= 1250. or UnitLife( MUIUnit( 100 ) ) <= 0 then
				call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				call RemoveLocation( MUILocation( 102 ) )
				call DestroyEffect( MUIEffect( 104 ) )
				call RemoveUnit( MUIUnit( 101 ) )
				call PauseTimer( GetExpiredTimer( ) )
				call FlushChildHashtable( HashTable, HandleID )
				call DestroyTimer( GetExpiredTimer( ) )
			endif
		endif
	endfunction

	function SaberArtoriaSpellEFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
		call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellEFunction3 )
	endfunction	

	function SaberArtoriaSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02K'
	endfunction

	function SaberArtoriaSpellRFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) )
		endif

		return true
	endfunction

	function SaberArtoriaSpellRFunction3 takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberArtoria\\HolyEnergy.mdl", MUIUnit( 100 ), "chest" ) )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Walk Stand Spin" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2.5 )
			endif

			if LocTime == 50 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), ( MUIDistance( 102, 103 ) - 150 ), .2, .01, false, true, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 60 or LocTime == 90 or LocTime == 120 or LocTime == 150 or LocTime == 180 or LocTime == 210 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ2" ), 100, 0 )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR2" ), 100, 0 )
			endif

			if LocTime == 250 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 150 + MUIPower( ) )
				call AddEffect( "Effects\\SaberArtoria\\HolyExplosion.mdl", 1, MUILocation( 103 ), MUIAngle( 102, 103 ), 0 )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A04R' )

				if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
					call StunUnit( MUIUnit( 101 ), 1 )
					call AddEffect( "Effects\\SaberArtoria\\ExcaliburLinear.mdl", 1, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
					call ScaleUnit( LoadUnit( "DummyUnit" ), .5 )
					call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 400, Filter( function SaberArtoriaSpellRFunction2 ) )
					call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				endif

				loop
					exitwhen i > 4
					call AddEffect( "GeneralEffects\\ValkDust.mdl", GetRandomReal( 2, 3 ), MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberArtoriaSpellRFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellRFunction3 )
	endfunction	

	function SaberArtoriaSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02L'
	endfunction

	function SaberArtoriaSpellTFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) and IsUnitInGroup( GetFilterUnit( ), LoadGroupHandle( HashTable, MUIHandle( ), 111 ) ) == false then
			if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
				call SlowUnit( GetFilterUnit( ) )
			endif
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 300 + MUIPower( ) + LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) )
			call GroupAddUnit( LoadGroupHandle( HashTable, MUIHandle( ), 111 ), GetFilterUnit( ) )
		endif

		return true
	endfunction

	function SaberArtoriaSpellTFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Slam One" )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberArtoria\\GoldGlow.mdl", MUIUnit( 100 ), "weapon" ) )
				call MUIDummy( 125, 'u001', 102, 0 )
				call ScaleUnit( MUIUnit( 125 ), .25 )
				call MUISaveEffect( 104, "Effects\\SaberArtoria\\ExcaliburBeam.mdl", 125 )
				call MUIDummy( 126, 'u001', 102, 0 )
				call MUISaveEffect( 105, "Effects\\SaberArtoria\\GoldChanting.mdl", 126 )
			endif

			if LocTime == 1 or LocTime == 10 then
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 102 ), 0, 0 )
			endif
			
			if LocTime == 50 then
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Slam Two" )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaT2" ), 100, 0 )
				call DestroyEffect( MUIEffect( 104 ) )
				call DestroyEffect( MUIEffect( 105 ) )
				call AddEffect( "Effects\\SaberArtoria\\ExcaliburLinear.mdl", 1, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
			endif

			if LocTime >= 100 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 100 )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), LoadReal( HashTable, HandleID, 110 ), MUIAngle( 102, 103 ) ) )
				call SaveReal( HashTable, HandleID, 112, ( LoadReal( HashTable, HandleID, 112 ) + 1 ) )

				if LoadReal( HashTable, HandleID, 112 ) >= 4 then
					call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 2, MUILocation( 107 ), 0, 0 )
					call SaveReal( HashTable, HandleID, 112, 0 )
				endif

				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 107 ) ) )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 500, Filter( function SaberArtoriaSpellTFunction2 ) )
				call RemoveLocation( MUILocation( 107 ) )

				if LoadReal( HashTable, HandleID, 110 ) >= 3000 then
					call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction	

	function SaberArtoriaSpellTFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
		call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellTFunction3 )
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

		call SaveTrig( "SaberArtoriaTrigD" )
		call GetUnitEvent( LoadTrig( "SaberArtoriaTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberArtoriaTrigD" ), Condition( function SaberArtoriaSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberArtoriaTrigD" ), function SaberArtoriaSpellDFunction3 )

		call SaveTrig( "SaberArtoriaTrigQ" )
		call GetUnitEvent( LoadTrig( "SaberArtoriaTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberArtoriaTrigQ" ), Condition( function SaberArtoriaSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberArtoriaTrigQ" ), function SaberArtoriaSpellQFunction4 )

		call SaveTrig( "SaberArtoriaTrigW" )
		call GetUnitEvent( LoadTrig( "SaberArtoriaTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberArtoriaTrigW" ), Condition( function SaberArtoriaSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberArtoriaTrigW" ), function SaberArtoriaSpellWFunction4 )

		call SaveTrig( "SaberArtoriaTrigE" )
		call GetUnitEvent( LoadTrig( "SaberArtoriaTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberArtoriaTrigE" ), Condition( function SaberArtoriaSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberArtoriaTrigE" ), function SaberArtoriaSpellEFunction4 )

		call SaveTrig( "SaberArtoriaTrigR" )
		call GetUnitEvent( LoadTrig( "SaberArtoriaTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberArtoriaTrigR" ), Condition( function SaberArtoriaSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberArtoriaTrigR" ), function SaberArtoriaSpellRFunction4 )

		call SaveTrig( "SaberArtoriaTrigT" )
		call GetUnitEvent( LoadTrig( "SaberArtoriaTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberArtoriaTrigT" ), Condition( function SaberArtoriaSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberArtoriaTrigT" ), function SaberArtoriaSpellTFunction4 )
	endfunction	

