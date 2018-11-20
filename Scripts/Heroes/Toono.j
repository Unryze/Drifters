	function ToonoShikiSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), .4, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell three" )
				call PlaySoundWithVolume( LoadSound( "NanayaQ1" ), 100, 0 )
			endif
			
			if LocTime == 25 then
				call CreateDistanceAndAngle( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), "Spell" )
				call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "Distance" ) / 2, GetReal( "Angle" ), "Effect" )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), -200, .5, .01, 0, DashEff( ) )
			endif

			if LocTime >= 25 then
				call AoEDamageXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 200, "AoE", "Physical", 250 + GetPower( 1. ), false, "", 0 )
			endif			

			if LocTime == 30 then
				call SetUnitAnimation( GetUnit( "Source" ), "spell four" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if StopSpell( HandleID, 0 ) == false then
			if LoadInteger( HashTable, HandleID, 110 ) < 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoW1" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), .8, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell two" )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) + 1 )
			call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 150, GetUnitFacing( GetUnit( "Source" ) ), "Effect" )
			call AddEffectXY( "Effects\\Nanaya\\Sensa1.mdl", 2, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetUnitFacing( GetUnit( "Source" ) ) + GetRandomReal( -45, 45 ), 0 )
			call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 200, 200, 255, 255 )
			call KillUnit( LoadUnit( "DummyUnit" ) )
			call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 350, "AoE", "Physical", GetPower( .033 ), true, "", 0 )

			if LoadInteger( HashTable, HandleID, 110 ) >= 30 then
				call SetUnitAnimation( GetUnit( "Source" ), "stand" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 1 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoE2" ), 100, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CCUnit( GetUnit( "Source" ), 1., "Stun", false )
				call SetUnitPathing( GetUnit( "Source" ), false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell channel three" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.25, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) + 150, .2, .01, false, false, "origin", DashEff( ) )
				call DestroyEffect( AddSpecialEffect( "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageCaster.mdl", GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
			endif

			if LocTime == 25 then
				call SetUnitTimeScale( GetUnit( "Source" ), 2.5 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell five" )
				call PlaySoundWithVolume( LoadSound( "ToonoE1" ), 100, 0 )
			endif

			if LocTime == 70 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 60, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), 300, .25, .01, false, false, "origin", DashEff( ) )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 500 + GetPower( 1. ) )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 45, 0 )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) - 45, 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		call SpellTime( )

		if StopSpell( HandleID, 0 ) == false and LocTime < 160 then
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoR1" ), 100, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) - 250, .1, .015, false, false, "origin", DashEff( ) )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call CCUnit( GetUnit( "Source" ), 1.2, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell channel five" )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.5, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddMultipleEffectsXY( 5, "GeneralEffects\\ValkDust.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0, 255, 255, 255, 255 )
				call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), 150, .2, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 32.5 + GetPower( .2 ) )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
			endif

			if LocTime == 40 then
				call SetUnitAnimation( GetUnit( "Source" ), "spell channel three" )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) - 250, .1, .01, false, false, "origin", DashEff( ) )
			endif
			
			if LocTime == 60 then
				call PlaySoundWithVolume( LoadSound( "ToonoR2" ), 100, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell channel one" )
			endif
			
			if LocTime == 110 then
				call CCUnit( GetUnit( "Source" ), 1., "Stun", false )
				call SetUnitTimeScale( GetUnit( "Source" ), 3 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )	
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.25, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 45 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 60 + GetPower( .25 ) )
				call MakeUnitAirborne( GetUnit( "Source" ), 800, 2000 )
				call MakeUnitAirborne( GetUnit( "Target" ), 800, 2000 )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), 200, .4, .01, false, false, "origin", "" )
				call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), 200, .4, .01, false, false, "origin", "" )
			endif
		endif

		if LocTime == 160 then
			call PlaySoundWithVolume( LoadSound( "ToonoR3" ), 100, 0 )
			call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
			call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
			call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 45 )
			call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 900, 99999 )
			call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.25, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 180, 45 )
			call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 900, 99999 )
			call SetUnitFlyHeight( GetUnit( "Source" ), 0, 3000 )
			call SetUnitFlyHeight( GetUnit( "Target" ), 0, 3000 )
			call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), 200, .25, .01, false, false, "origin", "" )
			call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), 200, .25, .01, false, false, "origin", "" )
			call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 60 + GetPower( .25 ) )
			call SetUnitAnimation( GetUnit( "Source" ), "spell channel four" )
		endif

		if LocTime == 200 then
			call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
			call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
			set i = 1

			loop
				exitwhen i > 4
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( .5, 2 ), GetReal( "CasterX" ), GetReal( "CasterY" ), i * 90, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( .5, 2 ), GetReal( "TargetX" ), GetReal( "TargetY" ), i * 90, 0 )
				set i = i + 1
			endloop

			call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 600, "AoE", "Physical", 40 + GetPower( .5 ), false, "Stun", 1 )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ToonoShikiSpellT takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 1 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ToonoE2" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), 1.4, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell one" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call SetUnitPathing( GetUnit( "Source" ), false )
			endif

			if LocTime == 90 then
				call PlaySoundWithVolume( LoadSound( "GlassShatter1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "ToonoT1" ), 100, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 200, GetReal( "Angle" ), "Move" )
				call SetUnitPosition( GetUnit( "Source" ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), 400, .4, .01, false, false, "origin", DashEff( ) )
				call SetUnitPathing( GetUnit( "Source" ), false )
				call AddMultipleEffectsXY( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, GetReal( "TargetX" ), GetReal( "TargetY" ), 270, 0, 255, 255, 255, 255 )

				loop
					exitwhen i > 17
					if i <= 8 then
						call AddEffectXY( "GeneralEffects\\ValkDust.mdl", .8 + i * 2 / 10, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
					endif
					call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetRandomReal( 0, 360 ), 0 )
					call DisplaceUnitWithArgs( LoadUnit( "DummyUnit" ), GetUnitFacing( LoadUnit( "DummyUnit" ) ), GetRandomReal( 200, 800 ), .1, .01, 0 )
					set i = i + 1
				endloop

				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 3000 + GetPower( 1. ) )
				call SaveReal( HashTable, HandleID, 110, 0 )
			endif
			
			if LocTime == 130 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ToonoShikiSpells takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A027' then
			call PlaySoundWithVolume( LoadSound( "ToonoD1" ), 100, 0 )
		endif

		if GetSpellAbilityId( ) == 'A024' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A025' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
				call TimerStart( LoadMUITimer( LocPID ), .025, true, function ToonoShikiSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A026' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellE )
		endif

		if GetSpellAbilityId( ) == 'A028' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellR )
		endif

		if GetSpellAbilityId( ) == 'A029' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ToonoShikiSpellT )
		endif
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
		call TriggerAddAction( LoadTrig( "AllHeroSpells" ), function ToonoShikiSpells )
	endfunction	

