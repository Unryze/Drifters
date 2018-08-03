	function AddEffect takes string LocName, real LocScale, location LocLoc, real LocFacing, real LocRotation returns nothing
		local integer DummyID = 'u001'

		if LocRotation == 45 then
			set DummyID = 'u002'
		endif
		
		if LocRotation == 90 then
			set DummyID = 'u003'
		endif

		call SaveUnit( "DummyUnit", CreateUnitAtLoc( Player( PLAYER_NEUTRAL_PASSIVE ), DummyID, LocLoc, LocFacing ) )
		call DestroyEffect( AddSpecialEffectTarget( LocName, LoadUnit( "DummyUnit" ), "origin" ) )
		call ScaleUnit( LoadUnit( "DummyUnit" ), LocScale )
	endfunction

	function AddMultipleEffects takes integer LocCount, string LocName, real LocScale, location LocLocation, real LocFacing, real LocRotation, integer LocRed, integer LocBlue, integer LocGreen, integer LocAlpha returns nothing
		loop
			exitwhen LocCount == 0
			call AddEffect( LocName, LocScale, LocLocation, LocFacing, LocRotation )
			call SetUnitVertexColor( LoadUnit( "DummyUnit" ), LocRed, LocBlue, LocGreen, LocAlpha )
			set LocCount = LocCount - 1
		endloop
	endfunction 

