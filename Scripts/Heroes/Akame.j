	function AkameSpellDFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03K' or GetSpellAbilityId( ) == 'A052'
	endfunction

	function AkameSpellDFunction2 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkameD1" ), 80, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitFacing( MUIUnit( 100 ), GetAngleBetweenPoints( MUILocation( 102 ), MUILocation( 103 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitInvulnerable( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
			endif

			if LocTime == 20 then
				call DisplaceUnitWithArgs( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), LoadReal( HashTable, HandleID, 0 ), .2, .01, 0 )
			endif

			if LocTime == 30 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellDFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( GetTriggerUnit( ) ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )

		if GetSpellAbilityId( ) == 'A052' then
			call SaveReal( HashTable, HandleID, 0, -350 )
			call SetPlayerAbilityAvailable( Player( LocPID ), 'A03L', true )
			call SetPlayerAbilityAvailable( Player( LocPID ), 'A052', false )
		else
			call SaveReal( HashTable, HandleID, 0, -400 )
		endif

		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellDFunction2 )
	endfunction

	function AkameSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03L'
	endfunction

	function AkameSpellQFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Four" )
			endif

			if LocTime == 20 then
				call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03L', false )
				call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A052', true )
				call PauseUnit( MUIUnit( 100 ), false )
				call PlaySoundWithVolume( LoadSound( "AkameQ1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 200, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call AddEffect( "GeneralEffects\\AkihaClaw.mdl", 1.5, MUILocation( 103 ), MUIAngle( 102, 103 ) + 30, 0 )
				call AoEDamage( HandleID, MUILocation( 103 ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 220 then
				call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03L', true )
				call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A052', false )
				call FlushChildHashtable( HashTable, HandleID )
			endif
		endif
	endfunction

	function AkameSpellQFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellQFunction2 )
	endfunction

	function AkameSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03M'
	endfunction

	function AkameSpellWFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		
		if StopSpell( HandleID, 1 ) == false then

			if MUIInteger( 0 ) < 1 then
				call SaveInteger( HashTable, HandleID, 0, MUIInteger( 0 ) + 1 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Channel" )
				call SaveInteger( HashTable, HandleID, 110, 255 )
				call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ) ) )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) - 10 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), MUIDistance( 102, 103 ) / 20, MUIAngle( 102, 103 ) ) )
			call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
			call FaceLocation( MUIUnit( 100 ), MUILocation( 103 ), 0 )
			call SetUnitVertexColor( MUIUnit( 100 ), 255, 255, 255, LoadInteger( HashTable, HandleID, 110 ) )

			if MUIDistance( 103, 107 ) <= 150 then
				call PlaySoundWithVolume( LoadSound( "AkameW1" ), 90, 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
				call AddEffect( "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 153, 0, 0, 255 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call StunUnit( MUIUnit( 101 ), 1 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 200 + MUILevel( ) * 100 + MUIPower( ) )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
				call ClearAllData( HandleID )
			else
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif
		endif
	endfunction

	function AkameSpellWFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellWFunction2 )
	endfunction

	function AkameSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03N'
	endfunction

	function AkameSpellEFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Four" )
				call PlaySoundWithVolume( LoadSound( "AkameE1" ), 100, 0 )
			endif

			if LocTime == 30 then
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), MUIDistance( 102, 103 ) * .5, MUIAngle( 102, 103 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffect( "GeneralEffects\\AkihaClaw.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 103, -200, .5, .01, 0, DashEff( ) )
				call AoEDamage( HandleID, MUILocation( 107 ), 450, "AoE", "Physical", 300 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellEFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellEFunction2 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction

	function AkameSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03O'
	endfunction

	function AkameSpellRFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local integer LocCount  = LoadInteger( HashTable, HandleID, 1 )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )

		if StopSpell( HandleID, 1 ) == false then
			if IsCounted == true then
				call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			else
				call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )
			endif

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .6, .01, false, false, "origin", DashEff( ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "AkameD1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 103 ), 0, 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 2., MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 400, .5, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUILevel( ) * 30 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 103, 102 ), 400, 1, .01, 0 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 140 then
				call SaveBoolean( HashTable, HandleID, 10, false )
				call PlaySoundWithVolume( LoadSound( "AkameR2" ), 80, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 102 ) ) )
				call ShowUnit( MUIUnit( 100 ), false )
				call RemoveLocation( MUILocation( 102 ) )
			endif
			
			if IsCounted == false then
				if LocCount == 2 then
					call SaveInteger( HashTable, HandleID, 1, 1 )
					call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
					
					if LoadReal( HashTable, HandleID, 110 ) < 20 then
						call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 25 + MUILevel( ) )
						call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )

						if LoadReal( HashTable, HandleID, 110 ) < 16 then
							call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
							call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 150, LoadReal( HashTable, HandleID, 110 ) * 24 ) )
						endif

						call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 107 ) ) )
						call RemoveLocation( MUILocation( 103 ) )
						call RemoveLocation( MUILocation( 107 ) )
					else
						call SaveBoolean( HashTable, HandleID, 10, true )
						call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
						call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
						call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 500, MUIAngle( 103, 102 ) ) )
						call ShowUnit( MUIUnit( 100 ), true )
						call UnitSelect( MUIUnit( 100 ) )
						call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
						call FaceLocation( MUIUnit( 100 ), MUILocation( 103 ), 0 )
						call PauseUnit( MUIUnit( 100 ), true )
						call SetUnitTimeScale( MUIUnit( 100 ), .1 )
						call SetUnitAnimation( MUIUnit( 100 ), "attack" )
						call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BlackBlink.mdl", MUILocation( 107 ) ) )
						call RemoveLocation( MUILocation( 102 ) )
						call RemoveLocation( MUILocation( 103 ) )
						call RemoveLocation( MUILocation( 107 ) )
						call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
					endif
				endif
			endif

			if LocTime == 190 then
				call PlaySoundWithVolume( LoadSound( "AkameW1" ), 90, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			endif
			
			if LocTime == 210 then
				call PlaySoundWithVolume( LoadSound( "AkameR1" ), 90, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 500, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) + 200, .2, .01, false, false, "origin", DashEff( ) )
				call AddEffect( "GeneralEffects\\AkihaClaw.mdl", 4, MUILocation( 103 ), MUIAngle( 102, 103 ), 0 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "origin" ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 260 then
				call StunUnit( MUIUnit( 101 ), 1 )
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 500 + MUILevel( ) * 50 + MUIPower( ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellRFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveBoolean( HashTable, HandleID, 10, true )
		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellRFunction2 )
	endfunction

	function AkameSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03P'
	endfunction

	function AkameSpellTFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .6, .01, false, false, "origin", DashEff( ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call StunUnit( MUIUnit( 101 ), 2 )
				call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 103 ), 0, 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1.5, MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 600, 1, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 500 + MUILevel( ) * 50 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 75 then
				call PlaySoundWithVolume( LoadSound( "AkameT1" ), 80, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) + 600, .8, .01, 400 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 155 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call PlaySoundWithVolume( LoadSound( "AkameQ1" ), 80, 0 )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 205 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call StunUnit( MUIUnit( 101 ), 1 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1000 + MUILevel( ) * 100 + MUIPower( ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodExplosion.mdl", MUILocation( 103 ) ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellTFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellTFunction2 )
	endfunction

	function HeroInit7 takes nothing returns nothing
		call SaveSound( "AkameD1", "Akame\\SpellD1.mp3" )
		call SaveSound( "AkameQ1", "Akame\\SpellQ1.mp3" )
		call SaveSound( "AkameW1", "Akame\\SpellW1.mp3" )
		call SaveSound( "AkameE1", "Akame\\SpellE1.mp3" )
		call SaveSound( "AkameR1", "Akame\\SpellR1.mp3" )
		call SaveSound( "AkameR2", "Akame\\SpellR2.mp3" )
		call SaveSound( "AkameT1", "Akame\\SpellT1.mp3" )

		call SaveTrig( "AkameTrigD" )
		call GetUnitEvent( LoadTrig( "AkameTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkameTrigD" ), Condition( function AkameSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkameTrigD" ), function AkameSpellDFunction3 )

		call SaveTrig( "AkameTrigQ" )
		call GetUnitEvent( LoadTrig( "AkameTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkameTrigQ" ), Condition( function AkameSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkameTrigQ" ), function AkameSpellQFunction3 )

		call SaveTrig( "AkameTrigW" )
		call GetUnitEvent( LoadTrig( "AkameTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkameTrigW" ), Condition( function AkameSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkameTrigW" ), function AkameSpellWFunction3 )

		call SaveTrig( "AkameTrigE" )
		call GetUnitEvent( LoadTrig( "AkameTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkameTrigE" ), Condition( function AkameSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkameTrigE" ), function AkameSpellEFunction3 )

		call SaveTrig( "AkameTrigR" )
		call GetUnitEvent( LoadTrig( "AkameTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkameTrigR" ), Condition( function AkameSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkameTrigR" ), function AkameSpellRFunction3 )

		call SaveTrig( "AkameTrigT" )
		call GetUnitEvent( LoadTrig( "AkameTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "AkameTrigT" ), Condition( function AkameSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "AkameTrigT" ), function AkameSpellTFunction3 )
	endfunction	

