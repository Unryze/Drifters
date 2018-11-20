	function RyougiSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiQ1" ), 80, 0 )
				call CCUnit( GetUnit( "Source" ), .3, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell channel four" )
				call SetUnitTimeScale( GetUnit( "Source" ), 1.5 )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call SetUnitTimeScale( GetUnit( "Source" ), 1 )
				call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 100, GetUnitFacing( GetUnit( "Source" ) ), "Effect" )
				call SaveReal( HashTable, HandleID, StringHash( "DummyHeight" ), 50 )
				call AddMultipleEffectsXY( 5, "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, GetReal( "EffectX" ), GetReal( "EffectY" ), GetUnitFacing( GetUnit( "Source" ) ), 0, 65, 235, 245, 255 )
				call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 200, GetUnitFacing( GetUnit( "Source" ) ), "Effect" )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 300, .5, .01, 150, "" )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 300, "AoE", "Physical", 240 + GetPower( 1. ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiW1" ), 100, 0 )
				call CCUnit( GetUnit( "Source" ), .5, "Stun", false )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
				call CreateDistanceAndAngle( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), "Spell" )
				call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ), .4, .01, false, true, "origin", "" )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Channel Slam" )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call ResetAbilityCooldown( GetUnit( "Source" ), 'A032' )
				call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 200, GetUnitFacing( GetUnit( "Source" ) ), "Effect" )
				call AddMultipleEffectsXY( 5, "GeneralEffects\\FireSlashSlow\\FireSlashSlowVertical.mdl", 4, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetUnitFacing( GetUnit( "Source" ) ), 0, 65, 235, 245, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 150, .2, .01, 0, DashEff( ) )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 400, "AoE", "Physical", 250 + GetPower( 1. ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 1 ) == false then
			call SpellTime( )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiE1" ), 80, 0 )
				call CCUnit( GetUnit( "Source" ), .85, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell channel five" )
				call AddEffectXY( "GeneralEffects\\BlackBlink.mdl", .5, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 270, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 0, 0 )
			endif

			if LocTime == 25 then
				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 100, GetReal( "Angle" ), "Move" )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 1000 + GetPower( .5 ) )
				call SetUnitPosition( GetUnit( "Source" ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetReal( "Angle" ), 0 )
			endif

			if LocTime == 50 then
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call SetUnitAnimation( GetUnit( "Source" ), "spell slam one" )
			endif

			if LocTime == 75 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 1000 + GetPower( .5 ) )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call AddMultipleEffectsXY( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 270, 0, 255, 255, 255, 255 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ) ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function RyougiSpellR takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 1 ) == false then
			if LoadBoolean( HashTable, HandleID, 10 ) == false then
				if LocTime < 1 then
					call SaveInteger( HashTable, HandleID, 0, 1 )
					call SaveInteger( HashTable, HandleID, 1, 1 )
					call CCUnit( GetUnit( "Source" ), .4, "Stun", false )
					call SetUnitPathing( GetUnit( "Source" ), false )
					call SetUnitAnimation( GetUnit( "Source" ), "spell channel three" )
					call PlaySoundWithVolume( LoadSound( "RyougiD1" ), 100, 0 )
					call SetUnitPathing( GetUnit( "Source" ), false )
				endif

				call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), 40, GetReal( "Angle" ), "Move" )
				call DestroyEffect( AddSpecialEffect( DashEff( ), GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
				call SetUnitPosition( GetUnit( "Source" ), GetReal( "MoveX" ), GetReal( "MoveY" ) )

				if DistanceBetweenAxis( GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "MoveX" ), GetReal( "MoveY" ) ) <= 600 then
					call CCUnit( GetUnit( "Source" ), 1.1, "Stun", false )
					call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
					call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.75, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
					call PlaySoundWithVolume( LoadSound( "RyougiR1" ), 100, 0 )
					call LinearDisplacement( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) + 200, .2, .01, false, false, "origin", DashEff( ) )
					call SetUnitAnimation( GetUnit( "Source" ), "spell channel four" )
					call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 1500 + GetPower( .5 ) )
					call CCUnit( GetUnit( "Target" ), .5, "Stun", true )
					call SaveBoolean( HashTable, HandleID, 10, true )
					call SaveReal( HashTable, HandleID, StringHash( "DummyHeight" ), 50 )
				endif
			else
				if LoadInteger( HashTable, HandleID, 1 ) < 31 then
					call SaveInteger( HashTable, HandleID, 1, LoadInteger( HashTable, HandleID, 1 ) + 1 )
					call AddMultipleEffectsXY( 3, "Effects\\Toono\\LinearSlashBlue1.mdl", 1, GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 9 * LoadInteger( HashTable, HandleID, 1 ), 0, 255, 255, 255, 255 )
					call PlaySoundWithVolume( LoadSound( "RyougiR2" ), 100, 0 )
				else
					call SpellTime( )
				endif

				if LoadInteger( HashTable, HandleID, 1 ) == 30 then
					call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
					call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
					call DisplaceUnitWithArgs( GetUnit( "Source" ), GetReal( "Angle" ), GetReal( "Distance" ) + 200, .8, .01, 250 )
					call SetUnitAnimation( GetUnit( "Source" ), "spell" )
				endif

				if LocTime == 60 then
					call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 70, 0 )
					call CreateTargetXY( HandleID, GetUnit( "Source" ), GetUnit( "Target" ) )
					call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
					call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
					call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 1500 + GetPower( .5 ) )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) + 45, 0 )
					call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 2, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ) - 45, 0 )
				endif

				if LocTime == 110 then
					call ClearAllData( HandleID )
				endif
			endif			
		endif
	endfunction

	function RyougiSpells takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A033' then
			call PlaySoundWithVolume( LoadSound( "RyougiD1" ), 60, 0 )
		endif
		
		if GetSpellAbilityId( ) == 'A032' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellQ )
		endif
		
		if GetSpellAbilityId( ) == 'A031' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A034' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellE )
		endif		
		
		if GetSpellAbilityId( ) == 'A035' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, false )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellR )
		endif
	endfunction	

	function HeroInit3 takes nothing returns nothing
		call SaveSound( "RyougiD1", "Ryougi\\SpellD1.mp3" )
		call SaveSound( "RyougiQ1", "Ryougi\\SpellQ1.mp3" )
		call SaveSound( "RyougiW1", "Ryougi\\SpellW1.mp3" )
		call SaveSound( "RyougiE1", "Ryougi\\SpellE1.mp3" )
		call SaveSound( "RyougiR1", "Ryougi\\SpellR1.mp3" )
		call SaveSound( "RyougiR2", "Ryougi\\SpellR2.mp3" )
		call TriggerAddAction( LoadTrig( "AllHeroSpells" ), function RyougiSpells )
	endfunction	

