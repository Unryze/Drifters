function RubyRouseSpellQFunction2 takes nothing returns nothing
	call DoNothing()
endfunction

function RubyRouseSpellQFunction1 takes nothing returns boolean
	return GetSpellAbilityId() == 'A000' // Позже переставить на реальный.
endfunction

function HeroInit3 takes nothing returns nothing
		call SaveSound( "RubyRouseD1", "RubyRouse\\SpellD1.mp3" )
		call SaveSound( "RubyRouseQ1", "RubyRouse\\SpellQ1.mp3" )
		call SaveSound( "RubyRouseW1", "RubyRouse\\SpellW1.mp3" )
		call SaveSound( "RubyRouseE1", "RubyRouse\\SpellE1.mp3" )
		call SaveSound( "RubyRouseR1", "RubyRouse\\SpellR1.mp3" )
		call SaveSound( "RubyRouseR2", "RubyRouse\\SpellR2.mp3" )
		call SaveSound( "RubyRouseT1", "RubyRouse\\SpellT1.mp3" )

		/*call SaveTrig( "RubyRouseTrigD" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigD" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigD" ), Condition( function RubyRouseSpellDFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigD" ), function RubyRouseSpellDFunction2 )*/

		call SaveTrig( "RubyRouseTrigQ" )
		call GetUnitEvent( LoadTrig( "RubyRouseTrigQ" ), EVENT_PLAYER_UNIT_SPELL_EFFECT )
		call TriggerAddCondition( LoadTrig( "RubyRouseTrigQ" ), Condition( function RubyRouseSpellQFunction1 ) )
		call TriggerAddAction( LoadTrig( "RubyRouseTrigQ" ), function RubyRouseSpellQFunction2 )

		/*call SaveTrig( "RubyRouseTrigW" )
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
		call TriggerAddAction( LoadTrig( "RubyRouseTrigT" ), function RubyRouseSpellTFunction6 )*/
	endfunction
  
