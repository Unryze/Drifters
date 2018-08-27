	function ClearAllData takes integer HandleID returns nothing
		call PauseTimer( GetExpiredTimer( ) )

		if MUIUnit( 100 ) != null then
			if IsUnitPaused( MUIUnit( 100 ) ) then
				call PauseUnit( MUIUnit( 100 ), false )
				call IssueImmediateOrder( MUIUnit( 100 ), "stop" )
			endif

			call ShowUnit( MUIUnit( 100 ), true )
			call SetUnitTimeScale( MUIUnit( 100 ), 1 )
			call SetUnitPathing( MUIUnit( 100 ), true )
			call UnitRemoveAbility( MUIUnit( 100 ), 'Amrf' )
			call SetUnitFlyHeight( MUIUnit( 100 ), 0, 9999 )
			call SetUnitInvulnerable( MUIUnit( 100 ), false )
			call SetUnitVertexColor( MUIUnit( 100 ), 255, 255, 255, 255 )
		endif

		if MUIUnit( 101 ) != null then
			call UnitRemoveAbility( MUIUnit( 101 ), 'A054' )
			call SetUnitFlyHeight( MUIUnit( 101 ), 0, 9999 )
			call UnitRemoveAbility( MUIUnit( 101 ), 'Amrf' )
		endif

		if MUIUnit( 106 ) != null then
			call KillUnit( MUIUnit( 106 ) )
		endif

		if LoadEffectHandle( HashTable, HandleID, 108 ) != null then
			call DestroyEffect( LoadEffectHandle( HashTable, HandleID, 108 ) )
		endif

		if LoadGroupHandle( HashTable, HandleID, 111 ) != null then
			call DestroyGroup( LoadGroupHandle( HashTable, HandleID, 111 ) )
		endif

		call FlushChildHashtable( HashTable, HandleID )
		call DestroyTimer( GetExpiredTimer( ) )
	endfunction	

	function StopSpell takes integer HandleID, integer LocType returns boolean
		if LocType == 0 then
			if UnitLife( MUIUnit( 100 ) ) <= 0 then
				call ClearAllData( HandleID )
				return true
			endif
		else
			if UnitLife( MUIUnit( 100 ) ) <= 0 or UnitLife( MUIUnit( 101 ) ) <= 0 then
				call ClearAllData( HandleID )
				return true
			endif
		endif

		return false
	endfunction	
	
