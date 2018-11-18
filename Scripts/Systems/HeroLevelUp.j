	function HeroAbilityUnlockAction takes nothing returns nothing
		local integer ID 	= GetPlayerId( GetOwningPlayer( GetLevelingUnit( ) ) )
		local integer Level = GetUnitLevel( GetLevelingUnit( ) )

		if Level >= 3 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A004', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A012', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A018', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A025', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A031', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A037', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A042', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A047', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A052', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A057', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A065', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A068', true )
		endif

		if Level >= 4 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A064', true )
		endif

		if Level >= 5 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A062', true )
		endif

		if Level >= 6 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A050', true )
		endif

		if Level >= 10 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A005', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A014', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A019', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A026', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A034', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A039', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A043', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A048', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A053', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A059', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A069', true )
		endif

		if Level >= 15 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A006', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A016', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A021', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A022', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A028', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A029', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A035', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A038', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A044', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A049', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A054', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A060', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A066', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A070', true )
		endif
	endfunction

