	function SaberNeroSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroQ1" ), 100, 0 )
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call CCUnit( MUIUnit( 100 ), .7, "Stun", false )
				call AddEffectXY( "GeneralEffects\\Dash\\Effect1.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ), 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .5, .01, false, true, "origin", DashEff( ) )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
			endif

			if LocTime == 50 then
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, GetReal( "Angle" ), "Effect" )
				call AddMultipleEffectsXY( 2, "Effects\\SaberNero\\FireCut.mdl", 2.5, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0, 255, 255, 255, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, .3, .01, 0, DashEff( ) )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 400, "AoE", "Physical", 250 + MUIPower( 1. ), false, "", 0 )
			endif

			if LocTime == 60 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberNeroSpellW takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroW1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .5, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "attack slam" )
			endif

			if LocTime == 40 then
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\LightningStrike1.mdl", GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ) ) )
				call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 2, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )

				loop
					exitwhen i > 4
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( 2, 3 ), GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, .25, .01, 0, DashEff( ) )
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 450, "AoE", "Physical", 250 + MUIPower( 1. ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberNeroSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime 	= MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CCUnit( MUIUnit( 100 ), 1.6, "Stun", false )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw Two" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .25, .01, false, false, "origin", "" )
			endif

			if LocTime == 50 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 70 + MUIPower( .4 ) )
				call PlaySoundWithVolume( LoadSound( "SaberNeroE1" ), 100, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw One" )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\LightningStrike1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
			endif

			if LocTime == 100 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call AddMultipleEffectsXY( 3, "Effects\\SaberNero\\FireCut.mdl", 2.5, GetReal( "TargetX" ), GetReal( "TargetY" ), GetUnitFacing( MUIUnit( 100 ) ), 0, 255, 255, 255, 255 )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 350, .5, .01, false, false, "origin", DashEff( ) )
			endif

			if LocTime == 120 then
				call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 70 + MUIPower( .4 ) )
			endif

			if LocTime == 150 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function SaberNeroSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroR1" ), 100, 0 )
				call SaveReal( HashTable, HandleID, 110, 800 )
				call CCUnit( MUIUnit( 100 ), 2., "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell One" )
				call InitSpiralXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, 15, 800, "Abilities\\Spells\\Other\\Doom\\DoomDeath.mdl" )
			endif

			if LocTime < 80 then
				call SpiralMovement( HandleID )
			endif
			
			if LocTime == 80 then
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) / 3, 1, .01, false, false, "origin", DashEff( ) )
			endif
			
			if LocTime == 130 then
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) * .6, .6, .01, 600 )
				call SetUnitAnimation( MUIUnit( 100 ), "attack slam" )
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 2, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 45 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1., GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
			endif
			
			if LocTime == 185 then
				call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 6, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )

				loop
					exitwhen i > 4
					call AddEffectXY( "GeneralEffects\\ValkDust50.mdl", 6, GetReal( "SpellX" ), GetReal( "SpellY" ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				set i = 1

				loop
					exitwhen i > 12
					call CreateXY( GetReal( "SpellX" ), GetReal( "SpellY" ), 200, 30 * i, "Effect" )
					call SaveUnit( "DummyUnit", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u008', GetReal( "EffectX" ), GetReal( "EffectY" ), 0 ) )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 0, 255 )

					call CreateXY( GetReal( "SpellX" ), GetReal( "SpellY" ), 400, 30 * i, "Effect" )
					call SaveUnit( "DummyUnit", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u008', GetReal( "EffectX" ), GetReal( "EffectY" ), 0 ) )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 0, 255 )

					call CreateXY( GetReal( "SpellX" ), GetReal( "SpellY" ), 600, 30 * i, "Effect" )
					call SaveUnit( "DummyUnit", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u008', GetReal( "EffectX" ), GetReal( "EffectY" ), 0 ) )
					call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1 )
					call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 100, 0, 255 )
					set i = i + 1
				endloop

				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 200, 1., .01, 1000, DashEff( ) )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 800, "AoE", "Physical", 250 + MUIPower( .8 ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function SaberNeroSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A036' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A037' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellW )
		endif

		if GetSpellAbilityId( ) == 'A038' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellR )
		endif

		if GetSpellAbilityId( ) == 'A039' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellE )
		endif
		
		return false
	endfunction	

	function HeroInit5 takes nothing returns nothing
		call SaveSound( "SaberNeroQ1", "SaberNero\\SpellQ1.mp3" )
		call SaveSound( "SaberNeroW1", "SaberNero\\SpellW1.mp3" )
		call SaveSound( "SaberNeroE1", "SaberNero\\SpellE1.mp3" )
		call SaveSound( "SaberNeroR1", "SaberNero\\SpellR1.mp3" )
		call TriggerAddCondition( LoadTrig( "RemoveInvisTrig" ), Condition( function SaberNeroSpells ) )
	endfunction	

