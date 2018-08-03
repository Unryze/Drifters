	function SaberAlterSpellDFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03S'
	endfunction

	function SaberAlterSpellDFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
			call DisplaceUnitWithArgs( GetFilterUnit( ), AngleBetweenUnits( MUIUnit( 100 ), GetFilterUnit( ) ), 200, .5, .01, 400 )
		endif

		return true
	endfunction

	function SaberAlterSpellDFunction3 takes nothing returns nothing
		local real i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterD1" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Morph" )
			endif

			if LocTime == 20 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )

				loop
					exitwhen i > 5
					call AddEffect( "Effects\\SaberAlter\\DarkNova.mdl", .2 * i, MUILocation( 102 ), 0, 0 )
					set i = i + 1
				endloop

				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 102 ), 400, Filter( function SaberAlterSpellDFunction2 ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAlterSpellDFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellDFunction3 )
	endfunction

	function SaberAlterSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03T'
	endfunction

	function SaberAlterSpellQFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call SaveLocationHandle( HashTable, MUIHandle( ), 109, GetUnitLoc( GetFilterUnit( ) ) )
			call LinearDisplacement( GetFilterUnit( ), MUIAngle( 107, 109 ), 200, .5, .01, false, false, "origin", DashEff( ) )
			call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 109 ) ) )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
			call StunUnit( GetFilterUnit( ), 1 )
			call RemoveLocation( MUILocation( 109 ) )
		endif

		return true
	endfunction

	function SaberAlterSpellQFunction3 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
				call PlaySoundWithVolume( LoadSound( "SaberAlterQ1" ), 100, 0 )
			endif

			if LocTime == 10 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterQ2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), MUIDistance( 102, 103 ) * .5, MUIAngle( 102, 103 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffect( "Effects\\SaberAlter\\LinearSlashBlack1.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 75, 0, 130, 255 )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 400, Filter( function SaberAlterSpellQFunction2 ) )
			endif

			if LocTime == 30 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAlterSpellQFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellQFunction3 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction

	function SaberAlterSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03U'
	endfunction

	function SaberAlterSpellWFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 150 + MUILevel( ) * 50 + MUIPower( ) )
		endif

		return true
	endfunction

	function SaberAlterSpellWFunction3 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterW1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Two" )
				call AddEffect( "Effects\\SaberAlter\\DarkExplosion.mdl", .4, MUILocation( 102 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .4, .01, 600 )
			endif
			
			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterW2" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterW3" ), 100, 0 )
				call AddEffect( "Effects\\SaberAlter\\DarkExplosion.mdl", .75, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\LightningStrike1.mdl", .75, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2.5, MUILocation( 103 ), 0, 0 )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 300, Filter( function SaberAlterSpellWFunction2 ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAlterSpellWFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellWFunction3 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction

	function SaberAlterSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03V'
	endfunction

	function SaberAlterSpellEFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) and IsUnitInGroup( GetFilterUnit( ), LoadGroupHandle( HashTable, MUIHandle( ), 111 ) ) == false then
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 75 + MUIPower( ) )
			call DisplaceUnitWithArgs( GetFilterUnit( ), 0, 0, 1, .01, 400 )
			call GroupAddUnit( LoadGroupHandle( HashTable, MUIHandle( ), 111 ), GetFilterUnit( ) )
		endif

		return true
	endfunction

	function SaberAlterSpellEFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
		else
			call RemoveUnit( MUIUnit( 101 ) )
		endif
		
		if LocTime == 1 then
			call PlaySoundWithVolume( LoadSound( "SaberAlterE1" ), 100, 0 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call PauseUnit( MUIUnit( 100 ), true )
			call SetUnitAnimation( MUIUnit( 100 ), "spell Five" )
			call SaveUnitHandle( HashTable, HandleID, 101, CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u001', MUILocation( 102 ), MUIAngle( 102, 103 ) ) )
		endif

		if LocTime == 60 then
			call PlaySoundWithVolume( LoadSound( "SaberAlterE2" ), 100, 0.5 )
			call PauseUnit( MUIUnit( 100 ), false )
			call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
		endif
		
		if LocTime > 60 then
			call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 150 )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), LoadReal( HashTable, HandleID, 110 ), MUIAngle( 102, 103 ) ) )
			call DestroyEffect( AddSpecialEffectLoc( "Effects\\SaberAlter\\ShadowBurstBig.mdl", MUILocation( 107 ) ) )
			call SetUnitPositionLoc( MUIUnit( 101 ), MUILocation( 107 ) )
			call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 300, Filter( function SaberAlterSpellEFunction2 ) )
			
			if LoadReal( HashTable, HandleID, 110 ) >= 1500. or UnitLife( MUIUnit( 100 ) ) <= 0 then
				call RemoveUnit( MUIUnit( 101 ) )
				call ClearAllData( HandleID )
			else
				call RemoveLocation( MUILocation( 107 ) )
			endif
		endif
	endfunction

	function SaberAlterSpellEFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
		call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellEFunction3 )
	endfunction

	function SaberAlterSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03W'
	endfunction

	function SaberAlterSpellRLastSlash takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 30 + MUIPower( ) * 0.25 )
			call DisplaceUnitWithArgs( GetFilterUnit( ), GetUnitFacing( MUIUnit( 100 ) ), 300, .35, .01, 0 )
			call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetFilterUnit( ), "origin" ) )
		endif

		return true
	endfunction	

	function SaberAlterSpellRFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 30 + MUIPower( ) * 0.25 )
			call DisplaceUnitWithArgs( GetFilterUnit( ), GetUnitFacing( MUIUnit( 100 ) ), 100, .35, .01, 300 )
			call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl", GetFilterUnit( ), "chest" ) )
		endif

		return true
	endfunction

	function SaberAlterSpellRFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterR1" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call PauseUnit( MUIUnit( 100 ), true )
			endif

			if LocTime == 10 or LocTime == 50 or LocTime == 90 then
				if LocTime == 50 then
					call SetUnitAnimation( MUIUnit( 100 ), "spell Six" )
				else
					call SetUnitAnimation( MUIUnit( 100 ), "spell Three" )
				endif

				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 50, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call AddEffect( "Effects\\SaberAlter\\SlashBlack1.mdl", 1, MUILocation( 102 ), GetUnitFacing( MUIUnit( 100 ) ), 0 )
				
				if IsTerrainPathable( GetLocationX( MUILocation( 103 ) ), GetLocationY( MUILocation( 103 ) ), PATHING_TYPE_WALKABILITY ) == false then
					call RemoveLocation( MUILocation( 103 ) )
					call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 100, GetUnitFacing( MUIUnit( 100 ) ) ) )
					call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), 100, .4, .01, false, false, "origin", DashEff( ) )
				endif
				
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 102 ), 300, Filter( function SaberAlterSpellRFunction2 ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 120 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 50, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), ( MUIDistance( 102, 103 )*.5 ), MUIAngle( 102, 103 ) ) )
				call AddEffect( "Effects\\SaberAlter\\LinearSlashBlack1.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 75, 0, 130, 255 )
				
				if IsTerrainPathable( GetLocationX( MUILocation( 103 ) ), GetLocationY( MUILocation( 103 ) ), PATHING_TYPE_WALKABILITY ) == false then
					call RemoveLocation( MUILocation( 103 ) )
					call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 300, GetUnitFacing( MUIUnit( 100 ) ) ) )
					call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .2, .01, false, false, "origin", DashEff( ) )
				endif
				
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 102 ), 300, Filter( function SaberAlterSpellRLastSlash ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAlterSpellRFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellRFunction3 )
	endfunction

	function SaberAlterSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03X'
	endfunction

	function SaberAlterSpellTFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) and IsUnitInGroup( GetFilterUnit( ), LoadGroupHandle( HashTable, MUIHandle( ), 111 ) ) == false then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 300 + MUIPower( ) )
			call GroupAddUnit( LoadGroupHandle( HashTable, MUIHandle( ), 111 ), GetFilterUnit( ) )
		endif
		
		return true
	endfunction

	function SaberAlterSpellTFunction3 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Channel One" )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberAlter\\ShadowBurst.mdl", MUIUnit( 100 ), "weapon" ) )
			endif

			if LocTime == 1 or LocTime == 10 then
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 102 ), 0, 0 )
				call AddEffect( "Effects\\SaberAlter\\DarkExplosion.mdl", .5, MUILocation( 102 ), 0, 0 )
			endif

			if LocTime == 100 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell Channel Two" )
				call PlaySoundWithVolume( LoadSound( "SaberAlterT2" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterT3" ), 100, 0 )
				call AddEffect( "Effects\\SaberAlter\\DarkWave.mdl", 1, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
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
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 500, Filter( function SaberAlterSpellTFunction2 ) )

				if LoadReal( HashTable, HandleID, 110 ) >= 3000 then
					call ClearAllData( HandleID )
				endif

				call RemoveLocation( MUILocation( 107 ) )
			endif
		endif
	endfunction

	function SaberAlterSpellTFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
		call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellTFunction3 )
	endfunction

	function HeroInit4 takes nothing returns nothing
		call SaveSound( "SaberAlterD1", "SaberAlter\\SpellD1.mp3" )
		call SaveSound( "SaberAlterQ1", "SaberAlter\\SpellQ1.mp3" )
		call SaveSound( "SaberAlterQ2", "SaberAlter\\SpellQ2.mp3" )
		call SaveSound( "SaberAlterW1", "SaberAlter\\SpellW1.mp3" )
		call SaveSound( "SaberAlterW2", "SaberAlter\\SpellW2.mp3" )
		call SaveSound( "SaberAlterW3", "SaberAlter\\SpellW3.mp3" )
		call SaveSound( "SaberAlterE1", "SaberAlter\\SpellE1.mp3" )
		call SaveSound( "SaberAlterE2", "SaberAlter\\SpellE2.mp3" )
		call SaveSound( "SaberAlterR1", "SaberAlter\\SpellR1.mp3" )
		call SaveSound( "SaberAlterR2", "SaberAlter\\SpellR2.mp3" )
		call SaveSound( "SaberAlterT1", "SaberAlter\\SpellT1.mp3" )
		call SaveSound( "SaberAlterT2", "SaberAlter\\SpellT2.mp3" )
		call SaveSound( "SaberAlterT3", "SaberAlter\\SpellT3.mp3" )

		call SaveTrig( "SaberAlterTrigD" )
		call GetUnitEvent( LoadTrig( "SaberAlterTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberAlterTrigD" ), Condition( function SaberAlterSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberAlterTrigD" ), function SaberAlterSpellDFunction4 )

		call SaveTrig( "SaberAlterTrigQ" )
		call GetUnitEvent( LoadTrig( "SaberAlterTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberAlterTrigQ" ), Condition( function SaberAlterSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberAlterTrigQ" ), function SaberAlterSpellQFunction4 )

		call SaveTrig( "SaberAlterTrigW" )
		call GetUnitEvent( LoadTrig( "SaberAlterTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberAlterTrigW" ), Condition( function SaberAlterSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberAlterTrigW" ), function SaberAlterSpellWFunction4 )

		call SaveTrig( "SaberAlterTrigE" )
		call GetUnitEvent( LoadTrig( "SaberAlterTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberAlterTrigE" ), Condition( function SaberAlterSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberAlterTrigE" ), function SaberAlterSpellEFunction4 )

		call SaveTrig( "SaberAlterTrigR" )
		call GetUnitEvent( LoadTrig( "SaberAlterTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberAlterTrigR" ), Condition( function SaberAlterSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberAlterTrigR" ), function SaberAlterSpellRFunction4 )

		call SaveTrig( "SaberAlterTrigT" )
		call GetUnitEvent( LoadTrig( "SaberAlterTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberAlterTrigT" ), Condition( function SaberAlterSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "SaberAlterTrigT" ), function SaberAlterSpellTFunction4 )
	endfunction	

