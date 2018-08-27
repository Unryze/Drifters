	function ProjectileMovement takes integer HandleID returns nothing
		if GetReal( "InitDistance" ) <= GetReal( "MaxDistance" ) then
			call SaveReal( HashTable, HandleID, StringHash( "InitDistance" ), GetReal( "InitDistance" ) + GetReal( "Step" ) )
			call CreateXY( GetReal( "InitProjectileX" ), GetReal( "InitProjectileY" ), GetReal( "InitDistance" ), GetReal( "ProjectileAngle" ), "ProjectileMove" )
			call SetUnitPosition( MUIUnit( StringHash( "GetProjectile" ) ), GetReal( "ProjectileMoveX" ), GetReal( "ProjectileMoveY" ) )
			call AoEDamageXY( MUIHandle( ), GetReal( "ProjectileMoveX" ), GetReal( "ProjectileMoveY" ), 200, "", "", 0, true, "", 0 )
		else
			call KillUnit( MUIUnit( StringHash( "GetProjectile" ) ) )
			call DestroyEffect( MUIEffect( StringHash( "DummyEffect" ) ) )
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
		call MUIDummyXY( StringHash( "GetProjectile" ), 'u001', GetReal( "InitProjectileX" ), GetReal( "InitProjectileY" ), GetReal( "ProjectileAngle" ) )
		call ScaleUnit( MUIUnit( StringHash( "GetProjectile" ) ), Scale )
		call SetUnitPathing( MUIUnit( StringHash( "GetProjectile" ) ), false )
		call MUISaveEffect( StringHash( "DummyEffect" ), Effect, StringHash( "GetProjectile" ) )
	endfunction

