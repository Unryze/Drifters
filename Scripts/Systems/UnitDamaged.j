	function GetSource takes nothing returns unit
		return LoadUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Source" ) )
	endfunction

	function GetTarget takes nothing returns unit
		return LoadUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Target" ) )
	endfunction	

	function ReinforceAoEDamage takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( GetSource( ) ) ) then
			call DestroyEffect( AddSpecialEffectTarget( "Effects\\Reinforce\\BlackMist.mdl", GetFilterUnit( ), "chest" ) )
			call TargetDamage( GetSource( ), GetFilterUnit( ), "AoE", "Magical", LoadReal( HashTable, GetHandleId( GetSource( ) ), 200 ) )
			call DamageVisualDrawNumberAction( GetSource( ), GetFilterUnit( ), LoadReal( HashTable, GetHandleId( GetSource( ) ), 200 ) )
		endif

		return true
	endfunction	

	function AkamePoisonDamage takes nothing returns nothing
		if GetUnitAbilityLevel( MUIUnit( 101 ), 'B006' ) > 0 then
			call TargetDamage( MUIUnit( 100 ), MUIUnit( 101 ), "Target", "Physical", 10 + MUILevel( ) + .1 * MUIPower( ) )
		else
			call ClearAllData( MUIHandle( ) )
		endif
	endfunction

	function InitAkamePoison takes unit LocTrigUnit, unit LocTargUnit returns nothing
		local integer LocPID = GetPlayerId( GetOwningPlayer( LocTrigUnit ) )
		local integer HandleID = NewMUITimer( LocPID )

		call SaveUnitHandle( HashTable, HandleID, 100, LocTrigUnit )
		call SaveUnitHandle( HashTable, HandleID, 101, LocTargUnit )
		call TimerStart( LoadMUITimer( LocPID ), 1, true, function AkamePoisonDamage )
	endfunction 

	function UnitDamagedAction takes nothing returns nothing
		local real 		SourceDmg 	= GetEventDamage( )
		local real		Multiplier	= 1
		local real 		DealtDmg 	= 0
		local real 		DmgMult		= 0
		local real 		LocReqHP	= 0

		if SourceDmg > 1 then
			call SaveUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Source" ), GetEventDamageSource( ) )
			call SaveUnitHandle( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ), StringHash( "Target" ), GetTriggerUnit( ) )
			call DisableTrigger( GetTriggeringTrigger( ) )
			
			if GetUnitTypeId( GetSource( ) ) == 'H00A' then
				call SetWidgetLife( GetSource( ), UnitLife( GetSource( ) ) + SourceDmg * .15 )
			endif

			if GetUnitTypeId( GetSource( ) ) == 'H006' then
				if GetUnitAbilityLevel( GetTarget( ), 'B006' ) <= 0 then
					call InitAkamePoison( GetSource( ), GetTarget( ) )
				endif

				call IssueTargetOrder( LoadUnit( I2S( GetPlayerId( GetOwningPlayer( GetSource( ) ) ) ) ), "slow", GetTarget( ) )
			endif

			if GetUnitAbilityLevel( GetSource( ), 'B002' ) > 0 or GetUnitAbilityLevel( GetSource( ), 'B000' ) > 0 then
				if GetUnitAbilityLevel( GetSource( ), 'B002' ) > 0 then
					set DmgMult = 10
				endif

				if GetUnitAbilityLevel( GetSource( ), 'B000' ) > 0 then
					set DmgMult = 20
				endif

				if UnitHasItemById( GetSource( ), 'NONE' ) then
					set DmgMult = DmgMult + DmgMult / 2
					set LocReqHP = 10
				else
					set LocReqHP = 5
				endif

				set DealtDmg = GetHeroLevel( GetSource( ) ) * DmgMult + GetHeroInt( GetSource( ), true ) * DmgMult / 100

				if GetUnitStatePercentage( GetTarget( ), UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE ) <= LocReqHP then
					if GetUnitAbilityLevel( GetSource( ), 'B002' ) > 0 then
						call ResetAbilityCooldown( GetSource( ), 'A02X' )
						call UnitRemoveAbility( GetSource( ), 'B002' )
					endif

					if GetUnitAbilityLevel( GetSource( ), 'B000' ) > 0 then
						call ResetAbilityCooldown( GetSource( ), 'A035' )
						call UnitRemoveAbility( GetSource( ), 'B000' )
					endif

					call SaveLocationHandle( HashTable, GetHandleId( GetTarget( ) ), 250, GetUnitLoc( GetTarget( ) ) )
					call AddEffect( "Effects\\Nanaya\\ArcDrive1.mdl", 4, LoadLocationHandle( HashTable, GetHandleId( GetTarget( ) ), 250 ), 270, 0 )
					set DealtDmg = 100000000
					call DestroyEffect( AddSpecialEffect( "GeneralEffects\\BloodEffect1.mdl", GetUnitX( GetTarget( ) ), GetUnitY( GetTarget( ) ) ) )
					call RemoveLocation( LoadLocationHandle( HashTable, GetHandleId( GetTarget( ) ), 250 ) )
				endif

				call TargetDamage( GetSource( ), GetTarget( ), "Target", "Physical", DealtDmg )
			endif 

			if GetUnitTypeId( GetSource( ) ) == 'H009' and LoadInteger( HashTable, GetHandleId( GetSource( ) ), 0 ) > 0 then
				call SaveReal( HashTable, GetHandleId( GetSource( ) ), 200, GetHeroInt( GetSource( ), true ) * .25 )
				call GroupEnumUnitsInRange( EnumUnits( ), GetUnitX( GetTarget( ) ), GetUnitY( GetTarget( ) ), 250, Filter( function ReinforceAoEDamage ) )
				call SaveInteger( HashTable, GetHandleId( GetSource( ) ), 0, LoadInteger( HashTable, GetHandleId( GetSource( ) ), 0 ) - 1 )
			endif

			if GetUnitTypeId( GetSource( ) ) == 'H007' then
				if IsUnitType( GetTarget( ), UNIT_TYPE_HERO ) == false then
					set Multiplier = 2
				endif

				set DmgMult = 0.01 * Multiplier
				set DealtDmg = .005 * Multiplier * UnitMaxLife( GetTarget( ) )
				call TargetDamage( GetSource( ), GetTarget( ), "Target", "Physical", DealtDmg )
				call SetWidgetLife( GetSource( ), UnitMaxLife( GetSource( ) ) * DmgMult + UnitLife( GetSource( ) ) )
			endif

			if GetUnitTypeId( GetTarget( ) ) == 'tstu' then
				call SetWidgetLife( GetTarget( ), UnitMaxLife( GetTarget( ) ) )
			endif
		endif

		call FlushChildHashtable( HashTable, GetHandleId( LoadTrig( "UnitDamagedTrig" ) ) )
		call EnableTrigger( GetTriggeringTrigger( ) )
	endfunction

