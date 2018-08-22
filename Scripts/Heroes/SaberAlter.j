	function SaberAtlerSpellD takes nothing returns nothing
		local real i = 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterD1" ), 100, 0 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "Morph" )
			endif
			
			if LocTime == 15 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )

				loop
					exitwhen i > 5
					call AddEffect( "Effects\\SaberAlter\\DarkNova.mdl", .2 * i, MUILocation( 102 ), 0, 0 )
					set i = i + 1
				endloop
			endif

			if LocTime == 20 then
				call AoEDisplace( HandleID, 102, 200, .5, .01, 400, "" )
				call AoEDamage( HandleID, MUILocation( 102 ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAtlerSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitTimeScale( MUIUnit( 100 ), 1.5 )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
				call PlaySoundWithVolume( LoadSound( "SaberAlterQ1" ), 100, 0 )
			endif

			if LocTime == 25 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterQ2" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), MUIDistance( 102, 103 ) * .5, MUIAngle( 102, 103 ) ) )
				call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .1, .01, false, true, "origin", DashEff( ) )
				call AddEffect( "Effects\\SaberAlter\\LinearSlashBlack1.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 75, 0, 130, 255 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 107, 200, .5, .01, 0, DashEff( ) )
				call AoEDamage( HandleID, MUILocation( 107 ), 400, "AoE", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
			endif

			if LocTime == 50 then
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAtlerSpellW takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterW1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Two" )
				call AddEffect( "Effects\\SaberAlter\\DarkExplosion.mdl", .4, MUILocation( 102 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1, MUILocation( 102 ), 0, 0 )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .4, .01, 600 )
			endif
			
			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterW2" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterW3" ), 100, 0 )
				call AddEffect( "Effects\\SaberAlter\\DarkExplosion.mdl", .75, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\LightningStrike1.mdl", .75, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2.5, MUILocation( 103 ), 0, 0 )
				call AoEDamage( HandleID, MUILocation( 103 ), 300, "AoE", "Physical", 150 + MUILevel( ) * 50 + MUIPower( ), false, "Stun", 1 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAtlerSpellE takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
		else
			call RemoveUnit( MUIUnit( 101 ) )
		endif
		
		if LocTime == 1 then
			call PlaySoundWithVolume( LoadSound( "SaberAlterE1" ), 100, 0 )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
			call PauseUnit( MUIUnit( 100 ), true )
			call SetUnitAnimation( MUIUnit( 100 ), "spell Five" )
			call SaveUnitHandle( HashTable, HandleID, 101, CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u001', MUILocation( 102 ), MUIAngle( 102, 103 ) ) )
		endif

		if LocTime == 60 then
			call PlaySoundWithVolume( LoadSound( "SaberAlterE2" ), 100, 0.5 )
			call PauseUnit( MUIUnit( 100 ), false )
			call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
		endif
		
		if LocTime > 60 then
			call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 150 )
			call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), LoadReal( HashTable, HandleID, 110 ), MUIAngle( 102, 103 ) ) )
			call DestroyEffect( AddSpecialEffectLoc( "Effects\\SaberAlter\\ShadowBurstBig.mdl", MUILocation( 107 ) ) )
			call SetUnitPositionLoc( MUIUnit( 101 ), MUILocation( 107 ) )
			call AoEDisplace( HandleID, 107, .1, 1, .01, 400, "" )
			call AoEDamage( HandleID, MUILocation( 107 ), 450, "AoE", "Physical", MUILevel( ) * 75 + MUIPower( ), false, "Stun", 1 )
			
			if LoadReal( HashTable, HandleID, 110 ) >= 1500. or UnitLife( MUIUnit( 100 ) ) <= 0 then
				call RemoveUnit( MUIUnit( 101 ) )
				call ClearAllData( HandleID )
			else
				call RemoveLocation( MUILocation( 107 ) )
			endif
		endif
	endfunction

	function SaberAtlerSpellR takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterR1" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call PauseUnit( MUIUnit( 100 ), true )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "Objects\\Spawnmodels\\Critters\\Albatross\\CritterBloodAlbatross.mdl" )
			endif

			if LocTime == 10 or LocTime == 50 or LocTime == 90 then
				if LocTime == 50 then
					call SetUnitAnimation( MUIUnit( 100 ), "spell Six" )
				else
					call SetUnitAnimation( MUIUnit( 100 ), "spell Three" )
				endif

				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 50, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call AddEffect( "Effects\\SaberAlter\\SlashBlack1.mdl", 1, MUILocation( 102 ), GetUnitFacing( MUIUnit( 100 ) ), 0 )

				if IsTerrainPathable( GetLocationX( MUILocation( 103 ) ), GetLocationY( MUILocation( 103 ) ), PATHING_TYPE_WALKABILITY ) == false then
					call RemoveLocation( MUILocation( 103 ) )
					call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 100, GetUnitFacing( MUIUnit( 100 ) ) ) )
					call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), 100, .4, .01, false, false, "origin", DashEff( ) )
				endif

				call AoEDisplace( HandleID, 102, 100, .35, .01, 300, "" )
				call AoEDamage( HandleID, MUILocation( 102 ), 300, "AoE", "Physical", MUILevel( ) * 30 + MUIPower( ) * 0.25, true, "", 0 )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 103 ) )
			endif
			
			if LocTime == 120 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell Slam" )
			endif

			if LocTime == 150 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterR2" ), 100, 0.50 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 50, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), ( MUIDistance( 102, 103 )*.5 ), MUIAngle( 102, 103 ) ) )
				call AddEffect( "Effects\\SaberAlter\\LinearSlashBlack1.mdl", 3, MUILocation( 107 ), MUIAngle( 102, 103 ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 75, 0, 130, 255 )
				
				if IsTerrainPathable( GetLocationX( MUILocation( 103 ) ), GetLocationY( MUILocation( 103 ) ), PATHING_TYPE_WALKABILITY ) == false then
					call RemoveLocation( MUILocation( 103 ) )
					call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), 300, GetUnitFacing( MUIUnit( 100 ) ) ) )
					call LinearDisplacement( MUIUnit( 100 ), MUIAngle( 102, 103 ), MUIDistance( 102, 103 ), .2, .01, false, false, "origin", DashEff( ) )
				endif
				
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDisplace( HandleID, 102, 300, .35, .01, 0, "" )
				call AoEDamage( HandleID, MUILocation( 102 ), 300, "AoE", "Physical", MUILevel( ) * 30 + MUIPower( ) * 0.25, true, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function SaberAtlerSpellT takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "SaberAlterT1" ), 100, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
				call PauseUnit( MUIUnit( 100 ), true )
				call SetUnitAnimation( MUIUnit( 100 ), "spell Channel One" )
				call DestroyEffect( AddSpecialEffectTarget( "Effects\\SaberAlter\\ShadowBurst.mdl", MUIUnit( 100 ), "weapon" ) )
			endif

			if LocTime == 1 or LocTime == 10 then
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 1.5, MUILocation( 102 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2, MUILocation( 102 ), 0, 0 )
				call AddEffect( "Effects\\SaberAlter\\DarkExplosion.mdl", .5, MUILocation( 102 ), 0, 0 )
			endif

			if LocTime == 100 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell Channel Two" )
				call PlaySoundWithVolume( LoadSound( "SaberAlterT2" ), 100, 0 )
				call PlaySoundWithVolume( LoadSound( "SaberAlterT3" ), 100, 0 )
				call AddEffect( "Effects\\SaberAlter\\DarkWave.mdl", 1, MUILocation( 102 ), MUIAngle( 102, 103 ), 0 )
			endif
			
			if LocTime >= 100 then
				call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 100 )
				call SaveLocationHandle( HashTable, HandleID, 107, CreateLocation( MUILocation( 102 ), LoadReal( HashTable, HandleID, 110 ), MUIAngle( 102, 103 ) ) )
				call SaveReal( HashTable, HandleID, 112, ( LoadReal( HashTable, HandleID, 112 ) + 1 ) )
				
				if LoadReal( HashTable, HandleID, 112 ) >= 4 then
					call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 2, MUILocation( 107 ), 0, 0 )
					call SaveReal( HashTable, HandleID, 112, 0 )
				endif

				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 107 ) ) )
				call AoEDamage( HandleID, MUILocation( 107 ), 500, "AoE", "Physical", MUILevel( ) * 300 + MUIPower( ), false, "", 0 )

				if LoadReal( HashTable, HandleID, 110 ) >= 3000 then
					call ClearAllData( HandleID )
				endif

				call RemoveLocation( MUILocation( 107 ) )
			endif
		endif
	endfunction
	
	function SaberAtlerSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID

		if GetSpellAbilityId( ) == 'A03S' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAtlerSpellD )
		endif
		
		if GetSpellAbilityId( ) == 'A03T' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAtlerSpellQ )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif		
		
		if GetSpellAbilityId( ) == 'A03U' then
			if IsTerrainPathable( GetSpellTargetX( ), GetSpellTargetY( ), PATHING_TYPE_WALKABILITY ) == false then
				set HandleID = NewMUITimer( LocPID )
				call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
				call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
				call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAtlerSpellW )
			else
				call IssueImmediateOrder( GetTriggerUnit( ), "stop" )
			endif
		endif
		
		if GetSpellAbilityId( ) == 'A03V' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAtlerSpellE )
		endif
		
		if GetSpellAbilityId( ) == 'A03W' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAtlerSpellR )
		endif		
		
		if GetSpellAbilityId( ) == 'A03X' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function SaberAtlerSpellT )
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
		call SaveSound( "SaberAlterT1", "SaberAlter\\SpellT1.mp3" )
		call SaveSound( "SaberAlterT2", "SaberAlter\\SpellT2.mp3" )
		call SaveSound( "SaberAlterT3", "SaberAlter\\SpellT3.mp3" )

		call SaveTrig( "SaberAtlerSpells" )
		call GetUnitEvent( LoadTrig( "SaberAtlerSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "SaberAtlerSpells" ), Condition( function SaberAtlerSpells ) )
	endfunction	

