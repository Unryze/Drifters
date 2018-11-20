	function ItemPickUpAction takes nothing returns boolean
		if GetItemPlayer( GetManipulatedItem( ) ) == Player( 15 ) then
			call SetItemPlayer( GetManipulatedItem( ), GetOwningPlayer( GetTriggerUnit( ) ), false )
	elseif GetItemPlayer( GetManipulatedItem( ) ) != GetOwningPlayer( GetTriggerUnit( ) ) then
			call UnitRemoveItem( GetTriggerUnit( ), GetManipulatedItem( ) )
			return false
		endif

		if GetItemPlayer( GetManipulatedItem( ) ) == GetOwningPlayer( GetTriggerUnit( ) ) then
			if GetItemTypeId( GetManipulatedItem( ) ) == 'I000' then
				if CountItems( GetTriggerUnit( ), 'I000' ) == 1 and LoadBoolean( HashTable, GetHandleId( GetTriggerUnit( ) ), 300 ) == false then
					call SaveTimerHandle( HashTable, GetHandleId( GetTriggerUnit( ) ), StringHash( "ItemAoEFireTimer" ), CreateTimer( ) )
					call SaveUnitHandle( HashTable, GetHandleId( LoadTimerHandle( HashTable, GetHandleId( GetTriggerUnit( ) ), StringHash( "ItemAoEFireTimer" ) ) ), StringHash( "RobeOwner" ), GetTriggerUnit( ) )
					call SaveBoolean( HashTable, GetHandleId( GetTriggerUnit( ) ), 300, true )
					call TimerStart( LoadTimerHandle( HashTable, GetHandleId( GetTriggerUnit( ) ), StringHash( "ItemAoEFireTimer" ) ), .01, true, function ItemAoEFireAction )
				endif
			endif
		endif

		return false
	endfunction

