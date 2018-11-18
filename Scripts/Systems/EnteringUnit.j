	function SaberNeroHealthRegen takes nothing returns nothing
		call SetWidgetLife( MUIUnit( 0 ), UnitLife( MUIUnit( 0 ) ) + UnitMaxLife( MUIUnit( 0 ) ) * .005 )
	endfunction

	function EnteringUnitCheckAction takes nothing returns boolean
		if LoadBoolean( HashTable, GetHandleId( GetFilterUnit(  ) ), StringHash( "Registered" ) ) == false then
			call SaveBoolean( HashTable, GetHandleId( GetFilterUnit(  ) ), StringHash( "Registered" ), true )
			call TriggerRegisterUnitEvent( LoadTrig( "UnitDamagedTrig" ), GetFilterUnit( ), EVENT_UNIT_DAMAGED )

			if IsUnitType( GetFilterUnit( ), UNIT_TYPE_HERO ) != null then
				if GetUnitTypeId( GetFilterUnit( ) ) == 'H004' then
					call SaveTimerHandle( HashTable, GetHandleId( GetFilterUnit( ) ), StringHash( "NeroPassiveTimer" ), CreateTimer( ) )
					call SaveUnitHandle( HashTable, GetHandleId( LoadTimerHandle( HashTable, GetHandleId( GetFilterUnit( ) ), StringHash( "NeroPassiveTimer" ) ) ), 0, GetFilterUnit( ) )
					call TimerStart( LoadTimerHandle( HashTable, GetHandleId( GetFilterUnit( ) ), StringHash( "NeroPassiveTimer" ) ), 1, true, function SaberNeroHealthRegen )
				endif
			endif
		endif

		return false
	endfunction

