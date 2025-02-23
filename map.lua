local mq = require("mq")
local logger = require("knightlinc/Write")

logger.prefix = string.format("\at%s\ax", "[ZONED]")
logger.postfix = function () return string.format(" %s", os.date("%X")) end

-- auto adjusts map height filter in some zones
local function autoMapHeightFilter()
    local heights = {
        -- original
        blackburrow = { min = 10, max = 10},
        felwithea = { min = 9, max = 9},
        freporte = { min = 30, max = 30},
        gukbottom = {min = 40, max = 40},
        guktop = {min = 40, max = 40},
        highpasshold = { min = 25, max = 25},
        highkeep = { min = 10, max = 10},
        lavastorm = { min = 100, max = 100},
        permafrost = { min = 20, max = 20},
        qeynos2 = { min = 20, max = 20},
        soltemple = {min = 10, max = 10},
        soldunga = { min = 15, max = 15},
        unrest = { min = 8, max = 8},

        --planes
        hateplane = {min = 20, max = 20},
        airplane = {min = 40, max = 40},

        -- kunark
        chardok = {min = 60, max = 60},
        kaesora = {min = 20, max = 20},
        karnor = {min = 20, max = 20},
        sebilis = {min = 30, max = 30},

        -- velious
        sirens = {min = 50, max = 50},
        necropolis = {min = 80, max = 80},

        -- luclin
        fungusgrove = {min = 80, max = 80},

        -- pop
        codecay = {min = 30, max = 30},
        poair = {min = 160, max = 160},

        -- omens
        riftseekers = {min = 120, max = 120},

        -- DoN
        stillmoona = {min = 50, max = 50},
        thundercrest = {min = 70, max = 70},
        broodlands = {min = 140, max = 140},
    }

    local zone_shortname = mq.TLO.Zone.ShortName()
    local data = heights[zone_shortname]
    local unknown = false
    if data == nil then
        data = {min = 20, max = 20}
        unknown = true
    end

    -- NOTE: this need recent macroquest, past july 25 2023 for the SetText
    mq.TLO.Window("MVW_MapToolBar/MVW_MinZEditBox").SetText(string.format("%d", data.min))
    mq.TLO.Window("MVW_MapToolBar/MVW_MaxZEditBox").SetText(string.format("%d", data.max))

    if not unknown then
        if not mq.TLO.Window("MVW_MapToolBar/MVW_ZFilterButton").Checked() then
            logger.Info("auto-map-height: enabled min %d, max %d for %s", data.min, data.max, zone_shortname)
            mq.cmd("/notify MVW_MapToolBar MVW_ZFilterButton leftmouseup")
        end
    else
        if mq.TLO.Window("MVW_MapToolBar/MVW_ZFilterButton").Checked() then
            logger.Info("auto-map-height: height filter was on, disabling for unknown zone!")
            mq.cmd("/notify MVW_MapToolBar MVW_ZFilterButton leftmouseup")
        end
    end

    return true
end

return {
    AutoMapHeightFilter = autoMapHeightFilter
}
