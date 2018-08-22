	function ReinforceSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ReinforceQ1" ), 60, 0 )
				call AddEffect( "Effects\\Reinforce\\SmallBlackHole.mdl", 1.2, MUILocation( 102 ), 270, 0 )
				call AddEffect( "Effects\\SaberAlter\\DarkExplosion.mdl", 1.2, MUILocation( 102 ), 0, 0 )
				call AoEDisplace( HandleID, 102, -10, .05, .01, 0, "" )
			endif

			if LocTime > 1 and LocTime < 100 then
				call AoEDamage( HandleID, MUILocation( 102 ), 400, "", "", 0, true, "", 0 )
			endif

			if LocTime == 100 then
				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call AoEDisplace( HandleID, 102, 200, 1., .01, 0, "" )
				call AoEDamage( HandleID, MUILocation( 102 ), 400, "AoE", "Magical", 250 + MUILevel( ) * 50 + MUIPower( ), true, "Stun", 1.5 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 5, MUILocation( 102 ), 270, 90 )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .05 )
				call AddEffect( "Effects\\Reinforce\\BlackExplosion.mdl", 4, MUILocation( 102 ), 0, 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function ReinforceSpellWDummyFacing takes nothing returns nothing
		call FaceLocation( GetEnumUnit( ), MUILocation( 102 ), 0 )
	endfunction

	function ReinforceSpellWDummyMovement takes nothing returns nothing
		call SetUnitFlyHeight( GetEnumUnit( ), 0, 99999 )
		call SetUnitPositionLoc( GetEnumUnit( ), MUILocation( 102 ) )
		call SetUnitFacing( GetEnumUnit( ), MUIAngle( 102, 102 ) )
	endfunction

	function ReinforceSpellW takes nothing returns nothing
		local real 	  i 		= 1
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			
			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ReinforceW1" ), 60, 0 )
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 101 ) ) )

				loop
					exitwhen i > 20
					call SaveLocationHandle( HashTable, HandleID, 103, CreateLocation( MUILocation( 102 ), GetRandomReal( 100, 1000 ), 36 * i ) )
					call SaveUnit( "DummyUnit", CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), 'u00B', MUILocation( 103 ), MUIAngle( 103, 102 ) ) )
					call GroupAddUnit( LoadGroupHandle( HashTable, HandleID, 111 ), LoadUnit( "DummyUnit" ) )
					call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Orc\\FeralSpirit\\feralspirittarget.mdl", LoadUnit( "DummyUnit" ), "origin" ) )
					call RemoveLocation( MUILocation( 103 ) )
					set i = i + 1
				endloop
			endif
			
			call ForGroup( LoadGroupHandle( HashTable, GetHandleId( GetExpiredTimer( ) ), 111 ), function ReinforceSpellWDummyFacing )
		
			if LocTime == 100 then
				call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 101 ) ) )
				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodCircle.mdl", MUILocation( 102 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\BloodEffect1.mdl", MUILocation( 102 ) ) )
				call ForGroup( LoadGroupHandle( HashTable, HandleID, 111 ), function ReinforceSpellWDummyMovement )
				call CCUnit( MUIUnit( 101 ), 1, "Stun" )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 250 + MUILevel( ) * 50 + MUIPower( ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ReinforceSpellE takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ReinforceE1" ), 60, 0 )
			endif

			if LocTime == 100 then
				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call DestroyEffect( AddSpecialEffectLoc( "GeneralEffects\\NewDirtEx.mdl", MUILocation( 102 ) ) )
				call DestroyEffect( AddSpecialEffectLoc( "Effects\\Reinforce\\ApocalypseStomp.mdl", MUILocation( 102 ) ) )
				call AddEffect( "GeneralEffects\\Moonwrath.mdl", 6, MUILocation( 102 ), 0, 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 120, 0, 170, 255 )
				call AddEffect( "GeneralEffects\\ValkDust.mdl", 2.5, MUILocation( 102 ), 0, 0 )
				call AoEDamage( HandleID, MUILocation( 102 ), 450, "AoE", "Magical", MUILevel( ) * 60 + MUIPower( ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ReinforceSpellR takes nothing returns nothing	
		local integer HandleID = GetHandleId( GetExpiredTimer( ) )
		local integer LocTime  = LoadInteger( HashTable, HandleID, 0 )

		call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

		if LocTime == 1 then
			call PauseUnit( MUIUnit( 100 ), true )
			call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw" )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( MUIUnit( 100 ) ) )
		endif

		if LocTime == 10 then
			call InitProjectile( 100, HandleID, 102, 103, 200, 10, 1200, 3, 200, "Effects\\Reinforce\\WormHole.mdl", true )
		endif

		if LocTime == 20 then
			call PauseUnit( MUIUnit( 100 ), false )
		endif

		if LocTime > 10 then
			if UnitLife( MUIUnit( StringHash( "GetProjectile" ) ) ) > 0 then
				call ProjectileMovement( HandleID )
			else
				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call AoEDamage( MUIHandle( ), GetLoc( "ProjectileLoc" ), 300, "AoE", "Magical", MUILevel( ) * 75 + MUIPower( ), true, "", 0 )
				call RemoveLocation( GetLoc( "ProjectileLoc" ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function ReinforceSpellT takes nothing returns nothing
		local real  i			= 1 
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )

		if StopSpell( HandleID, 0 ) == false then
			if IsCounted == true then
				call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			else
				if LocTime < 1 then
					call SaveInteger( HashTable, HandleID, 0, 1 )
					call InitSpiral( HandleID, 103, 450, 16, 800, "Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl" )
					call PlaySoundWithVolume( LoadSound( "ReinforceT1" ), 80, 0 )
					call CCUnit( MUIUnit( 100 ), 2.5, "Stun" )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel" )
					call SaveEffectHandle( HashTable, HandleID, 150, AddSpecialEffectTarget( "Effects\\Reinforce\\Aura.mdl", MUIUnit( 100 ), "origin" ) )

					loop
						exitwhen i > 5
						call AddEffect( "Effects\\Reinforce\\MagicCircle.mdl", i / 2, MUILocation( 102 ), 0, 0 )
						call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', 1.75 )
						call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 255, 50, 255, 255 )
						set i = i + 1
					endloop
				endif

				call SpiralMovement( HandleID )

				if GetReal( "Limit" ) <= 0 then
					call SaveBoolean( HashTable, HandleID, 10, true )
				endif
			endif

			if LocTime == 20 then
				call MUIDummy( 106, 'u001', 103, 0 )
				call MUISaveEffect( 151, "Effects\\Reinforce\\BlackHole.mdl", 106 )
				call ScaleUnit( MUIUnit( 106 ), 3.5 )
			endif

			if LocTime == 70 then
				call SaveLocationHandle( HashTable, HandleID, 113, CreateLocation( MUILocation( 102 ), 130, GetUnitFacing( MUIUnit( 100 ) ) ) )
				call RemoveLocation( MUILocation( 102 ) )
				call RemoveLocation( MUILocation( 113 ) )
			endif
			
			if LocTime == 150 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell slam" )
			endif

			if LocTime == 230 then
				call RemoveUnit( MUIUnit( 106 ) )
				call DestroyEffect( MUIEffect( 150 ) )
				call DestroyEffect( MUIEffect( 151 ) )
				call AddEffect( "Effects\\Reinforce\\ShadowExplosion.mdl", 5, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\SlamEffect.mdl", 5., MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\FuzzyStomp.mdl", 6, MUILocation( 103 ), 0, 0 )
				call AddEffect( "GeneralEffects\\ValkDust50.mdl", 6, MUILocation( 103 ), 0, 0 )
				call AoEDisplace( HandleID, 103, 300, .5, .01, 0, "" )
				call AoEDamage( HandleID, MUILocation( 103 ), 900, "AoE", "Magical", MUILevel( ) * 400 + MUIPower( ), false, "Stun", 1 )
			endif
			
			if LocTime == 250 then
				call SetUnitAnimation( MUIUnit( 100 ), "Stand Ready" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function ReinforceSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A04G' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 102, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellQ )
		endif
		
		if GetSpellAbilityId( ) == 'A04H' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call SaveGroupHandle( HashTable, HandleID, 111, CreateGroup( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellW )
		endif
		
		if GetSpellAbilityId( ) == 'A04I' then
			set	HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 102, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellE )
		endif		
		
		if GetSpellAbilityId( ) == 'A04J' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellR )
		endif

		if GetSpellAbilityId( ) == 'A04K' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, false )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveLocationHandle( HashTable, HandleID, 102, GetUnitLoc( GetTriggerUnit( ) ) )
			call SaveLocationHandle( HashTable, HandleID, 103, GetSpellTargetLoc( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellT )
		endif

		return true
	endfunction	

	function HeroInit10 takes nothing returns nothing
		call SaveSound( "ReinforceD1", "Reinforce\\SpellD1.mp3" )
		call SaveSound( "ReinforceQ1", "Reinforce\\SpellQ1.mp3" )
		call SaveSound( "ReinforceW1", "Reinforce\\SpellW1.mp3" )
		call SaveSound( "ReinforceE1", "Reinforce\\SpellE1.mp3" )
		call SaveSound( "ReinforceR1", "Reinforce\\SpellR1.mp3" )
		call SaveSound( "ReinforceT1", "Reinforce\\SpellT1.mp3" )

		call SaveTrig( "ReinforceSpells" )
		call GetUnitEvent( LoadTrig( "ReinforceSpells" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "ReinforceSpells" ), Condition( function ReinforceSpells ) )
	endfunction	

