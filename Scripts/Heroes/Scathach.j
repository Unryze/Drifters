	function ResetScathachQ takes nothing returns nothing
		call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A040', true )
		call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03Y', false )
		call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03Z', false )
	endfunction

	function ScathachSpellQFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A040'
	endfunction

	function ScathachSpellQFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime 	= MUIInteger( 0 )

		if UnitLife( MUIUnit( 100 ) ) > 0 and UnitLife( MUIUnit( 101 ) ) > 0 then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ScathachQ3" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 102 ), 0, 45 )
				call RemoveLocation( MUILocation( 102 ) )
			endif

			if LocTime == 20 then
				if GetUnitLevel( MUIUnit( 100 ) ) >= 5 then
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A040', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03Y', true )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03Z', false )
				endif

				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 150, MUIAngle( 103, 102 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 107 ), MUIDistance( 102, 107 ), .35, .01, false, true, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif
			
			if LocTime == 55 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
				call StunUnit( MUIUnit( 101 ), 1 )
				call AddEffect( "GeneralEffects\\OrbOfFire.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUILevel( ) * 50 + MUIPower( ) * 0.5 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
		endif

		if LocTime == 300 or UnitLife( MUIUnit( 100 ) ) <= 0 or UnitLife( MUIUnit( 101 ) ) <= 0 then
			call ResetScathachQ( )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ScathachSpellQFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQFunction2 )
	endfunction

	function ScathachSpellQSecondFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03Y'
	endfunction

	function ScathachSpellQSecondFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		
		if UnitLife( MUIUnit( 100 ) ) > 0 and UnitLife( MUIUnit( 101 ) ) > 0 then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PlaySoundWithVolume( LoadSound( "ScathachQ2" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .2, .01, false, true, "origin", DashEff( ) )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Seven" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 20 then
				if GetUnitLevel( MUIUnit( 100 ) ) >= 8 then
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A040', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03Y', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A03Z', true )
				endif

				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call AddEffect( "GeneralEffects\\t_huobao.mdl", .25, MUILocation( 103 ), 0, 0 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 50 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 35 then
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif
		endif

		if LocTime == 300 or UnitLife( MUIUnit( 100 ) ) <= 0 or UnitLife( MUIUnit( 101 ) ) <= 0 then
			call ResetScathachQ( )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ScathachSpellQSecondFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQSecondFunction2 )
	endfunction

	function ScathachSpellQThirdFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A03Z'
	endfunction

	function ScathachSpellQThirdFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )	
		local integer LocTime   = MUIInteger( 0 )
		
		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ScathachQ1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Three" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 103 ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .2, .01, false, true, "origin", DashEff( ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 20 then
				call ResetScathachQ( )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Four" )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\FireSlamSmall.mdl", MUIUnit( 101 ), "chest" ) )
			endif
			
			if LocTime == 45 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 200, .25, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellQThirdFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQThirdFunction2 )
	endfunction

	function ScathachSpellWFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A041'
	endfunction

	function ScathachSpellWFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call StunUnit( GetFilterUnit( ), 2 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
		endif

		return true
	endfunction

	function ScathachSpellWFunction3 takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ScathachW1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Throw" )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .5, .01, 600 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 102 ) ) )
				call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "ScathachQ3" ), 100, 0 )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 103 ), 400, Filter( function ScathachSpellWFunction2 ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\LightningStrike1.mdl", MUILocation( 103 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\SlamEffect.mdl", MUILocation( 103 ) ) )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2., MUILocation( 103 ), 0, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellWFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellWFunction3 )
		else
			call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
		endif
	endfunction

	function ScathachSpellEFunctionRemoveUnits takes nothing returns nothing
		call KillUnit( GetEnumUnit( ) )
	endfunction	

	function ScathachSpellEFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A042'
	endfunction

	function ScathachSpellEFunctionDisplaceDummy takes nothing returns nothing
		call SaveLocationHandle( HashTable, MUIHandle( ), 123, GetUnitLoc( GetEnumUnit( ) ) )
		call SaveLocationHandle( HashTable, MUIHandle( ), 124, CreateLocation( MUILocation( 123 ), 50, MUIAngle( 102, 103 ) ) )
		call SetUnitPositionLoc( GetEnumUnit( ), MUILocation( 124 ) )
		call RemoveLocation( MUILocation( 123 ) )
		call RemoveLocation( MUILocation( 124 ) )
	endfunction

	function ScathachSpellEFunction2 takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 75 + MUIPower( ) )
		endif

		return true
	endfunction

	function ScathachSpellEFunction3 takes nothing returns nothing
		local real i			= 1
		local integer HandleID  = MUIHandle( )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )
		local integer LocTime   = MUIInteger( 0 )

		if UnitLife( MUIUnit( 100 ) ) > 0 then
			if IsCounted == true then
				call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			else
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )

				if LocTime < 1 then
					call SaveInteger( HashTable, HandleID, 0, 1 )
					call PauseUnit( MUIUnit( 100 ), true )
					call SetUnitPathing( MUIUnit( 100 ), false )
					call SetUnitAnimation( MUIUnit( 100 ), "spell Channel" )
					call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .1, .01, false, false, "origin", DashEff( ) )

					loop
						exitwhen i > 10
						call SaveLocationHandle( HashTable, HandleID, 123, GetUnitLoc( MUIUnit( 100 ) ) )
						call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
						call SaveLocationHandle( HashTable, HandleID, 124, CreateLocation( MUILocation( 123 ), 80. * i, MUIAngle( 123, 103 ) - 160 ) )
						call AddEffect( "GeneralEffects\\OrbOfFire.mdl", 2, MUILocation( 124 ), MUIAngle( 123, 103 ), 0 )
						call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 9999 )
						call GroupAddUnit( LoadGroupHandle( HashTable, HandleID, 111 ), LoadUnit( "DummyUnit" ) )
						call RemoveLocation( MUILocation( 124 ) )
						call SaveLocationHandle( HashTable, HandleID, 124, CreateLocation( MUILocation( 123 ), 80. * i, MUIAngle( 123, 103 ) + 160 ) )
						call AddEffect( "GeneralEffects\\OrbOfFire.mdl", 2, MUILocation( 124 ), MUIAngle( 123, 103 ), 0 )
						call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 9999 )
						call GroupAddUnit( LoadGroupHandle( HashTable, HandleID, 111 ), LoadUnit( "DummyUnit" ) )
						call RemoveLocation( MUILocation( 124 ) )
						call RemoveLocation( MUILocation( 123 ) )
						call RemoveLocation( MUILocation( 103 ) )
						set i = i + 1
					endloop	

					call PauseUnit( MUIUnit( 100 ), true )
					call SetUnitPathing( MUIUnit( 100 ), false )
				endif

				call ForGroup( LoadGroupHandle( HashTable, HandleID, 111 ), function ScathachSpellEFunctionDisplaceDummy )

				if MUIDistance( 102, 103 ) <= 150 then
					call PlaySoundWithVolume( LoadSound( "ScathachR1" ), 100, 0 )
					call ForGroup( LoadGroupHandle( HashTable, HandleID, 111 ), function ScathachSpellEFunctionRemoveUnits )
					call PauseUnit( MUIUnit( 100 ), true )
					call SetUnitAnimation( MUIUnit( 100 ), "spell Seven" )
					call DestroyGroup( LoadGroupHandle( HashTable, HandleID, 111 ) )
					call SaveBoolean( HashTable, HandleID, 10, true )
				endif
				
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 45 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 500, .4, .01, false, false, "origin", DashEff( ) )
				call AddEffect( "GeneralEffects\\t_huobao.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ), 90 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1., MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell four" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 85 then
				call PlaySoundWithVolume( LoadSound( "ScathachR2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
				call SetUnitPathing( MUIUnit( 100 ), true )
				call AddEffect( "GeneralEffects\\OrbOfFire.mdl", 2, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
				call SaveUnitHandle( HashTable, HandleID, 106, LoadUnit( "DummyUnit" ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime >= 85 then
				call SaveLocationHandle( HashTable, HandleID, 109, GetUnitLoc( MUIUnit( 106 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 115, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 116, CreateLocation( MUILocation( 109 ), 50, MUIAngle( 109, 115 ) ) )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call SetUnitPositionLoc( MUIUnit( 106 ), MUILocation( 116 ) )
				call FaceLocation( MUIUnit( 106 ), MUILocation( 115 ), 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 109 ) ) )
				
				if MUIDistance( 115, 116 ) <= 100 then
					call KillUnit( MUIUnit( 106 ) )
					call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 109 ), 600, Filter( function ScathachSpellEFunction2 ) )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					set i = 1

					loop
						exitwhen i > 10
						call AddEffect( "GeneralEffects\\t_huobao.mdl", .5, MUILocation( 103 ), 36 * i, 0 )
						set i = i + 1
					endloop

					call ClearAllData( HandleID )
				else
					call RemoveLocation( MUILocation( 109 ) )
					call RemoveLocation( MUILocation( 115 ) )
					call RemoveLocation( MUILocation( 116 ) )
				endif
			endif
		else
			call ForGroup( LoadGroupHandle( HashTable, HandleID, 111 ), function ScathachSpellEFunctionRemoveUnits )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ScathachSpellEFunction4 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveBoolean( HashTable, HandleID, 10, false )
		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellEFunction3 )
	endfunction

	function ScathachSpellRFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A043'
	endfunction

	function ScathachSpellRFunction2 takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ScathachE1" ), 80, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 25 + MUIPower( ) * 0.17 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .2, .01, false, false, "origin", DashEff( ) )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Two" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 25 or LocTime == 100 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 103 ), 50, MUIAngle( 103, 102 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 25 + MUIPower( ) * 0.17 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1 + .1 * GetRandomInt( 3, 5 ), MUILocation( 107 ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 107 ), MUIDistance( 102, 107 ), .2, .01, false, true, "origin", "" )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 150, .25, .01, false, false, "origin", "" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
				call RemoveLocation( MUILocation( 107 ) )
			endif
			
			if LocTime == 25 then
				call StunUnit( MUIUnit( 101 ), 2 )
				call MakeUnitAirborne( MUIUnit( 101 ), 500, 2000 )
			endif
			
			if LocTime == 50 then
				call SetUnitFlyHeight( MUIUnit( 101 ), 0, 750 )
			endif
			
			if LocTime == 75 then
				call SetUnitFlyHeight( MUIUnit( 101 ), 0, 500 )
			endif
			
			if LocTime == 105 or LocTime == 110 then
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 25 + MUIPower( ) * 0.17 )
			endif
			
			if LocTime == 125 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 25 + MUIPower( ) * 0.17 )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 50, .25, .01, false, false, "origin", "" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellRFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellRFunction2 )
	endfunction

	function ScathachSpellTFunction1 takes nothing returns boolean
		return GetSpellAbilityId( ) == 'A044'
	endfunction

	function ScathachSpellTLinearMovementAction takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call SetUnitPositionLoc( GetFilterUnit( ), MUILocation( 109 ) )
		endif

		return true
	endfunction

	function ScathachSpellTAoEDamageAction takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call StunUnit( GetFilterUnit( ), 1 )
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", MUILevel( ) * 300 + MUIPower( ) )
		endif

		return true
	endfunction

	function ScathachSpellTFunction2 takes nothing returns nothing
		local real    i			= 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call AddEffect( "GeneralEffects\\ShockWaveRed.mdl", 2, MUILocation( 102 ), 0, 0 )
				call PlaySoundWithVolume( LoadSound( "ScathachQ1" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Three" )
				call MUIDummy( 106, 'u001', 102, MUIAngle( 102, 103 ) )
				call MUISaveEffect( 150, "Effects\\Scathach\\Spear.mdl", 106 )
				call ScaleUnit( MUIUnit( 106 ), 2 )
				call SetUnitVertexColor( MUIUnit( 106 ), 128, 0, 0, 100 )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call RemoveLocation( MUILocation( 102 ) )
			endif

			if LocTime > 1 and LocTime <= 100 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call ScaleUnit( MUIUnit( 106 ), 1 + LoadReal( HashTable, HandleID, 110 ) / 50 )
				call RemoveLocation( MUILocation( 102 ) )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "ScathachT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Four" )
				call RemoveLocation( MUILocation( 102 ) )
			endif

			if LocTime >= 100 then
				call SaveLocationHandle( HashTable, HandleID, 107, GetUnitLoc( MUIUnit( 106 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( 107 ), 50, MUIAngle( 107, 103 ) ) )
				call SetUnitPositionLoc( MUIUnit( 106 ), MUILocation( 109 ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 107 ) ) )
				call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 400, Filter( function ScathachSpellTLinearMovementAction ) )

				if MUIDistance( 103, 109 ) <= 100 then
					call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
					call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 107 ), 450, Filter( function ScathachSpellTAoEDamageAction ) )
					set i = 1

					loop
						exitwhen i > 4
						call AddEffect( "GeneralEffects\\t_huobao.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ), 0 )
						call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 255, 255, 200 )
						set i = i + 1
					endloop

					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodCircle.mdl", MUILocation( 103 ) ) )
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 103 ) ) )
					call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 103 ) ) )
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction

	function ScathachSpellTFunction3 takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
		call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
		call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellTFunction2 )
	endfunction

	function HeroInit8 takes nothing returns nothing
		call SaveSound( "ScathachQ1", "Scathach\\SpellQ1.mp3" )
		call SaveSound( "ScathachQ2", "Scathach\\SpellQ2.mp3" )
		call SaveSound( "ScathachQ3", "Scathach\\SpellQ3.mp3" )
		call SaveSound( "ScathachW1", "Scathach\\SpellW1.mp3" )
		call SaveSound( "ScathachE1", "Scathach\\SpellE1.mp3" )
		call SaveSound( "ScathachR1", "Scathach\\SpellR1.mp3" )
		call SaveSound( "ScathachR2", "Scathach\\SpellR2.mp3" )
		call SaveSound( "ScathachT1", "Scathach\\SpellT1.mp3" )

		call SaveTrig( "ScathachTrigQ1" )
		call GetUnitEvent( LoadTrig( "ScathachTrigQ1" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ScathachTrigQ1" ), Condition( function ScathachSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "ScathachTrigQ1" ), function ScathachSpellQFunction3 )

		call SaveTrig( "ScathachTrigQ2" )
		call GetUnitEvent( LoadTrig( "ScathachTrigQ2" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ScathachTrigQ2" ), Condition( function ScathachSpellQSecondFunction1 ) )
		call TriggerAddAction( LoadTrig( "ScathachTrigQ2" ), function ScathachSpellQSecondFunction3 )

		call SaveTrig( "ScathachTrigQ3" )
		call GetUnitEvent( LoadTrig( "ScathachTrigQ3" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ScathachTrigQ3" ), Condition( function ScathachSpellQThirdFunction1 ) )
		call TriggerAddAction( LoadTrig( "ScathachTrigQ3" ), function ScathachSpellQThirdFunction3 )

		call SaveTrig( "ScathachTrigW" )
		call GetUnitEvent( LoadTrig( "ScathachTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ScathachTrigW" ), Condition( function ScathachSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "ScathachTrigW" ), function ScathachSpellWFunction4 )

		call SaveTrig( "ScathachTrigE" )
		call GetUnitEvent( LoadTrig( "ScathachTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ScathachTrigE" ), Condition( function ScathachSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "ScathachTrigE" ), function ScathachSpellRFunction3 )

		call SaveTrig( "ScathachTrigR" )
		call GetUnitEvent( LoadTrig( "ScathachTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ScathachTrigR" ), Condition( function ScathachSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "ScathachTrigR" ), function ScathachSpellEFunction4 )

		call SaveTrig( "ScathachTrigT" )
		call GetUnitEvent( LoadTrig( "ScathachTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ScathachTrigT" ), Condition( function ScathachSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "ScathachTrigT" ), function ScathachSpellTFunction3 )
	endfunction	

