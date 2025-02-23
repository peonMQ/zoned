local mq = require("mq")
local logger = require("knightlinc/Write")
local map = require("map")

logger.prefix = string.format("\at%s\ax", "[Zoned]")
logger.postfix = function () return string.format(" %s", os.date("%X")) end

map.AutoMapHeightFilter()

mq.cmd("/easyfind reload")