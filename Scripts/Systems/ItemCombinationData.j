	function ItemOwnerSettingAction takes nothing returns nothing
		if GetItemPlayer( GetManipulatedItem( ) ) == Player( 15 ) then
			call SetItemPlayer( GetManipulatedItem( ), GetOwningPlayer( GetTriggerUnit( ) ), false )
	elseif GetItemPlayer( GetManipulatedItem( ) ) != GetOwningPlayer( GetTriggerUnit( ) ) then
			call UnitRemoveItem( GetTriggerUnit( ), GetManipulatedItem( ) )
		endif
	endfunction

	function ItemCombinationAction takes nothing returns nothing

	endfunction

	function MapItemRemovalAction takes nothing returns nothing
		local real ItemX = GetItemX( GetManipulatedItem( ) )
		local real ItemY = GetItemY( GetManipulatedItem( ) )
		
		if GetRectMinX( GetWorldBounds( ) ) <= ItemX and ItemX <= GetRectMaxX( GetWorldBounds( ) ) and GetRectMinY( GetWorldBounds( ) ) <= ItemY and ItemY <= GetRectMaxY( GetWorldBounds( ) ) then
			if GetWidgetLife( GetManipulatedItem( ) ) <= 0 then
				call RemoveItem( GetManipulatedItem( ) )
			endif
		endif
	endfunction

