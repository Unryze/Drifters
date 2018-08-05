	function AoEDamageAction takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) and UnitLife( GetFilterUnit( ) ) > 0 and IsUnitIgnored( GetFilterUnit( ) ) != 1 then
			if IsDamageRepeated( ) == false then
				call SaveInteger( HashTable, MUIHandle( ), GetHandleId( GetFilterUnit( ) ), 1 )
			endif
			
			if GetStunDur( ) > 0 then
				call StunUnit( GetFilterUnit( ), GetStunDur( ) )
			endif
			
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), LoadTargType( ), LoadDmgType( ), LoadGroupDamage( ) )
		endif

		return true
	endfunction	
	
	function AoEDamage takes integer HandleID, location GetLoc, real GetAoE, string TargType, string DmgType, real Damage, boolean IsRepeated, real StunDur returns nothing
		if LoadBoolean( HashTable, HandleID, StringHash( "IsUpdated" ) ) == false then
			call SaveStr( HashTable, HandleID, StringHash( "TargType" ), TargType )
			call SaveStr( HashTable, HandleID, StringHash( "DmgType" ), DmgType )
			call SaveReal( HashTable, HandleID, StringHash( "StunDuration" ), StunDur )
			call SaveBoolean( HashTable, HandleID, StringHash( "IsRepeated" ), IsRepeated )
			call SaveBoolean( HashTable, HandleID, StringHash( "IsUpdated" ), true )
		endif

		call SaveReal( HashTable, HandleID, StringHash( "Damage" ), Damage )
		call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), GetLoc, GetAoE, Filter( function AoEDamageAction ) )
	endfunction

