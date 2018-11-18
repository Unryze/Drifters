	function AkameSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = MUIInteger( 0 )

		if StopSpell( HandleID, 0 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call CCUnit( MUIUnit( 100 ), .25, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Four" )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "AkameQ1" ), 60, 0 )
				call CreateXY( GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 200., GetUnitFacing( MUIUnit( 100 ) ), "Effect" )
				call AddEffectXY( "GeneralEffects\\AkihaClaw.mdl", 1.5, GetReal( "EffectX" ), GetReal( "EffectY" ), GetUnitFacing( MUIUnit( 100 ) ) - 90, 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 400, "AoE", "Physical", 250 + MUIPower( 1. ), false, "Stun", 1 )
			endif

			if LocTime == 25 then
				call FlushChildHashtable( HashTable, HandleID )
			endif
		endif
	endfunction

	function AkameSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if StopSpell( HandleID, 1 ) == false then
			if MUIInteger( 0 ) < 1 then
				call SaveInteger( HashTable, HandleID, 0, MUIInteger( 0 ) + 1 )
				call CCUnit( MUIUnit( 100 ), ( DistanceBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) - 150 ) / 1000, "Stun", false )
				call SetUnitPathing( MUIUnit( 100 ), false )
				call SetUnitAnimation( MUIUnit( 100 ), "Spell Channel" )
				call SaveInteger( HashTable, HandleID, 110, 255 )
				call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ) ) )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) - 10 )
			call SetUnitXAndY( MUIUnit( 100 ), GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), DistanceBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) / 20, AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) )
			call SetUnitVertexColor( MUIUnit( 100 ), 255, 255, 255, LoadInteger( HashTable, HandleID, 110 ) )

			if DistanceBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) <= 150 then
				call PlaySoundWithVolume( LoadSound( "AkameW1" ), 90, 0 )
				call AddEffectXY( "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 153, 0, 0, 255 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "origin" ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUIPower( 1. ) )
				call SetUnitAnimation( MUIUnit( 100 ), "attack" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )
		local integer LocCount  = LoadInteger( HashTable, HandleID, 1 )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )

		if StopSpell( HandleID, 1 ) == false then
			if IsCounted == true then
				call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )
			else
				call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )
			endif

			if LocTime == 1 then
				call LinearDisplacement( MUIUnit( 100 ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), DistanceBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) - 150, .4, .01, false, false, "origin", DashEff( ) )
				call CCUnit( MUIUnit( 100 ), 2.8, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
				call PlaySoundWithVolume( LoadSound( "AkameE1" ), 80, 0 )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "AkameD1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 0, 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 2., GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call LinearDisplacement( MUIUnit( 101 ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), 400, .5, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 30 + MUIPower( .25 ) )
				call SetUnitAnimation( MUIUnit( 100 ), "spell two" )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), AngleBetweenUnits( MUIUnit( 101 ), MUIUnit( 100 ) ), 400, 1, .01, 0 )
			endif

			if LocTime == 140 then
				call SaveBoolean( HashTable, HandleID, 10, false )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ) ) )
				call ShowUnit( MUIUnit( 100 ), false )
			endif
			
			if IsCounted == false then
				if LocCount == 2 then
					call SaveInteger( HashTable, HandleID, 1, 1 )
					call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
					
					if LoadReal( HashTable, HandleID, 110 ) < 20 then
						call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 5 + MUIPower( .01 ) )

						if LoadReal( HashTable, HandleID, 110 ) < 16 then
							call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
						endif

						call CreateXY( GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 150., LoadReal( HashTable, HandleID, 110 ) * 24, "Effect" )
						call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
					else
						call SaveBoolean( HashTable, HandleID, 10, true )
						call CreateXY( GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 500., AngleBetweenUnits( MUIUnit( 101 ), MUIUnit( 100 ) ), "Target" )
						call ShowUnit( MUIUnit( 100 ), true )
						call UnitSelect( MUIUnit( 100 ) )
						call SetUnitPosition( MUIUnit( 100 ), GetReal( "TargetX" ), GetReal( "TargetY" ) )
						call SetUnitFacing( MUIUnit( 100 ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) )
						call SetUnitTimeScale( MUIUnit( 100 ), .1 )
						call SetUnitAnimation( MUIUnit( 100 ), "attack" )
						call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
						call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
					endif
				endif
			endif

			if LocTime == 190 then
				call PlaySoundWithVolume( LoadSound( "AkameW1" ), 90, 0 )
				call SetUnitTimeScale( MUIUnit( 100 ), 2 )
			endif
			
			if LocTime == 210 then
				call PlaySoundWithVolume( LoadSound( "AkameE2" ), 80, 0 )
				call LinearDisplacement( MUIUnit( 100 ), GetUnitFacing( MUIUnit( 100 ) ), 700, .2, .01, false, false, "origin", DashEff( ) )
				call AddEffectXY( "GeneralEffects\\AkihaClaw.mdl", 4, GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), GetUnitFacing( MUIUnit( 100 ) ), 0 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "origin" ) )
			endif
			
			if LocTime == 260 then
				call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ) ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 500 + MUIPower( 1. ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellR takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = MUIInteger( 0 )

		if StopSpell( HandleID, 1 ) == false then
			call SaveInteger( HashTable, HandleID, 0, LocTime + 1 )

			if LocTime == 1 then
				call LinearDisplacement( MUIUnit( 100 ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), DistanceBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) - 150, .6, .01, false, false, "origin", DashEff( ) )
				call CCUnit( MUIUnit( 100 ), 2.25, "Stun", false )
				call SetUnitAnimation( MUIUnit( 100 ), "spell three" )
				call CCUnit( MUIUnit( 101 ), 1, "Stun", true )
				call SaveEffectHandle( HashTable, HandleID, 108, AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", MUIUnit( 100 ), "weapon" ) )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), 0, 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.5, GetUnitX( MUIUnit( 101 ) ), GetUnitY( MUIUnit( 101 ) ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
				call LinearDisplacement( MUIUnit( 101 ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), 600, 1, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 500  )
			endif
			
			if LocTime == 75 then
				call PlaySoundWithVolume( LoadSound( "AkameR1" ), 80, 0 )
				call DisplaceUnitWithArgs( MUIUnit( 100 ), AngleBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ), DistanceBetweenUnits( MUIUnit( 100 ), MUIUnit( 101 ) ) + 600, .8, .01, 400 )
			endif

			if LocTime == 155 then
				call SetUnitTimeScale( MUIUnit( 100 ), 1.75 )
				call PlaySoundWithVolume( LoadSound( "AkameQ1" ), 80, 0 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", MUIUnit( 101 ), "chest" ) )
			endif

			if LocTime == 205 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call CCUnit( MUIUnit( 101 ), 1, "Stun", false )
				call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 100 + MUIPower( 1. ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodExplosion.mdl", MUIUnit( 101 ), "chest" ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function AkameSpells takes nothing returns boolean
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A046' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A047' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellW )
		endif

		if GetSpellAbilityId( ) == 'A048' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, true )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellE )
		endif

		if GetSpellAbilityId( ) == 'A049' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, 101, GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellR )
		endif

		return false
	endfunction	

	function HeroInit7 takes nothing returns nothing
		call SaveSound( "AkameD1", "Akame\\SpellD1.mp3" )
		call SaveSound( "AkameQ1", "Akame\\SpellQ1.mp3" )
		call SaveSound( "AkameW1", "Akame\\SpellW1.mp3" )
		call SaveSound( "AkameE1", "Akame\\SpellE1.mp3" )
		call SaveSound( "AkameE2", "Akame\\SpellE2.mp3" )
		call SaveSound( "AkameR1", "Akame\\SpellR1.mp3" )
		call TriggerAddCondition( LoadTrig( "RemoveInvisTrig" ), Condition( function AkameSpells ) )
	endfunction	

