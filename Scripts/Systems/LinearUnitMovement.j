	function SimpleMovement takes integer HandleID, string AxisName, integer IsEnabled returns nothing
		call SaveStr( HashTable, HandleID, StringHash( "AxisName" ), AxisName )
		call SaveInteger( HashTable, HandleID, StringHash( "IsEnabled" ), IsEnabled )
	endfunction

	function LinearDisplacementAction takes nothing returns nothing
		local integer 	HandleID 	= MUIHandle( )
		local real 		MoveX 		= GetUnitX( GetUnit( "Displaced" ) ) + GetReal( "MaxDistance" ) * GetReal( "AngleX" )
		local real 		MoveY 		= GetUnitY( GetUnit( "Displaced" ) ) + GetReal( "MaxDistance" ) * GetReal( "AngleY" )

		if GetReal( "Duration" ) > 0 and UnitLife( GetUnit( "Displaced" ) ) > 0 then
			call IssueImmediateOrder( GetUnit( "Displaced" ), "stop" )
			call SaveReal( HashTable, HandleID, StringHash( "Duration" ), GetReal( "Duration" ) - 1 )

			if GetBool( "Pathing" ) == false and IsTerrainPathable( MoveX, MoveY, PATHING_TYPE_WALKABILITY ) then
				call SaveInteger( HashTable, HandleID, StringHash( "StopMovement" ), 1 )
			else
				call SetUnitX( GetUnit( "Displaced" ), MoveX )
				call SetUnitY( GetUnit( "Displaced" ), MoveY )
			endif

			if GetInt( "ShowEffect" ) == 0 then
				if GetUnitFlyHeight( GetUnit( "Displaced" ) ) < 5. then
					call DestroyEffect( AddSpecialEffect( GetStr( "Effect" ), GetUnitX( GetUnit( "Displaced" ) ), GetUnitY( GetUnit( "Displaced" ) ) ) )
				endif
			endif

			if GetInt( "ShowEffect" ) == 2 then
				call SaveInteger( HashTable, HandleID, StringHash( "ShowEffect" ), 0 )
			endif

			call SaveReal( HashTable, HandleID, StringHash( "MaxDistance" ), GetReal( "MaxDistance" ) - GetReal( "MoveRate" ) )

			if GetReal( "MaxDistance" ) <= 0 or RMin( RMax( GetReal( "InitX" )  * 1, GetMapBound( "MinX" ) ), GetMapBound( "MaxX" ) ) != GetReal( "InitX" )  or RMin( RMax( GetReal( "InitY" )  * 1, GetMapBound( "MinY" ) ), GetMapBound( "MaxY" ) ) != GetReal( "InitY" )  then
				call SaveInteger( HashTable, HandleID, StringHash( "StopMovement" ), 1 )
			endif

			if GetInt( "StopMovement" ) == 1 then
				call SetUnitFlyHeight( GetUnit( "Displaced" ), GetUnitDefaultFlyHeight( GetUnit( "Displaced" ) ), 200 )
				call SetUnitTimeScale( GetUnit( "Displaced" ), 1 )
			endif
		else
			call TimerPause( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, HandleID )
		endif
	endfunction

	function LinearDisplacement takes unit LocTrigUnit, real LocFacing, real LocDistance, real LocTime, real LocRate, boolean LocDestrDestruct, boolean LocPathing, string LocAttach, string LocEffect returns nothing
		local integer LocPID
		local integer HandleID

		if LocTrigUnit != null then
			set LocPID = GetPlayerId( GetOwningPlayer( LocTrigUnit ) )
			set HandleID = NewMUITimer( LocPID )
			call SaveReal( HashTable, HandleID, StringHash( "AngleX" ), Cos( Deg2Rad( LocFacing ) ) )
			call SaveReal( HashTable, HandleID, StringHash( "AngleY" ), Sin( Deg2Rad( LocFacing ) ) )
			call SaveReal( HashTable, HandleID, StringHash( "MaxDistance" ), 2 * LocDistance * LocRate / LocTime )
			call SaveReal( HashTable, HandleID, StringHash( "MoveRate" ), ( 2 * LocDistance * LocRate / LocTime ) * LocRate / LocTime )
			call SaveReal( HashTable, HandleID, StringHash( "InitX" ), GetUnitX( LocTrigUnit ) )
			call SaveReal( HashTable, HandleID, StringHash( "InitY" ), GetUnitY( LocTrigUnit ) )
			call SaveUnitHandle( HashTable, HandleID, StringHash( "Displaced" ), LocTrigUnit )
		//	call SaveBoolean( HashTable, HandleID, StringHash( "DestroysDoodads" ), LocDestrDestruct )
			call SaveBoolean( HashTable, HandleID, StringHash( "Pathing" ), LocPathing )
		//	call SaveStr( HashTable, HandleID, StringHash( "Attachment" ), LocAttach )
			call SaveStr( HashTable, HandleID, StringHash( "Effect" ), LocEffect )
			call SaveReal( HashTable, HandleID, StringHash( "Duration" ), LocTime / LocRate )
			call SaveBoolean( HashTable, GetHandleId( LocTrigUnit ), 1000, true )
			call TimerStart( LoadMUITimer( LocPID ), LocRate, true, function LinearDisplacementAction )
		endif
	endfunction

