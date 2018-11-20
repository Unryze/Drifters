	function ClearAllData takes integer HandleID returns nothing
		if GetUnit( "Source" ) != null then
			call ShowUnit( GetUnit( "Source" ), true )
			call SetUnitTimeScale( GetUnit( "Source" ), 1 )
			call SetUnitPathing( GetUnit( "Source" ), true )
			call UnitRemoveAbility( GetUnit( "Source" ), 'Amrf' )
			call SetUnitFlyHeight( GetUnit( "Source" ), 0, 0 )
			call SetUnitInvulnerable( GetUnit( "Source" ), false )
			call SetUnitVertexColor( GetUnit( "Source" ), 255, 255, 255, 255 )
		endif

		if GetUnit( "Target" ) != null then
			call UnitRemoveAbility( GetUnit( "Target" ), 'A058' )
			call SetUnitFlyHeight( GetUnit( "Target" ), 0, 0 )
			call UnitRemoveAbility( GetUnit( "Target" ), 'Amrf' )
		endif

		if GetEffect( "Effect0" ) != null then
			call DestroyEffect( GetEffect( "Effect0" ) )
		endif

		call TimerPause( GetExpiredTimer( ) )
		call FlushChildHashtable( HashTable, HandleID )
	endfunction	

	function StopSpell takes integer HandleID, integer LocType returns boolean
		if LocType == 0 then
			if UnitLife( GetUnit( "Source" ) ) <= 0 then
				call ClearAllData( HandleID )
				return true
			endif
		else
			if UnitLife( GetUnit( "Source" ) ) <= 0 or UnitLife( GetUnit( "Target" ) ) <= 0 then
				call ClearAllData( HandleID )
				return true
			endif
		endif

		return false
	endfunction	

