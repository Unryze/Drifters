	function SetDamageDealt takes unit LocTrigUnit, unit LocTargUnit, string GetTargetType, attacktype GetAtkType, damagetype GetDmgType, real LocDamage, boolean IsHealed returns nothing
		local real Healing

		if GetDmgType == DAMAGE_TYPE_MAGIC and GetUnitAbilityLevel( LocTargUnit, 'B04J' ) > 0 and UnitLife( LocTargUnit ) > LocDamage then
			call SaveReal( HashTable, GetHandleId( LocTargUnit ), 500, LocDamage + LoadReal( HashTable, GetHandleId( LocTargUnit ), 500 ) )
			set LocDamage = 0
			call DisplayTextToPlayer( GetOwningPlayer( LocTargUnit ), 0, 0, "Damage Absorbed: " + I2S( R2I( LoadReal( HashTable, GetHandleId( LocTargUnit ), 500 ) ) ) )
		endif

		if GetUnitTypeId( LocTrigUnit ) == 'H00A' and IsHealed == true then
			set Healing = LocDamage * .15

			if GetTargetType == "AoE" then
				set Healing = Healing / 3
			endif

			call SetWidgetLife( LocTrigUnit, UnitLife( LocTrigUnit ) + Healing )
		endif

		if LocDamage > 0 then
			call DamageVisualDrawNumberAction( LocTrigUnit, LocTargUnit, LocDamage )
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
			// If no parameter is sent or is empty then default damage is applied, that cannot damage spell-immune or ethereal
			call SetDamageDealt( LocTrigUnit, LocTargUnit, GetTargetType, ATTACK_TYPE_MELEE, DAMAGE_TYPE_MAGIC, LocDamage, true )
		endif
	endfunction

