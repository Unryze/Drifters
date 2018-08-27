	function DisplaceUnitAction takes nothing returns nothing
		local integer   HandleID		= MUIHandle( )
	//									= MUIUnit( 0 )
	//	local real 		LocOrigHeigth 	= LoadReal( HashTable, HandleID, 1 )
		local real 		LocAngle 		= LoadReal( HashTable, HandleID, 2 )
		local real 		LocDist 		= LoadReal( HashTable, HandleID, 3 )
		local real 		LocHeightMax 	= LoadReal( HashTable, HandleID, 4 )
		local real 		LocDHeight 		= LoadReal( HashTable, HandleID, 5 )
		local real 		LocGetX 		= LoadReal( HashTable, HandleID, 6 )
		local real 		LocGetY 		= LoadReal( HashTable, HandleID, 7 )
		local integer 	LocSteep 		= MUIInteger( 8 )
		local integer 	LocSteepMax 	= MUIInteger( 9 )

		if LocSteep < LocSteepMax and UnitLife( MUIUnit( 0 ) ) > 0 then
			if LoadBoolean( HashTable, GetHandleId( MUIUnit( 0 ) ), 1000 ) == false then
				call SetUnitX( MUIUnit( 0 ), RMin( RMax( LocGetX + LocSteep * LocDist * Cos( LocAngle * 3.14159 / 180. ) * 1., GetMapBound( "MinX" ) ), GetMapBound( "MaxX" ) ) )
				call SetUnitY( MUIUnit( 0 ), RMin( RMax( LocGetY + LocSteep * LocDist * Sin( LocAngle * 3.14159 / 180. ) * 1., GetMapBound( "MinY" ) ), GetMapBound( "MaxY" ) ) )
			endif
			call SaveInteger( HashTable, HandleID, 8, LocSteep + 1 )
			call SetUnitFlyHeight( MUIUnit( 0 ), ( -( 2 * I2R( LocSteep ) * LocDHeight - 1 ) * ( 2 * I2R( LocSteep ) * LocDHeight - 1 ) + 1 ) * LocHeightMax + GetUnitDefaultFlyHeight( MUIUnit( 0 ) ), 99999 )
			call IssueImmediateOrder( MUIUnit( 0 ), "stop" )
		else
			call SetUnitPathing( MUIUnit( 0 ), true )
			call SaveBoolean( HashTable, GetHandleId( MUIUnit( 0 ) ), 1000, false )
			call SetUnitFlyHeight( MUIUnit( 0 ), GetUnitDefaultFlyHeight( MUIUnit( 0 ) ), 99999 )
			call PauseTimer( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, HandleID )
			call DestroyTimer( GetExpiredTimer( ) )
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
			call SaveUnitHandle( HashTable, HandleID, 0, LocTrigUnit )	
			call SaveReal( HashTable, HandleID, 1, GetUnitFlyHeight( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, 2, LocAngle )
			call SaveReal( HashTable, HandleID, 3, LocTotalDist / LocSteepMax ) // LocDist
			call SaveReal( HashTable, HandleID, 4, LocHeightMax )
			call SaveReal( HashTable, HandleID, 5, 1. / LocSteepMax ) // LocDHeight
			call SaveReal( HashTable, HandleID, 6, GetUnitX( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, 7, GetUnitY( LocTrigUnit ) )
			call SaveInteger( HashTable, HandleID, 8, 0 ) // LocSteep
			call SaveInteger( HashTable, HandleID, 9, LocSteepMax )
			call SaveBoolean( HashTable, GetHandleId( LocTrigUnit ), 1000, false )
			call TimerStart( LoadMUITimer( LocPID ), LocRate, true, function DisplaceUnitAction )
		endif
	endfunction

