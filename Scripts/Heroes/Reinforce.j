	function ReinforceSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ReinforceQ1" ), 60, 0 )
				call AddEffectXY( "Effects\\Reinforce\\SmallBlackHole.mdl", 1.2, GetReal( "SpellX" ), GetReal( "SpellY" ), 270, 0 )
				call AddEffectXY( "Effects\\SaberAlter\\DarkExplosion.mdl", 1.2, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), -10, .05, .01, 0, "" )
			endif

			if LocTime > 1 and LocTime < 100 then
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 400, "", "", 0, true, "", 0 )
			endif

			if LocTime == 100 then
				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 200, 1., .01, 0, "" )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 400, "AoE", "Magical", 250 + MUILevel( ) * 50 + MUIPower( ), true, "Stun", 1.5 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 5, GetReal( "SpellX" ), GetReal( "SpellY" ), 270, 90 )
				call UnitApplyTimedLife( LoadUnit( "DummyUnit" ), 'BTLF', .05 )
				call AddEffectXY( "Effects\\Reinforce\\BlackExplosion.mdl", 4, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 200, 99999 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function ReinforceSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call PlaySoundWithVolume( LoadSound( "ReinforceE1" ), 60, 0 )
			endif

			if LocTime == 50 then
				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\NewDirtEx.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call DestroyEffect( AddSpecialEffect( "Effects\\Reinforce\\ApocalypseStomp.mdl", GetReal( "SpellX" ), GetReal( "SpellY" ) ) )
				call AddEffectXY( "GeneralEffects\\Moonwrath.mdl", 6, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 120, 0, 170, 255 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2.5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 450, "AoE", "Magical", MUILevel( ) * 60 + MUIPower( ), false, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function ReinforceSpellE takes nothing returns nothing	
		local integer HandleID = GetHandleId( GetExpiredTimer( ) )
		local integer LocTime  = LoadInteger( HashTable, HandleID, 0 )

		call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

		if LocTime == 1 then
			call CCUnit( MUIUnit( 100 ), .2, "Stun" )
			call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			call SetUnitAnimation( MUIUnit( 100 ), "Spell Throw" )
		endif

		if LocTime == 10 then
			call InitProjectileXY( HandleID, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetReal( "SpellX" ), GetReal( "SpellY" ), 50, 10, 1200, 3, 200, "Effects\\Reinforce\\WormHole.mdl", true )
		endif

		if LocTime > 10 then
			if UnitLife( MUIUnit( StringHash( "GetProjectile" ) ) ) > 0 then
				call ProjectileMovement( HandleID )
			else
				call SaveInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0, LoadInteger( HashTable, GetHandleId( MUIUnit( 100 ) ), 0 ) + 1 )
				call AoEDamageXY( MUIHandle( ), GetReal( "ProjectileMoveX" ), GetReal( "ProjectileMoveY" ), 300, "AoE", "Magical", MUILevel( ) * 75 + MUIPower( ), true, "", 0 )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction	

	function ReinforceSpellR takes nothing returns nothing
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
					call InitSpiralXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 450, 16, 800, "Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl" )
					call PlaySoundWithVolume( LoadSound( "ReinforceT1" ), 80, 0 )
					call CCUnit( MUIUnit( 100 ), 2.75, "Stun" )
					call SetUnitAnimation( MUIUnit( 100 ), "spell channel" )
					call SaveEffectHandle( HashTable, HandleID, 150, AddSpecialEffectTarget( "Effects\\Reinforce\\Aura.mdl", MUIUnit( 100 ), "origin" ) )

					loop
						exitwhen i > 5
						call AddEffectXY( "Effects\\Reinforce\\MagicCircle.mdl", i / 2, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 0, 0 )
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
				call MUIDummyXY( 106, 'u001', GetReal( "SpellX" ), GetReal( "SpellY" ), 0 )
				call MUISaveEffect( 151, "Effects\\Reinforce\\BlackHole.mdl", 106 )
				call ScaleUnit( MUIUnit( 106 ), 3.5 )
			endif

			if LocTime == 150 then
				call SetUnitAnimation( MUIUnit( 100 ), "spell slam" )
			endif

			if LocTime == 230 then
				call RemoveUnit( MUIUnit( 106 ) )
				call DestroyEffect( MUIEffect( 150 ) )
				call DestroyEffect( MUIEffect( 151 ) )
				call AddEffectXY( "Effects\\Reinforce\\ShadowExplosion.mdl", 5, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 5., GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\FuzzyStomp.mdl", 6, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust50.mdl", 6, GetReal( "SpellX" ), GetReal( "SpellY" ), 0, 0 )
				call AoEDisplaceXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 300, .5, .01, 0, "" )
				call AoEDamageXY( HandleID, GetReal( "SpellX" ), GetReal( "SpellY" ), 900, "AoE", "Magical", MUILevel( ) * 400 + MUIPower( ), false, "Stun", 1 )
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
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A04I' then
			set	HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellW )
		endif		
		
		if GetSpellAbilityId( ) == 'A04J' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellE )
		endif

		if GetSpellAbilityId( ) == 'A04K' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, false )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellX" ), GetSpellTargetX( ) )
			call SaveReal( HashTable, HandleID, StringHash( "SpellY" ), GetSpellTargetY( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function ReinforceSpellR )
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

