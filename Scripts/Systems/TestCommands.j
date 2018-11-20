	function GetSubString takes integer LocStart returns string
		return SubString( GetEventPlayerChatString( ), LocStart, StringLength( GetEventPlayerChatString( ) ) )
	endfunction	

	function PlayAnimationAction takes nothing returns nothing
		local integer LocalInteger = S2I( GetSubString( 15 ) )

		if LocalInteger >= 0 then
			call SetUnitAnimationByIndex( SelectedUnit( GetTriggerPlayer( ) ), LocalInteger )
			call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ffff" + "Animation was set to ID|r: " + "|cffffcc00" + "[" + I2S( LocalInteger ) + "]|r" )
		endif
	endfunction

	function GetUnitMoveSpeedAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|cffffcc00" + "[Selected Unit's]|r " + "|c0000ffff" + "current movement speed is|r: " + "|cffffcc00" + "[" + R2S( GetUnitMoveSpeed( SelectedUnit( GetTriggerPlayer( ) ) ) ) + "]|r" )
	endfunction

	function DebugCamInfo takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|cffffcc00Current Camera Information|r:
		|cffffcc00" + "Targ" + "|r" + " = " + "|c0000ffff" + "( " + R2SW( GetCameraTargetPositionX( ), 0, 0 ) + ", " + R2SW( GetCameraTargetPositionY( ), 0, 0 ) + ", " + R2SW( GetCameraTargetPositionZ( ), 0, 0 ) + " )|r
		|cffffcc00" + "Dist" + "|r" + " = " + "|c0000ffff" + R2SW( GetCameraField( CAMERA_FIELD_TARGET_DISTANCE ), 0, 0 ) + "|r
		|cffffcc00" + "FarZ" + "|r" + " = " + "|c0000ffff" + R2SW( GetCameraField( CAMERA_FIELD_FARZ ), 0, 0 ) + "|r
		|cffffcc00" +  "AoA" + "|r" + " = " + "|c0000ffff" + R2SW( GetCameraField( CAMERA_FIELD_ANGLE_OF_ATTACK ) * bj_RADTODEG, 0, 2 ) + "|r
		|cffffcc00" +  "FoV" + "|r" + " = " + "|c0000ffff" + R2SW( GetCameraField( CAMERA_FIELD_FIELD_OF_VIEW ) * bj_RADTODEG, 0, 2 ) + "|r
		|cffffcc00" + "Roll" + "|r" + " = " + "|c0000ffff" + R2SW( GetCameraField( CAMERA_FIELD_ROLL ) * bj_RADTODEG, 0, 2 ) + "|r
		|cffffcc00" +  "Rot" + "|r" + " = " + "|c0000ffff" + R2SW( GetCameraField( CAMERA_FIELD_ROTATION ) * bj_RADTODEG, 0, 2 ) + "|r" )
	endfunction

	function TeleportToLocation takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|cffffcc00You have been teleported to axis|r:
		|cffffcc00" + "X: " + "|r" + "|c0000ffff" + R2S( GetCameraTargetPositionX( ) ) + "|r
		|cffffcc00" + "Y: " + "|r" + "|c0000ffff" + R2S( GetCameraTargetPositionY( ) ) + "|r" )
		call SetUnitPosition( SelectedUnit( GetTriggerPlayer( ) ), GetCameraTargetPositionX( ), GetCameraTargetPositionY( ) )
	endfunction

	function RemoveUnitCommandAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Unit removed|r" )
		call RemoveUnit( SelectedUnit( GetTriggerPlayer( ) ) )
	endfunction
	
	function ItemCreationChatCommandAction takes nothing returns nothing
		local integer LocalDummyID = String2Id( GetSubString( 12 ) )
		
		if LocalDummyID != 0 then
			call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Item with ID|r: " + "[" + Id2String( LocalDummyID ) + "] |c0000ff00was spawned" )
			call CreateItem( LocalDummyID, GetUnitX( SelectedUnit( GetTriggerPlayer( ) ) ), GetUnitY( SelectedUnit( GetTriggerPlayer( ) ) ) )
		endif
	endfunction	

	function UnitCreationChatCommandAction takes nothing returns nothing
		local integer LocalDummyID = String2Id( GetSubString( 12 ) )
		
		if LocalDummyID != 0 then
			call SaveUnit( "SysUnit", CreateUnit( GetTriggerPlayer( ), LocalDummyID, 8000, 8000, 270 ) )
			call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Unit with ID|r: " + "[" + Id2String( LocalDummyID ) + "] |c0000ff00was spawned" )
			call SetUnitPosition( LoadUnit( "SysUnit" ), GetCameraTargetPositionX( ), GetCameraTargetPositionY( ) )
		endif
	endfunction

	function LearnAbilityChatCommandAction takes nothing returns nothing
		local integer LocalDummyID = String2Id( GetSubString( 12 ) )

		if LocalDummyID != 0 then
			call SaveUnit( "SysUnit", SelectedUnit( GetTriggerPlayer( ) ) )
			call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Ability|r: " + "[" + GetObjectName( LocalDummyID ) + "] |c0000ff00was added to hero|r: " + "[" + GetHeroProperName( LoadUnit( "SysUnit" ) ) + "]" )
			call UnitAddAbility( LoadUnit( "SysUnit" ), LocalDummyID )
		endif
	endfunction

	function UnlearnAbilityChatCommandAction takes nothing returns nothing
		local integer LocalDummyID = String2Id( GetSubString( 15 ) )
		
		if LocalDummyID != 0 then
			call SaveUnit( "SysUnit", SelectedUnit( GetTriggerPlayer( ) ) )
			call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Ability|r: " + "[" + GetObjectName( LocalDummyID ) + "] |c0000ff00was removed from hero|r: " + "[" + GetHeroProperName( LoadUnit( "SysUnit" ) ) + "]" )
			call UnitRemoveAbility( LoadUnit( "SysUnit" ), LocalDummyID )
		endif
	endfunction

	function SetUnitStatAction takes nothing returns nothing
		local string  GetCommand = SubString( GetEventPlayerChatString( ), 0, 5 )
		local integer LocalStat  = S2I( GetSubString( 5 ) )

		call SaveUnit( "SysUnit", SelectedUnit( GetTriggerPlayer( ) ) )

		if GetCommand == "-STR " or GetCommand == "-str " then
			call SetHeroStr( LoadUnit( "SysUnit" ), LocalStat, true )
	elseif GetCommand == "-AGI " or GetCommand == "-agi " then
			call SetHeroAgi( LoadUnit( "SysUnit" ), LocalStat, true )
	elseif GetCommand == "-INT " or GetCommand == "-int " then
			call SetHeroInt( LoadUnit( "SysUnit" ), LocalStat, true )
		endif
	endfunction

	function SetUnitScaleSystemAction takes nothing returns nothing
		call ScaleUnit( SelectedUnit( GetTriggerPlayer( ) ), S2R( GetSubString( 7 ) ) )
	endfunction

	function AddGoldAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 5, "|c0000ff00You recieved 100000000 Gold.|r" )
		call SetPlayerState( GetTriggerPlayer( ), PLAYER_STATE_RESOURCE_GOLD, 100000000 )
	endfunction

	function SetLevelAction takes nothing returns nothing
		local integer LocalOldLevel = 0
		local integer LocalNewLevel = S2I( GetSubString( 7 ) )

		call SaveUnit( "SysUnit", SelectedUnit( GetTriggerPlayer( ) ) )

		if IsUnitType( LoadUnit( "SysUnit" ), UNIT_TYPE_HERO ) then
			set LocalOldLevel = GetHeroLevel( LoadUnit( "SysUnit" ) )

			if LocalNewLevel > LocalOldLevel then
				call SetHeroLevel( LoadUnit( "SysUnit" ), LocalNewLevel, false )
			else
				call UnitStripHeroLevel( LoadUnit( "SysUnit" ), LocalOldLevel - LocalNewLevel )
			endif
		endif
	endfunction

	function SetUnitOwnerAction takes nothing returns nothing
		local integer LocalID = S2I( GetSubString( 7 ) )

		if LocalID >= 0 and LocalID <= 15 then
			call SaveUnit( "SysUnit", SelectedUnit( GetTriggerPlayer( ) ) )
			call SetUnitOwner( LoadUnit( "SysUnit" ), Player( LocalID ), true )
			call StartAI( LoadUnit( "SysUnit" ) )
		endif
	endfunction

	function ResetCDTargets takes nothing returns boolean
		if GetOwningPlayer( GetFilterUnit( ) ) != Player( PLAYER_NEUTRAL_AGGRESSIVE ) and IsUnitType( GetFilterUnit( ), UNIT_TYPE_HERO ) then
			call UnitResetCooldown( GetFilterUnit( ) )
		endif

		return true
	endfunction

	function ResetCooldownTimedAction takes nothing returns nothing
		call GroupEnumUnitsInRect( EnumUnits( ), GetWorldBounds( ), Condition( function ResetCDTargets ) )
	endfunction

	function NoCooldownActivationAction takes nothing returns nothing
		if IsTriggerEnabled( LoadTrig( "NoCDTrig" ) ) then
			call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c00ff0000No-CoolDown Mode Operation Disabled!|r" )
			call DisableTrigger( LoadTrig( "NoCDTrig" ) )
		else
			call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000FF00No-CoolDown Mode Operation Enabled!|r" )
			call EnableTrigger( LoadTrig( "NoCDTrig" ) )
		endif
	endfunction

	function AllHeroPickAction takes nothing returns nothing
		local integer i = 1

		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00The host got all heroes.|r" )

		loop
			exitwhen i > LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalHeroes" ) )
			call CreateUnit( GetTriggerPlayer( ), LoadInteger( HashTable, GetHandleId( HashTable ), StringHash( "HeroID" ) + i ), -11000., 10000., 270 )
			set i = i + 1
		endloop
	endfunction

	function TestUnitSpawnAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 5, "|c0000ff00Test Unit Has Been Spawned.|r" )
		call CreateUnit( Player( PLAYER_NEUTRAL_AGGRESSIVE ), 'tstu', 0, -500, 270 )
	endfunction

	function GetUsedAbilityIDAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Used Ability ID|r: " + "[" + Id2String( GetSpellAbilityId( ) ) + "]" )
	endfunction

	function UnitIDAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Selected unit ID|r: " + "[" + Id2String( GetUnitTypeId( GetTriggerUnit( ) ) ) + "]" )
		//call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Unit Coords|r: X: " + R2S( GetUnitX( GetTriggerUnit( ) ) ) + " Y: " + R2S( GetUnitY( GetTriggerUnit( ) ) ) )
	endfunction

	function PickedUpItemIDAction takes nothing returns nothing
		call DisplayTimedTextToPlayer( GetTriggerPlayer( ), 0, 0, 10, "|c0000ff00Picked Item ID|r: " + "[" + Id2String( GetItemTypeId( GetManipulatedItem( ) ) ) + "]" )
	endfunction

	function ExecuteFunction takes nothing returns nothing
		call ExecuteFunc( GetSubString( 9 ) )
	endfunction	

