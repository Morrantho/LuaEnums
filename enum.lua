local enum = {}
local mt   = {}
local mt2  = {}

function mt.__call(...)
    -- args[1] = newly created __index table
    -- args[2] = enum table
    -- args[3] = tab passed to __index table.
    local args = {...}
    local nm = args[1][1]

    _G[nm] = {}
    setmetatable(_G[nm],mt2)

    for k,v in pairs(args[3]) do
        if type(k) == "number" then -- Map values as keys and keys as values.
            _G[nm][v] = k
        else                        -- Support keys too.
            _G[nm][k] = v
        end
    end

    args[2][nm] = nil
end

function mt.__index(t,k,v)
    t[k] = {k}
    setmetatable(t[k],mt)
    return t[k]
end
setmetatable(enum,mt)

function mt2.__call(t,k,v)
    if t[k] then
        return t[k]
    else
        return nil
    end
end

enum: Suit {
    "Diamonds",
    "Hearts",
    "Spades",
    "Clubs"
}

enum: Face {
    King  = 10,
    Queen = 10,
    Jack  = 10,
    "Ace"
}

local s = Suit("Diamonds")
local f = Face("King")

for a,b in pairs(Face) do print(a,b) end
