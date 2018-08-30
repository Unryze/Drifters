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
	
	function AkainuSpellTTimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A04E' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .05, true, function AkainuSpellT )
		endif
	endfunction

	function AkameSpellD takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "AkameD1" ), 80, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call SetUnitFacing( MUIUnit( 100 ), MUIAngleData( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call CCUnit( MUIUnit( 100 ), .4, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
			endif

			if LocTime == 5 then
				call SetUnitInvulnerable( MUIUnit( 100 ), true )
			endif

			if LocTime == 20 then
				call DisplaceUnitWithArgs( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), LoadReal( HashTable, HandleID, 0 ), .2, .01, 0 )
			endif

			if LocTime == 30 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .4, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Four" )
				call PlaySoundWithVolume( LoadSound( "AkameE1" ), 100, 0 )
			endif

			if LocTime == 30 then
				call CreateDistanceAndAngle( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), "Spell" )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "Distance" ) / 2, GetReal( "Angle" ), "Effect" )
				call AddEffectXY( "GeneralEffects\\AkihaClaw.mdl", 3, GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ), 0 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ), .1, .01, false, true, "origin", DashEff( ) )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), -200, .5, .01, 0, DashEff( ) )
			endif

			if LocTime >= 30 then
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 250, "AoE", "Physical", 300 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
			endif

			if LocTime == 40 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function AkameSpellDandETimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A03K' or GetSpellAbilityId( ) == 'A052' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )

			if GetSpellAbilityId( ) == 'A052' then
				call SaveReal( HashTable, HandleID, 0, -350 )
				call SetPlayerAbilityAvailable( Player( LocPID ), 'A03L', true )
				call SetPlayerAbilityAvailable( Player( LocPID ), 'A052', false )
			else
				call SaveReal( HashTable, HandleID, 0, -400 )
			endif

			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellD )
		endif		
		
		if GetSpellAbilityId( ) == 'A03N' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellE )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
	endfunction

	function ArcueidSpellT takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ArcueidT1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .6, "Stun" )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 1.5, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\BlackBlink.mdl", 1.5, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Six" )
			endif

			if LocTime == 25 then
				call ShowUnit( MUIUnit( 100 ), false )
				call SetUnitPosition( MUIUnit( 100 ), GetReal( "SpellX" ), GetReal( "SpellY" ) )
			endif

			if LocTime == 45 then
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 600, "AoE", "Physical", MUILevel( ) * 200 + MUIPower( ), false, "Stun", 1 )
			endif

			if LocTime == 50 then
				call ShowUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Stand" )
				call UnitSelect( MUIUnit( 100 ) )

				loop
					exitwhen i == 3
					call AddEffectXY( "GeneralEffects\\ValkDust" + I2S( 50 * GetRandomInt( 1, 3 ) ) + ".mdl", GetRandomReal( 1.5, 2 ), GetReal( "SpellX" ), GetReal( "SpellY" ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function ArcueidTimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A02A' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
				call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function ArcueidSpellT )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
	endfunction

	function KuchikiByakuyaSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ByakuyaW1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), .9, "Stun" )
				call SetUnitAnimation( MUIUnit( 100 ), "spell channel one" )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
			endif

			if GetIteration( LocTime, 5 ) and LocTime <= 40 then
				call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), 100, 45 * ( LocTime / 5 ), "Effect" )
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call SetUnitPosition( MUIUnit( 101 ), GetReal( "TargetX" ), GetReal( "TargetY" ) )
				call SaveUnit( "DummyUnit", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u009', GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ) ) )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .9 - I2R( LocTime * 2 ) / 100 )
				call ScaleUnit( LoadUnit( "DummyUnit" ), 3 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 20000 )
			endif

			if LocTime == 50 then
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 245 + MUILevel( ) * 65 + MUIPower( ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Spark_Pink.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\Deadspirit Asuna.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
			endif

			if LocTime == 80 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function ByakuyaSpellWTimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A03D' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function KuchikiByakuyaSpellW )
		endif
	endfunction

	function ReinforceSpellW takes nothing returns nothing
		local integer i 		= 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ReinforceW1" ), 60, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )

				loop
					exitwhen i > 20
					call CreateXY( GetReal( "TargetX" ), GetReal( "TargetY" ), GetRandomReal( 100, 1000 ), 36 * i, "Effect" )
					call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
					call SaveUnit( "DummyUnit" + I2S( i ), CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'u00B', GetReal( "EffectX" ), GetReal( "EffectY" ), GetReal( "Angle" ) ) )
					call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", LoadUnit( "DummyUnit" + I2S( i ) ), "origin" ) )
					set i = i + 1
				endloop

				set i = 1
			endif

			if LocTime == 100 then
				loop
					exitwhen i > 20
					call SetUnitFlyHeight( LoadUnit( "DummyUnit" + I2S( i ) ), 0, 0 )
					call SetUnitPosition( LoadUnit( "DummyUnit" + I2S( i ) ), GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) )
					set i = i + 1
				endloop

				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodCircle.mdl", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function ReinforceSpellWTimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A04H' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellW )
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
	
	function RyougiSpellETimer takes nothing returns nothing
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
	endfunction

	function SaberAlterSpellR takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterR1" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call CCUnit( MUIUnit( 100 ), 1.6, "Stun" )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl" )
			endif

			if LocTime == 10 or LocTime == 50 or LocTime == 90 then
				if LocTime == 50 then
					call SetUnitAnimation( MUIUnit( 100 ), "spell Six" )
				else
					call SetUnitAnimation( MUIUnit( 100 ), "spell Three" )
				endif

				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 50, GetUnitFacing( MUIUnit( 100 ) ), "Spell" )
				call AddEffectXY( "Effects\\SaberAlter\\SlashBlack1.mdl", 1, GetReal( "SpellX" ), GetReal( "SpellY" ), GetUnitFacing( MUIUnit( 100 ) ), 0 )

				if IsTerrainPathable( GetReal( "SpellX" ), GetReal( "SpellY" ), PATHING_TYPE_WALKABILITY ) == false then
					call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), 100, .4, .01, false, false, "origin", DashEff( ) )
				endif

				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 100, .35, .01, 300, "" )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, "AoE", "Physical", MUILevel( ) * 30 + MUIPower( ) * 0.25, true, "", 0 )
			endif
			
			if LocTime == 120 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 50, GetUnitFacing( MUIUnit( 100 ) ), "Effect" )
				call AddEffectXY( "Effects\\SaberAlter\\LinearSlashBlack1.mdl", 3, GetReal( "EffectX" ), GetReal( "EffectY" ), GetUnitFacing( MUIUnit( 100 ) ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 75, 0, 130, 255 )

				if IsTerrainPathable( GetReal( "SpellX" ), GetReal( "SpellY" ), PATHING_TYPE_WALKABILITY ) == false then
					call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), 300, .2, .01, false, false, "origin", DashEff( ) )
				endif

				call AoEDisplaceXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, .35, .01, 0, "" )
				call SaveBoolean( HashTable, HandleID, StringHash( "IsUpdated" ), false )
			endif

			if LocTime >= 150 then
				call AoEDamageXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, "AoE", "Physical", MUILevel( ) * 30 + MUIPower( ) * 0.25, false, "", 0 )
			endif

			if LocTime == 170 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function SaberAlterSpellRTimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A03W' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAlterSpellR )
		endif	
	endfunction

	function SaberArtoriaSpellR takes nothing returns nothing
		local integer i = 1
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR1" ), 100, 0 )
				call CCUnit( MUIUnit( 100 ), 2.6, "Stun" )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberArtoria\\HolyEnergy.mdl", MUIUnit( 100 ), "chest" ) )
				call SetUnitAnimation( MUIUnit( 100 ), "Attack Walk Stand Spin" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2.5 )
			endif

			if LocTime == 50 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .2, .01, false, true, "origin", DashEff( ) )
			endif

			if LocTime == 60 or LocTime == 90 or LocTime == 120 or LocTime == 150 or LocTime == 180 or LocTime == 210 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaQ2" ), 100, 0 )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaR2" ), 100, 0 )
			endif

			if LocTime == 250 then
				call PlaySoundWithVolume( LoadSound( "SaberArtoriaW2" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 150 + MUIPower( ) )
				call AddEffectXY( "Effects\\SaberArtoria\\HolyExplosion.mdl", 1, GetReal( "TargetX" ), GetReal( "TargetY" ), GetReal( "Angle" ), 0 )
				call ResetAbilityCooldown( MUIUnit( 100 ), 'A04R' )

				if LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ) > 0 then
					call CCUnit( MUIUnit( 101 ), 1, "Stun" )
					call AddEffectXY( "Effects\\SaberArtoria\\ExcaliburLinear.mdl", 1, GetReal( "CasterX" ), GetReal( "CasterY" ), GetReal( "Angle" ), 0 )
					call ScaleUnit( LoadUnit( "DummyUnit" ), .5 )
					call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 400, "AoE", "Physical", LoadReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500 ), false, "Stun", 1 )
					call SaveReal( HashTable, GetHandleId( MUIUnit( 100 ) ), 500, 0 )
				endif

				loop
					exitwhen i > 4
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( 2, 3 ), GetReal( "TargetX" ), GetReal( "TargetY" ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call ClearAllData( HandleID )
			endif
		endif
	endfunction	
	
	function SaberArtoriaSpellRTimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A02K' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberArtoriaSpellR )
		endif
	endfunction
	
	function SaberNeroSpellE takes nothing returns nothing
		local integer i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberNeroE1" ), 100, 0 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call LinearDisplacement( MUIUnit( 100 ), GetReal( "Angle" ), GetReal( "Distance" ) - 150, .1, .015, false, true, "origin", DashEff( ) )
				call CCUnit( MUIUnit( 100 ), 1.8, "Stun" )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Three" )
			endif

			if LocTime == 35 or LocTime == 70 or LocTime == 105 or LocTime == 140 then
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", MUILevel( ) * 10 )
				call SetUnitFacing( MUIUnit( 100 ), GetReal( "Angle" ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\RedAftershock.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
				call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Weapons\\FireBallMissile\\FireBallMissile.mdl", MUIUnit( 101 ), "chest" ) )
			endif

			if LocTime == 170 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1 )
				call CreateTargetXY( HandleID, MUIUnit( 100 ), MUIUnit( 101 ) )
				call CreateDistanceAndAngle( GetReal( "CasterX" ), GetReal( "CasterY" ), "Target" )
				call AddEffectXY( "GeneralEffects\\MoonWrath.mdl", 4, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 0, 255, 255 )
				call AddEffectXY( "GeneralEffects\\ApocalypseCowStomp.mdl", 1.5, GetReal( "TargetX" ), GetReal( "TargetY" ), 0, 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 0, 255, 255 )

				loop
					exitwhen i > 4
					call AddEffectXY( "GeneralEffects\\ValkDust.mdl", GetRandomReal( 2, 3 ), GetReal( "TargetX" ), GetReal( "TargetY" ), GetRandomReal( 0, 360 ), 0 )
					set i = i + 1
				endloop

				call AoEDamageXY( HandleID, GetReal( "TargetX" ), GetReal( "TargetY" ), 400, "AoE", "Physical", MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function SaberNeroSpellETimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A03A' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberNeroSpellE )
		endif	
	endfunction	

	function ScathachSpellEFunctionRemoveUnits takes nothing returns nothing
		call KillUnit( GetEnumUnit( ) )
	endfunction	

	function ScathachSpellEFunctionDisplaceDummy takes nothing returns nothing
		call SaveLocationHandle( HashTable, MUIHandle( ), 123, GetUnitLoc( GetEnumUnit( ) ) )
		call SaveLocationHandle( HashTable, MUIHandle( ), 124, CreateLocation( MUILocation( 123 ), 50, MUIAngle( 102, 103 ) ) )
		call SetUnitPositionLoc( GetEnumUnit( ), MUILocation( 124 ) )
		call RemoveLocation( MUILocation( 123 ) )
		call RemoveLocation( MUILocation( 124 ) )
	endfunction

	function ScathachSpellE takes nothing returns nothing
		local real i			= 1
		local integer HandleID  = MUIHandle( )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )
		local integer LocTime   = MUIInteger( 0 )

		if UnitLife( MUIUnit( 100 ) ) > 0 then
			if IsCounted == true then
				call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			else
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )

				if LocTime < 1 then
					call SaveInteger( HashTable, HandleID, 0, 1 )
					call CCUnit( MUIUnit( 100 ), .95, "Stun" )
					call SetUnitPathing( MUIUnit( 100 ), false )
					call SetUnitAnimation( MUIUnit( 100 ), "spell Channel" )
					call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ) - 150, .1, .01, false, false, "origin", DashEff( ) )

					loop
						exitwhen i > 10
						call SaveLocationHandle( HashTable, HandleID, 123, GetUnitLoc( MUIUnit( 100 ) ) )
						call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
						call SaveLocationHandle( HashTable, HandleID, 124, CreateLocation( MUILocation( 123 ), 80. * i, MUIAngle( 123, 103 ) - 160 ) )
						call AddEffect( "GeneralEffects\\OrbOfFire.mdl", 2, MUILocation( 124 ), MUIAngle( 123, 103 ), 0 )
						call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 9999 )
						call GroupAddUnit( LoadGroupHandle( HashTable, HandleID, 111 ), LoadUnit( "DummyUnit" ) )
						call RemoveLocation( MUILocation( 124 ) )
						call SaveLocationHandle( HashTable, HandleID, 124, CreateLocation( MUILocation( 123 ), 80. * i, MUIAngle( 123, 103 ) + 160 ) )
						call AddEffect( "GeneralEffects\\OrbOfFire.mdl", 2, MUILocation( 124 ), MUIAngle( 123, 103 ), 0 )
						call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 9999 )
						call GroupAddUnit( LoadGroupHandle( HashTable, HandleID, 111 ), LoadUnit( "DummyUnit" ) )
						call RemoveLocation( MUILocation( 124 ) )
						call RemoveLocation( MUILocation( 123 ) )
						call RemoveLocation( MUILocation( 103 ) )
						set i = i + 1
					endloop	

					call PauseUnit( MUIUnit( 100 ), true )
					call SetUnitPathing( MUIUnit( 100 ), false )
				endif

				call ForGroup( LoadGroupHandle( HashTable, HandleID, 111 ), function ScathachSpellEFunctionDisplaceDummy )

				if MUIDistance( 102, 103 ) <= 150 then
					call PlaySoundWithVolume( LoadSound( "ScathachR1" ), 100, 0 )
					call ForGroup( LoadGroupHandle( HashTable, HandleID, 111 ), function ScathachSpellEFunctionRemoveUnits )
					call SetUnitAnimation( MUIUnit( 100 ), "spell Seven" )
					call DestroyGroup( LoadGroupHandle( HashTable, HandleID, 111 ) )
					call SaveBoolean( HashTable, HandleID, 10, true )
				endif
				
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif

			if LocTime == 45 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call LinearDisplacement( MUIUnit( 101 ), MUIAngle( 102, 103 ), 500, .4, .01, false, false, "origin", DashEff( ) )
				call AddEffect( "GeneralEffects\\t_huobao.mdl", 2, MUILocation( 103 ), MUIAngle( 102, 103 ), 90 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 1., MUILocation( 103 ), MUIAngle( 102, 103 ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell four" )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 85 then
				call PlaySoundWithVolume( LoadSound( "ScathachR2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
				call SetUnitPathing( MUIUnit( 100 ), true )
				call AddEffect( "GeneralEffects\\OrbOfFire.mdl", 2, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
				call SaveUnitHandle( HashTable, HandleID, 106, LoadUnit( "DummyUnit" ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime >= 85 then
				call SaveLocationHandle( HashTable, HandleID, 109, GetUnitLoc( MUIUnit( 106 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 115, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 116, CreateLocation( MUILocation( 109 ), 50, MUIAngle( 109, 115 ) ) )
				call SetUnitPathing( MUIUnit( 106 ), false )
				call SetUnitPositionLoc( MUIUnit( 106 ), MUILocation( 116 ) )
				call FaceLocation( MUIUnit( 106 ), MUILocation( 115 ), 0 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 109 ) ) )
				
				if MUIDistance( 115, 116 ) <= 100 then
					call KillUnit( MUIUnit( 106 ) )
					call AoEDamage( HandleID, MUILocation( 109 ), 600, "AoE", "Physical", MUILevel( ) * 75 + MUIPower( ), false, "", 0 )
					call SaveLocationHandle( HashTable, HandleID, 103, GetUnitLoc( MUIUnit( 101 ) ) )
					set i = 1

					loop
						exitwhen i > 10
						call AddEffect( "GeneralEffects\\t_huobao.mdl", .5, MUILocation( 103 ), 36 * i, 0 )
						set i = i + 1
					endloop

					call ClearAllData( HandleID )
				else
					call RemoveLocation( MUILocation( 109 ) )
					call RemoveLocation( MUILocation( 115 ) )
					call RemoveLocation( MUILocation( 116 ) )
				endif
			endif
		else
			call ForGroup( LoadGroupHandle( HashTable, HandleID, 111 ), function ScathachSpellEFunctionRemoveUnits )
			call ClearAllData( HandleID )
		endif
	endfunction
	
	function ScathachSpellETimer takes nothing returns nothing
		if GetSpellAbilityId( ) == 'A042' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, false )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ScathachSpellE )
		endif	
	endfunction	