ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

Citizen.CreateThread(function()
	while true do
		local wait = 1000
		for i = 1, #Config.ShopItem do
			local v = Config.ShopItem[i]
			local pPos = GetEntityCoords(PlayerPedId())

			for k in pairs(v.PositonMenu) do
				local pos = v.PositonMenu
				local dst = Vdist(pos[k].x, pos[k].y, pos[k].z, pPos.x, pPos.y, pPos.z)

				if dst <= v.Marker.Distance and v.MarkesEnable then
					wait = 0
					DrawMarker(v.Marker.Type, pos[k].x, pos[k].y, pos[k].z-0.9, 0.0, 0.0, 0.0, 0.0,0.0,0.0, v.Marker.SizeLargeur, v.Marker.SizeEpaisseur, v.Marker.SizeHauteur, v.Marker.ColorR, v.Marker.ColorG, v.Marker.ColorB, v.Marker.Opacite, v.Marker.Saute, true, p19, v.Marker.Tourne)
				end

				if dst <= 1.0 then
					wait = 0
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour interagir.")
					if IsControlJustPressed(1, 51) then
						OpenMenuShopItem(v)
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
	for i = 1, #Config.ShopItem do
		local v = Config.ShopItem[i]
		if v.PedEnable then
			local HashPed = GetHashKey(v.Ped.hash)
			while not HasModelLoaded(HashPed) do
			RequestModel(HashPed)
			Wait(20)
			end

			Ped = CreatePed("PED_TYPE_CIVMALE", HashPed, v.Ped.pos.x, v.Ped.pos.y, v.Ped.pos.z - 1, false, true)
			SetBlockingOfNonTemporaryEvents(Ped, true)
			FreezeEntityPosition(Ped, true)
			SetEntityInvincible(Ped, true)
			SetEntityHeading(Ped, v.Ped.pos.w)
			
		end

		if v.BlipsEnable then

			local blip = AddBlipForCoord(v.Blips.pos)

			SetBlipSprite(blip, v.Blips.Id)
			SetBlipScale (blip, v.Blips.Taille)
			SetBlipColour(blip, v.Blips.Color)
			SetBlipAsShortRange(blip, v.Blips.Range)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(v.Blips.Name)
			EndTextCommandSetBlipName(blip)
			
		end
	end
end)