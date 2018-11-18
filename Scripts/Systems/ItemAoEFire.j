	function ItemAoEFireDamage takes nothing returns boolean
		if UnitLife( MUIUnit( 100 ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
			call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Magical", 30 + MUILevel( 2. ) )
			call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl", GetFilterUnit( ), "chest" ) )
		endif

		return true
	endfunction

	function ItemAoEFireAction takes nothing returns nothing
		local integer LocTime = MUIInteger( 0 )

		call SaveInteger( HashTable, MUIHandle( ), 0, LocTime + 1 )

		if UnitHasItemById( MUIUnit( 100 ), 'I000' ) then
			if LocTime == 100 then
				call SaveInteger( HashTable, MUIHandle( ), 0, 0 )
				call GroupEnumUnitsInRange( EnumUnits( ), GetUnitX( MUIUnit( 100 ) ), GetUnitY( MUIUnit( 100 ) ), 300, Filter( function ItemAoEFireDamage ) )
			endif
		else
			call SaveBoolean( HashTable, GetHandleId( MUIUnit( 100 ) ), 300, false )
			call TimerPause( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, MUIHandle( ) )
		endif
	endfunction

