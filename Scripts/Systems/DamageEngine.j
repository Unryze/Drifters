	function SetDamageDealt takes unit LocTrigUnit, unit LocTargUnit, string GetTargetType, attacktype GetAtkType, damagetype GetDmgType, real LocDamage, boolean IsHealed returns nothing
		local real Healing

		if GetUnitAbilityLevel( LocTargUnit, 'B008' ) > 0 and UnitLife( LocTargUnit ) > LocDamage then
			call SaveReal( HashTable, GetHandleId( LocTargUnit ), StringHash( "Mitigated" ), LocDamage + LoadReal( HashTable, GetHandleId( LocTargUnit ), StringHash( "Mitigated" ) ) )
			set LocDamage = 0
			call DisplayTextToPlayer( GetOwningPlayer( LocTargUnit ), 0, 0, "Damage Absorbed: " + I2S( R2I( LoadReal( HashTable, GetHandleId( LocTargUnit ), StringHash( "Mitigated" ) ) ) ) )
		endif

		if GetUnitTypeId( LocTrigUnit ) == 'H010' and IsHealed == true then
			set Healing = LocDamage * .15

			if GetTargetType == "AoE" then
				set Healing = Healing / 3
			endif

			call SetWidgetLife( LocTrigUnit, UnitLife( LocTrigUnit ) + Healing )
		endif
		
		if GetUnitTypeId( LocTrigUnit ) == 'H001' and UnitMaxLife( LocTargUnit ) > UnitMaxLife( LocTrigUnit ) then
			// Example: 2000 / 1000 / 4 = .5 -> 1. + .5 = 1.5 -> LocDamage * 1.5 ( 50% damage increase )
			set LocDamage = LocDamage * ( 1. + UnitMaxLife( LocTargUnit ) / UnitMaxLife( LocTrigUnit ) / 4 )
		endif

		if LocDamage > 0 then
			if LoadBoolean( HashTable, GetHandleId( LocTrigUnit ), StringHash( "HideDamage" ) ) == false then
				call DamageVisualDrawNumberAction( LocTrigUnit, LocTargUnit, LocDamage )
			endif
			
			if GetUnitAbilityLevel( LocTrigUnit, 'B000' ) > 0 then
				call UnitRemoveAbility( LocTrigUnit, 'B000' )

				if GetUnitStatePercentage( LocTargUnit, UNIT_STATE_LIFE, UNIT_STATE_MAX_LIFE ) <= 20 then
					call AddEffectXY( "Effects\\Nanaya\\ArcDrive1.mdl", 4, GetUnitX( LocTargUnit ), GetUnitY( LocTargUnit ), 270, 0 )
					set LocDamage = 9999999999
				endif
			endif

			call UnitDamageTarget( LoadUnit( I2S( GetPlayerId( GetOwningPlayer( LocTrigUnit ) ) ) ), LocTargUnit, LocDamage, true, false, GetAtkType, GetDmgType, WEAPON_TYPE_WHOKNOWS )
		endif
	endfunction	

	function TargetDamage takes unit LocTrigUnit, unit LocTargUnit, string GetTargetType, string GetDmgType, real LocDamage returns nothing
		local real TruePercent = LoadReal( HashTable, GetHandleId( LocTrigUnit ), StringHash( "TrueDamage" ) ) 
		local real TrueDamage  = LocDamage * ( TruePercent / 100 )
		local real NormDamage  = LocDamage - TrueDamage

		if GetDmgType == "Physical" then
			call SetDamageDealt( LocTrigUnit, LocTargUnit, GetTargetType, ATTACK_TYPE_HERO, DAMAGE_TYPE_NORMAL, NormDamage, true )
			call SetDamageDealt( LocTrigUnit, LocTargUnit, GetTargetType, ATTACK_TYPE_HERO, DAMAGE_TYPE_UNIVERSAL, TrueDamage, false )
	elseif GetDmgType == "Magical" then
			call SetDamageDealt( LocTrigUnit, LocTargUnit, GetTargetType, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, NormDamage, true )
			call SetDamageDealt( LocTrigUnit, LocTargUnit, GetTargetType, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_MAGIC, TrueDamage, false )
		else
			// If wrong parameter is sent or is empty then default damage is applied, that cannot damage spell-immune or ethereal.
			call SetDamageDealt( LocTrigUnit, LocTargUnit, GetTargetType, ATTACK_TYPE_MELEE, DAMAGE_TYPE_MAGIC, LocDamage, true )
		endif
	endfunction

