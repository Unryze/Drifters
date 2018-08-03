	function HeroAbilityUnlockAction takes nothing returns nothing
		local integer ID 	= GetPlayerId( GetOwningPlayer( GetLevelingUnit( ) ) )
		local integer Level = GetUnitLevel( GetLevelingUnit( ) )

		if Level >= 2 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A04C', true )
		endif

		if Level >= 3 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A02E', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02N', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02V', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03M', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03D', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A039', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04H', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A032', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03U', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A040', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A01Y', true )
		endif

		if Level >= 4 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A04B', true )
		endif

		if Level >= 5 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A049', true )
		endif

		if Level >= 6 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A03N', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04I', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03S', true )
		endif

		if Level >= 8 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A041', true )
		endif

		if Level >= 10 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A02G', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02O', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02W', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03O', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03G', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03A', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04J', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A034', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03V', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A042', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A026', true )
		endif

		if Level >= 15 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A02K', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02Q', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02Y', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03P', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03H', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03B', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A036', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03W', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04D', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A043', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A027', true )
		endif

		if Level >= 20 then
			call SetPlayerAbilityAvailable( Player( ID ), 'A02L', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02R', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02Z', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03I', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03C', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04K', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A037', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A03X', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A04E', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A044', true )
			call SetPlayerAbilityAvailable( Player( ID ), 'A02A', true )
		endif
	endfunction

