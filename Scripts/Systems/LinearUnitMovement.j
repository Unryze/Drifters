	function SimpleMovement takes integer HandleID, string AxisName, integer IsEnabled returns nothing
		call SaveStr( HashTable, HandleID, StringHash( "AxisName" ), AxisName )
		call SaveInteger( HashTable, HandleID, StringHash( "IsEnabled" ), IsEnabled )
	endfunction

	function LinearDisplacementAction takes nothing returns nothing
		local integer 	HandleID 	= MUIHandle( )
		local real 		LocCos 		= LoadReal( HashTable, HandleID, 0 )
		local real 		LocSin 		= LoadReal( HashTable, HandleID, 1 )
		local real 		MaxDist 	= LoadReal( HashTable, HandleID, 2 )
		local real 		MoveRate 	= LoadReal( HashTable, HandleID, 3 )
		local real 		InitX 		= LoadReal( HashTable, HandleID, 4 )
		local real 		InitY 		= LoadReal( HashTable, HandleID, 5 )
	// 	local unit		MovedUnit	= MUIUnit( 6 )
	//	local boolean	DestroyDest	= LoadBoolean( HashTable, HandleID, 7 )
		local boolean 	LocPathing 	= LoadBoolean( HashTable, HandleID, 8 )
	//	local string 	LocAttach 	= LoadStr( HashTable, HandleID, 9 )
		local string 	LocEffect 	= LoadStr( HashTable, HandleID, 10 )
		local integer 	IsStopped 	= MUIInteger( 11 )
		local integer 	IsEffect 	= MUIInteger( 12 )
		local real 		MoveX 		= GetUnitX( MUIUnit( 6 ) ) + MaxDist * LocCos
		local real 		MoveY 		= GetUnitY( MUIUnit( 6 ) ) + MaxDist * LocSin
		local real 		Duration 	= LoadReal( HashTable, HandleID, 13 )

		if Duration > 0 and UnitLife( MUIUnit( 6 ) ) > 0 then
			call SaveReal( HashTable, HandleID, 13, Duration - 1 )

			if LocPathing == false and IsTerrainPathable( MoveX, MoveY, PATHING_TYPE_WALKABILITY ) then
				call SaveInteger( HashTable, HandleID, 11, 1 )
			else
				call SetUnitX( MUIUnit( 6 ), MoveX )
				call SetUnitY( MUIUnit( 6 ), MoveY )
			endif

			if IsEffect == 0 then
				if GetUnitFlyHeight( MUIUnit( 6 ) ) < 5. then
					call DestroyEffect( AddSpecialEffect( LocEffect, GetUnitX( MUIUnit( 6 ) ), GetUnitY( MUIUnit( 6 ) ) ) )
				endif
			endif

			if IsEffect == 2 then
				call SaveInteger( HashTable, HandleID, 12, 0 )
			endif

			call SaveReal( HashTable, HandleID, 2, MaxDist - MoveRate )

			if MaxDist <= 0 or RMin( RMax( InitX * 1, GetMapBound( "MinX" ) ), GetMapBound( "MaxX" ) ) != InitX or RMin( RMax( InitY * 1, GetMapBound( "MinY" ) ), GetMapBound( "MaxY" ) ) != InitY then
				call SaveInteger( HashTable, HandleID, 11, 1 )
			endif

			if IsStopped == 1 then
				call SetUnitFlyHeight( MUIUnit( 6 ), GetUnitDefaultFlyHeight( MUIUnit( 6 ) ), 200 )
				call SetUnitTimeScale( MUIUnit( 6 ), 1 )
			endif
		else
			call PauseTimer( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, HandleID )
			call DestroyTimer( GetExpiredTimer( ) )
		endif
	endfunction

	function LinearDisplacement takes unit LocTrigUnit, real LocFacing, real LocDistance, real LocTime, real LocRate, boolean LocDestrDestruct, boolean LocPathing, string LocAttach, string LocEffect returns nothing
		local integer LocPID
		local integer HandleID

		if LocTrigUnit != null then
			set LocPID = GetPlayerId( GetOwningPlayer( LocTrigUnit ) )
			set HandleID = NewMUITimer( LocPID )
			call SaveReal( HashTable, HandleID, 0, Cos( Deg2Rad( LocFacing ) ) )
			call SaveReal( HashTable, HandleID, 1, Sin( Deg2Rad( LocFacing ) ) )
			call SaveReal( HashTable, HandleID, 2, 2 * LocDistance * LocRate / LocTime )
			call SaveReal( HashTable, HandleID, 3, ( 2 * LocDistance * LocRate / LocTime ) * LocRate / LocTime )
			call SaveReal( HashTable, HandleID, 4, GetUnitX( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, 5, GetUnitY( LocTrigUnit ) )
			call SaveUnitHandle( HashTable, HandleID, 6, LocTrigUnit )
			call SaveBoolean( HashTable, HandleID, 7, LocDestrDestruct )
			call SaveBoolean( HashTable, HandleID, 8, LocPathing )
			call SaveStr( HashTable, HandleID, 9, LocAttach )
			call SaveStr( HashTable, HandleID, 10, LocEffect )
			call SaveInteger( HashTable, HandleID, 11, 0 )
			call SaveInteger( HashTable, HandleID, 12, 0 )
			call SaveReal( HashTable, HandleID, 13, LocTime / LocRate )
			call SaveBoolean( HashTable, GetHandleId( LocTrigUnit ), 1000, true )
			call TimerStart( LoadMUITimer( LocPID ), LocRate, true, function LinearDisplacementAction )
		endif
	endfunction

