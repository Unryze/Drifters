	function AkainuSpellD takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if GetUnitAbilityLevel( MUIUnit( 100 ), 'B04H' ) > 0 then
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call AoEDamage( HandleID, MUILocation( 102 ), 300, "AoE", "Physical", MUILevel( ) * 12.5 + MUIPower( ) * 0.1, true, "", 0 )
			call RemoveLocation( MUILocation( 102 ) )
		else
			call ClearAllData( HandleID )
		endif
	endfunction

	function AkainuSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 20, MUIAngle( 102, 103 ) ) )	

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuR2" ), 90, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call MakeUnitAirborne( MUIUnit( 100 ), 100, 9999 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .25, .01, false, true, "origin", "Effects\\Akainu\\MagmaBlast.mdl" )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "AkainuR1" ), 90, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call AddEffect( "Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) + 90, 0 )
				call AddEffect( "GeneralEffects\\t_huobao.mdl", 1.5, MUILocation( 103 ), MUIAngle( 102, 103 ), 90 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 100, 99999 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 175 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 300, .4, .01, false, false, "origin", DashEff( ) )
				call AoEDamage( HandleID, MUILocation( 103 ), 300, "AoE", "Physical", 175 + MUILevel( ) * 25 + MUIPower( ) * 0.5, false, "", 0 )
				call ClearAllData( HandleID )
			else
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif
		endif
	endfunction

	function AkainuSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuE1" ), 90, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 102 ) ) )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .5, .01, 600 )
			endif

			if LocTime == 50 then
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\LightningStrike1.mdl", MUILocation( 103 ) ) )
				call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "Effects\\Akainu\\MagmaBlast.mdl", 1, MUILocation( 103 ), 0, 0 )
				call AoEDamage( HandleID, MUILocation( 103 ), 350, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkainuSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuW1" ), 90, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
			endif

			if LocTime == 20 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
				call AddEffect( "Effects\\Akainu\\MagmaWolf.mdl", 1., MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				call SetUnitPathing( LoadUnit( "DummyUnit" ), false )
				call SaveUnitHandle( HashTable, HandleID, 106, LoadUnit( "DummyUnit" ) )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call AddEffect( "Effects\\Akainu\\MagmaBlast.mdl", .25, MUILocation( 102 ), 0, 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				call SetUnitPathing( LoadUnit( "DummyUnit" ), false )
				call SaveUnitHandle( HashTable, HandleID, 126, LoadUnit( "DummyUnit" ) )
				call SetUnitPathing( MUIUnit( 126 ), false )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime > 20 then
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, GetUnitLoc( MUIUnit( 106 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 107 ), 40, MUIAngle( 107, 103 ) ) )
				call FaceLocation( MUIUnit( 106 ), MUILocation( 103 ), 0 )
				call SetUnitPositionLoc( MUIUnit( 106 ), MUILocation( 109 ) )
				call FaceLocation( MUIUnit( 126 ), MUILocation( 103 ), 0 )
				call SetUnitPositionLoc( MUIUnit( 126 ), MUILocation( 109 ) )

				if LocTime == 21 or LocTime == 25 or LocTime == 30 or LocTime == 35 or LocTime == 40 or LocTime == 45 or LocTime == 50 then
					call AddEffect( "GeneralEffects\\ValkDust.mdl", 1., MUILocation( 109 ), 0, 90 )
					call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				endif

				if MUIDistance( 103, 109 ) <= 150 then
					call KillUnit( MUIUnit( 106 ) )
					call KillUnit( MUIUnit( 126 ) )
					call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
					call AddEffect( "Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", 2, MUILocation( 103 ), MUIAngle( 103, 107 ) + 90, 0 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
					call RemoveLocation( MUILocation( 109 ) )
					call ClearAllData( HandleID )
				else
					call RemoveLocation( MUILocation( 103 ) )
					call RemoveLocation( MUILocation( 107 ) )
					call RemoveLocation( MUILocation( 109 ) )
				endif
			endif
		endif
	endfunction

	function AkainuSpellR takes nothing returns nothing
		local integer i	= 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuQ1" ), 90, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
			endif

			if LocTime == 20 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 127, CreateLocation( MUILocation( 102 ), 300, MUIAngle( 102, 103 ) ) )
				call AddEffect( "Effects\\Akainu\\LinearMagmaHand.mdl", 2, MUILocation( 127 ), MUIAngle( 102, 103 ), 0 )
				call RemoveLocation( MUILocation( 127 ) )
				call PlaySoundWithVolume( LoadSound( "AkainuR2" ), 60, 0 )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			if LocTime > 20 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 100 )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), LoadReal( HashTable, HandleID, 110 ), MUIAngle( 102, 103 ) ) )

				loop
					exitwhen i > 2
					call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 107 ), GetRandomReal( 0, 500 ), GetRandomReal( 0, 360 ) ) )
					call DestroyEffect( AddSpecialEffectLoc( "abilities\\weapons\\catapult\\catapultmissile.mdl", MUILocation( 109 ) ) )
					call AddEffect( "Effects\\Akainu\\MagmaBlast.mdl", .25, MUILocation( 109 ), GetRandomReal( 0, 360 ), 0 )
					call RemoveLocation( MUILocation( 109 ) )
					set i = i + 1
				endloop

				call AoEDamage( HandleID, MUILocation( 107 ), 500, "AoE", "Physical", MUILevel( ) * 100 + MUIPower( ), false, "", 0 )
				call RemoveLocation( MUILocation( 107 ) )

				if LoadReal( HashTable, HandleID, 110 ) >= 1500 then
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction

	function AkainuSpellT takes nothing returns nothing
		local integer HandleID  = MUIHandle( )	
		local integer LocTime   = MUIInteger( 0 )
		local integer LocCount  = LoadInteger( HashTable, HandleID, 1 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuT1" ), 90, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell" )
			endif

			call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
			call SaveReal( HashTable, HandleID, 118, LoadReal( HashTable, HandleID, 118 ) + 1 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )

			if LoadReal( HashTable, HandleID, 118 ) == 1 then
				call SaveReal( HashTable, HandleID, 5, -90 )
			else
				call SaveReal( HashTable, HandleID, 5, 90 )
				call SaveReal( HashTable, HandleID, 118, 0 )
			endif

			if LoadReal( HashTable, HandleID, 110 ) < 50 then
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 70, MUIAngle( 102, 103 ) + LoadReal( HashTable, HandleID, 5 ) ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif

			if LocTime > 10 then
				call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )
				call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 103 ), GetRandomReal( 0, 550 ), GetRandomReal( 0, 360 ) ) )
				call AddEffect( "Effects\\Akainu\\VerticalMagmaHand.mdl", .65, MUILocation( 109 ), GetRandomReal( 0, 360 ), 0 )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .5 )

				if LocCount > 7 then
					call AoEDamage( HandleID, MUILocation( 109 ), 500, "AoE", "Physical", MUILevel( ) * 25 + MUIPower( ) * 0.05, true, "", 0 )
				endif

				call RemoveLocation( MUILocation( 109 ) )
			endif

			if LoadReal( HashTable, HandleID, 110 ) == 70 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function AkainuSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A049' then
			set HandleID = NewMUITimer( LocPID )
			call PlaySoundWithVolume( LoadSound( "AkainuD1" ), 100, 0 )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "GeneralEffects\\lavaspray.mdl", GetTriggerUnit( ), "head" ) )
			call TimerStart( LoadMUITimer( LocPID ), .5, true, function AkainuSpellD )
		endif

		if GetSpellAbilityId( ) == 'A04A' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A04C' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A04B' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellE )
		endif
		
		if GetSpellAbilityId( ) == 'A04D' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellR )
		endif
		
		if GetSpellAbilityId( ) == 'A04E' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .05, true, function AkainuSpellT )
		endif

		return false
	endfunction	

	function HeroInit9 takes nothing returns nothing
		call SaveSound( "AkainuD1", "Akainu\\SpellD1.mp3" )
		call SaveSound( "AkainuQ1", "Akainu\\SpellQ1.mp3" )
		call SaveSound( "AkainuW1", "Akainu\\SpellW1.mp3" )
		call SaveSound( "AkainuE1", "Akainu\\SpellE1.mp3" )
		call SaveSound( "AkainuR1", "Akainu\\SpellR1.mp3" )
		call SaveSound( "AkainuR2", "Akainu\\SpellR2.mp3" )
		call SaveSound( "AkainuT1", "Akainu\\SpellT1.mp3" )

		call SaveTrig( "AkainuSpells" )
		call GetUnitEvent( LoadTrig( "AkainuSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkainuSpells" ), Condition( function AkainuSpells ) )
	endfunction	

