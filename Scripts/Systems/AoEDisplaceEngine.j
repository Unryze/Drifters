	function AoEDisplaceAction takes unit LocUnit returns nothing
		call SaveLocationHandle( HashTable, MUIHandle( ), 109, GetUnitLoc( LocUnit ) )
		call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngle( GetInt( "LocationID" ), 109 ) )
		if GetReal( "Height" ) == 0 then
			call LinearDisplacement( LocUnit, GetReal( "Angle" ), GetReal( "Distance" ), GetReal( "Time" ), GetReal( "Period" ), false, false, "origin", GetStr( "Effect" ) )
		else
			call DisplaceUnitWithArgs( LocUnit, GetReal( "Angle" ), GetReal( "Distance" ), GetReal( "Time" ), GetReal( "Period" ), GetReal( "Height" ) )
		endif

		call RemoveLocation( MUILocation( 109 ) )
	endfunction

	function AoEDisplace takes integer HandleID, integer LocationID, real Distance, real Time, real Period, real Height, string Effect returns nothing
		call SaveInteger( HashTable, HandleID, StringHash( "LocationID" ), LocationID )
		call SaveReal( HashTable, HandleID, StringHash( "Distance" ), Distance )
		call SaveReal( HashTable, HandleID, StringHash( "Time" ), Time )
		call SaveReal( HashTable, HandleID, StringHash( "Period" ), Period )
		call SaveReal( HashTable, HandleID, StringHash( "Height" ), Height )
		call SaveStr( HashTable, HandleID, StringHash( "Effect" ), Effect )
	endfunction

