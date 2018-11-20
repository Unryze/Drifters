	function ResetScathachQ takes nothing returns nothing
		call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A057', true )
		call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A055', false )
		call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A056', false )
	endfunction

	function ScathachSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime 	= GetInt( "SpellTime" )

		if UnitLife( GetUnit( "Source" ) ) > 0 and UnitLife( GetUnit( "Target" ) ) > 0 then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), .65, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachQ3" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "Attack" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 45 )
			endif

			if LocTime == 20 then
				if GetUnitLevel( GetUnit( "Source" ) ) >= 5 then
					call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A057', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A055', true )
					call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A056', false )
				endif

				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .35, .01, false, true, "origin", DashEff( ) )
			endif

			if LocTime == 55 then
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call AddEffectXY( "GeneralEffects\\OrbOfFire.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 100 + GetPower( .5 ) )
			endif
		endif

		if LocTime == 300 or UnitLife( GetUnit( "Source" ) ) <= 0 or UnitLife( GetUnit( "Target" ) ) <= 0 then
			call ResetScathachQ( )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ScathachSpellQSecond takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )
		
		if UnitLife( GetUnit( "Source" ) ) > 0 and UnitLife( GetUnit( "Target" ) ) > 0 then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), .35, "Stun", false )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call PlaySoundWithVolume( LoadSound( "ScathachQ2" ), 100, 0 )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, true, "origin", DashEff( ) )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Seven" )
			endif

			if LocTime == 20 then
				if GetUnitLevel( GetUnit( "Source" ) ) >= 8 then
					call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A057', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A055', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( GetUnit( "Source" ) ), 'A056', true )
				endif

				call AddEffectXY( "GeneralEffects\\BigFireSlam.mdl", .25, GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 0, 0 )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 50 + GetPower( .5 ) )
			endif
		endif

		if LocTime == 300 or UnitLife( GetUnit( "Source" ) ) <= 0 or UnitLife( GetUnit( "Target" ) ) <= 0 then
			call ResetScathachQ( )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ScathachSpellQThird takes nothing returns nothing
		local integer HandleID  = MUIHandle( )	
		local integer LocTime   = GetInt( "SpellTime" )
		
		if StopSpell( HandleID, 1 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), .55, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachQ1" ), 100, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Three" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, true, "origin", DashEff( ) )
			endif

			if LocTime == 20 then
				call ResetScathachQ( )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Four" )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\FireSlamSmall.mdl", GetUnit( "Target" ), "chest" ) )
			endif
			
			if LocTime == 45 then
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), 200, .25, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 100 + GetPower( .5 ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), .6, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachW1" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell Throw" )
				call CreateDistanceAndAngle( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), "Spell" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call DisplaceUnitWithArgs( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ), .5, .01, 600 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ) ) )
				call SaveEffectHandle( HashTable, HandleID, StringHash( "Effect0" ), AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", GetUnit( "Source" ), "weapon" ) )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "ScathachQ3" ), 100, 0 )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 400, "AoE", "Physical", 250 + GetPower( 1. ), false, "Stun", 1 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\LightningStrike1.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\SlamEffect.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 1 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), 1.35, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachE1" ), 80, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", GetPower( .17 ) )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, false, "origin", DashEff( ) )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call SetUnitTimeScale( GetUnit( "Source" ), 1.5 )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Two" )
			endif

			if LocTime == 25 or LocTime == 100 then
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", GetPower( .17 ) )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), 150, .2, .01, false, true, "origin", "" )
				call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), 150, .25, .01, false, false, "origin", "" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1 + .1 * GetRandomInt( 3, 5 ), GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
			endif

			if LocTime == 25 then
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call MakeUnitAirborne( GetUnit( "Target" ), 500, 2000 )
				call PlaySoundWithVolume( LoadSound( "ScathachE2" ), 80, 0 )
			endif
			
			if LocTime == 50 then
				call SetUnitFlyHeight( GetUnit( "Target" ), 0, 750 )
			endif

			if LocTime == 75 then
				call SetUnitFlyHeight( GetUnit( "Target" ), 0, 500 )
			endif
			
			if LocTime == 105 or LocTime == 110 then
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", GetPower( .17 ) )
			endif
			
			if LocTime == 125 then
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", GetPower( .17 ) )
				call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), 50, .25, .01, false, false, "origin", "" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellR takes nothing returns nothing
		local real    i			= 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), 1.1, "Stun", false )
				call AddEffectXY( "GeneralEffects\\ShockWaveRed.mdl", 2, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call PlaySoundWithVolume( LoadSound( "ScathachQ1" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell Three" )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call GetDummyXY( "Dummy1", 'u001', GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "Angle" ) )
				call SaveEffect( "Effect1", "Effects\\Scathach\\Spear.mdl", "Dummy1" )
				call ScaleUnit( GetUnit( "Dummy1" ), 2 )
				call SetUnitVertexColor( GetUnit( "Dummy1" ), 128, 0, 0, 100 )
				call SetUnitPathing( GetUnit( "Dummy1" ), false )
				call SetUnitFlyHeight( GetUnit( "Dummy1" ), 150, 99999 )
			endif

			if LocTime > 1 and LocTime <= 100 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
				call ScaleUnit( GetUnit( "Dummy1" ), 1 + LoadReal( HashTable, HandleID, 110 ) / 50 )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "ScathachR1" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell Four" )
				call SimpleMovement( HandleID, "Effect", 1 )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( GetUnit( "Source" ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( GetUnit( "Source" ) ) )
			endif

			if LocTime >= 100 then
				call SaveReal( HashTable, HandleID, StringHash( "Distance" ), GetReal( "Distance" ) + 50 )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Distance" ), GetReal( "Angle" ), "Effect" )
				call SetUnitPosition( GetUnit( "Dummy1" ), GetReal( "EffectX" ), GetReal( "EffectY" ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 400, "", "", 0, true, "", 0 )

				if GetReal( "Distance" ) >= 3000 then
					call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
					call RemoveUnit( GetUnit( "Dummy1" ) )
					call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 450, "AoE", "Physical", GetPower( 1. ), false, "Stun", 1 )
					set i = 1

					loop
						exitwhen i > 4
						call AddEffectXY( "GeneralEffects\\BigFireSlam.mdl", 2, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
						call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 255, 255, 200 )
						set i = i + 1
					endloop

					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodCircle.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction

	function ScathachSpells takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A057' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A055' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQSecond )
		endif

		if GetSpellAbilityId( ) == 'A056' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQThird )
		endif		

		if GetSpellAbilityId( ) == 'A058' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A059' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellE )
		endif		

		if GetSpellAbilityId( ) == 'A060' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellR )
		endif
	endfunction

	function HeroInit8 takes nothing returns nothing
		call SaveSound( "ScathachQ1", "Scathach\\SpellQ1.mp3" )
		call SaveSound( "ScathachQ2", "Scathach\\SpellQ2.mp3" )
		call SaveSound( "ScathachQ3", "Scathach\\SpellQ3.mp3" )
		call SaveSound( "ScathachW1", "Scathach\\SpellW1.mp3" )
		call SaveSound( "ScathachE1", "Scathach\\SpellE1.mp3" )
		call SaveSound( "ScathachE2", "Scathach\\SpellE2.mp3" )
		call SaveSound( "ScathachR1", "Scathach\\SpellR1.mp3" )
		call TriggerAddAction( LoadTrig( "AllHeroSpells" ), function ScathachSpells )
	endfunction	

