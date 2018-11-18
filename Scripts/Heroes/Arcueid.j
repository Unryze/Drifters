	function ArcueidSpellQ takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidQ1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .3, "Stun", false )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell One" )
			endif

			if LocTime == 20 then
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, GetUnitFacing( MUIUnit( 100 ) ), "Spell" )
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), -300, .5, .01, 250, "" )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, "AoE", "Physical", 70 + MUIPower( 1. ), false, "Stun", 1 )				
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )
		local integer i = 1

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidW1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .5, "Stun", false )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Five" )
			endif

			if LocTime == 10 then
				loop
					exitwhen i == 3
					call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1, 2 ), GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop
			endif
				
			if LocTime == 25 then
				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, .15, .01, 0, "" )
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 450, "AoE", "Physical", 60 + MUIPower( 1. ), false, "", 0 )
			endif
			
			if LocTime == 40 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellE takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidE1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .35, "Stun", false )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\BlackBlink.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Two" )
			endif

			if LocTime == 15 then
				call ShowUnit( MUIUnit( 100 ), false )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "SlamSound1" ), 60, 0 )
				call SetUnitPosition( MUIUnit( 100 ), GetReal( "SpellX" ), GetReal( "SpellY" ) )
				call ShowUnit( MUIUnit( 100 ), true )
				call UnitSelect( MUIUnit( 100 ) )
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 400, "AoE", "Physical", MUIPower( 1. ), false, "Stun", 1 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )

				loop
					exitwhen i == 3
					call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1, 2 ), GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ArcueidSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidR1" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CCUnit( MUIUnit( 100 ), .9, "Stun", false )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Slam" )
			endif

			if LocTime == 15 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", 1.5, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUIPower( .5 ) )
				call MakeUnitAirborne( MUIUnit( 101 ), 600, 4000 )
			endif

			if LocTime == 25 then
				call AddEffectXY( "GeneralEffects\\BlackBlink.mdl", 1.5, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
			endif

			if LocTime == 30 then
				call MakeUnitAirborne( MUIUnit( 100 ), 700, 4000 )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Two" )
			endif
		endif

		if LocTime == 60 then
			call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUIPower( .5 ) )
			call SetUnitFlyHeight( MUIUnit( 101 ), 0, 2000 )
			call SetUnitFlyHeight( MUIUnit( 100 ), 0, 99999 )
			call SaveReal( HashTable, HandleID, StringHash( "Angle" ), MUIAngleData( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
			call LinearDisplacement( MUIUnit( 101 ), GetReal( "Angle" ), 250, .2, .01, false, false, "origin", "" )
		endif

		if LocTime == 80 then
			call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 1.5, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 0, 0 )

			loop
				exitwhen i == 3
				call AddEffectXY( "GeneralEffects\\ValkDust150.mdl", GetRandomReal( 1.5, 2 ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), GetRandomReal( 0, 360 ), 0 )
				set i = i + 1
			endloop

			call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 400, "AoE", "Physical", MUIPower( .5 ), false, "Stun", 1 )
			call ClearAllData( HandleID )
		endif
	endfunction

	function ArcueidSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A003' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellQ )
		endif
		
		if GetSpellAbilityId( ) == 'A004' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellW )
		endif
		
		if GetSpellAbilityId( ) == 'A005' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellE )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A006' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellR )
		endif

		return false
	endfunction	

	function HeroInit11 takes nothing returns nothing
		call SaveSound( "ArcueidQ1", "Arcueid\\SpellQ1.mp3" )
		call SaveSound( "ArcueidW1", "Arcueid\\SpellW1.mp3" )
		call SaveSound( "ArcueidE1", "Arcueid\\SpellE1.mp3" )
		call SaveSound( "ArcueidR1", "Arcueid\\SpellR1.mp3" )
		call TriggerAddCondition( LoadTrig( "RemoveInvisTrig" ), Condition( function ArcueidSpells ) )
	endfunction

