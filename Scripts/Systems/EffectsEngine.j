	function AddEffectXY takes string LocName, real LocScale, real LocX, real LocY, real LocFacing, real LocRotation returns nothing
		local integer DummyID = 'u001'

		if LocRotation == 45 then
			set DummyID = 'u002'
		endif
		
		if LocRotation == 90 then
			set DummyID = 'u003'
		endif

		call SaveUnit( "DummyUnit", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), DummyID, LocX, LocY, LocFacing ) )
		call DestroyEffect( AddSpecialEffectTarget( LocName, LoadUnit( "DummyUnit" ), "origin" ) )
		call ScaleUnit( LoadUnit( "DummyUnit" ), LocScale )
		call SetUnitFlyHeight( LoadUnit( "DummyUnit" ), GetReal( "DummyHeight" ), 0 )
	endfunction	

	function AddMultipleEffectsXY takes integer LocCount, string LocName, real LocScale, real LocX, real LocY, real LocFacing, real LocRotation, integer LocRed, integer LocBlue, integer LocGreen, integer LocAlpha returns nothing
		loop
			exitwhen LocCount == 0
			call AddEffectXY( LocName, LocScale, LocX, LocY, LocFacing, LocRotation )
			call SetUnitVertexColor( LoadUnit( "DummyUnit" ), LocRed, LocBlue, LocGreen, LocAlpha )
			set LocCount = LocCount - 1
		endloop
	endfunction

