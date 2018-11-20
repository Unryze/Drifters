	function AkameSpellQ takes nothing returns nothing
		local integer HandleID = MUIHandle( )
		local integer LocTime  = GetInt( "SpellTime" )

		if StopSpell( HandleID, 0 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call CCUnit( GetUnit( "Source" ), .25, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Four" )
			endif

			if LocTime == 20 then
				call PlaySoundWithVolume( LoadSound( "AkameQ1" ), 60, 0 )
				call CreateXY( GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), 200., GetUnitFacing( GetUnit( "Source" ) ), "Effect" )
				call AddEffectXY( "GeneralEffects\\AkihaClaw.mdl", 1.5, GetReal( "EffectX" ), GetReal( "EffectY" ), GetUnitFacing( GetUnit( "Source" ) ) - 90, 0 )
				call SaveStr( HashTable, HandleID, StringHash( "UnitEffect" ), "GeneralEffects\\BloodEffect1.mdl" )
				call AoEDamageXY( HandleID, GetReal( "EffectX" ), GetReal( "EffectY" ), 400, "AoE", "Physical", 250 + GetPower( 1. ), false, "Stun", 1 )
			endif

			if LocTime == 25 then
				call FlushChildHashtable( HashTable, HandleID )
			endif
		endif
	endfunction

	function AkameSpellW takes nothing returns nothing
		local integer HandleID = MUIHandle( )

		if StopSpell( HandleID, 1 ) == false then
			if GetInt( "SpellTime" ) < 1 then
				call SpellTime( )
				call CCUnit( GetUnit( "Source" ), ( DistanceBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) - 150 ) / 1000, "Stun", false )
				call SetUnitPathing( GetUnit( "Source" ), false )
				call SetUnitAnimation( GetUnit( "Source" ), "Spell Channel" )
				call SaveInteger( HashTable, HandleID, 110, 255 )
				call SaveEffectHandle( HashTable, HandleID, StringHash( "Effect0" ), AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", GetUnit( "Source" ), "weapon" ) )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ) ) )
			endif

			call SaveInteger( HashTable, HandleID, 110, LoadInteger( HashTable, HandleID, 110 ) - 10 )
			call SetUnitXAndY( GetUnit( "Source" ), GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), DistanceBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) / 20, AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) )
			call SetUnitVertexColor( GetUnit( "Source" ), 255, 255, 255, LoadInteger( HashTable, HandleID, 110 ) )

			if DistanceBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) <= 150 then
				call PlaySoundWithVolume( LoadSound( "AkameW1" ), 90, 0 )
				call AddEffectXY( "GeneralEffects\\FireSlashSlow\\FireSlashSlow.mdl", 4, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), 0 )
				call SetUnitVertexColor( LoadUnit( "DummyUnit" ), 153, 0, 0, 255 )
				call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), 150, 99999 )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "origin" ) )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 100 + GetPower( 1. ) )
				call SetUnitAnimation( GetUnit( "Source" ), "attack" )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellE takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )
		local integer LocCount  = LoadInteger( HashTable, HandleID, 1 )
		local boolean IsCounted = LoadBoolean( HashTable, HandleID, 10 )

		if StopSpell( HandleID, 1 ) == false then
			if IsCounted == true then
				call SpellTime( )
			else
				call SaveInteger( HashTable, HandleID, 1, LocCount + 1 )
			endif

			if LocTime == 1 then
				call LinearDisplacement( GetUnit( "Source" ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), DistanceBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) - 150, .4, .01, false, false, "origin", DashEff( ) )
				call CCUnit( GetUnit( "Source" ), 2.8, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell three" )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
				call PlaySoundWithVolume( LoadSound( "AkameE1" ), 80, 0 )
			endif

			if LocTime == 40 then
				call PlaySoundWithVolume( LoadSound( "AkameD1" ), 80, 0 )
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 0, 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 2., GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "chest" ) )
				call LinearDisplacement( GetUnit( "Target" ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), 400, .5, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 30 + GetPower( .25 ) )
				call SetUnitAnimation( GetUnit( "Source" ), "spell two" )
				call DisplaceUnitWithArgs( GetUnit( "Source" ), AngleBetweenUnits( GetUnit( "Target" ), GetUnit( "Source" ) ), 400, 1, .01, 0 )
			endif

			if LocTime == 140 then
				call SaveBoolean( HashTable, HandleID, 10, false )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ) ) )
				call ShowUnit( GetUnit( "Source" ), false )
			endif
			
			if IsCounted == false then
				if LocCount == 2 then
					call SaveInteger( HashTable, HandleID, 1, 1 )
					call SaveReal( HashTable, HandleID, 110, LoadReal( HashTable, HandleID, 110 ) + 1 )
					
					if LoadReal( HashTable, HandleID, 110 ) < 20 then
						call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 5 + GetPower( .01 ) )

						if LoadReal( HashTable, HandleID, 110 ) < 16 then
							call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "chest" ) )
						endif

						call CreateXY( GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 150., LoadReal( HashTable, HandleID, 110 ) * 24, "Effect" )
						call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetReal( "EffectX" ), GetReal( "EffectY" ) ) )
					else
						call SaveBoolean( HashTable, HandleID, 10, true )
						call CreateXY( GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 500., AngleBetweenUnits( GetUnit( "Target" ), GetUnit( "Source" ) ), "Target" )
						call ShowUnit( GetUnit( "Source" ), true )
						call UnitSelect( GetUnit( "Source" ) )
						call SetUnitPosition( GetUnit( "Source" ), GetReal( "TargetX" ), GetReal( "TargetY" ) )
						call SetUnitFacing( GetUnit( "Source" ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) )
						call SetUnitTimeScale( GetUnit( "Source" ), .1 )
						call SetUnitAnimation( GetUnit( "Source" ), "attack" )
						call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BlackBlink.mdl", GetReal( "TargetX" ), GetReal( "TargetY" ) ) )
						call SaveEffectHandle( HashTable, HandleID, StringHash( "Effect0" ), AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", GetUnit( "Source" ), "weapon" ) )
					endif
				endif
			endif

			if LocTime == 190 then
				call PlaySoundWithVolume( LoadSound( "AkameW1" ), 90, 0 )
				call SetUnitTimeScale( GetUnit( "Source" ), 2 )
			endif
			
			if LocTime == 210 then
				call PlaySoundWithVolume( LoadSound( "AkameE2" ), 80, 0 )
				call LinearDisplacement( GetUnit( "Source" ), GetUnitFacing( GetUnit( "Source" ) ), 700, .2, .01, false, false, "origin", DashEff( ) )
				call AddEffectXY( "GeneralEffects\\AkihaClaw.mdl", 4, GetUnitX( GetUnit( "Source" ) ), GetUnitY( GetUnit( "Source" ) ), GetUnitFacing( GetUnit( "Source" ) ), 0 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "origin" ) )
			endif
			
			if LocTime == 260 then
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ) ) )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 500 + GetPower( 1. ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction

	function AkameSpellR takes nothing returns nothing
		local integer HandleID  = MUIHandle( )
		local integer LocTime   = GetInt( "SpellTime" )

		if StopSpell( HandleID, 1 ) == false then
			call SpellTime( )

			if LocTime == 1 then
				call LinearDisplacement( GetUnit( "Source" ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), DistanceBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) - 150, .6, .01, false, false, "origin", DashEff( ) )
				call CCUnit( GetUnit( "Source" ), 2.25, "Stun", false )
				call SetUnitAnimation( GetUnit( "Source" ), "spell three" )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", true )
				call SaveEffectHandle( HashTable, HandleID, StringHash( "Effect0" ), AddSpecialEffectTarget( "Abilities\\Weapons\\PhoenixMissile\\Phoenix_Missile.mdl", GetUnit( "Source" ), "weapon" ) )
			endif

			if LocTime == 50 then
				call PlaySoundWithVolume( LoadSound( "KickSound1" ), 60, 0 )
				call AddEffectXY( "GeneralEffects\\ValkDust.mdl", 2., GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), 0, 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call AddEffectXY( "GeneralEffects\\SlamEffect.mdl", 1.5, GetUnitX( GetUnit( "Target" ) ), GetUnitY( GetUnit( "Target" ) ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), 45 )
				call MakeUnitAirborne( LoadUnit( "DummyUnit" ), 200, 99999 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "chest" ) )
				call LinearDisplacement( GetUnit( "Target" ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), 600, 1, .01, false, false, "origin", DashEff( ) )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 500  )
			endif
			
			if LocTime == 75 then
				call PlaySoundWithVolume( LoadSound( "AkameR1" ), 80, 0 )
				call DisplaceUnitWithArgs( GetUnit( "Source" ), AngleBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ), DistanceBetweenUnits( GetUnit( "Source" ), GetUnit( "Target" ) ) + 600, .8, .01, 400 )
			endif

			if LocTime == 155 then
				call SetUnitTimeScale( GetUnit( "Source" ), 1.75 )
				call PlaySoundWithVolume( LoadSound( "AkameQ1" ), 80, 0 )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodEffect1.mdl", GetUnit( "Target" ), "chest" ) )
			endif

			if LocTime == 205 then
				call PlaySoundWithVolume( LoadSound( "BloodFlow1" ), 60, 0 )
				call CCUnit( GetUnit( "Target" ), 1, "Stun", false )
				call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 100 + GetPower( 1. ) )
				call DestroyEffect( AddSpecialEffectTarget( "GeneralEffects\\BloodExplosion.mdl", GetUnit( "Target" ), "chest" ) )
				call ClearAllData( HandleID )
			endif
		endif
	endfunction
	
	function AkameSpells takes nothing returns nothing
		local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
		local integer HandleID
		
		if GetSpellAbilityId( ) == 'A046' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellQ )
		endif

		if GetSpellAbilityId( ) == 'A047' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellW )
		endif

		if GetSpellAbilityId( ) == 'A048' then
			set HandleID = NewMUITimer( LocPID )
			call SaveBoolean( HashTable, HandleID, 10, true )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellE )
		endif

		if GetSpellAbilityId( ) == 'A049' then
			set HandleID = NewMUITimer( LocPID )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), GetTriggerUnit( ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), GetSpellTargetUnit( ) )
			call TimerStart( LoadMUITimer( LocPID ), .01, true, function AkameSpellR )
		endif
	endfunction	

	function HeroInit7 takes nothing returns nothing
		call SaveSound( "AkameD1", "Akame\\SpellD1.mp3" )
		call SaveSound( "AkameQ1", "Akame\\SpellQ1.mp3" )
		call SaveSound( "AkameW1", "Akame\\SpellW1.mp3" )
		call SaveSound( "AkameE1", "Akame\\SpellE1.mp3" )
		call SaveSound( "AkameE2", "Akame\\SpellE2.mp3" )
		call SaveSound( "AkameR1", "Akame\\SpellR1.mp3" )
		call TriggerAddAction( LoadTrig( "AllHeroSpells" ), function AkameSpells )
	endfunction	

