	globals
		camerasetup CameraSet = CreateCameraSetup( )
		hashtable HashTable   = InitHashtable( )
	endglobals

	function Char2Id takes string LocalString1 returns integer
		local integer LocalInteger1 = 0
		local string  LocalString3

		loop
			set LocalString3 = SubString( LoadStr( HashTable, GetHandleId( CameraSet ), StringHash( "Letters" ) ), LocalInteger1, LocalInteger1 + 1 )
			exitwhen LocalString3 == null or LocalString3 == LocalString1
			set LocalInteger1 = LocalInteger1 + 1
		endloop

		if LocalInteger1 < 10 then
			return LocalInteger1 + 48
	elseif LocalInteger1 < 36 then
			return LocalInteger1 + 65 - 10
		endif
		
		return LocalInteger1 + 97 - 36
	endfunction

	function String2Id takes string LocalString4 returns integer
		return ( ( Char2Id( SubString( LocalString4, 0, 1 ) ) * 256 + Char2Id( SubString( LocalString4, 1, 2 ) ) ) * 256 + Char2Id( SubString( LocalString4, 2, 3 ) ) ) * 256 + Char2Id( SubString( LocalString4, 3, 4 ) )
	endfunction

	function Id2Char takes integer LocalInteger1 returns string
		if LocalInteger1 >= 97 then
			return SubString( LoadStr( HashTable, GetHandleId( CameraSet ), StringHash( "Letters" ) ), LocalInteger1 - 97 + 36, LocalInteger1 - 96 + 36 )
	elseif LocalInteger1 >= 65 then
			return SubString( LoadStr( HashTable, GetHandleId( CameraSet ), StringHash( "Letters" ) ), LocalInteger1 - 65 + 10, LocalInteger1 - 64 + 10 )
		endif

		return SubString( LoadStr( HashTable, GetHandleId( CameraSet ), StringHash( "Letters" ) ), LocalInteger1 - 48, LocalInteger1 - 47 )
	endfunction

	function Id2String takes integer LocalInteger2 returns string
		local integer LocalInteger3 = LocalInteger2 / 256
		local string  LocalString5  = Id2Char( LocalInteger2 - 256 * LocalInteger3 )

		set LocalInteger2 = LocalInteger3 / 256
		set LocalString5  = Id2Char( LocalInteger3 - 256 * LocalInteger2 ) + LocalString5
		set LocalInteger3 = LocalInteger2 / 256

		return Id2Char( LocalInteger3 ) + Id2Char( LocalInteger2 - 256 * LocalInteger3 ) + LocalString5
	endfunction

	function GetDialog takes nothing returns dialog
		return LoadDialogHandle( HashTable, GetHandleId( CameraSet ), StringHash( "ModeDialog" ) )
	endfunction

	function GetMultiboard takes nothing returns multiboard
		return LoadMultiboardHandle( HashTable, GetHandleId( CameraSet ), StringHash( "Multiboard" ) )
	endfunction

	function GetMBItem takes nothing returns multiboarditem 
		return LoadMultiboardItemHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ) )
	endfunction	

	function ReleaseMBItem takes nothing returns nothing
		call MultiboardReleaseItem( GetMBItem( ) )
		call RemoveSavedHandle( HashTable, GetHandleId( CameraSet ), StringHash( "MBItem" ) )
	endfunction

	function MakeSound takes string SoundName returns sound
		return CreateSound( "Sounds\\" + SoundName, false, false, false, 12700, 12700, "DefaultEAXON" )
	endfunction	
	
	function SaveSound takes string SoundHashName, string SoundPath returns nothing
		call SaveSoundHandle( HashTable, GetHandleId( CameraSet ), StringHash( SoundHashName ), MakeSound( SoundPath ) )
	endfunction
	
	function LoadSound takes string SoundHashName returns sound
		return LoadSoundHandle( HashTable, GetHandleId( CameraSet ), StringHash( SoundHashName ) )
	endfunction
	
	function SaveTrig takes string TrigHashName returns nothing
		call SaveTriggerHandle( HashTable, GetHandleId( CameraSet ), StringHash( TrigHashName ), CreateTrigger( ) )
	endfunction
	
	function LoadTrig takes string TrigHashName returns trigger
		return LoadTriggerHandle( HashTable, GetHandleId( CameraSet ), StringHash( TrigHashName ) )
	endfunction	
	
	function SaveUnit takes string UnitHashName, unit LocUnit returns nothing
		call SaveUnitHandle( HashTable, GetHandleId( CameraSet ), StringHash( UnitHashName ), LocUnit )
	endfunction
	
	function LoadUnit takes string UnitHashName returns unit
		return LoadUnitHandle( HashTable, GetHandleId( CameraSet ), StringHash( UnitHashName ) )
	endfunction
	
	function LoadQuest takes string QuestHashName returns quest
		return LoadQuestHandle( HashTable, GetHandleId( LoadUnit( "WayGate" ) ), StringHash( QuestHashName ) )
	endfunction	
	
	function NewMUITimer takes integer PID returns integer
		local integer GetIterator = LoadInteger( HashTable, GetHandleId( Player( PID ) ), StringHash( "TimerIterator" ) )

		if LoadInteger( HashTable, GetHandleId( Player( PID ) ), StringHash( "TimerIterator" ) ) <= 4000 then
			call SaveInteger( HashTable, GetHandleId( Player( PID ) ), StringHash( "TimerIterator" ), GetIterator + 1 )
			set GetIterator = LoadInteger( HashTable, GetHandleId( Player( PID ) ), StringHash( "TimerIterator" ) ) - 1
		else
			call SaveInteger( HashTable, GetHandleId( Player( PID ) ), StringHash( "TimerIterator" ), 0 )
			set GetIterator = 0
		endif

		if LoadTimerHandle( HashTable, GetHandleId( Player( PID ) ), GetIterator ) == null then
			call SaveTimerHandle( HashTable, GetHandleId( Player( PID ) ), GetIterator, CreateTimer( ) )
		endif

		return GetHandleId( LoadTimerHandle( HashTable, GetHandleId( Player( PID ) ), GetIterator ) )
	endfunction

	function LoadMUITimer takes integer PID returns timer
		return LoadTimerHandle( HashTable, GetHandleId( Player( PID ) ), LoadInteger( HashTable, GetHandleId( Player( PID ) ), StringHash( "TimerIterator" ) ) - 1 )
	endfunction	

	function UnitMaxLife takes unit LocUnit returns real
		return GetUnitState( LocUnit, UNIT_STATE_MAX_LIFE )
	endfunction

	function UnitLife takes unit LocUnit returns real
		return GetUnitState( LocUnit, UNIT_STATE_LIFE )
	endfunction	

	function GetUnitEvent takes trigger LocTrig, playerunitevent whichEvent returns nothing
		local integer index = 0

		loop
			call TriggerRegisterPlayerUnitEvent( LocTrig, Player( index ), whichEvent, null )
			set index = index + 1
			exitwhen index == bj_MAX_PLAYER_SLOTS
		endloop
	endfunction

	function GetPlayerEvent takes trigger LocTrig, playerevent whichEvent returns nothing
		local integer index = 0
		
		loop
			call TriggerRegisterPlayerEvent( LocTrig, Player( index ), whichEvent )
			set index = index + 1
			exitwhen index == bj_MAX_PLAYER_SLOTS
		endloop
	endfunction

	function GetChatEvent takes trigger LocTrig, string LocText, boolean LocBool returns nothing
		local integer index = 0
		
		loop
			call TriggerRegisterPlayerChatEvent( LocTrig, Player( index ), LocText, LocBool )
			set index = index + 1
			exitwhen index == bj_MAX_PLAYER_SLOTS
		endloop
	endfunction

	function AngleBetweenUnits takes unit CasterUnit, unit TargetUnit returns real
		return 180.0 / 3.14159 * Atan2( GetUnitY( TargetUnit ) - GetUnitY( CasterUnit ), GetUnitX( TargetUnit ) - GetUnitX( CasterUnit ) )
	endfunction

	function MUIAngleCoord takes real CasterX, real CasterY, real TargetX, real TargetY returns real
		return Atan2( TargetY - CasterY, TargetX - CasterX )
	endfunction
	
	function MUIAngleUnits takes unit CasterUnit, unit TargetUnit returns real
		return MUIAngleCoord( GetUnitX( CasterUnit ), GetUnitY( CasterUnit ), GetUnitX( TargetUnit ), GetUnitY( TargetUnit ) )
	endfunction	

	function MUIAngleData takes real CasterX, real CasterY, real TargetX, real TargetY returns real
		return 180.0 / 3.14159 * Atan2( TargetY - CasterY, TargetX - CasterX )
	endfunction	

	function DistanceBetweenUnits takes unit UnitA, unit UnitB returns real
		return SquareRoot( Pow( GetUnitX( UnitB ) - GetUnitX( UnitA ), 2 ) + Pow( GetUnitY( UnitB ) - GetUnitY( UnitA ), 2 ) )
	endfunction

	function DistanceBetweenAxis takes real LocX1, real LocY1, real LocX2, real LocY2 returns real
		return SquareRoot( Pow( LocX2 - LocX1, 2 ) + Pow( LocY2 - LocY1, 2 ) )
	endfunction

	function SetUnitXAndY takes unit LocUnit, real InitX, real InitY, real LocDistance, real LocAngle returns nothing
		call SetUnitPosition( LocUnit, InitX + LocDistance * Cos( LocAngle * bj_DEGTORAD ), InitY + LocDistance * Sin( LocAngle * bj_DEGTORAD ) )
		call SetUnitFacing( LocUnit, LocAngle )
	endfunction

	function MUIHandle takes nothing returns integer
		return GetHandleId( GetExpiredTimer( ) )
	endfunction

	function GetStr takes string HashName returns string
		return LoadStr( HashTable, MUIHandle( ), StringHash( HashName ) )
	endfunction
	
	function GetInt takes string HashName returns integer
		return LoadInteger( HashTable, MUIHandle( ), StringHash( HashName ) )
	endfunction	

	function GetReal takes string HashName returns real
		return LoadReal( HashTable, MUIHandle( ), StringHash( HashName ) )
	endfunction
	
	function GetBool takes string HashName returns boolean 
		return LoadBoolean( HashTable, MUIHandle( ), StringHash( HashName ) )
	endfunction	

	function GetEffect takes string HashName returns effect 
		return LoadEffectHandle( HashTable, MUIHandle( ), StringHash( HashName ) )
	endfunction	

	function CreateXY takes real InitX, real InitY, real LocDistance, real LocAngle, string HashName returns nothing
		call SaveReal( HashTable, MUIHandle( ), StringHash( HashName + "X" ), InitX + LocDistance * Cos( LocAngle * bj_DEGTORAD ) )
		call SaveReal( HashTable, MUIHandle( ), StringHash( HashName + "Y" ), InitY + LocDistance * Sin( LocAngle * bj_DEGTORAD ) )
	endfunction	

	function CreateDistanceAndAngle takes real LocX, real LocY, string HashName returns nothing
		call SaveReal( HashTable, MUIHandle( ), StringHash( "Distance" ), DistanceBetweenAxis( LocX, LocY, GetReal( HashName + "X" ), GetReal( HashName + "Y" ) ) )
		call SaveReal( HashTable, MUIHandle( ), StringHash( "Angle" ), MUIAngleData( LocX, LocY, GetReal( HashName + "X" ), GetReal( HashName + "Y" ) ) )
	endfunction
	
	function CreateTargetXY takes integer HandleID, unit Caster, unit Target returns nothing
		call SaveReal( HashTable, HandleID, StringHash( "CasterX" ), GetUnitX( Caster ) )
		call SaveReal( HashTable, HandleID, StringHash( "CasterY" ), GetUnitY( Caster ) )
		call SaveReal( HashTable, HandleID, StringHash( "TargetX" ), GetUnitX( Target ) )
		call SaveReal( HashTable, HandleID, StringHash( "TargetY" ), GetUnitY( Target ) )
	endfunction
	
	function GetIteration takes integer Init, integer Divider returns boolean
		return Init / ( Init / Divider ) == Divider
	endfunction

	function MUIUnit takes integer UID returns unit
		return LoadUnitHandle( HashTable, MUIHandle( ), UID )
	endfunction

	function MUICasterID takes nothing returns integer
		return GetPlayerId( GetOwningPlayer( MUIUnit( 100 ) ) )
	endfunction

	function MUILevel takes nothing returns integer
		return GetHeroLevel( MUIUnit( 100 ) )
	endfunction

	function MUIPower takes nothing returns integer
		return GetHeroInt( MUIUnit( 100 ), true )
	endfunction	

	function MUIInteger takes integer ID returns integer
		return LoadInteger( HashTable, MUIHandle( ), ID )
	endfunction	

	function MUIEffect takes integer ID returns effect
		return LoadEffectHandle( HashTable, MUIHandle( ), ID )
	endfunction 

	function MUISaveEffect takes integer EffID, string EffName, integer UID returns nothing
		call SaveEffectHandle( HashTable, MUIHandle( ), EffID, AddSpecialEffectTarget( EffName, MUIUnit( UID ), "origin" ) )
	endfunction 

	function MUIDummyXY takes integer ID, integer UID, real LocX, real LocY, real LocFacing returns nothing
		call SaveUnitHandle( HashTable, MUIHandle( ), ID, CreateUnit( Player( PLAYER_NEUTRAL_PASSIVE ), UID, LocX, LocY, LocFacing ) )
	endfunction	

	function IsUnitIgnored takes unit LocUnit returns integer
		return LoadInteger( HashTable, MUIHandle( ), GetHandleId( LocUnit ) )
	endfunction

	function UnitSelect takes unit LocUnit returns nothing
		if GetLocalPlayer( ) == GetOwningPlayer( LocUnit ) then
			call ClearSelection( )
			call SelectUnit( LocUnit, true )
		endif
	endfunction

	function SetUnitData takes unit LocUnit, integer ID, integer Amount returns nothing
		call SaveInteger( HashTable, GetHandleId( LocUnit ), ID, Amount )
	endfunction 

	function GetUnitData takes unit LocUnit, integer ID returns integer
		return LoadInteger( HashTable, GetHandleId( LocUnit ), ID )
	endfunction

	function GetMapBound takes string LocString returns real
		return LoadReal( HashTable, GetHandleId( CameraSet ), StringHash( LocString ) )
	endfunction

	function EnumUnits takes nothing returns group
		return LoadGroupHandle( HashTable, GetHandleId( CameraSet ), StringHash( "GlobalGroup" ) )
	endfunction

	function GetTeamColour takes integer ID returns string
		if GetPlayerTeam( Player( ID ) ) == 0 then
			return "|c00FF0000"
		else
			return "|c0000FFFF"
		endif
	endfunction	

	function DisableSharedUnitsAct takes nothing returns nothing
		local integer IndexA = 0
		local integer IndexB = 0

		loop
			exitwhen IndexA > 11

			if Player( IndexA ) != Player( IndexB ) then
				call SetPlayerAlliance( Player( IndexA ), Player( IndexB ), ALLIANCE_SHARED_CONTROL, false )
			endif

			set IndexB = IndexB + 1

			if IndexB > 11 then
				set IndexB = 0
				set IndexA = IndexA + 1
			endif
		endloop
	endfunction	

	function ScaleUnit takes unit LocUnit, real LocScale returns nothing
		call SetUnitScale( LocUnit, LocScale, LocScale, LocScale )
	endfunction

	function DashEff takes nothing returns string
		return "Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl"
	endfunction

	function RMin takes real a, real b returns real
		if a < b then
			return a
		else
			return b
		endif
	endfunction

	function RMax takes real a, real b returns real
		if a < b then
			return b
		else
			return a
		endif
	endfunction

	function SwapAmount takes integer LocInt1, boolean LocBool returns integer
		if LocBool == true then
			set LocInt1 = -LocInt1
		endif

		return LocInt1
	endfunction	

	function GetUnitStatePercentage takes unit whichUnit, unitstate whichState, unitstate whichMaxState returns real
		local real value  	= GetUnitState( whichUnit, whichState )
		local real maxValue = GetUnitState( whichUnit, whichMaxState )

		if whichUnit == null or maxValue == 0 then
			return .0
		endif

		return value / maxValue * 100.0
	endfunction

	function MakeUnitAirborne takes unit AirUnit, real AirHeight, real AirRate returns nothing
		call UnitAddAbility( AirUnit, 'Amrf' )
		call SetUnitFlyHeight( AirUnit, AirHeight, AirRate )
	endfunction	

	function ResetAbilityCooldown takes unit LocTarget, integer LocID returns nothing
		call UnitRemoveAbility( LocTarget, LocID )	
		call UnitAddAbility( LocTarget, LocID )
	endfunction

	function GetInventoryIndexOfItem takes unit whichUnit, integer itemId returns integer
		local integer index = 0

		loop
			set bj_lastCreatedItem = UnitItemInSlot( whichUnit, index )

			if bj_lastCreatedItem != null and GetItemTypeId( bj_lastCreatedItem ) == itemId then
				return index + 1
			endif

			set index = index + 1
			exitwhen index >= bj_MAX_INVENTORY
		endloop

		return 0
	endfunction

	function GetUnitHasItem takes unit whichUnit, integer itemId returns item
		local integer index = GetInventoryIndexOfItem( whichUnit, itemId )

		if index == 0 then
			return null
		else
			return UnitItemInSlot( whichUnit, index - 1 )
		endif
	endfunction

	function CountItems takes unit whichUnit, integer whatItemtype returns integer
		local integer index = 0
		local integer count = 0

		loop
			exitwhen index >= bj_MAX_INVENTORY
			
			if GetItemTypeId( UnitItemInSlot( whichUnit, index ) ) == whatItemtype then
				set count = count + 1
			endif

			set index = index + 1
		endloop

		return count
	endfunction

	function SelectedFind takes nothing returns boolean
		call SaveUnit( "SelectedUnit", GetFilterUnit( ) )
		return true
	endfunction

	function SelectedUnit takes player LocPlayer returns unit
		call GroupEnumUnitsSelected( EnumUnits( ), LocPlayer, Condition( function SelectedFind ) )

		if LoadUnit( "SelectedUnit" ) == null then
			return null
		else
			return LoadUnit( "SelectedUnit" )
		endif
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

	function UnitHasItemById takes unit LocaUnitId, integer LocalTargetItemId returns boolean
		local integer index = 0

		if LocalTargetItemId != 0 then
			loop
				if GetItemTypeId( UnitItemInSlot( LocaUnitId, index ) ) == LocalTargetItemId then
					return true
				endif
				
				set index = index + 1
				exitwhen index >= 6
			endloop
		endif

		return false
	endfunction

	function HasEmptyItemSlot takes unit u returns boolean
		return UnitItemInSlot( u, 0 ) == null or UnitItemInSlot( u, 1 ) == null or UnitItemInSlot( u, 2 ) == null or UnitItemInSlot( u, 3 ) == null or UnitItemInSlot( u, 4 ) == null or UnitItemInSlot( u, 5 ) == null
	endfunction		

	function DialogShow takes dialog DialogName, boolean Show returns nothing
		local integer i = 0

		loop
			exitwhen i > 9
			call DialogDisplay( Player( i ), DialogName, Show )
			set i = i + 1
		endloop
	endfunction	

	function PlaySoundWithVolume takes sound soundHandle, real volumePercent, real startingOffset returns nothing
		local integer result = R2I( volumePercent * I2R( 127 ) * 0.01 )

		if result < 0 then
			set result = 0
	elseif result > 127 then
			set result = 127
		endif

		call SetSoundVolume( soundHandle, result )
		call StartSound( soundHandle )
		call SetSoundPlayPosition( soundHandle, R2I( startingOffset * 1000 ) )
	endfunction

