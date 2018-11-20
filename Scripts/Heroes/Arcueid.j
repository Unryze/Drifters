	function ArcueidSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidQ1" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), .3, "Stun", false )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell One" )
			endif

			if LocTime == 20 then
				call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 300, GetUnitFacing( GetUnit( "Source" ) ), "Spell" )
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), -300, .5, .01, 250, "" )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, "AoE", "Physical", 70 + GetPower( 1. ), false, "Stun", 1 )				
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )
		local integer i = 1

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidW1" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), .5, "Stun", false )
				call SetUnitTimeScale( GetUnit( "Source" ), 1.75 )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Five" )
			endif

			if LocTime == 10 then
				loop
					exitwhen i == 3
					call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1, 2 ), GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop
			endif
				
			if LocTime == 25 then
				call AoEDisplaceXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 200, .15, .01, 0, "" )
				call AoEDamageXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 450, "AoE", "Physical", 60 + GetPower( 1. ), false, "", 0 )
			endif
			
			if LocTime == 40 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellE takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidE1" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), .35, "Stun", false )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\BlackBlink.mdl", 1, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call SetUnitAnimation( GetUnit( "Source" ), "Attack Two" )
			endif

			if LocTime == 15 then
				call ShowUnit( GetUnit( "Source" ), false )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "SlamSound1" ), 60, 0 )
				call SetUnitPosition( GetUnit( "Source" ), GetReal( "SpellX" ), GetReal( "SpellY" ) )
				call ShowUnit( GetUnit( "Source" ), true )
				call UnitSelect( GetUnit( "Source" ) )
				call AoEDamageXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 400, "AoE", "Physical", GetPower( 1. ), false, "Stun", 1 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )

				loop
					exitwhen i == 3
					call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1, 2 ), GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidR1" ), 100, 0 )
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CCUnit( GetUnit( "Source" ), .9, "Stun", false )
				call SetUnitTimeScale( GetUnit( "Source" ), 1.75 )
				call SetUnitAnimation( GetUnit( "Source" ), "Attack Slam" )
			endif

			if LocTime == 15 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", GetPower( .5 ) )
				call MakeUnitAirborne( GetUnit( "Target" ), 600, 4000 )
			endif

			if LocTime == 25 then
				call AddEffectXY( "GeneralEffects\\BlackBlink.mdl", 1.5, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
			endif

			if LocTime == 30 then
				call MakeUnitAirborne( GetUnit( "Source" ), 700, 4000 )
				call SetUnitAnimation( GetUnit( "Source" ), "Attack Two" )
			endif
		endif

		if LocTime == 60 then
			call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", GetPower( .5 ) )
			call SetUnitFlyHeight( GetUnit( "Target" ), 0, 2000 )
			call SetUnitFlyHeight( GetUnit( "Source" ), 0, 99999 )
			call SaveReal( HashTable, HandleID, StringHash( "Angle" ), MUIAngleData( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ) ) )
			call LinearDisplacement( GetUnit( "Target" ), GetReal( "Angle" ), 250, .2, .01, false, false, "origin", "" )
		endif

		if LocTime == 80 then
			call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 1.5, GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 0, 0 )

			loop
				exitwhen i == 3
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1.5, 2 ), GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), GetRandomReal( 0, 360 ), 0 )
				set i = i + 1
			endloop

			call AoEDamageXY( HandleID, GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 400, "AoE", "Physical", GetPower( .5 ), false, "Stun", 1 )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ArcueidSpells takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A003' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellQ )
		endif
		
		if GetSpellAbilityId( ) == 'A004' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellW )
		endif
		
		if GetSpellAbilityId( ) == 'A005' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellE )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A006' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellR )
		endif
	endfunction	

	function HeroInit11 takes nothing returns nothing
		call SaveSound( "ArcueidQ1", "Arcueid\\SpellQ1.mp3" )
		call SaveSound( "ArcueidW1", "Arcueid\\SpellW1.mp3" )
		call SaveSound( "ArcueidE1", "Arcueid\\SpellE1.mp3" )
		call SaveSound( "ArcueidR1", "Arcueid\\SpellR1.mp3" )
		call TriggerAddAction( LoadTrig( "AllHeroSpells" ),function ArcueidSpells )
	endfunction

