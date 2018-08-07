	function SpiralMovementAction takes nothing returns boolean
		if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) and UnitLife( GetFilterUnit( ) ) > 0 then
			call SetUnitPositionLoc( GetFilterUnit( ), MUILocation( 109 ) )
		endif

		return true
	endfunction

	function SpiralMovement takes integer HandleID returns nothing
		if GetReal( "Limit" ) >= 0 then
			call SaveReal( HashTable, HandleID, StringHash( "Limit" ), GetReal( "Limit" ) - GetReal( "Step" ) )
			call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( GetInt( "LocationID" ) ), GetReal( "Limit" ), GetReal( "Limit" ) ) )
			call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 109 ), GetReal( "Area" ), Filter( function SpiralMovementAction ) )
			call DestroyEffect( AddSpecialEffectLoc( GetStr( "Effect" ), MUILocation( 109 ) ) )
			call RemoveLocation( MUILocation( 109 ) )
			call SaveLocationHandle( HashTable, HandleID, 109, CreateLocation( MUILocation( GetInt( "LocationID" ) ), GetReal( "Limit" ), GetReal( "Limit" ) + 180 ) )
			call GroupEnumUnitsInRangeOfLoc( EnumUnits( ), MUILocation( 109 ), GetReal( "Area" ), Filter( function SpiralMovementAction ) )
			call DestroyEffect( AddSpecialEffectLoc( GetStr( "Effect" ), MUILocation( 109 ) ) )
			call RemoveLocation( MUILocation( 109 ) )
		endif
	endfunction

	function InitSpiral takes integer HandleID, integer LocationID, real Area, real Step, real Limit, string Effect returns nothing
		call SaveInteger( HashTable, HandleID, StringHash( "LocationID" ), LocationID )
		call SaveReal( HashTable, HandleID, StringHash( "Area" ), Area )
		call SaveReal( HashTable, HandleID, StringHash( "Step" ), Step )
		call SaveReal( HashTable, HandleID, StringHash( "Limit" ), Limit )
		call SaveStr( HashTable, HandleID, StringHash( "Effect" ), Effect )
	endfunction

