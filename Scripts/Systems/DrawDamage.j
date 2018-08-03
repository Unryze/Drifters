	function DamageVisualDrawNumber takes string LocNumber, real LocPosX, real LocPosY, string LocSuffix returns nothing
		call DestroyEffect( AddSpecialEffect( "DamageSystemVisual\\Number_" + LocNumber + LocSuffix + ".mdl", LocPosX, LocPosY ) )
	endfunction

	function DamageVisualGetPosition takes real GraphSpace, real LocInitPos, integer LocActual, integer LocFinal, real LocRatio returns real
		return LocInitPos - ( GraphSpace * LocRatio * ( LocFinal / 2 ) ) + ( GraphSpace * LocRatio * LocActual )
	endfunction

	function DamageVisualDrawNumberAction takes unit LocSource, unit LocTarget, real LocAmount returns nothing
		local real 		GraphSpace 	= 70.
		local real 		LocPosX 	= GetUnitX( LocTarget )
		local real 		LocPosY 	= GetUnitY( LocTarget ) + GetUnitFlyHeight( LocTarget ) + 150
		local string 	LocNumbers 	= I2S( R2I( LocAmount ) )
		local integer 	LocSize 	= StringLength( LocNumbers )
		local real 		LocNewPosX 	= 0
		local string 	LocSuffix 	= ""
		local real 		LocRatio 	= 0
		local integer 	index 		= 0

		if LocAmount >= 5000 then
			set LocSuffix = "_Large"
			set LocRatio = 1.3
	elseif LocAmount >= 500 then
			set LocSuffix = ""
			set LocRatio = 1.0
		else
			set LocSuffix = "_Small"
			set LocRatio = 0.7
		endif

		set index = -1

		loop
			set index = index + 1
			exitwhen index > LocSize - 1
			set LocNewPosX = DamageVisualGetPosition( GraphSpace, LocPosX, index, LocSize, LocRatio )

			if IsUnitVisible( LocTarget, GetOwningPlayer( LocSource ) ) then
				call DamageVisualDrawNumber( SubString( LocNumbers, index, index + 1 ), LocNewPosX, LocPosY, LocSuffix )
			endif
		endloop
	endfunction

