	function SkillShotMovement takes integer HandleID returns nothing
		if GetReal( "InitDistance" ) <= GetReal( "MaxDistance" ) and UnitLife( MUIUnit( StringHash( "GetDummy" ) ) ) > 0 then
			call SaveReal( HashTable, HandleID, StringHash( "InitDistance" ), GetReal( "InitDistance" ) + GetReal( "Step" ) )
			call SaveLocationHandle( HashTable, HandleID, StringHash( "TempLoc" ), CreateLocation( MUILocation( StringHash( "GetInitLoc" ) ), GetReal( "InitDistance" ), MUIAngle( GetInt( "InitLocID" ), GetInt( "TargLocID" ) ) ) )
			call SetUnitPositionLoc( MUIUnit( StringHash( "GetDummy" ) ), GetLoc( "TempLoc" ) )
			call AoEDamage( MUIHandle( ), GetLoc( "TempLoc" ), 200, "", "", 0, true, 0 )
		else
			call SaveLocationHandle( HashTable, HandleID, StringHash( "GetInitLoc" ), GetLoc( "TempLoc" ) )
			call KillUnit( MUIUnit( StringHash( "GetDummy" ) ) )
			call DestroyEffect( MUIEffect( StringHash( "DummyEffect" ) ) )
		endif
		
		call RemoveLocation( GetLoc( "TempLoc" ) )
	endfunction

	function InitSkillShot takes integer LocUnitID, integer HandleID, integer InitLocID, integer TargLocID, real InitDistance, real Step, real MaxDistance, real Scale, real AoE, string Effect returns integer
		call SaveInteger( HashTable, HandleID, StringHash( "InitLocID" ), InitLocID )
		call SaveInteger( HashTable, HandleID, StringHash( "TargLocID" ), TargLocID )
		call SaveReal( HashTable, HandleID, StringHash( "InitDistance" ), 0 )
		call SaveReal( HashTable, HandleID, StringHash( "Step" ), Step )
		call SaveReal( HashTable, HandleID, StringHash( "MaxDistance" ), MaxDistance )
		call SaveReal( HashTable, HandleID, StringHash( "Scale" ), Scale )
		call SaveReal( HashTable, HandleID, StringHash( "AoE" ), AoE )
		call SaveLocationHandle( HashTable, HandleID, StringHash( "GetInitLoc" ), CreateLocation( MUILocation( InitLocID ), InitDistance, GetUnitFacing( MUIUnit( LocUnitID ) ) ) )
		call MUIDummy( StringHash( "GetDummy" ), 'u001', StringHash( "GetInitLoc" ), MUIAngle( InitLocID, TargLocID ) )
		call ScaleUnit( MUIUnit( StringHash( "GetDummy" ) ), Scale )
		call SetUnitPathing( MUIUnit( StringHash( "GetDummy" ) ), false )
		call MUISaveEffect( StringHash( "DummyEffect" ), Effect, StringHash( "GetDummy" ) )
		return GetHandleId( GetLoc( "GetInitLoc" ) )
	endfunction

