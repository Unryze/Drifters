	function InitTriggers takes nothing returns nothing
		local integer i = 0

		loop
			exitwhen i > 9

			if GetPlayerSlotState( Player( i ) ) == PLAYER_SLOT_STATE_PLAYING then
				call SaveInteger( HashTable, GetHandleId( Player( i ) ), 0, LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "MPosition" ) ) )
				call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "MPosition" ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "MPosition" ) ) + 1 )

				if GetPlayerController( Player( i ) ) == MAP_CONTROL_USER then
					if StringLength( GetPlayerName( Player( i ) ) ) > LoadInteger( HashTable, GetHandleId( HashTable ), 0 ) then
						call SaveInteger( HashTable, GetHandleId( HashTable ), 0, StringLength( GetPlayerName( Player( i ) ) ) )
					endif

					call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalPlayers" ), LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalPlayers" ) ) + 1 )

					if GetPlayerTeam( Player( i ) ) == 0 then
						call SaveInteger( HashTable, GetHandleId( CameraSet ), 500, LoadInteger( HashTable, GetHandleId( CameraSet ), 500 ) + 1 )
					else
						call SaveInteger( HashTable, GetHandleId( CameraSet ), 501, LoadInteger( HashTable, GetHandleId( CameraSet ), 501 ) + 1 )
					endif
				endif
			endif

			set i = i + 1
		endloop

		set i = 0
		call SaveTrig( "AllianceChange" )

		loop
			exitwhen i > 9
			call TriggerRegisterPlayerAllianceChange( LoadTrig( "AllianceChange" ), Player( i ), ALLIANCE_SHARED_CONTROL )
			set i = i + 1
		endloop

		call TriggerAddAction( LoadTrig( "AllianceChange" ), function DisableSharedUnitsAct )

		call SaveTrig( "InitMultiboard" )
		call TriggerRegisterTimerEvent( LoadTrig( "InitMultiboard" ), 0, false )
		call TriggerAddAction( LoadTrig( "InitMultiboard" ), function MultiBoardCreationFunction1 )

		call SaveTrig( "InitModeSelect1" )
		call TriggerRegisterDialogEvent( LoadTrig( "InitModeSelect1" ), GetDialog( ) )
		call TriggerAddAction( LoadTrig( "InitModeSelect1" ), function ModeSelectionFunction2 )

		call SaveTrig( "NoCDTrig" )
		call DisableTrigger( LoadTrig( "NoCDTrig" ) )
		call TriggerRegisterTimerEvent( LoadTrig( "NoCDTrig" ), .01, true )
		call TriggerAddAction( LoadTrig( "NoCDTrig" ), function ResetCooldownTimedAction )

		call SaveTrig( "PlayerLeaveTrig" )
		call GetPlayerEvent( LoadTrig( "PlayerLeaveTrig" ), EVENT_PLAYER_LEAVE )
		call TriggerAddAction( LoadTrig( "PlayerLeaveTrig" ), function RegisterPlayerLeaveAction )

		call SaveTrig( "HeroSelectionTrig" )
		call DisableTrigger( LoadTrig( "HeroSelectionTrig" ) )
		call GetUnitEvent( LoadTrig( "HeroSelectionTrig" ), EVENT_PLAYER_UNIT_SELECTED )
		call TriggerAddAction( LoadTrig( "HeroSelectionTrig" ), function HeroSelectionAction )

		call SaveTrig( "ItemOwnerTrig" )
		call GetUnitEvent( LoadTrig( "ItemOwnerTrig" ), EVENT_PLAYER_UNIT_PICKUP_ITEM )
		call TriggerAddAction( LoadTrig( "ItemOwnerTrig" ), function ItemPickUpAction )

		call SaveTrig( "ItemRemoveTrig" )
		call GetUnitEvent( LoadTrig( "ItemRemoveTrig" ), EVENT_PLAYER_UNIT_DROP_ITEM )
		call TriggerAddAction( LoadTrig( "ItemRemoveTrig" ), function MapItemRemovalAction )

		call SaveTrig( "UnlockSpellsTrig" )
		call GetUnitEvent( LoadTrig( "UnlockSpellsTrig" ), EVENT_PLAYER_HERO_LEVEL )
		call TriggerAddAction( LoadTrig( "UnlockSpellsTrig" ), function HeroAbilityUnlockAction )

		call SaveTrig( "RemoveInvisTrig" )
		call GetUnitEvent( LoadTrig( "RemoveInvisTrig" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddAction( LoadTrig( "RemoveInvisTrig" ), function RemoveInvisForCast )

		call SaveTrig( "InitModeSelect2" )
		call TriggerRegisterDialogEvent( LoadTrig( "InitModeSelect2" ), GetDialog( ) )
		call TriggerAddAction( LoadTrig( "InitModeSelect2" ), function ModeDialogAction )

		call SaveTrig( "UnitDamagedTrig" )
		call TriggerAddAction( LoadTrig( "UnitDamagedTrig" ), function UnitDamagedAction )		

		call SaveTrig( "GetEnteringUnitTrig" )
		call SaveRegionHandle( HashTable, GetHandleId( LoadTrig( "GetEnteringUnitTrig" ) ), 0, CreateRegion( ) )
		call RegionAddRect( LoadRegionHandle( HashTable, GetHandleId( LoadTrig( "GetEnteringUnitTrig" ) ), 0 ), GetWorldBounds( ) )
		call TriggerRegisterEnterRegion( LoadTrig( "GetEnteringUnitTrig" ), LoadRegionHandle( HashTable, GetHandleId( LoadTrig( "GetEnteringUnitTrig" ) ), 0 ), Filter( function EnteringUnitCheckAction ) )

		call SaveTrig( "ReviveSystemTrig" )
		call GetUnitEvent( LoadTrig( "ReviveSystemTrig" ), EVENT_PLAYER_UNIT_DEATH )
		call TriggerAddCondition( LoadTrig( "ReviveSystemTrig" ), Condition( function ReviveSystemAction ) )

		call SaveTrig( "CameraHeightTrig" )
		call TimerStart( CreateTimer( ), .0, true, function CameraSetHeight )
		call GetChatEvent( LoadTrig( "CameraHeightTrig" ), "-camera ", false )
		call TriggerAddAction( LoadTrig( "CameraHeightTrig" ), function CameraAdjustionAction )

		call SaveTrig( "ClearMessagesTrig" )
		call GetChatEvent( LoadTrig( "ClearMessagesTrig" ), "-clear", true )
		call TriggerAddAction( LoadTrig( "ClearMessagesTrig" ), function ClearMessagesAction )
	endfunction

	function InitSystemUnits takes nothing returns nothing
		call SaveUnit( "WayGate", CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'wgt1', -11000, 10000, 270 ) )
		call WaygateSetDestination( LoadUnit( "WayGate" ), 0, 4000 )
		call WaygateActivate( LoadUnit( "WayGate" ), true )
		call CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), 'mtk1', -11500, 10500,  270 )
	endfunction

	function InitInformation takes nothing returns nothing
		call SaveQuestHandle( HashTable, GetHandleId( LoadUnit( "WayGate" ) ), StringHash( "GameInfo" ), CreateQuest( ) )
		call QuestSetTitle( LoadQuest( "GameInfo" ), "|cffffcc00Gameplay Information|r" )
		call QuestSetDescription( LoadQuest( "GameInfo" ), "TRIGSTR_000" )
		call QuestSetIconPath( LoadQuest( "GameInfo" ), "Characters\\SaberAlter\\ReplaceableTextures\\CommandButtons\\BTNSaberAlterIcon.blp" )
		call QuestSetRequired( LoadQuest( "GameInfo" ), true )
		call QuestSetDiscovered( LoadQuest( "GameInfo" ), true )
		call QuestSetCompleted( LoadQuest( "GameInfo" ), false )
		call RemoveSavedHandle( HashTable, GetHandleId( LoadUnit( "WayGate" ) ), StringHash( "GameInfo" ) )

		call SaveQuestHandle( HashTable, GetHandleId( LoadUnit( "WayGate" ) ), StringHash( "Credits" ), CreateQuest( ) )
		call QuestSetTitle( LoadQuest( "Credits" ), "|cffffcc00Map Credits|r" )
		call QuestSetDescription( LoadQuest( "Credits" ), "TRIGSTR_001" )
		call QuestSetIconPath( LoadQuest( "Credits" ), "Characters\\SaberNero\\ReplaceableTextures\\CommandButtons\\BTNSaberNeroIcon.blp" )
		call QuestSetRequired( LoadQuest( "Credits" ), false )
		call QuestSetDiscovered( LoadQuest( "Credits" ), true )
		call QuestSetCompleted( LoadQuest( "Credits" ), false )
		call RemoveSavedHandle( HashTable, GetHandleId( LoadUnit( "WayGate" ) ), StringHash( "Credits" ) )

		call SaveQuestHandle( HashTable, GetHandleId( LoadUnit( "WayGate" ) ), StringHash( "Sponsors" ), CreateQuest( ) )
		call QuestSetTitle( LoadQuest( "Sponsors" ), "|cffffcc00Sponsor Sites|r" )
		call QuestSetDescription( LoadQuest( "Sponsors" ), "TRIGSTR_002" )
		call QuestSetIconPath( LoadQuest( "Sponsors" ), "Characters\\Scathach\\ReplaceableTextures\\CommandButtons\\BTNScathachIcon.blp" )
		call QuestSetRequired( LoadQuest( "Sponsors" ), false )
		call QuestSetDiscovered( LoadQuest( "Sponsors" ), true )
		call QuestSetCompleted( LoadQuest( "Sponsors" ), false )
		call RemoveSavedHandle( HashTable, GetHandleId( LoadUnit( "WayGate" ) ), StringHash( "Sponsors" ) )
	endfunction

	function TestTriggers takes nothing returns nothing
		local integer i = 0

		loop
			exitwhen i > 11

			if GetPlayerSlotState( Player( i ) ) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController( Player( i ) ) == MAP_CONTROL_USER then
				if GetPlayerName( Player( i ) ) == "Unryze" or GetPlayerName( Player( i ) ) == "WorldEdit" then	
					call SaveTrig( "GetUsedAbilTrig" )
					call GetUnitEvent( LoadTrig( "GetUsedAbilTrig" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
					call TriggerAddAction( LoadTrig( "GetUsedAbilTrig" ), function GetUsedAbilityIDAction )

					call SaveTrig( "GetUnitIDTrig" )
					call GetUnitEvent( LoadTrig( "GetUnitIDTrig" ), EVENT_PLAYER_UNIT_SELECTED )
					call TriggerAddAction( LoadTrig( "GetUnitIDTrig" ), function UnitIDAction )

					call SaveTrig( "GetItemIDTrig" )
					call GetUnitEvent( LoadTrig( "GetItemIDTrig" ), EVENT_PLAYER_UNIT_PICKUP_ITEM )
					call TriggerAddAction( LoadTrig( "GetItemIDTrig" ), function PickedUpItemIDAction )
					set i = 20
				endif
			endif

			set i = i + 1
		endloop

		call SaveTrig( "NCDTextTrig" )
		call GetChatEvent( LoadTrig( "NCDTextTrig" ), "-nc", true )
		call TriggerAddAction( LoadTrig( "NCDTextTrig" ), function NoCooldownActivationAction )

		call SaveTrig( "PlayUnitAnimTrig" )
		call GetChatEvent( LoadTrig( "PlayUnitAnimTrig" ), "-PlayAnimation ", false )
		call TriggerAddAction( LoadTrig( "PlayUnitAnimTrig" ), function PlayAnimationAction )		

		call SaveTrig( "GetMSTrig" )
		call GetChatEvent( LoadTrig( "GetMSTrig" ), "-ms", false )
		call TriggerAddAction( LoadTrig( "GetMSTrig" ), function GetUnitMoveSpeedAction )

		call SaveTrig( "GetCamInfoTrig" )
		call GetChatEvent( LoadTrig( "GetCamInfoTrig" ), "-Caminfo", true )
		call TriggerAddAction( LoadTrig( "GetCamInfoTrig" ), function DebugCamInfo )

		call SaveTrig( "TestTeleportTrig" )
		call GetChatEvent( LoadTrig( "TestTeleportTrig" ), "-Teleport", true )
		call TriggerAddAction( LoadTrig( "TestTeleportTrig" ), function TeleportToLocation )
		
		call SaveTrig( "SetOwnerTrig" )
		call GetChatEvent( LoadTrig( "SetOwnerTrig" ), "-owner ", false )
		call TriggerAddAction( LoadTrig( "SetOwnerTrig" ), function SetUnitOwnerAction )
		
		call SaveTrig( "CreateItemTrig" )
		call GetChatEvent( LoadTrig( "CreateItemTrig" ), "-CreateItem ", false )
		call TriggerAddAction( LoadTrig( "CreateItemTrig" ), function ItemCreationChatCommandAction )		
		
		call SaveTrig( "CreateUnitTrig" )
		call GetChatEvent( LoadTrig( "CreateUnitTrig" ), "-CreateUnit ", false )
		call TriggerAddAction( LoadTrig( "CreateUnitTrig" ), function UnitCreationChatCommandAction )		
		
		call SaveTrig( "RemoveUnitTrig" )
		call GetChatEvent( LoadTrig( "RemoveUnitTrig" ), "-RemoveUnit", true )
		call TriggerAddAction( LoadTrig( "RemoveUnitTrig" ), function RemoveUnitCommandAction )

		call SaveTrig( "AddAbilityTrig" )
		call GetChatEvent( LoadTrig( "AddAbilityTrig" ), "-AddAbility ", false )
		call TriggerAddAction( LoadTrig( "AddAbilityTrig" ), function LearnAbilityChatCommandAction )

		call SaveTrig( "RemoveAbilityTrig" )
		call GetChatEvent( LoadTrig( "RemoveAbilityTrig" ), "-RemoveAbility ", false )
		call TriggerAddAction( LoadTrig( "RemoveAbilityTrig" ), function UnlearnAbilityChatCommandAction )

		call SaveTrig( "SetStatTrig" )
		call GetChatEvent( LoadTrig( "SetStatTrig" ), "-str ", false )
		call GetChatEvent( LoadTrig( "SetStatTrig" ), "-agi ", false )
		call GetChatEvent( LoadTrig( "SetStatTrig" ), "-int ", false )
		call TriggerAddAction( LoadTrig( "SetStatTrig" ), function SetUnitStatAction )

		call SaveTrig( "ScaleUnitTrig" )
		call GetChatEvent( LoadTrig( "ScaleUnitTrig" ), "-scale ", false )
		call TriggerAddAction( LoadTrig( "ScaleUnitTrig" ), function SetUnitScaleSystemAction )

		call SaveTrig( "SetGoldTrig" )
		call GetChatEvent( LoadTrig( "SetGoldTrig" ), "-gold", true )
		call TriggerAddAction( LoadTrig( "SetGoldTrig" ), function AddGoldAction )

		call SaveTrig( "SetLevelTrig" )
		call GetChatEvent( LoadTrig( "SetLevelTrig" ), "-level ", false )
		call TriggerAddAction( LoadTrig( "SetLevelTrig" ), function SetLevelAction )

		call SaveTrig( "GetAllHeroesTrig" )
		call GetChatEvent( LoadTrig( "GetAllHeroesTrig" ), "-heroes", true )
		call TriggerAddAction( LoadTrig( "GetAllHeroesTrig" ), function AllHeroPickAction )

		call SaveTrig( "SpawnTestUnitTrig" )
		call GetChatEvent( LoadTrig( "SpawnTestUnitTrig" ), "-TestUnit", true )
		call TriggerAddAction( LoadTrig( "SpawnTestUnitTrig" ), function TestUnitSpawnAction )

		call SaveTrig( "ExecuteFunction" )
		call GetChatEvent( LoadTrig( "ExecuteFunction" ), "-Execute ", false )
		call TriggerAddAction( LoadTrig( "ExecuteFunction" ), function ExecuteFunction )
	endfunction

	function InitSoloDetection takes nothing returns nothing
		local integer i = 0

		if LoadInteger( HashTable, GetHandleId( CameraSet ), 500 ) == 0 or LoadInteger( HashTable, GetHandleId( CameraSet ), 501 ) == 0 then
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), StringHash( "TestMode" ), true )
			call SaveBoolean( HashTable, GetHandleId( CameraSet ), StringHash( "IsSameHero" ), true )

			loop
				exitwhen i > LoadInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TotalHeroes" ) )
				call InitHeroTrig( i )
				set i = i + 1
			endloop

			call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "RoundLimit" ), 999999999 )
			call SaveInteger( HashTable, GetHandleId( CameraSet ), StringHash( "TimerMaximumCount" ), 4000 )
			call ExecuteFunc( "TestTriggers" )
			call DestroyTrigger( LoadTrig( "InitModeSelect1" ) )
			call EnableTrigger( LoadTrig( "HeroSelectionTrig" ) )
			call TimerStart( CreateTimer( ), 1, true, function InGameTimerAction )
		else
			call TimerStart( CreateTimer( ), 2, false, function ModeSelectionFunction1 )
		endif
	endfunction	

	function InitMapData takes nothing returns nothing
		call FogEnable( false )
		call FogMaskEnable( false )
		call SetTimeOfDayScale( 0. )
		call SuspendTimeOfDay( true )
		call SetMapMusic( "Music", true, 0 )
		call NewSoundEnvironment( "Default" )
		call SetSkyModel( "UI\\DNC\\Sky.mdl" )
		call SetWaterBaseColor( 255, 255, 255, 255 )
		call SetMapFlag( MAP_FOG_HIDE_TERRAIN, true )
		call SetTerrainFogEx( 0, 3000, 5000, .5, 0, 0, 0 )
		call SetMapFlag( MAP_LOCK_RESOURCE_TRADING, true )
		call SetMapFlag( MAP_SHARED_ADVANCED_CONTROL, false )
		call SetFloatGameState( GAME_STATE_TIME_OF_DAY, 12.00 )
		call SetDayNightModels( "UI\\DNC\\Terrain.mdl", "UI\\DNC\\Unit.mdl" )
		call SetCameraBounds( -11008., -11520., 11008., 11008., -11008., 11008., 11008., -11520. )
	endfunction

	function InitPreload takes nothing returns nothing
		call Preloader( "scripts\\OrcMelee.pld" )
		call Preloader( "scripts\\HumanMelee.pld" )
		call Preloader( "scripts\\UndeadMelee.pld" )
		call Preloader( "scripts\\NightElfMelee.pld" )
	endfunction

	function main takes nothing returns nothing
		call ExecuteFunc( "InitPreload" )
		call ExecuteFunc( "InitMapData" )
		call ExecuteFunc( "InitVariables" )
		call ExecuteFunc( "InitTriggers" )
		call ExecuteFunc( "InitPlayerData" )
		call ExecuteFunc( "InitInformation" )
		call ExecuteFunc( "InitSystemUnits" )
		call ExecuteFunc( "InitHeroPickData" )
		call ExecuteFunc( "InitSoloDetection" )
		call ExecuteFunc( "InitSetPlayerName" )
	endfunction

	function config takes nothing returns nothing
		local integer index  = 0
		local integer TeamID = 0

		call SetPlayers( 10 )
		call SetTeams( 2 )

		loop
			exitwhen index > 11
			if index > 4 then
				set TeamID = 1
			endif

			call SetPlayerTeam( Player( index ), TeamID )
			call SetPlayerRaceSelectable( Player( index ), false )
			call SetPlayerController( Player( index ), MAP_CONTROL_USER )
			call SetPlayerRacePreference( Player( index ), RACE_PREF_HUMAN )

			set index = index + 1
		endloop
	endfunction