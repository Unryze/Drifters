	function ItemAoEFireDamage takes nothing returns boolean
		if UnitLife( GetUnit( "RobeOwner" ) ) > 0 and IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( GetUnit( "RobeOwner" ) ) ) then
			call TargetDamage( GetUnit( "RobeOwner" ), GetFilterUnit( ), "AoE", "Magical", 30 + GetLevel( 2. ) )
			call DestroyEffect( AddSpecialEffectTarget( "Abilities\\Spells\\Other\\ImmolationRed\\ImmolationRedDamage.mdl", GetFilterUnit( ), "chest" ) )
		endif

		return true
	endfunction

	function ItemAoEFireAction takes nothing returns nothing
		local integer LocTime = GetInt( "SpellTime" )

		call SpellTime( )

		if UnitHasItemById( GetUnit( "RobeOwner" ), 'I000' ) then
			if LocTime == 100 then
				call SaveInteger( HashTable, MUIHandle( ), 0, 0 )
				call GroupEnumUnitsInRange( EnumUnits( ), GetUnitX( GetUnit( "RobeOwner" ) ), GetUnitY( GetUnit( "RobeOwner" ) ), 300, Filter( function ItemAoEFireDamage ) )
			endif
		else
			call SaveBoolean( HashTable, GetHandleId( GetUnit( "RobeOwner" ) ), 300, false )
			call TimerPause( GetExpiredTimer( ) )
			call FlushChildHashtable( HashTable, MUIHandle( ) )
		endif
	endfunction

