ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("eCoreShops:checkinv", function(source, cb, b)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end

    if xPlayer.getInventoryItem(b.name).count + b.ListIndex - 1 >= b.qtmax then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu ne peut pas en prendre plus sur toi.')
        cb(false)
    else
        cb(true)
    end
end)

ESX.RegisterServerCallback("eCoreShops:checkmoney_cash", function(source, cb, b)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end

    if xPlayer.getMoney() >= b.price * b.ListIndex then
        xPlayer.removeMoney(b.price * b.ListIndex)
        xPlayer.addInventoryItem(b.name, b.ListIndex)
        cb(true)
    else
        cb(false)
        TriggerClientEvent('esx:showNotification', source, '~r~Tu n\'a pas asser d\'argent.')
    end
end)

ESX.RegisterServerCallback("eCoreShops:checkmoney_bank", function(source, cb, b)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end

    if xPlayer.getAccount("bank").money >= b.price * b.ListIndex then
        xPlayer.removeAccountMoney("bank", b.price * b.ListIndex)
        xPlayer.addInventoryItem(b.name, b.ListIndex)
        cb(true)
    else
        cb(false)
        TriggerClientEvent('esx:showNotification', source, '~r~Tu n\'a pas asser d\'argent.')
    end
end)

ESX.RegisterServerCallback("eCoreShops:checkmoney_blackmoney", function(source, cb, b)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return end

    if xPlayer.getAccount("black_money").money >= b.price * b.ListIndex then
        xPlayer.removeAccountMoney("black_money", b.price * b.ListIndex)
        xPlayer.addInventoryItem(b.name, b.ListIndex)
        cb(true)
    else
        cb(false)
        TriggerClientEvent('esx:showNotification', source, '~r~Tu n\'a pas asser d\'argent.')
    end
end)