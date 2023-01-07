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

local open = false
local onPay = false
local Index = 1
local b2 = nil
local v2 = nil

function OpenMenuShopItem(v) 

	for a,b in pairs(v.Items) do
		b.donttouch = {}
		for i = 1, b.qtmax do
			table.insert(b.donttouch, i)
		end
	end

	local Main = RageUI.CreateMenu(v.NameMenu, v.DescriptionMenu, nil, nil, v.Directory, v.Banner)

	Main.Display.Header = true
	Main.Closed = function()
		open = false
		FreezeEntityPosition(PlayerPedId(), false)
	end

    if open then 
		open = false
		RageUI.Visible(Main, false)
		return
	else
		open = true 
		RageUI.Visible(Main, true)
		FreezeEntityPosition(PlayerPedId(), true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(Main, function()

			for a,b in pairs(v.Items) do
				RageUI.List(b.label..": ~"..v.ColorMenu.."~"..b.price * b.ListIndex.."~s~$", b.donttouch, b.ListIndex, nil, {Preview, LeftBadge = RageUI.BadgeStyle.Star}, true, {
		
					onListChange = function(i, Item)
						b.ListIndex = i;
					end,
		
					onSelected = function()

						ESX.TriggerServerCallback("eCoreShops:checkinv", function(result) 
							if result then
								onPay = true
								b2 = b
								v2 = v
							elseif not result then
								onPay = false
							end
						end, b)
					end, 
				})
			end

			if onPay == true then
				RageUI.Line()

				RageUI.List("Mode de paiement:", {"~"..v2.ColorMenu.."~Liquide~s~", "~"..v2.ColorMenu.."~Banque~s~", "~"..v2.ColorMenu.."~Argent Sale~s~"}, Index, nil, {Preview}, true, {
	
					onListChange = function(i, Item)
						Index = i;
					end,

					onActive = function()
						if Index == 1 then
							if not v.PayedMethode.Cash then
								Index = Index + 1
							end
						end

						if Index == 2 then
							if not v.PayedMethode.Bank then
								Index = Index + 1
							end
						end

						if Index == 3 then
							if not v.PayedMethode.BlackMoney then
								Index = Index - 2
							end
						end
					end,
		
					onSelected = function()

						if Index == 1 then
							ESX.TriggerServerCallback("eCoreShops:checkmoney_cash", function(result) 
								if result then
									onPay = false
								end
							end, b2)
						end

						if Index == 2 then
							ESX.TriggerServerCallback("eCoreShops:checkmoney_bank", function(result) 
								if result then
									onPay = false
								end
							end, b2)
						end

						if Index == 3 then
							ESX.TriggerServerCallback("eCoreShops:checkmoney_blackmoney", function(result) 
								if result then
									onPay = false
								end
							end, b2)
						end
					end, 
				})
			end
        end)
        Wait(0)
    end
    end)
    end
end

