function RubyRouseSpellQFunction4 takes nothing returns boolean
    local integer id = GetHandleId(GetExpiredTimer())
	if IsUnitEnemy( GetFilterUnit( ), GetOwningPlayer( MUIUnit( 100 ) ) ) then
        call TargetDamage( MUIUnit( 100 ), GetFilterUnit( ), "AoE", "Physical", 240 + MUILevel( ) * 80 + MUIPower( ) )
        call DestroyEffect(AddSpecialEffectTarget("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", GetFilterUnit(), "chest"))
    endif
    return true
endfunction

function RubyRouseSpellQFunction3 takes nothing returns nothing
	local integer   i   = GetHandleId( GetExpiredTimer( ) )
    local unit      u   = MUIUnit( 100 )
    local real      a   = MUIReal( 101 )
    local real      d   = MUIReal( 102 )
    local real      x   = 0
    local real      y   = 0
    
    if GetUnitCurrentOrder(u) == OrderId("avatar") then
        if d > 0 then
            set x = GetUnitX(u) + 25 * Cos(a)
            set y = GetUnitY(u) + 25 * Sin(a)
            if IsTerrainPathable(x, y, PATHING_TYPE_FLYABILITY) == false then
                call SetUnitX(u, x)
                call SetUnitY(u, y)
                    if d == 50 then
                        call GroupEnumUnitsInRange(GroupEnum, x, y, 250, Filter( function RubyRouseSpellQFunction4 ))
                        set x = GetUnitX(u) + 75 * Cos(a)
                        set y = GetUnitY(u) + 75 * Sin(a)
                    endif
            else
                call IssueImmediateOrder(u, "stop")
            endif
            call SaveReal(HashTable, i, 102, d - 25)
        else
            call IssueImmediateOrder(u, "stop")
        endif
    else
        call SetUnitTimeScale(GetTriggerUnit(), 1)
        call DestroyTimer(GetExpiredTimer())
        call FlushChildHashtable(HashTable, i)
    endif
    
    set u = null
endfunction

function RubyRouseSpellQFunction2 takes nothing returns nothing
	local integer LocPID = GetPlayerId( GetTriggerPlayer( ) )
	local integer HandleID = NewMUITimer( LocPID )

	call SetUnitTimeScale(GetTriggerUnit(), 1.5)
	call SetUnitAnimationByIndex(GetTriggerUnit(), 14)
	
	call SaveUnitHandle( HashTable, HandleID, 100, GetTriggerUnit( ) )
	call SaveReal( HashTable, HandleID, 101, AngleBetweenUnits(GetTriggerUnit( ), GetSpellTargetUnit( ) ) * 3.14159 / 180 )
	call SaveReal( HashTable, HandleID, 102, 400)
	
	call TimerStart( LoadMUITimer( LocPID ), .01, true, function RubyRouseSpellQFunction3 )	
endfunction

function RubyRouseSpellQFunction1 takes nothing returns boolean
    return GetSpellAbilityId() == 'A000'
endfunction

function HeroInit13 takes nothing returns nothing
		/*
		call SaveSound( "RubyRouseD1", "RubyRouse\\null.mp3" )
		*/

		/*
		call SaveTrig( "RubyRouseTrigD" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigD" ), Condition( function RubyRouseSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigD" ), function RubyRouseSpellDFunction2 )
		*/

		call SaveTrig( "RubyRouseTrigQ" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigQ" ), Condition( function RubyRouseSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigQ" ), function RubyRouseSpellQFunction2 )

		/*
		call SaveTrig( "RubyRouseTrigW" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigW" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigW" ), Condition( function RubyRouseSpellWFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigW" ), function RubyRouseSpellWFunction4 )

		call SaveTrig( "RubyRouseTrigE" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigE" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigE" ), Condition( function RubyRouseSpellEFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigE" ), function RubyRouseSpellEFunction4 )

		call SaveTrig( "RubyRouseTrigR" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigR" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigR" ), Condition( function RubyRouseSpellRFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigR" ), function RubyRouseSpellRFunction3 )

		call SaveTrig( "RubyRouseTrigT" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigT" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigT" ), Condition( function RubyRouseSpellTFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigT" ), function RubyRouseSpellTFunction6 )
		*/
	endfunction
  
