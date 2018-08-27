	function AkainuSpellD takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if GetUnitAbilityLevel( MUIUnit( 100 ), 'B04H' ) > 0 then
			call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, "AoE", "Physical", MUILevel( ) * 12.5 + MUIPower( ) * 0.1, true, "", 0 )
		else
			call ClearAllData( HandleID )
		endif
	endfunction

	function AkainuSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .35, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call PlaySoundWithVolume( LoadSound( "AkainuR2" ), 90, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call MakeUnitAirborne( MUIUnit( 100 ), 100, 9999 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .25, .01, false, true, "origin", "Effects\\Akainu\\MagmaBlast.mdl" )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "AkainuR1" ), 90, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call AddEffectXY( "Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", 2, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), GetReal( "Angle" ) + 90, 0 )
				call AddEffectXY( "GeneralEffects\\t_huobao.mdl", 1.5, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), GetReal( "Angle" ), 90 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 100, 99999 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 175 + MUILevel( ) * 25 + MUIPower( ) * 0.5 )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 300, .4, .01, false, false, "origin", DashEff( ) )
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 300, "AoE", "Physical", 175 + MUILevel( ) * 25 + MUIPower( ) * 0.5, false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkainuSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkainuE1" ), 90, 0 )
				call CCUnit( MUIUnit( 100 ), .6, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one" )
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\NewDirtEx.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .4, .01, 600 )
			endif
			
			if LocTime == 40 then
				call AddEffectXY( "GeneralEffects\\LightningStrike1.mdl", 1., GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 1.5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "Effects\\Akainu\\MagmaBlast.mdl", 1, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 350, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
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
				call CCUnit( MUIUnit( 100 ), .3, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
			endif

			if LocTime == 20 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
				call AddEffectXY( "Effects\\Akainu\\MagmaWolf.mdl", 1., GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ), 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				call SetUnitPathing( LoadUnit( "DummyUnit" ), false )
				call SaveUnitHandle( HashTable, HandleID, 106, LoadUnit( "DummyUnit" ) )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call AddEffectXY( "Effects\\Akainu\\MagmaBlast.mdl", .25, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				call SetUnitPathing( LoadUnit( "DummyUnit" ), false )
				call SaveUnitHandle( HashTable, HandleID, 126, LoadUnit( "DummyUnit" ) )
				call SetUnitPathing( MUIUnit( 126 ), false )
			endif

			if LocTime > 20 then
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetUnitX( MUIUnit( 106 ) ), GetUnitY( MUIUnit( 106 ) ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call SetUnitXAndY( MUIUnit( 106 ), GetUnitX( MUIUnit( 106 ) ), GetUnitY( MUIUnit( 106 ) ), 40, GetReal( "Angle" ) )
				call SetUnitXAndY( MUIUnit( 126 ), GetUnitX( MUIUnit( 126 ) ), GetUnitY( MUIUnit( 126 ) ), 40, GetReal( "Angle" ) )

				if LocTime == 21 or LocTime == 25 or LocTime == 30 or LocTime == 35 or LocTime == 40 or LocTime == 45 or LocTime == 50 then
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1., GetUnitX( MUIUnit( 126 ) ), GetUnitY( MUIUnit( 126 ) ), 0, 90 )
					call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 120, 99999 )
				endif

				if DistanceBetweenAxis( GetUnitX( MUIUnit( 106 ) ), GetUnitY( MUIUnit( 106 ) ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) <= 150 then
					call KillUnit( MUIUnit( 106 ) )
					call KillUnit( MUIUnit( 126 ) )
					call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
					call AddEffectXY( "Abilities\\Weapons\\DemolisherFireMissile\\DemolisherFireMissile.mdl", 2, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), GetReal( "Angle" ) + 90, 0 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
					call ClearAllData( HandleID )
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
				call CCUnit( MUIUnit( 100 ), .25, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
				call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( MUIUnit( 100 ) ) )
				call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( MUIUnit( 100 ) ) )
			endif

			if LocTime == 20 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), 300, GetReal( "Angle" ), "Effect" )
				call AddEffectXY( "Effects\\Akainu\\LinearMagmaHand.mdl", 2, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
				call PlaySoundWithVolume( LoadSound( "AkainuR2" ), 60, 0 )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			if LocTime > 20 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 100 )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), LoadReal( HashTable, HandleID, 110 ), GetReal( "Angle" ), "Effect" )

				loop
					exitwhen i > 2
					call SaveReal( HashTable, HandleID, StringHash( "Random" ), GetRandomReal( 0, 360 ) )
					call CreateXY( GetReal( "EffectX" ), GetReal( "EffectY" ), GetRandomReal( 0, 500 ), GetReal( "Random" ), "Flame" )
					call DestroyEffect( AddSpecialEffect( "abilities\\weapons\\catapult\\catapultmissile.mdl", GetReal( "FlameX" ), GetReal( "FlameY" ) ) )
					call AddEffectXY( "Effects\\Akainu\\MagmaBlast.mdl", .25, GetReal( "FlameX" ), GetReal( "FlameY" ), GetReal( "Random" ), 0 )
					set i = i + 1
				endloop

				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 500, "AoE", "Physical", MUILevel( ) * 100 + MUIPower( ), false, "", 0 )

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

			if LocTime > 10 then
				call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )
				call SaveReal( HashTable, HandleID, StringHash( "Random" ), GetRandomReal( 0, 360 ) )
				call CreateXY( GetReal( "SpellX" ), GetReal( "SpellY" ), GetRandomReal( 0, 550 ), GetReal( "Random" ), "Effect" )
				call AddEffectXY( "Effects\\Akainu\\VerticalMagmaHand.mdl", .65, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Random" ), 0 )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .5 )

				if LocCount > 7 then
					call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 500, "AoE", "Physical", MUILevel( ) * 25 + MUIPower( ) * 0.05, true, "", 0 )
				endif
			endif

			if LocTime == 70 then
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
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
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
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkainuSpellR )
		endif
		
		if GetSpellAbilityId( ) == 'A04E' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
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

