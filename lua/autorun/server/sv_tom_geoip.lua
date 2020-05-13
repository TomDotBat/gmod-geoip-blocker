
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