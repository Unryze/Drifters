	function ResetScathachQ takes nothing returns nothing
		call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A057', true )
		call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A055', false )
		call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A056', false )
	endfunction

	function ScathachSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime 	= MUIInteger( 0 )

		if UnitLife( MUIUnit( 100 ) ) > 0 and UnitLife( MUIUnit( 101 ) ) > 0 then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .65, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachQ3" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 45 )
			endif

			if LocTime == 20 then
				if GetUnitLevel( MUIUnit( 100 ) ) >= 5 then
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A057', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A055', true )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A056', false )
				endif

				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .35, .01, false, true, "origin", DashEff( ) )
			endif

			if LocTime == 55 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
				call AddEffectXY( "GeneralEffects\\OrbOfFire.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUIPower( .5 ) )
			endif
		endif

		if LocTime == 300 or UnitLife( MUIUnit( 100 ) ) <= 0 or UnitLife( MUIUnit( 101 ) ) <= 0 then
			call ResetScathachQ( )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ScathachSpellQSecond takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		
		if UnitLife( MUIUnit( 100 ) ) > 0 and UnitLife( MUIUnit( 101 ) ) > 0 then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .35, "Stun", false )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call PlaySoundWithVolume( LoadSound( "ScathachQ2" ), 100, 0 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, true, "origin", DashEff( ) )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Seven" )
			endif

			if LocTime == 20 then
				if GetUnitLevel( MUIUnit( 100 ) ) >= 8 then
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A057', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A055', false )
					call SetPlayerAbilityAvailable( GetOwningPlayer( MUIUnit( 100 ) ), 'A056', true )
				endif

				call AddEffectXY( "GeneralEffects\\BigFireSlam.mdl", .25, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 0, 0 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 50 + MUIPower( .5 ) )
			endif
		endif

		if LocTime == 300 or UnitLife( MUIUnit( 100 ) ) <= 0 or UnitLife( MUIUnit( 101 ) ) <= 0 then
			call ResetScathachQ( )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ScathachSpellQThird takes nothing returns nothing
		local integer HandleID  = MUIHandle( )	
		local integer LocTime   = MUIInteger( 0 )
		
		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .55, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachQ1" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Three" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, true, "origin", DashEff( ) )
			endif

			if LocTime == 20 then
				call ResetScathachQ( )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Four" )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\FireSlamSmall.mdl", MUIUnit( 101 ), "chest" ) )
			endif
			
			if LocTime == 45 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 200, .25, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUIPower( .5 ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .6, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachW1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Throw" )
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .5, .01, 600 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ) ) )
				call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "ScathachQ3" ), 100, 0 )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 400, "AoE", "Physical", 250 + MUIPower( 1. ), false, "Stun", 1 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\LightningStrike1.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\SlamEffect.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), 1.35, "Stun", false )
				call PlaySoundWithVolume( LoadSound( "ScathachE1" ), 80, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUIPower( .17 ) )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, false, "origin", DashEff( ) )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Two" )
			endif

			if LocTime == 25 or LocTime == 100 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUIPower( .17 ) )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), 150, .2, .01, false, true, "origin", "" )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 150, .25, .01, false, false, "origin", "" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1 + .1 * GetRandomInt( 3, 5 ), GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
			endif

			if LocTime == 25 then
				call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
				call MakeUnitAirborne( MUIUnit( 101 ), 500, 2000 )
				call PlaySoundWithVolume( LoadSound( "ScathachE2" ), 80, 0 )
			endif
			
			if LocTime == 50 then
				call SetUnitFlyHeight( MUIUnit( 101 ), 0, 750 )
			endif

			if LocTime == 75 then
				call SetUnitFlyHeight( MUIUnit( 101 ), 0, 500 )
			endif
			
			if LocTime == 105 or LocTime == 110 then
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUIPower( .17 ) )
			endif
			
			if LocTime == 125 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUIPower( .17 ) )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 50, .25, .01, false, false, "origin", "" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ScathachSpellR takes nothing returns nothing
		local real    i			= 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), 1.1, "Stun", false )
				call AddEffectXY( "GeneralEffects\\ShockWaveRed.mdl", 2, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call PlaySoundWithVolume( LoadSound( "ScathachQ1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Three" )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call MUIDummyXY( 106, 'u001', GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ) )
				call MUISaveEffect( 150, "Effects\\Scathach\\Spear.mdl", 106 )
				call ScaleUnit( MUIUnit( 106 ), 2 )
				call SetUnitVertexColor( MUIUnit( 106 ), 128, 0, 0, 100 )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call SetUnitFlyHeight( MUIUnit( 106 ), 150, 99999 )
			endif

			if LocTime > 1 and LocTime <= 100 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
				call ScaleUnit( MUIUnit( 106 ), 1 + LoadReal( HashTable, HandleID, 110 ) / 50 )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "ScathachR1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Four" )
				call SimpleMovement( HandleID, "Effect", 1 )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( MUIUnit( 100 ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( MUIUnit( 100 ) ) )
			endif

			if LocTime >= 100 then
				call SaveReal( HashTable, HandleID, StringHash( "Distance" ), GetReal( "Distance" ) + 50 )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Distance" ), GetReal( "Angle" ), "Effect" )
				call SetUnitPosition( MUIUnit( 106 ), GetReal( "EffectX" ), GetReal( "EffectY" ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 400, "", "", 0, true, "", 0 )

				if GetReal( "Distance" ) >= 3000 then
					call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
					call RemoveUnit( MUIUnit( 106 ) )
					call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 450, "AoE", "Physical", MUIPower( 1. ), false, "Stun", 1 )
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

	function ScathachSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A057' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A055' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQSecond )
		endif

		if GetSpellAbilityId( ) == 'A056' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellQThird )
		endif		

		if GetSpellAbilityId( ) == 'A058' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A059' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellE )
		endif		

		if GetSpellAbilityId( ) == 'A060' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellR )
		endif

		return false
	endfunction

	function HeroInit8 takes nothing returns nothing
		call SaveSound( "ScathachQ1", "Scathach\\SpellQ1.mp3" )
		call SaveSound( "ScathachQ2", "Scathach\\SpellQ2.mp3" )
		call SaveSound( "ScathachQ3", "Scathach\\SpellQ3.mp3" )
		call SaveSound( "ScathachW1", "Scathach\\SpellW1.mp3" )
		call SaveSound( "ScathachE1", "Scathach\\SpellE1.mp3" )
		call SaveSound( "ScathachE2", "Scathach\\SpellE2.mp3" )
		call SaveSound( "ScathachR1", "Scathach\\SpellR1.mp3" )
		call TriggerAddCondition( LoadTrig( "RemoveInvisTrig" ), Condition( function ScathachSpells ) )
	endfunction	

