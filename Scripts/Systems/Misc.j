	function CameraSetHeight takes nothing returns nothing
		call SetCameraField( CAMERA_FIELD_TARGET_DISTANCE, LoadReal( HashTable, GetHandleId( CameraSet ), StringHash( "CameraDistance" ) ), 0 )

		if LoadBoolean( HashTable, GetHandleId( CameraSet ), GetPlayerId( GetLocalPlayer( ) ) ) == false then //IsSelected
			call CameraSetupSetDestPosition( CameraSet, -1800., 5800, 0 )
			call CameraSetupSetField( CameraSet, CAMERA_FIELD_ANGLE_OF_ATTACK, 270, 0 )
			call CameraSetupApplyForceDuration( CameraSet, true, 0 )
		endif
	endfunction

	function CameraAdjustionAction takes nothing returns nothing
		local real InputAmount = S2R( SubString( GetEventPlayerChatString( ), 8, 11 ) )

		if GetLocalPlayer( ) == GetTriggerPlayer( ) then
			if InputAmount >= 50 and InputAmount <= 250 then
				call SaveReal( HashTable, GetHandleId( CameraSet ), StringHash( "CameraDistance" ), 20 * InputAmount )
			endif
		endif
	endfunction		

	function RemoveInvisForCast takes nothing returns nothing
		if GetSpellAbilityId( ) != 'A021' and GetSpellAbilityId( ) != 'A00X' then
			call UnitRemoveAbility( GetTriggerUnit( ), 'B018' )
			call UnitRemoveAbility( GetTriggerUnit( ), 'Binv' )
		endif
	endfunction
	
	function ClearMessagesAction takes nothing returns nothing
		if GetLocalPlayer( ) == GetTriggerPlayer( ) then
			call ClearTextMessages( )
		endif
	endfunction

