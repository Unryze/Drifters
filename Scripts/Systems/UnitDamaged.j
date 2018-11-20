	function GetSource takes nothing returns unit
		return LoadUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Source" ) )
	endfunction

	function GetTarget takes nothing returns unit
		return LoadUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Target" ) )
	endfunction	

	function ReinforceAoEDamage takes nothing returns boolean
		if UnitLife( GetFilterUnit( ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( GetSource( ) ) ) then
			call DestroyEffect( AddSpecialEffectTarget( "Effects\\Reinforce\\BlackMist.mdl", GetFilterUnit( ), "chest" ) )
			call TargetDamage( GetSource( ), GetFilterUnit( ), "AoE", "Magical", LoadReal( HashTable, GetHandleId( GetSource( ) ), StringHash( "ShadowDamage" ) ) )
			call DamageVisualDrawNumberAction( GetSource( ), GetFilterUnit( ), LoadReal( HashTable, GetHandleId( GetSource( ) ), StringHash( "ShadowDamage" ) ) )
		endif

		return true
	endfunction	

	function AkamePoisonDamage takes nothing returns nothing
		if GetUnitAbilityLevel( GetUnit( "Target" ), 'B003' ) > 0 then
			call TargetDamage( GetUnit( "Source" ), GetUnit( "Target" ), "Target", "Physical", 10 + GetPower( .1 ) )
		else
			call ClearAllData( MUIHandle( ) )
		endif
	endfunction

	function InitAkamePoison takes unit LocTrigUnit, unit LocTargUnit returns nothing
		local integer LocPID = GetPlayerId( GetOwningPlayer( LocTrigUnit ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, StringHash( "Source" ), LocTrigUnit )
		call SaveUnitHandle( HashTable, HandleID, StringHash( "Target" ), LocTargUnit )
		call TimerStart( LoadMUITimer( LocPID ), 1, true, function AkamePoisonDamage )
	endfunction 

	function UnitDamagedAction takes nothing returns nothing
		local integer SourceID
		local integer TargetID 
		local real SourceDmg  = GetEventDamage( )
		local real Multiplier = 1

		if SourceDmg > 1 then
			call DisableTrigger( GetTriggeringTrigger( ) )
			call SaveUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Source" ), GetEventDamageSource( ) )
			call SaveUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Target" ), GetTriggerUnit( ) )
			set SourceID = GetUnitTypeId( GetSource( ) )
			set TargetID = GetUnitTypeId( GetTarget( ) )

			if SourceID == 'H005' or SourceID == 'H007' then
				call SaveBoolean( HashTable, GetHandleId( GetSource( ) ), StringHash( "HideDamage" ), true )

				if SourceID == 'H005' then
					call TargetDamage( GetSource( ), GetTarget( ), "Target", "Magical", 20 + GetHeroInt( GetSource( ), true ) * .1 )
				endif

				if SourceID == 'H007' then
					if IsUnitType( GetTarget( ), UNIT_TYPE_HERO ) == false then
						set Multiplier = 2
					endif

					call TargetDamage( GetSource( ), GetTarget( ), "Target", "Physical", .005 * Multiplier * UnitMaxLife( GetTarget( ) ) )
					call SetWidgetLife( GetSource( ), ( UnitMaxLife( GetSource( ) ) * Multiplier ) / 100 + UnitLife( GetSource( ) ) )
				endif

				call SaveBoolean( HashTable, GetHandleId( GetSource( ) ), StringHash( "HideDamage" ), false )
			endif

			if SourceID == 'H010' then
				call SetWidgetLife( GetSource( ), UnitLife( GetSource( ) ) + SourceDmg * .15 )
			endif

			if SourceID == 'H006' then
				if GetUnitAbilityLevel( GetTarget( ), 'B003' ) <= 0 then
					call InitAkamePoison( GetSource( ), GetTarget( ) )
				endif

				call IssueTargetOrder( LoadUnit( I2S( GetPlayerId( GetOwningPlayer( GetSource( ) ) ) ) ), "cripple", GetTarget( ) )
			endif

			if SourceID == 'H009' and LoadInteger( HashTable, GetHandleId( GetSource( ) ), StringHash( "ShadowStack" ) ) > 0 then
				call SaveReal( HashTable, GetHandleId( GetSource( ) ), StringHash( "ShadowDamage" ), GetHeroInt( GetSource( ), true ) * .25 )
				call GroupEnumUnitsInRange( EnumUnits( ), GetUnitX( GetTarget( ) ), GetUnitY( GetTarget( ) ), 250, Filter( function ReinforceAoEDamage ) )
				call SaveInteger( HashTable, GetHandleId( GetSource( ) ), StringHash( "ShadowStack" ), LoadInteger( HashTable, GetHandleId( GetSource( ) ), StringHash( "ShadowStack" ) ) - 1 )
			endif

			if TargetID == 'tstu' then
				call SetWidgetLife( GetTarget( ), UnitMaxLife( GetTarget( ) ) )
			endif

			call FlushChildHashtable( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ) )
			call EnableTrigger( GetTriggeringTrigger( ) )
		endif
	endfunction

