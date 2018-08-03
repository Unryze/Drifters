	function SaberNeroHealthRegen takes nothing returns nothing
		local real 		MaxHP 		= UnitMaxLife( MUIUnit( 999 ) )
		local real 		CurrentHP 	= UnitLife( MUIUnit( 999 ) )
	//	local real		LocalLevel	= MUILevel( )

		call SetWidgetLife( MUIUnit( 999 ), ( MaxHP - CurrentHP ) * .04 + CurrentHP )
	endfunction

	function EnteringUnitCheckAction takes nothing returns nothing
		if IsUnitInGroup( GetEnteringUnit( ), LoadGroupHandle( HashTable, GetHandleId( CameraSet ), StringHash( "DamagedGroup" ) ) ) == false and GetUnitAbilityLevel( GetEnteringUnit( ), 'Aloc' ) <= 0 then
			call GroupAddUnit( LoadGroupHandle( HashTable, GetHandleId( CameraSet ), StringHash( "DamagedGroup" ) ), GetEnteringUnit( ) )
			call TriggerRegisterUnitEvent( LoadTrig( "UnitDamagedTrig" ), GetEnteringUnit( ), EVENT_UNIT_DAMAGED )

			if IsUnitType( GetEnteringUnit( ), UNIT_TYPE_HERO ) != null then
				if GetUnitTypeId( GetEnteringUnit( ) ) == 'H00E' then
					call SaveTimerHandle( HashTable, GetHandleId( GetEnteringUnit( ) ), StringHash( "NeroPassiveTimer" ), CreateTimer( ) )
					call SaveUnitHandle( HashTable, GetHandleId( LoadTimerHandle( HashTable, GetHandleId( GetEnteringUnit( ) ), StringHash( "NeroPassiveTimer" ) ) ), 999, GetEnteringUnit( ) )
					call TimerStart( LoadTimerHandle( HashTable, GetHandleId( GetEnteringUnit( ) ), StringHash( "NeroPassiveTimer" ) ), 1, true, function SaberNeroHealthRegen )
				endif
			endif
		endif
	endfunction

