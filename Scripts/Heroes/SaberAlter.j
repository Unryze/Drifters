	function SaberAlterSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .6, "Stun", false )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
				call PlaySoundWithVolume( LoadSound( "SaberAlterQ1" ), 100, 0 )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterQ2" ), 100, 0 )
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Distance" ) / 2, GetReal( "Angle" ), "Effect" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffectXY( "Effects\\SaberAlter\\LinearSlashBlack1.mdl", 3, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 75, 0, 130, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), -200, .5, .01, 0, DashEff( ) )
			endif

			if LocTime >= 25 then
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, "AoE", "Physical", 250 + MUIPower( 1. ), false, "Stun", 1 )
			endif

			if LocTime == 50 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAlterSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterW1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .5, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Two" )
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call AddEffectXY( "Effects\\SaberAlter\\DarkExplosion.mdl", .4, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .4, .01, 600 )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterW2" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterW3" ), 100, 0 )
				call AddEffectXY( "Effects\\SaberAlter\\DarkExplosion.mdl", .75, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\LightningStrike1.mdl", .75, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2.5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, "AoE", "Physical", 150 + MUIPower( 1. ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAlterSpellE takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
		else
			call RemoveUnit( MUIUnit( 101 ) )
		endif
		
		if LocTime == 1 then
			call PlaySoundWithVolume( LoadSound( "SaberAlterE1" ), 100, 0 )
			call CCUnit( MUIUnit( 100 ), .7, "Stun", false )
			call SetUnitAnimation( MUIUnit( 100 ), "spell Five" )
			call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
			call SaveUnitHandle( HashTable, HandleID, 101, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u001', GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ) ) )
			call SetUnitXAndY( MUIUnit( 101 ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 150, GetReal( "Angle" ) )
		endif

		if LocTime == 60 then
			call PlaySoundWithVolume( LoadSound( "SaberAlterE2" ), 100, 0.5 )
			call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
		endif

		if LocTime > 60 then
			call SaveReal( HashTable, HandleID, StringHash( "MoveDist" ), GetReal( "MoveDist" ) + 150 )
			call DestroyEffect( AddSpecialEffect( "Effects\\SaberAlter\\ShadowBurstBig.mdl", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
			call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), .1, 1, .01, 400, "" )
			call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 450, "AoE", "Physical", MUIPower( 1. ), false, "Stun", 1 )
			call SetUnitXAndY( MUIUnit( 101 ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 150, GetReal( "Angle" ) )
			if GetReal( "MoveDist" ) >= 1500. or UnitLife( MUIUnit( 100 ) ) <= 0 then
				call RemoveUnit( MUIUnit( 101 ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAlterSpellR takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), 1.1, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Channel One" )
				call PlaySoundWithVolume( LoadSound( "SaberAlterR1" ), 100, 0 )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( MUIUnit( 100 ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( MUIUnit( 100 ) ) )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberAlter\\ShadowBurst.mdl", MUIUnit( 100 ), "weapon" ) )
			endif

			if LocTime == 1 or LocTime == 10 then
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call AddEffectXY( "Effects\\SaberAlter\\DarkExplosion.mdl", .5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
			endif

			if LocTime == 100 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell Channel Two" )
				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterR3" ), 100, 0 )
				call AddEffectXY( "Effects\\SaberAlter\\DarkWave.mdl", 1, GetReal( "CasterX" ), GetReal( "CasterY" ), GetUnitFacing( MUIUnit( 100 ) ), 0 )
			endif

			if LocTime >= 100 then
				call SaveReal( HashTable, HandleID, StringHash( "GetPosition" ), GetReal( "GetPosition" ) + 100 )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "GetPosition" ), GetUnitFacing( MUIUnit( 100 ) ), "Effect" )

				if LoadReal( HashTable, HandleID, 112 ) >= 4 then
					call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 2, GetReal( "EffectX" ), GetReal( "EffectY" ), 0, 0 )
					call SaveReal( HashTable, HandleID, 112, 0 )
				else
					call SaveReal( HashTable, HandleID, 112, LoadReal( HashTable, HandleID, 112 ) + 1 )
				endif

				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 500, "AoE", "Physical", MUIPower( 1. ), false, "", 0 )

				if GetReal( "GetPosition" ) >= 3000 then
					call ClearAllData( HandleID )
				endif
			endif
		endif
	endfunction
	
	function SaberAlterSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A051' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif		
		
		if GetSpellAbilityId( ) == 'A052' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A053' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellE )
		endif

		if GetSpellAbilityId( ) == 'A054' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellR )
		endif

		return false
	endfunction	

	function HeroInit4 takes nothing returns nothing
		call SaveSound( "SaberAlterD1", "SaberAlter\\SpellD1.mp3" )
		call SaveSound( "SaberAlterQ1", "SaberAlter\\SpellQ1.mp3" )
		call SaveSound( "SaberAlterQ2", "SaberAlter\\SpellQ2.mp3" )
		call SaveSound( "SaberAlterW1", "SaberAlter\\SpellW1.mp3" )
		call SaveSound( "SaberAlterW2", "SaberAlter\\SpellW2.mp3" )
		call SaveSound( "SaberAlterW3", "SaberAlter\\SpellW3.mp3" )
		call SaveSound( "SaberAlterE1", "SaberAlter\\SpellE1.mp3" )
		call SaveSound( "SaberAlterE2", "SaberAlter\\SpellE2.mp3" )
		call SaveSound( "SaberAlterR1", "SaberAlter\\SpellR1.mp3" )
		call SaveSound( "SaberAlterR2", "SaberAlter\\SpellR2.mp3" )
		call SaveSound( "SaberAlterR3", "SaberAlter\\SpellR3.mp3" )
		call TriggerAddCondition( LoadTrig( "RemoveInvisTrig" ), Condition( function SaberAlterSpells ) )
	endfunction	

