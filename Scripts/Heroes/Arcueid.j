	function ArcueidSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A01N'
	endfunction

	function ArcueidSpellQFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call SaveLocationHandle( HashTable, MUIHandle( ), 107, GetUnitLoc( GetFilterUnit( ) ) )
			call DisplaceUnitWithArgs( GetFilterUnit( ), MUIAngle( 102, 107 ), -300, .5, .01, 250 )
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 250 + MUILevel( ) * 70 + MUIPower( ) )
			call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 107 ) ) )
			call RemoveLocation( MUILocation( 107 ) )
		endif

		return true
	endfunction

	function ArcueidSpellQFunction3 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidQ1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 300, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell One" )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 300, Filter( function ArcueidSpellQFunction2 ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellQFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellQFunction3 )
	endfunction 

	function ArcueidSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A01Y'
	endfunction

	function ArcueidSpellWFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call SaveLocationHandle( HashTable, MUIHandle( ), 113, GetUnitLoc( GetFilterUnit( ) ) )
			call LinearDisplacement( GetFilterUnit( ), MUIAngle( 102, 113 ), 200, .15, .01, false, false, "origin", DashEff( ) )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 350 + MUILevel( ) * 60 + MUIPower( ) )
			call RemoveLocation( MUILocation( 113 ) )
		endif

		return true
	endfunction	

	function ArcueidSpellWFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )
		local integer i = 1

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidW1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Five" )
			endif

			if LocTime == 10 then

				loop
					exitwhen i == 3
					call AddEffect( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1, 2 ), MUILocation( 102 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop
			endif
				
			if LocTime == 25 then
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 102 ), 450, Filter( function ArcueidSpellWFunction2 ) )
			endif
			
			if LocTime == 40 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellWFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellWFunction3 )
	endfunction 

	function ArcueidSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A026'
	endfunction

	function ArcueidSpellEFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 100 + MUIPower( ) )
		endif

		return true
	endfunction	

	function ArcueidSpellEFunction3 takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidE1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Two" )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 102 ) ) )
			endif

			if LocTime == 15 then
				call ShowUnit( MUIUnit( 100 ), false )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "SlamSound1" ), 60, 0 )
				call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 103 ) )
				call ShowUnit( MUIUnit( 100 ), true )

				if GetLocalPlayer( ) == GetOwningPlayer( MUIUnit( 100 ) ) then
					call ClearSelection( )
					call SelectUnit( MUIUnit( 100 ), true )
				endif

				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 400, Filter( function ArcueidSpellEFunction2 ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\SlamEffect.mdl", MUILocation( 103 ) ) )

				loop
					exitwhen i == 3
					call AddEffect( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1, 2 ), MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellEFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellEFunction3 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction 

	function ArcueidSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A027'
	endfunction

	function ArcueidSpellRFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 50 + MUIPower( ) )
		endif

		return true
	endfunction

	function ArcueidSpellRFunction3 takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidR1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Slam" )
			endif

			if LocTime == 15 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", 1.5, MUILocation( 102 ), 0, 0 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 150 + MUIPower( ) * .5 )
				call MakeUnitAirborne( MUIUnit( 101 ), 600, 4000 )
			endif

			if LocTime == 25 then
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 102 ) ) )
			endif

			if LocTime == 30 then
				call MakeUnitAirborne( MUIUnit( 100 ), 700, 4000 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Two" )
			endif
		endif

		if LocTime == 60 then
			call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 50 + MUIPower( ) * .5 )
			call SetUnitFlyHeight( MUIUnit( 101 ), 0, 2000 )
			call SetUnitFlyHeight( MUIUnit( 100 ), 0, 99999 )
			call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 250, .2, .01, false, false, "origin", "" )
		endif

		if LocTime == 80 then
			call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
			call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 1.5, MUILocation( 103 ), 0, 0 )

			loop
				exitwhen i == 3
				call AddEffect( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1.5, 2 ), MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
				set i = i + 1
			endloop

			call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 400, Filter( function ArcueidSpellRFunction2 ) )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ArcueidSpellRFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellRFunction3 )
	endfunction

	function ArcueidSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02A'
	endfunction

	function ArcueidSpellTFunction2 takes nothing returns boolean
		local integer i = 0

		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then

			loop
				exitwhen i == 2
				call SaveLocationHandle( HashTable, MUIHandle( ), 104, GetUnitLoc( GetFilterUnit( ) ) )
				call AddEffect( "GeneralEffects\\ShortSlash\\ShortSlash75.mdl", .75, MUILocation( 104 ), i * GetRandomInt( 60, 90 ), 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), GetUnitFlyHeight( GetFilterUnit( ) ) + 50, 9999 )
				call RemoveLocation( MUILocation( 104 ) )
				set i = i + 1
			endloop

			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 200 + MUIPower( ) )
			call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl", GetFilterUnit( ), "chest" ) )
			call DestroyEffect( AddSpecialEffectTarget( "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl", GetFilterUnit( ), "head" ) )
		endif

		return true
	endfunction	

	function ArcueidSpellTFunction3 takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Six" )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 102 ) ) )
			endif

			if LocTime == 25 then
				call ShowUnit( MUIUnit( 100 ), false )
				call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 103 ) )
			endif

			if LocTime == 45 then
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 600, Filter( function ArcueidSpellTFunction2 ) )
			endif

			if LocTime == 50 then
				call ShowUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Stand" )

				if GetLocalPlayer( ) == GetOwningPlayer( MUIUnit( 100 ) ) then
					call ClearSelection( )
					call SelectUnit( MUIUnit( 100 ), true )
				endif

				loop
					exitwhen i == 3
					call AddEffect( "GeneralEffects\\ValkDust" + I2S( 50 * GetRandomInt( 1, 3 ) ) + ".mdl", GetRandomReal( 1.5, 2 ), MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellTFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellTFunction3 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction 	

	function HeroInit11 takes nothing returns nothing
		call SaveSound( "ArcueidQ1", "Arcueid\\SpellQ1.mp3" )
		call SaveSound( "ArcueidW1", "Arcueid\\SpellW1.mp3" )
		call SaveSound( "ArcueidE1", "Arcueid\\SpellE1.mp3" )
		call SaveSound( "ArcueidR1", "Arcueid\\SpellR1.mp3" )
		call SaveSound( "ArcueidT1", "Arcueid\\SpellT1.mp3" )

		call SaveTrig( "ArcueidTrigQ" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigQ" ), Condition( function ArcueidSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigQ" ), function ArcueidSpellQFunction4 )

		call SaveTrig( "ArcueidTrigW" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigW" ), Condition( function ArcueidSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigW" ), function ArcueidSpellWFunction4 )

		call SaveTrig( "ArcueidTrigE" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigE" ), Condition( function ArcueidSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigE" ), function ArcueidSpellEFunction4 )

		call SaveTrig( "ArcueidTrigR" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigR" ), Condition( function ArcueidSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigR" ), function ArcueidSpellRFunction4 )

		call SaveTrig( "ArcueidTrigT" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigT" ), Condition( function ArcueidSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigT" ), function ArcueidSpellTFunction4 )
	endfunction

