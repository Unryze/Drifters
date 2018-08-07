	function ArcueidSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A01N'
	endfunction

	function ArcueidSpellQFunction2 takes nothing returns nothing
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
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 102, -300, .5, .01, 250, "" )
				call AoEDamage( HandleID, MUILocation( 103 ), 300, "AoE", "Physical", 250 + MUILevel( ) * 70 + MUIPower( ), false, "Stun", 1 )				
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellQFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellQFunction2 )
	endfunction 

	function ArcueidSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A01Y'
	endfunction

	function ArcueidSpellWFunction2 takes nothing returns nothing
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
				call AoEDisplace( HandleID, 102, 200, .15, .01, 0, "" )
				call AoEDamage( HandleID, MUILocation( 102 ), 450, "AoE", "Physical", 350 + MUILevel( ) * 60 + MUIPower( ), false, "", 0 )
			endif
			
			if LocTime == 40 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellWFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellWFunction2 )
	endfunction 

	function ArcueidSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A026'
	endfunction

	function ArcueidSpellEFunction2 takes nothing returns nothing
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
				call UnitSelect( MUIUnit( 100 ) )
				call AoEDamage( HandleID, MUILocation( 103 ), 400, "AoE", "Physical", MUILevel( ) * 100 + MUIPower( ), false, "Stun", 1 )
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

	function ArcueidSpellEFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellEFunction2 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction 

	function ArcueidSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A027'
	endfunction

	function ArcueidSpellRFunction2 takes nothing returns nothing
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

			call AoEDamage( HandleID, MUILocation( 103 ), 400, "AoE", "Physical", MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ArcueidSpellRFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellRFunction2 )
	endfunction

	function ArcueidSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A02A'
	endfunction

	function Unused takes nothing returns boolean
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
		endif
		
		//call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 600, Filter( function Unused ) )

		return true
	endfunction	

	function ArcueidSpellTFunction2 takes nothing returns nothing
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
				call AoEDamage( HandleID, MUILocation( 103 ), 600, "AoE", "Physical", MUILevel( ) * 200 + MUIPower( ), false, "Stun", 1 )
				
			endif

			if LocTime == 50 then
				call ShowUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Stand" )
				call UnitSelect( MUIUnit( 100 ) )

				loop
					exitwhen i == 3
					call AddEffect( "GeneralEffects\\ValkDust" + I2S( 50 * GetRandomInt( 1, 3 ) ) + ".mdl", GetRandomReal( 1.5, 2 ), MUILocation( 103 ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellTFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellTFunction2 )
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
		call TriggerAddAction( LoadTrig( "ArcueidTrigQ" ), function ArcueidSpellQFunction3 )

		call SaveTrig( "ArcueidTrigW" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigW" ), Condition( function ArcueidSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigW" ), function ArcueidSpellWFunction3 )

		call SaveTrig( "ArcueidTrigE" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigE" ), Condition( function ArcueidSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigE" ), function ArcueidSpellEFunction3 )

		call SaveTrig( "ArcueidTrigR" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigR" ), Condition( function ArcueidSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigR" ), function ArcueidSpellRFunction3 )

		call SaveTrig( "ArcueidTrigT" )
		call GetUnitEvent( LoadTrig( "ArcueidTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ArcueidTrigT" ), Condition( function ArcueidSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "ArcueidTrigT" ), function ArcueidSpellTFunction3 )
	endfunction

