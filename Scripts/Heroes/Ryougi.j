	function RyougiSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiW1" ), 80, 0 )
				call CCUnit( MUIUnit( 100 ), .3, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel four" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, GetUnitFacing( MUIUnit( 100 ) ), "Effect" ) 
				call AddMultipleEffectsXY( 5, "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, GetReal( "EffectX" ), GetReal( "EffectY" ), GetUnitFacing( MUIUnit( 100 ) ), 0, 65, 235, 245, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, .5, .01, 150, "" )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 300, "AoE", "Physical", 240 + MUILevel( ) * 80 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiQ1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .5, "Stun" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .4, .01, false, true, "origin", "" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Channel Slam" )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A033' )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200, GetUnitFacing( MUIUnit( 100 ) ), "Effect" )
				call AddMultipleEffectsXY( 5, "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetUnitFacing( MUIUnit( 100 ) ), 0, 65, 235, 245, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 150, .2, .01, 0, DashEff( ) )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiSpellE takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .6, "Stun" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel two" )
				call PlaySoundWithVolume( LoadSound( "RyougiE1" ), 100, 0 )
			endif
			
			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Distance" ) / 2, GetReal( "Angle" ), "Effect" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
			endif

			if LocTime >= 25 then
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, "AoE", "Physical", MUILevel( ) * 75 + MUIPower( ), false, "", 0 )
			endif			

			if LocTime == 50 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function RyougiSpellR takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "RyougiT1" ), 80, 0 )
				call CCUnit( MUIUnit( 100 ), .85, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel five" )
				call AddEffectXY( "GeneralEffects\\BlackBlink.mdl", .5, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 270, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
			endif

			if LocTime == 25 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 100, GetReal( "Angle" ), "Move" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1000 + MUILevel( ) * 100 + MUIPower( ) * .50 )
				call SetUnitPosition( MUIUnit( 100 ), GetReal( "MoveX" ), GetReal( "MoveY" ) )
				call AddEffectXY( "Effects\\Toono\\LinearSlashBlue1.mdl", 3, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Angle" ), 0 )
			endif

			if LocTime == 50 then
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell slam one" )
			endif

			if LocTime == 75 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 50, 0 )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1000 + MUILevel( ) * 100 + MUIPower( ) * .50 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call AddMultipleEffectsXY( 3, "Effects\\Nanaya\\ArcDrive1.mdl", 4, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 270, 0, 255, 255, 255, 255 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function RyougiSpellT takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local integer LocCount  = LoadInteger( HashTable, HandleID, 1 )

		if StopSpell( HandleID, 1 ) == false then
			if LoadBoolean( HashTable, HandleID, 10 ) == false then
				if LocTime < 1 then
					call SaveInteger( HashTable, HandleID, 0, 1 )
					call SaveInteger( HashTable, HandleID, 1, 1 )
					call SaveInteger( HashTable, HandleID, 2, 1 )
					call CCUnit( MUIUnit( 100 ), .2, "Stun" )
					call SetUnitPathing( MUIUnit( 100 ), false )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel three" )
					call PlaySoundWithVolume( LoadSound( "RyougiD1" ), 100, 0 )
					call SetUnitPathing( MUIUnit( 100 ), false )
				endif

				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CreateXY( GetReal( "CasterX" ), GetReal( "CasterY" ), 40, GetReal( "Angle" ), "Move" )
				call DestroyEffect( AddSpecialEffect( DashEff( ), GetReal( "CasterX" ), GetReal( "CasterY" ) ) )
				call SetUnitPosition( MUIUnit( 100 ), GetReal( "MoveX" ), GetReal( "MoveY" ) )

				if DistanceBetweenAxis( GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "MoveX" ), GetReal( "MoveY" ) ) <= 600 then
					call CCUnit( MUIUnit( 100 ), 1.1, "Stun" )
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.75, GetReal( "CasterX" ), GetReal( "CasterY" ), 0, 0 )
					call PlaySoundWithVolume( LoadSound( "RyougiR1" ), 100, 0 )
					call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) + 200, .2, .01, false, false, "origin", DashEff( ) )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel four" )
					call AddMultipleEffectsXY( 3, "Effects\\Toono\\LinearSlashBlue1.mdl", 1, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0, 255, 255, 255, 255 )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1500 + MUILevel( ) * 150 + MUIPower( ) * 0.50 )
					call CCUnit( MUIUnit( 101 ), .5, "Stun" )
					call SaveBoolean( HashTable, HandleID, 10, true )
				endif
			else
				if LoadInteger( HashTable, HandleID, 2 ) < 31 then
					call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )

					if LocCount == 25 then
						call SaveInteger( HashTable, HandleID, 1, 1 )
					endif

					call SaveInteger( HashTable, HandleID, 2, LoadInteger( HashTable, HandleID, 2 ) + 1 )
					call AddMultipleEffectsXY( 3, "Effects\\Toono\\LinearSlashBlue1.mdl", 1, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 9 * LoadInteger( HashTable, HandleID, 2 ), 0, 255, 255, 255, 255 )
					call PlaySoundWithVolume( LoadSound( "RyougiR2" ), 100, 0 )
				else
					call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
				endif

				if LoadInteger( HashTable, HandleID, 2 ) == 30 then
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
					call DisplaceUnitWithArgs( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) + 200, 1.1, .01, 250 )
					call SetUnitAnimation( MUIUnit( 100 ), "spell" )
				endif

				if LocTime == 60 then
					call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 70, 0 )
					call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
					call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
					call CCUnit( MUIUnit( 101 ), 1, "Stun" )
					call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 1500 + MUILevel( ) * 150 + MUIPower( ) * 0.50 )
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

	function RyougiSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A035' then
			call PlaySoundWithVolume( LoadSound( "RyougiD1" ), 60, 0 )
		endif
		
		if GetSpellAbilityId( ) == 'A033' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellQ )
		endif
		
		if GetSpellAbilityId( ) == 'A032' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif

		if GetSpellAbilityId( ) == 'A034' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellE )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A036' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellR )
		endif		
		
		if GetSpellAbilityId( ) == 'A037' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, false )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function RyougiSpellT )
		endif

		return false
	endfunction	

	function HeroInit3 takes nothing returns nothing
		call SaveSound( "RyougiD1", "Ryougi\\SpellD1.mp3" )
		call SaveSound( "RyougiQ1", "Ryougi\\SpellQ1.mp3" )
		call SaveSound( "RyougiW1", "Ryougi\\SpellW1.mp3" )
		call SaveSound( "RyougiE1", "Ryougi\\SpellE1.mp3" )
		call SaveSound( "RyougiR1", "Ryougi\\SpellR1.mp3" )
		call SaveSound( "RyougiR2", "Ryougi\\SpellR2.mp3" )
		call SaveSound( "RyougiT1", "Ryougi\\SpellT1.mp3" )

		call SaveTrig( "RyougiSpells" )
		call GetUnitEvent( LoadTrig( "RyougiSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RyougiSpells" ), Condition( function RyougiSpells ) )
	endfunction	

