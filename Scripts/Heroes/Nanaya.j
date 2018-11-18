	function NanayaSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .4, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
				call PlaySoundWithVolume( LoadSound( "NanayaQ1" ), 100, 0 )
			endif
			
			if LocTime == 25 then
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Distance" ) / 2, GetReal( "Angle" ), "Effect" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffectXY( "Effects\\Nanaya\\LinearSlash1.mdl", 3, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), -200, .5, .01, 0, DashEff( ) )
			endif

			if LocTime >= 25 then
				if GetUnitAbilityLevel( MUIUnit( 100 ), 'B001' ) > 0 then
					call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, "AoE", "Physical", ( 250 + MUIPower( 1. ) ) * 1.5, false, "Stun", 1 )
				else
					call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, "AoE", "Physical", 250 + MUIPower( 1. ), false, "", 0 )
				endif
			endif			

			if LocTime == 30 then
				call UnitRemoveAbility( MUIUnit( 100 ), 'B001' )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function NanayaSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if StopSpell( HandleID, 0 ) == false then
			if LoadInteger( HashTable, HandleID, 110 ) < 1 then
				call PlaySoundWithVolume( LoadSound( "NanayaW1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .8, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) + 1 )
			call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 150, GetUnitFacing( MUIUnit( 100 ) ), "Effect" )
			call AddEffectXY( "Effects\\Nanaya\\Sensa1.mdl", 2, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetUnitFacing( MUIUnit( 100 ) ) + GetRandomReal( -45, 45 ), 0 )
			call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 255, 255 )
			call KillUnit( LoadUnit( "DummyUnit" ) )
			if GetUnitAbilityLevel( MUIUnit( 100 ), 'B001' ) > 0 then
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 350, "AoE", "Physical", ( MUIPower( .033 ) ) * 1.5, true, "", 0 )
			else
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 350, "AoE", "Physical", MUIPower( .033 ), true, "", 0 )
			endif

			if LoadInteger( HashTable, HandleID, 110 ) >= 30 then
				call UnitRemoveAbility( MUIUnit( 100 ), 'B001' )
				call SetUnitAnimation( MUIUnit( 100 ), "stand" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function NanayaSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
		
		if LocTime == 1 then
			call CCUnit( MUIUnit( 100 ), .6, "Stun", false )
			call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
			call PlaySoundWithVolume( LoadSound( "NanayaR2" ), 90, 0 )
		endif

		if GetUnitAbilityLevel( MUIUnit( 100 ), 'B001' ) > 0 then
			if StopSpell( HandleID, 0 ) == false and LocTime < 125 then
				if LocTime == 25 then
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 150, GetReal( "Angle" ), "Move" )
					call SetUnitPosition( MUIUnit( 100 ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
					call SetUnitFacing( MUIUnit( 100 ), GetReal( "Angle" ) )
					call SetUnitAnimation( MUIUnit( 100 ), "spell two alternate" )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				endif

				if LocTime == 50 then
					call CCUnit( MUIUnit( 100 ), 1., "Stun", false )
					call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
					call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.5, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 45 )
					call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
					call MakeUnitAirborne( MUIUnit( 101 ), 800, 4000 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUIPower( 1. ) )
					call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 300, .4, .01, false, false, "origin", "" )
				endif

				if LocTime == 75 then
					call PlaySoundWithVolume( LoadSound( "NanayaE1" ), 100, 0 )
					call MakeUnitAirborne( MUIUnit( 100 ), 600, 4000 )
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), -200, GetReal( "Angle" ), "Move" )
					call SetUnitAnimation( MUIUnit( 100 ), "spell throw three" )
					call SetUnitPosition( MUIUnit( 100 ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
					call SetUnitFacing( MUIUnit( 100 ), GetReal( "Angle" ) )
				endif
			endif

			if LocTime == 125 then
				call PlaySoundWithVolume( LoadSound( "NanayaE2" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUIPower( .5 ) )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.25, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 180, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 800, 99999 )
				call SetUnitFlyHeight( MUIUnit( 101 ), 0, 2000 )
				call SetUnitFlyHeight( MUIUnit( 100 ), 0, 99999 )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 400, .4, .01, false, false, "origin", "" )
			endif

			if LocTime == 150 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 1.5, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw two" )
				call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 500, "AoE", "Physical", 250 + MUIPower( .5 ), false, "Stun", 1 )
				call UnitRemoveAbility( MUIUnit( 100 ), 'B001' )
				call ClearAllData( HandleID )
			endif
		else
			if StopSpell( HandleID, 0 ) == false then
				if LocTime == 50 then
					call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
					call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 300, GetReal( "Angle" ), "Move" )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUIPower( 1. ) )
					call SetUnitPosition( MUIUnit( 100 ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
					call AddEffectXY( "Effects\\Nanaya\\LinearSlash1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 45, 0 )
					call AddEffectXY( "Effects\\Nanaya\\LinearSlash1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) - 45, 0 )
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction

	function NanayaSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "NanayaT1" ), 100, 0 )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A020' )
				call CCUnit( MUIUnit( 100 ), 2.3, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw four" )
			endif
			
			if LocTime == 20 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), -( 600 - GetReal( "Distance" ) ), ( 600 - GetReal( "Distance" ) ) / 1000, .01, false, false, "origin", "" )
			endif

			if LocTime == 100 then
				call PlaySoundWithVolume( LoadSound( "NanayaT2" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 45 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.25, GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Angle" ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw five" )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 200, 1, .01, 400 )

				set i = 1

				loop
					exitwhen i > 15
					call SaveUnit( "DummyUnit", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u007', GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Angle" ) ) )
					call DisplaceUnitWithArgs( LoadUnit( "DummyUnit" ), GetReal( "Angle" ), GetReal( "Distance" ) - 200, 1 + .1 * i, .01, 400 )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitAnimation( LoadUnit( "DummyUnit" ), "spell throw five" )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 255, 255, ( 255 - ( 25 * i ) ) )
					set i = i + 1
				endloop		
			endif

			if LocTime == 200 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "NanayaR2" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 150, GetReal( "Angle" ), "Move" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
				call SetUnitPosition( MUIUnit( 100 ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
				call SetUnitFacing( MUIUnit( 100 ), GetReal( "Angle" ) )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), 400, .2, .01, false, false, "origin", DashEff( ) )
				call AddMultipleEffectsXY( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, GetReal( "TargetX" ), GetReal( "TargetY" ), 270, 0, 255, 255, 255, 255 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.25, GetReal( "MoveX" ), GetReal( "MoveY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.25, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )

				set i = 1

				loop
					exitwhen i > 4
					call AddEffectXY( "Effects\\Nanaya\\LinearSlash2.mdl", 3, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + Pow( -1, I2R( i ) ) * 30, 0 )
					set i = i + 1
				endloop

				call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 4000 + MUIPower( 1. ) )
			endif

			if LocTime == 220 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function NanayaSpellT takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )

		if StopSpell( HandleID, 0 ) == false then
			if IsCounted == true then
				call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			endif
			
			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), 1.9, "Stun", false )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A020' )
				call SetUnitAnimation( MUIUnit( 100 ), "stand" )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "NanayaT3" ), 100, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), .25 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one alternate" )
			endif
			
			if LocTime == 90 then
				call SetUnitTimeScale( MUIUnit( 100 ), 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call MUIDummyXY( 106, 'u001', GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Angle" ) )
				call MUISaveEffect( 104, "Effects\\Nanaya\\Knife.mdl", 106 )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call SetUnitFlyHeight( MUIUnit( 106 ), 100, 99999 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
				call SaveBoolean( HashTable, HandleID, 10, false )
			endif

			if IsCounted == false then
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Distance" ), DistanceBetweenAxis( GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), GetUnitX( MUIUnit( 106 ) ), GetUnitY( MUIUnit( 106 ) ) ) )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( MUIUnit( 106 ) ), GetUnitY( MUIUnit( 106 ) ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call CreateXY( GetUnitX( MUIUnit( 106 ) ), GetUnitY( MUIUnit( 106 ) ), GetReal( "Distance" ) *.1, GetReal( "Angle" ), "Knife" )
				call SetUnitPosition( MUIUnit( 106 ), GetReal( "KnifeX" ), GetReal( "KnifeY" ) )
				call SetUnitFacing( MUIUnit( 106 ), GetReal( "Angle" ) )
				
				if GetReal( "Distance" ) <= 75 then
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
					call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 150, GetReal( "Angle" ), "Effect" )
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.25, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
					call DestroyEffect( MUIEffect( 104 ) )
					call RemoveUnit( MUIUnit( 106 ) )
					call MakeUnitAirborne( MUIUnit( 100 ), 200, 99999 )
					call SetUnitPathing( MUIUnit( 100 ), false )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
					call SetUnitPosition( MUIUnit( 100 ), GetReal( "TargetX" ), GetReal( "TargetY" ) )
					call SaveUnitHandle( HashTable, HandleID, 20, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u007', GetReal( "EffectX" ), GetReal( "EffectY" ), GetUnitFacing( MUIUnit( 100 ) ) ) )
					call SetUnitAnimation( MUIUnit( 20 ), "spell slam three" )
					call SetUnitVertexColor( MUIUnit( 20 ), 255, 255, 255, 180 )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl",GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
					call SaveBoolean( HashTable, HandleID, 10, true )
				endif
			endif
			
			if LocTime == 130 then
				call RemoveUnit( MUIUnit( 20 ) )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call SetUnitFlyHeight( MUIUnit( 100 ), 0, 99999 )
				call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), 300, .4, .01, false, false, "origin", DashEff( ) )
				call AddEffectXY( "GeneralEffects\\BloodEffect1.mdl", 1, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call AddMultipleEffectsXY( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, GetReal( "TargetX" ), GetReal( "TargetY" ), 270, 0, 255, 255, 255, 255 )
				call AddEffectXY( "Effects\\Nanaya\\LinearSlash1.mdl", 3, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 45, 0 )
				call AddEffectXY( "Effects\\Nanaya\\LinearSlash1.mdl", 3, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0 )
				call AddEffectXY( "Effects\\Nanaya\\LinearSlash1.mdl", 3, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) - 45, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell throw six" )
			endif
			
			if LocTime == 160 then
				call CCUnit( MUIUnit( 101 ), 2, "Stun", true )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 400 + MUIPower( 1. ) )
			endif
			
			if LocTime == 180 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function NanayaSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A020' then
			call PlaySoundWithVolume( LoadSound( "NanayaD1" ), 90, 0 )
		endif

		if GetSpellAbilityId( ) == 'A017' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A018' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call TimerStart( LoadMUITimer( LocPID ), .025, true, function NanayaSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A019' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaSpellE )
		endif

		if GetSpellAbilityId( ) == 'A021' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaSpellR )
		endif

		if GetSpellAbilityId( ) == 'A022' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, true )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function NanayaSpellT )
		endif

		return false
	endfunction	

	function HeroInit1 takes nothing returns nothing
		call SaveSound( "NanayaD1", "Nanaya\\SpellD1.mp3" )
		call SaveSound( "NanayaQ1", "Nanaya\\SpellQ1.mp3" )
		call SaveSound( "NanayaW1", "Nanaya\\SpellW1.mp3" )
		call SaveSound( "NanayaE1", "Nanaya\\SpellE1.mp3" )
		call SaveSound( "NanayaE2", "Nanaya\\SpellE2.mp3" )
		call SaveSound( "NanayaR1", "Nanaya\\SpellR1.mp3" )
		call SaveSound( "NanayaR2", "Nanaya\\SpellR2.mp3" )
		call SaveSound( "NanayaT1", "Nanaya\\SpellT1.mp3" )
		call SaveSound( "NanayaT2", "Nanaya\\SpellT2.mp3" )
		call SaveSound( "NanayaT3", "Nanaya\\SpellT3.mp3" )
		call TriggerAddCondition( LoadTrig( "RemoveInvisTrig" ), Condition( function NanayaSpells ) )
	endfunction	

