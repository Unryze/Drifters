	function RyougiShikiSpellDFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A035'
	endfunction

	function RyougiShikiSpellDFunction2 takes nothing returns nothing
		call PlaySoundWithVolume( LoadSound( "RyougiD1" ), 60, 0 )
	endfunction

	function RyougiShikiSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A033'
	endfunction

	function RyougiShikiSpellQFunction2 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiW1" ), 80, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel four" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 200, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call AddMultipleEffects( 5, "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, MUILocation( 102 ), GetUnitFacing( MUIUnit( 100 ) ), 0, 65, 235, 245, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 102, 300, .5, .01, 150, "" )
				call AoEDamage( HandleID, MUILocation( 103 ), 300, "AoE", "Physical", 240 + MUILevel( ) * 80 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiShikiSpellQFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiShikiSpellQFunction2 )
	endfunction

	function RyougiShikiSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A032'
	endfunction

	function RyougiShikiSpellWFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiQ1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .4, .01, false, true, "origin", "" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Channel Slam" )
				call RemoveLocation( MUILocation( 102 ) )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A033' )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 200, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call AddMultipleEffects( 5, "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, MUILocation( 102 ), GetUnitFacing( MUIUnit( 100 ) ), 0, 65, 235, 245, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 102, 150, .2, .01, 0, DashEff( ) )
				call AoEDamage( HandleID, MUILocation( 107 ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiShikiSpellWFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiShikiSpellWFunction2 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction

	function RyougiShikiSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A034'
	endfunction

	function RyougiShikiSpellEFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiE1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel two" )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .4, .01, false, true, "origin", DashEff( ) )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), MUIDistance( 102, 103 ) * .5, MUIAngle( 102, 103 ) ) )
				call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDamage( HandleID, MUILocation( 107 ), 600, "AoE", "Physical", MUILevel( ) * 75 + MUIPower( ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiShikiSpellEFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiShikiSpellEFunction2 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction

	function RyougiShikiSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A036'
	endfunction

	function RyougiShikiSpellRFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiT1" ), 80, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel five" )
				call AddEffect( "GeneralEffects\\BlackBlink.mdl", .5, MUILocation( 102 ), 270, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
			endif

			if LocTime == 25 then
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 100, MUIAngle( 102, 103 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1000 + MUILevel( ) * 100 + MUIPower( ) * .50 )
				call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
				call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, MUILocation( 103 ), MUIAngle( 102, 103 ), 0 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 107 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 50 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1000 + MUILevel( ) * 100 + MUIPower( ) * .50 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call AddMultipleEffects( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, MUILocation( 103 ), 270, 0, 255, 255, 255, 255 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function RyougiShikiSpellRFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiShikiSpellRFunction2 )
	endfunction	

	function RyougiShikiSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A037'
	endfunction

	function RyougiShikiSpellTFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local integer LocCount  = LoadInteger( HashTable, HandleID, 1 )

		if StopSpell( HandleID, 1 ) == false then
			if LoadBoolean( HashTable, HandleID, 10 ) == false then
				if LocTime < 1 then
					call SaveInteger( HashTable, HandleID, 0, 1 )
					call SaveInteger( HashTable, HandleID, 1, 1 )
					call SaveInteger( HashTable, HandleID, 2, 1 )
					call PauseUnit( MUIUnit( 100 ), true )
					call SetUnitPathing( MUIUnit( 100 ), false )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
					call PlaySoundWithVolume( LoadSound( "RyougiD1" ), 100, 0 )
				endif
			
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), 40, MUIAngle( 102, 103 ) ) )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call SetUnitPositionLoc( MUIUnit( 100 ), MUILocation( 107 ) )
				call FaceLocation( MUIUnit( 100 ), MUILocation( 103 ), 0 )
				call DestroyEffect( AddSpecialEffectLoc( DashEff( ), MUILocation( 102 ) ) )

				if MUIDistance( 103, 107 ) <= 600 then
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
					call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.75, MUILocation( 102 ), 0, 0 )
					call PlaySoundWithVolume( LoadSound( "RyougiR1" ), 100, 0 )
					call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 103 ), 250, MUIAngle( 102, 103 ) ) )
					call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 109 ), MUIDistance( 102, 109 ), .2, .01, false, false, "origin", DashEff( ) )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel four" )
					call FaceLocation( MUIUnit( 100 ), MUILocation( 109 ), 0 )
					call AddMultipleEffects( 3, "Effects\\Toono\\LinearSlashBlue1.mdl", 1, MUILocation( 103 ), MUIAngle( 102, 103 ), 0, 255, 255, 255, 255 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1500 + MUILevel( ) * 150 + MUIPower( ) * 0.50 )
					call CCUnit( MUIUnit( 101 ), .5, "Stun" )
					call RemoveLocation( MUILocation( 109 ) )
					call SaveBoolean( HashTable, HandleID, 10, true )
				endif
				
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
			else
				if LoadInteger( HashTable, HandleID, 2 ) < 31 then
					call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )

					if LocCount == 25 then
						call SaveInteger( HashTable, HandleID, 1, 1 )
					endif

					call SaveInteger( HashTable, HandleID, 2, LoadInteger( HashTable, HandleID, 2 ) + 1 )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call AddMultipleEffects( 3, "Effects\\Toono\\LinearSlashBlue1.mdl", 1, MUILocation( 103 ), 9 * LoadInteger( HashTable, HandleID, 2 ), 0, 255, 255, 255, 255 )
					call PlaySoundWithVolume( LoadSound( "RyougiR2" ), 100, 0 )
					call RemoveLocation( MUILocation( 103 ) )
				else
					call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
				endif
				
				if LoadInteger( HashTable, HandleID, 2 ) == 30 then
					call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) + 600, 1.1, .01, 250 )
					call SetUnitAnimation( MUIUnit( 100 ), "spell" )
					call RemoveLocation( MUILocation( 102 ) )
					call RemoveLocation( MUILocation( 103 ) )
				endif
				
				if LocTime == 60 then
					call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 70, 0 )
					call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					call CCUnit( MUIUnit( 101 ), 1, "Stun" )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1500 + MUILevel( ) * 150 + MUIPower( ) * 0.50 )
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
					call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) + 45, 0 )
					call AddEffect( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ) - 45, 0 )
					call RemoveLocation( MUILocation( 102 ) )
					call RemoveLocation( MUILocation( 103 ) )
				endif
				
				if LocTime == 110 then
					call ClearAllData( HandleID )
				endif
			endif			
		endif
	endfunction

	function RyougiShikiSpellTFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveBoolean( HashTable, HandleID, 10, false )
		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiShikiSpellTFunction2 )
	endfunction	

	function HeroInit3 takes nothing returns nothing
		call SaveSound( "RyougiD1", "Ryougi\\SpellD1.mp3" )
		call SaveSound( "RyougiQ1", "Ryougi\\SpellQ1.mp3" )
		call SaveSound( "RyougiW1", "Ryougi\\SpellW1.mp3" )
		call SaveSound( "RyougiE1", "Ryougi\\SpellE1.mp3" )
		call SaveSound( "RyougiR1", "Ryougi\\SpellR1.mp3" )
		call SaveSound( "RyougiR2", "Ryougi\\SpellR2.mp3" )
		call SaveSound( "RyougiT1", "Ryougi\\SpellT1.mp3" )

		call SaveTrig( "RyougiTrigD" )
		call GetUnitEvent( LoadTrig( "RyougiTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RyougiTrigD" ), Condition( function RyougiShikiSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "RyougiTrigD" ), function RyougiShikiSpellDFunction2 )

		call SaveTrig( "RyougiTrigQ" )
		call GetUnitEvent( LoadTrig( "RyougiTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RyougiTrigQ" ), Condition( function RyougiShikiSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "RyougiTrigQ" ), function RyougiShikiSpellQFunction3 )

		call SaveTrig( "RyougiTrigW" )
		call GetUnitEvent( LoadTrig( "RyougiTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RyougiTrigW" ), Condition( function RyougiShikiSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "RyougiTrigW" ), function RyougiShikiSpellWFunction3 )

		call SaveTrig( "RyougiTrigE" )
		call GetUnitEvent( LoadTrig( "RyougiTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RyougiTrigE" ), Condition( function RyougiShikiSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "RyougiTrigE" ), function RyougiShikiSpellEFunction3 )

		call SaveTrig( "RyougiTrigR" )
		call GetUnitEvent( LoadTrig( "RyougiTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RyougiTrigR" ), Condition( function RyougiShikiSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "RyougiTrigR" ), function RyougiShikiSpellRFunction3 )

		call SaveTrig( "RyougiTrigT" )
		call GetUnitEvent( LoadTrig( "RyougiTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RyougiTrigT" ), Condition( function RyougiShikiSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "RyougiTrigT" ), function RyougiShikiSpellTFunction3 )
	endfunction	

