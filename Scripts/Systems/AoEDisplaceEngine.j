	function AoEDisplaceAction takes unit LocUnit returns nothing
		call SaveReal( HashTable, MUIHandle( ), StringHash( "AoEAngle" ), MUIAngleData( GetReal( "MoveX" ), GetReal( "MoveY" ), GetUnitX( LocUnit ), GetUnitY( LocUnit ) ) )
		if GetReal( "Height" ) == 0 then
			call LinearDisplacement( LocUnit, GetReal( "AoEAngle" ), GetReal( "AoEDistance" ), GetReal( "Time" ), GetReal( "Period" ), false, false, "origin", GetStr( "Effect" ) )
		else
			call DisplaceUnitWithArgs( LocUnit, GetReal( "AoEAngle" ), GetReal( "AoEDistance" ), GetReal( "Time" ), GetReal( "Period" ), GetReal( "Height" ) )
		endif
	endfunction

	function AoEDisplaceXY takes integer HandleID, real LocX, real LocY, real Distance, real Time, real Period, real Height, string Effect returns nothing
		call SaveReal( HashTable, HandleID, StringHash( "MoveX" ), LocX )
		call SaveReal( HashTable, HandleID, StringHash( "MoveY" ), LocY )
		call SaveReal( HashTable, HandleID, StringHash( "AoEDistance" ), Distance )
		call SaveReal( HashTable, HandleID, StringHash( "Time" ), Time )
		call SaveReal( HashTable, HandleID, StringHash( "Period" ), Period )
		call SaveReal( HashTable, HandleID, StringHash( "Height" ), Height )
		call SaveStr( HashTable, HandleID, StringHash( "Effect" ), Effect )
	endfunction

