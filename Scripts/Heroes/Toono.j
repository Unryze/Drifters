	function ToonoShikiSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .4, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call PlaySoundWithVolume( LoadSound( "NanayaQ1" ), 100, 0 )
			endif
			
			if LocTime == 25 then
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Distance" ) / 2, GetReal( "Angle" ), "Effect" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), -200, .5, .01, 0, DashEff( ) )
			endif

			if LocTime >= 25 then
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
			endif			

			if LocTime == 30 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell four" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if StopSpell( HandleID, 0 ) == false then
			if LoadInteger( HashTable, HandleID, 110 ) < 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoW1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .8, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) + 1 )
			call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 150, GetUnitFacing( MUIUnit( 100 ) ), "Effect" )
			call AddEffectXY( "Effects\\Nanaya\\Sensa1.mdl", 2, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetUnitFacing( MUIUnit( 100 ) ) + GetRandomReal( -45, 45 ), 0 )
			call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 200, 200, 255, 255 )
			call KillUnit( LoadUnit( "DummyUnit" ) )
			call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 350, "AoE", "Physical", MUILevel( ) * 5 + MUIPower( ) * 0.033, true, "", 0 )

			if LoadInteger( HashTable, HandleID, 110 ) >= 30 then
				call SetUnitAnimation( MUIUnit( 100 ), "stand" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoE2" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CCUnit( MUIUnit( 100 ), 1., "Stun" )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call SetUnitTimeScale( MUIUnit( 100 ), 2.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.25, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) + 50, .2, .01, false, false, "origin", DashEff( ) )
				call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "ToonoE1" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell five" )
			endif

			if LocTime == 70 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 60, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ) - 180, 300, .25, .01, false, false, "origin", DashEff( ) )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 500 + MUILevel( ) * 75 + MUIPower( ) )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 45, 0 )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) - 45, 0 )
			endif

			if LocTime == 90 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

		if StopSpell( HandleID, 0 ) == false and LocTime < 160 then
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoR1" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 250, .1, .015, false, false, "origin", DashEff( ) )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call CCUnit( MUIUnit( 100 ), 1.2, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel five" )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.5, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddMultipleEffectsXY( 5, "GeneralEffects\\ValkDust.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0, 255, 255, 255, 255 )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 150, .2, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 325 + MUILevel( ) * 32.5 + MUIPower( ) * 0.20 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
			endif

			if LocTime == 40 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 250, .1, .01, false, false, "origin", DashEff( ) )
			endif
			
			if LocTime == 60 then
				call PlaySoundWithVolume( LoadSound( "ToonoR2" ), 100, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
			endif
			
			if LocTime == 110 then
				call CCUnit( MUIUnit( 100 ), 1., "Stun" )
				call SetUnitTimeScale( MUIUnit( 100 ), 3 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )	
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.25, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 750 + MUILevel( ) * 60 + MUIPower( ) * 0.25 )
				call MakeUnitAirborne( MUIUnit( 100 ), 800, 2000 )
				call MakeUnitAirborne( MUIUnit( 101 ), 800, 2000 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), 200, .4, .01, false, false, "origin", "" )
				call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 200, .4, .01, false, false, "origin", "" )
			endif
		endif

		if LocTime == 160 then
			call PlaySoundWithVolume( LoadSound( "ToonoR3" ), 100, 0 )
			call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
			call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
			call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 45 )
			call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 900, 99999 )
			call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.25, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 180, 45 )
			call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 900, 99999 )
			call SetUnitFlyHeight( MUIUnit( 100 ), 0, 3000 )
			call SetUnitFlyHeight( MUIUnit( 101 ), 0, 3000 )
			call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), 200, .25, .01, false, false, "origin", "" )
			call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 200, .25, .01, false, false, "origin", "" )
			call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 750 + MUILevel( ) * 60 + MUIPower( ) * 0.25 )
			call SetUnitAnimation( MUIUnit( 100 ), "spell channel four" )
		endif

		if LocTime == 200 then
			call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
			call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
			set i = 1

			loop
				exitwhen i > 4
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( .5, 2 ), GetReal( "CasterX" ), GetReal( "CasterY" ), i * 90, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( .5, 2 ), GetReal( "TargetX" ), GetReal( "TargetY" ), i * 90, 0 )
				set i = i + 1
			endloop

			call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 600, "AoE", "Physical", 500 + MUILevel( ) * 40 + MUIPower( ) * 0.50, false, "Stun", 1 )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ToonoShikiSpellT takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoE2" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), 1.4, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell one" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call SetUnitPathing( MUIUnit( 100 ), false )
			endif

			if LocTime == 90 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "ToonoT1" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 200, GetReal( "Angle" ), "Move" )
				call SetUnitPosition( MUIUnit( 100 ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), 400, .4, .01, false, false, "origin", DashEff( ) )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call AddMultipleEffectsXY( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, GetReal( "TargetX" ), GetReal( "TargetY" ), 270, 0, 255, 255, 255, 255 )

				loop
					exitwhen i > 17
					if i <= 8 then
						call AddEffectXY( "GeneralEffects\\ValkDust.mdl", .8 + i * 2 / 10, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
					endif
					call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetRandomReal( 0, 360 ), 0 )
					call DisplaceUnitWithArgs( LoadUnit( "DummyUnit" ), GetUnitFacing( LoadUnit( "DummyUnit" ) ), GetRandomReal( 200, 800 ), .1, .01, 0 )
					set i = i + 1
				endloop

				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 3000 + MUILevel( ) * 300 + MUIPower( ) )
				call SaveReal( HashTable, HandleID, 110, 0 )
			endif
			
			if LocTime == 130 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A02X' then
			call PlaySoundWithVolume( LoadSound( "ToonoD1" ), 100, 0 )
		endif

		if GetSpellAbilityId( ) == 'A02U' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A02V' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call TimerStart( LoadMUITimer( LocPID ), .025, true, function ToonoShikiSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A02W' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellE )
		endif

		if GetSpellAbilityId( ) == 'A02Y' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellR )
		endif

		if GetSpellAbilityId( ) == 'A02Z' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellT )
		endif

		return false
	endfunction	

	function HeroInit2 takes nothing returns nothing
		call SaveSound( "ToonoD1", "Toono\\SpellD1.mp3" )
		call SaveSound( "ToonoW1", "Toono\\SpellW1.mp3" )
		call SaveSound( "ToonoE1", "Toono\\SpellE1.mp3" )
		call SaveSound( "ToonoE2", "Toono\\SpellE2.mp3" )
		call SaveSound( "ToonoR1", "Toono\\SpellR1.mp3" )
		call SaveSound( "ToonoR2", "Toono\\SpellR2.mp3" )
		call SaveSound( "ToonoR3", "Toono\\SpellR3.mp3" )
		call SaveSound( "ToonoT1", "Toono\\SpellT1.mp3" )
		call SaveSound( "ToonoT2", "Toono\\SpellT2.mp3" )
		
		call SaveTrig( "ToonoShikiSpells" )
		call GetUnitEvent( LoadTrig( "ToonoShikiSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ToonoShikiSpells" ), Condition( function ToonoShikiSpells ) )
	endfunction	

