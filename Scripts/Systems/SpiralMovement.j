	function SpiralMovementAction takes nothing returns boolean
		if UnitLife( GetFilterUnit( ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( GetUnit( "Source" ) ) ) then
			call SetUnitPosition( GetFilterUnit( ), GetReal( "SpiralX" ), GetReal( "SpiralY" ) )
		endif

		return true
	endfunction

	function SpiralMovement takes integer HandleID returns nothing
		if GetReal( "Limit" ) >= 0 then
			call SaveReal( HashTable, HandleID, StringHash( "Limit" ), GetReal( "Limit" ) - GetReal( "Step" ) )
			call CreateXY( GetReal( "InitSpiralX" ), GetReal( "InitSpiralY" ), GetReal( "Limit" ), GetReal( "Limit" ), "Spiral" )
			call GroupEnumUnitsInRange( EnumUnits( ), GetReal( "SpiralX" ), GetReal( "SpiralY" ), GetReal( "Area" ), Filter( function SpiralMovementAction ) )
			call DestroyEffect( AddSpecialEffect( GetStr( "Effect" ), GetReal( "SpiralX" ), GetReal( "SpiralY" ) ) )
			call CreateXY( GetReal( "InitSpiralX" ), GetReal( "InitSpiralY" ), GetReal( "Limit" ), GetReal( "Limit" ) + 180, "Spiral" )
			call GroupEnumUnitsInRange( EnumUnits( ), GetReal( "SpiralX" ), GetReal( "SpiralY" ), GetReal( "Area" ), Filter( function SpiralMovementAction ) )
			call DestroyEffect( AddSpecialEffect( GetStr( "Effect" ), GetReal( "SpiralX" ), GetReal( "SpiralY" ) ) )
		endif
	endfunction

	function InitSpiralXY takes integer HandleID, real LocX, real LocY, real Area, real Step, real Limit, string Effect returns nothing
		call SaveReal( HashTable, HandleID, StringHash( "InitSpiralX" ), LocX )
		call SaveReal( HashTable, HandleID, StringHash( "InitSpiralY" ), LocY )
		call SaveReal( HashTable, HandleID, StringHash( "Area" ), Area )
		call SaveReal( HashTable, HandleID, StringHash( "Step" ), Step )
		call SaveReal( HashTable, HandleID, StringHash( "Limit" ), Limit )
		call SaveStr( HashTable, HandleID, StringHash( "Effect" ), Effect )
	endfunction

