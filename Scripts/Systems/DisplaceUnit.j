	function DisplaceUnitAction takes nothing returns nothing
		if GetReal( "InitSteep" ) < GetReal( "MaxSteep" ) and UnitLife( GetUnit( "Displaced" ) ) > 0 then
			if LoadBoolean( HashTable, GetHandleId( GetUnit( "Displaced" ) ), 1000 ) == false then
				call SetUnitX( GetUnit( "Displaced" ), RMin( RMax( GetReal( "InitX" ) + GetReal( "InitSteep" ) * GetReal( "MoveStep" ) * Cos( GetReal( "Angle" ) * 3.14159 / 180. ) * 1., GetMapBound( "MinX" ) ), GetMapBound( "MaxX" ) ) )
				call SetUnitY( GetUnit( "Displaced" ), RMin( RMax( GetReal( "InitY" ) + GetReal( "InitSteep" ) * GetReal( "MoveStep" ) * Sin( GetReal( "Angle" ) * 3.14159 / 180. ) * 1., GetMapBound( "MinY" ) ), GetMapBound( "MaxY" ) ) )
			endif
			call SaveReal( HashTable, MUIHandle( ), StringHash( "InitSteep" ), GetReal( "InitSteep" ) + 1 )
			call SetUnitFlyHeight( GetUnit( "Displaced" ), ( -( 2 * GetReal( "InitSteep" ) * GetReal( "HeightStep" ) - 1 ) * ( 2 * GetReal( "InitSteep" ) * GetReal( "HeightStep" ) - 1 ) + 1 ) * GetReal( "MaxHeight" ) + GetReal( "DefaultHeight" ), 0 )
			call IssueImmediateOrder( GetUnit( "Displaced" ), "stop" )
		else
			call SetUnitPathing( GetUnit( "Displaced" ), true )
			call SaveBoolean( HashTable, GetHandleId( GetUnit( "Displaced" ) ), 1000, false )
			call SetUnitFlyHeight( GetUnit( "Displaced" ), GetReal( "DefaultHeight" ), 0 )
			call TimerPause( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, MUIHandle( ) )
		endif
	endfunction

	function DisplaceUnitWithArgs takes unit LocTrigUnit, real LocAngle, real LocTotalDist, real LocTotalTime, real LocRate, real LocHeightMax returns nothing
		local integer LocPID
		local integer HandleID
		local integer LocSteepMax = R2I( LocTotalTime / LocRate )

		if LocTrigUnit != null then
			set LocPID = GetPlayerId( GetOwningPlayer( LocTrigUnit ) )
			set HandleID = NewMUITimer( LocPID )
			call UnitAddAbility( LocTrigUnit, 'Amrf' )
			call UnitRemoveAbility( LocTrigUnit, 'Amrf' )		
			call SetUnitPathing( LocTrigUnit, false )
			call SaveInteger( HashTable, GetHandleId( LocTrigUnit ), 50, 1 )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Displaced" ), LocTrigUnit )	
		//	call SaveReal( HashTable, HandleID, StringHash( "InitHeight" ), GetUnitFlyHeight( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, StringHash( "DefaultHeight" ), GetUnitDefaultFlyHeight( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, StringHash( "Angle" ), LocAngle )
			call SaveReal( HashTable, HandleID, StringHash( "MoveStep" ), LocTotalDist / LocSteepMax )
			call SaveReal( HashTable, HandleID, StringHash( "MaxHeight" ), LocHeightMax )
			call SaveReal( HashTable, HandleID, StringHash( "HeightStep" ), 1. / LocSteepMax )
			call SaveReal( HashTable, HandleID, StringHash( "InitX" ), GetUnitX( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, StringHash( "InitY" ), GetUnitY( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, StringHash( "InitSteep" ), 0 )
			call SaveReal( HashTable, HandleID, StringHash( "MaxSteep" ), LocTotalTime / LocRate )
			call SaveBoolean( HashTable, GetHandleId( LocTrigUnit ), 1000, false )
			call TimerStart( LoadMUITimer( LocPID ), LocRate, true, function DisplaceUnitAction )
		endif
	endfunction

