	function ProjectileMovement takes integer HandleID returns nothing
		if GetReal( "InitDistance" ) <= GetReal( "MaxDistance" ) then
			call SaveReal( HashTable, HandleID, StringHash( "InitDistance" ), GetReal( "InitDistance" ) + GetReal( "Step" ) )
			call CreateXY( GetReal( "InitProjectileX" ), GetReal( "InitProjectileY" ), GetReal( "InitDistance" ), GetReal( "ProjectileAngle" ), "ProjectileMove" )
			call SetUnitPosition( GetUnit( "GetProjectile" ), GetReal( "ProjectileMoveX" ), GetReal( "ProjectileMoveY" ) )
			call AoEDamageXY( MUIHandle( ), GetReal( "ProjectileMoveX" ), GetReal( "ProjectileMoveY" ), GetReal( "AoE" ), "", "", 0, true, "", 0 )
		else
			call KillUnit( GetUnit( "GetProjectile" ) )
			call DestroyEffect( GetEffect( "DummyEffect" ) )
		endif
	endfunction

	function InitProjectileXY takes integer HandleID, real CasterX, real CasterY, real TargetX, real TargetY, real InitDistance, real Step, real MaxDistance, real Scale, real AoE, string Effect, boolean IsSkillShot returns nothing
		call SaveReal( HashTable, HandleID, StringHash( "InitDistance" ), InitDistance )
		call SaveReal( HashTable, HandleID, StringHash( "Step" ), Step )
		call SaveReal( HashTable, HandleID, StringHash( "MaxDistance" ), MaxDistance )
		call SaveReal( HashTable, HandleID, StringHash( "Scale" ), Scale )
		call SaveReal( HashTable, HandleID, StringHash( "AoE" ), AoE )
		call SaveReal( HashTable, MUIHandle( ), StringHash( "ProjectileAngle" ), MUIAngleData( CasterX, CasterY, TargetX, TargetY ) )
		call CreateXY( CasterX, CasterY, InitDistance, GetReal( "ProjectileAngle" ), "InitProjectile" )
		call SaveBoolean( HashTable, HandleID, StringHash( "IsSkillShot" ), IsSkillShot )
		call GetDummyXY( "GetProjectile", 'u001', GetReal( "InitProjectileX" ), GetReal( "InitProjectileY" ), GetReal( "ProjectileAngle" ) )
		call ScaleUnit( GetUnit( "GetProjectile" ), Scale )
		call SetUnitPathing( GetUnit( "GetProjectile" ), false )
		call SaveEffect( "DummyEffect", Effect, "GetProjectile" )
	endfunction

