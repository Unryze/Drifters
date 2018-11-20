	function AoEDamageAction takes nothing returns boolean
		if UnitLife( GetFilterUnit( ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( GetUnit( "Source" ) ) ) and IsUnitIgnored( GetFilterUnit( ) ) != 1 then
			if GetBool( "IsRepeated" ) == false then
				call SaveInteger( HashTable, MUIHandle( ), GetHandleId( GetFilterUnit( ) ), 1 )
			endif

			if GetReal( "CCDuration" ) > 0 then
				call CCUnit( GetFilterUnit( ), GetReal( "CCDuration" ), GetStr( "CCType" ), true )
			endif

			if GetReal( "AoEDistance" ) != 0 then
				call AoEDisplaceAction( GetFilterUnit( ) )
			endif

			if GetBool( "IsSkillShot" ) == true then
				call SaveReal( HashTable, MUIHandle( ), StringHash( "InitDistance" ), GetReal( "MaxDistance" ) + 100 )
			endif

			if GetInt( "IsEnabled" ) != 0 and GetStr( "AxisName" ) != "" then
				call SetUnitPosition( GetFilterUnit( ), GetReal( GetStr( "AxisName" ) + "X" ), GetReal( GetStr( "AxisName" ) + "Y" ) )
			endif

			if GetStr( "UnitEffect" ) != "" then
				call DestroyEffect( AddSpecialEffectTarget( GetStr( "UnitEffect" ), GetFilterUnit( ), "chest" ) )
			endif

			if GetReal( "Damage" ) > 0 then
				call TargetDamage( GetUnit( "Source" ), GetFilterUnit( ), GetStr( "TargType" ), GetStr( "DmgType" ), GetReal( "Damage" ) )
			endif
			
			if GetBool( "IsSingleTarget" ) == true then
				call SaveReal( HashTable, MUIHandle( ), StringHash( "Damage" ), 0 )
			endif
		endif

		return true
	endfunction	

	function AoEDamageXY takes integer HandleID, real LocX, real LocY, real GetAoE, string TargType, string DmgType, real Damage, boolean IsRepeated, string CCType, real CCDur returns nothing
		if GetBool( "IgnoreUpdate" ) == false then
			call SaveStr( HashTable, HandleID, StringHash( "TargType" ), TargType )
			call SaveStr( HashTable, HandleID, StringHash( "DmgType" ), DmgType )
			call SaveStr( HashTable, HandleID, StringHash( "CCType" ), CCType )
			call SaveReal( HashTable, HandleID, StringHash( "CCDuration" ), CCDur )
			call SaveBoolean( HashTable, HandleID, StringHash( "IsRepeated" ), IsRepeated )
			call SaveReal( HashTable, HandleID, StringHash( "Damage" ), Damage )
		endif
		call GroupEnumUnitsInRange( EnumUnits( ), LocX, LocY, GetAoE, Filter( function AoEDamageAction ) )
	endfunction	

