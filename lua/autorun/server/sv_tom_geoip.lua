
--[[-------------------------------------------------------------------------
Tom's GeoIP Blocker - A simple script to block certain countries from joining your Garry's Mod server.
Created by Tom.bat (STEAM_0:0:127595314)
Website: https://tomdotbat.dev
Email: tom@tomdotbat.dev
Discord: Tom.bat#0001
---------------------------------------------------------------------------]]

local config = {}

--Configuration Start--

config.punishByBan = false --Should we ban the user or just kick them?

config.isWhitelist = false --Should the country code list be a whitelist or blacklist?

config.countryList = { --Which countries should we white/blacklist? List of country codes, use: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements
    ["GB"] = true
}

config.bypassIDs = { --Who can bypass the GeoIP checks? List of SteamID64s.
    ["13234324"] = true
}

--Configuration End--


hook.Add("CheckPassword", "TomGeoIP.CheckPassword", function(steamid, ip, svpass, clpass, name)
    if config.bypassIDs[steamid] then return end
    if #config.countryList == 0 then return end

    ip = string.Split(ip, ":")[1]

    http.Fetch("http://ip-api.com/json/" .. ip,
        function(body, len, headers, status)
            local response = util.JSONToTable(body)
            if !response or !response.countryCode or !response.query then
                print("[TOM-GEOIP ERROR]: Given an invalid response when looking up " .. name .. ", please investigate.")
                return
            end

            if status != 200 then
                print("[TOM-GEOIP ERROR]: Given a non 200 status code when looking up " .. name .. ", please investigate.")
                return
            end

            if response.query != ip then
                print("[TOM-GEOIP ERROR]: API returned data for wrong IP  " .. name .. ", please investigate.")
                return
            end

        end,
        function(error)
            print("[TOM-GEOIP ERROR]: Failed to get GeoIP information about " .. name .. ", please investigate.")
        end
    )
end)