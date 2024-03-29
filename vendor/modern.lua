----------------------
--------------------
-- Modern --------
----------------
--------------
------------
----------
--------
------
----
--


------------------
-- Private Functions
--------
------
----
--


--[[
    Load mixin into a Module.
    Mixin will also have a link back to this Module.

    @internal
    @param   Module(obj)  - current Module
    @param   Module(key)  - mixin to add
    @return  void
]]--
local __addMixin = function(obj, mixin)
    assert(mixin.__name ~= nil, "Please make sure your table has a `__name` property (e.g. `{ __name = 'Example' }`)")

    -- link Modules..
    obj.__mixins[mixin.__name] = mixin
    mixin.__module = obj
end

--[[
    Get mixin by name, included in this Module.
    If not found, will error out.

    @internal
    @param   Module(obj)  - current Module
    @param   Module(key)  - mixin to add
    @return  void
]]--
local __getMixin = function(obj, mixinName)
    return obj.__mixins[mixinName] or
           error('Mixin with name `' .. mixinName .. '` does not exist.')
end

--[[
    Returns resolved names of code in line
        calling originating function.

    @internal
    @return string(name, caller, func)
]]--
local __resolveName = function()
    local info   = debug.getinfo(3, "Sl")
    local source = string.gsub(info.source, "@", "")
    
    return source:match("^.*/(.*).lua")
end

--[[
    Intercept function index requests.
    Create compound function if necessary
      otherwise return nil and fallback..

    @internal
    @param  Module(obj)
    @param  string(key)
    @return void
]]--
local __getIndex = function(obj, key)
    local value = rawget(obj, key)

    if value == nil or type(value) == 'function' then
        local funcs  = {}
        local values = {}
        --
        if type(value) == 'function' then
            table.insert(funcs, value)
        end
        for _, mixin in pairs(obj.__mixins) do
            if type(mixin[key]) == 'function' then
                table.insert(funcs, mixin[key])
            end
        end
        --
        if #funcs > 0 then
            return function(...)
                local output = {}
                for _, func in ipairs(funcs) do
                    for __, out in pairs({ func(...) }) do
                        table.insert(output, out)
                    end
                end
                return unpack(output)
            end
        else
            -- check mixins for key..
            for _, mixin in pairs(obj.__mixins) do
                if mixin[key] and type(mixin[key]) ~= 'function' then
                    return mixin[key]
                end
            end
        end
    end

    return value
end


------------------
-- Setup
--------
------
----
--


local Modern = {}

Modern.__name      = "Modern"
Modern.__namespace = "Modern"
Modern.__module    = false
Modern.__mixins    = {}
Modern.__index     = Modern

setmetatable(Modern, {
    __call = function(self)
        print("Error: cannot call `Modern()` directly.")
        print("------------")
        print("Hello! I am an abstract class, and therefore cannot be called.")
        print("The proper way to use me is the following:")
        print("\t1) Create a submodule of `Modern`: `local A = Modern:extend()`")
        print("\t2) Now call your new submodule: `local a = A()`")
        print("\t3) Use your submodule's instance `a` to do your bidding: a:foo('bar')")
        print("------------")
    end
})


------------------
-- Public Functions
--------
------
----
--


--[[
    Checks if `Module` is a (or inherits from)...

    @return boolean
]]--
function Modern:is(obj)
    local mt = getmetatable(self)

    while mt do
        if mt == obj then
            return true
        end

        mt = getmetatable(mt)
    end

    return false
end

--[[
    Checks `Module` for inclusion of a `Mixin`.

    @return boolean
]]--
function Modern:has(mixin)
    assert(mixin.__module ~= false, "Module you are comparing is not a Mixin.")

    return self == mixin.__module
end

--[[
    Return parent module.

    @return Module|table
]]--
function Modern:super(func, ...)
    local mt = getmetatable(self)

    if mt[func] then
        return mt[func](mt, ...)
    end

    return mt
end

--[[
    Make deep copy of `Module`.

    @return new `Module`
]]--
function Modern:copy()
    -- ref: https://gist.github.com/tylerneylon/81333721109155b2d244
    local function deepcopy(obj, seen)
      -- Handle non-tables and previously-seen tables.
      if type(obj) ~= 'table' then return obj end
      if seen and seen[obj] then return seen[obj] end

      -- New table; mark it as seen an copy recursively.
      local s = seen or {}
      local res = setmetatable({}, getmetatable(obj))
      s[obj] = res
      for k, v in pairs(obj) do res[deepcopy(k, s)] = deepcopy(v, s) end
      return res
    end

    return deepcopy(self)
end

--[[
    Make clone of `Module`.

    @return new `Module`
]]--
function Modern:clone()
    return setmetatable(self, getmetatable(self))
end

--[[
    Extend `Module`.

    @param  table(...) - `Mixins`
    @return new `Module`
]]--
function Modern:extend(...)
    local obj  = {}
    local name = __resolveName()

    -- copy metamethods..
    table.foreach(self, function(key, value)
        if string.sub(key, 0, 2) == "__" then
            rawset(obj, key, value)
        end
    end)

    -- overrides!
    obj.__name      = name
    obj.__super     = self
    obj.__namespace = self.__namespace .. "\\" .. name
    obj.__module    = false
    obj.__mixins    = {}
    obj.__index     = function(self, key)
        -- print('__getIndex', name, key, rawget(obj, key))
        -- check for special cases
        --   or fallback..
        return __getIndex(obj, key) or obj[key]
    end

    -- include mixins..
    table.foreach({...}, function(_, mixin)
        __addMixin(obj, mixin)
    end)

    return setmetatable(obj, self)
end

--[[
    Return new instance of Object called.

    Arguments passed in will be redirected
     to `new` function of returning instance.

    @param  ... - arguments
    @return new `Module` instance
]]--
function Modern:__call(...)
    local inst = setmetatable({}, self)
    inst.__module = false

    if inst['new'] then
        if rawget(self, 'new') then
            self['new'](inst, ...)
        end

        -- Invoke mixin `new`
        for _, mixin in pairs(inst.__mixins) do
            if mixin['__new'] then
                mixin.__module = inst
                mixin['__new'](mixin, ...)
            end
        end
    end

    return inst
end


--[[
    Return string representation of Object.
    TODO: this is a gnarly function

    @return string
]]--
function Modern:__tostring()
    local tableData = {{ '[ ]', 'Module', 'Namespace', 'DataType', 'Key', 'Value' }}
    local tableWidth = 0
    local colData = {}
    local overrides = {}
    local padding = 2
    local max = math.max
    local buildTableData
    local rowWidth = function(row)
        local width = #tableData[1] * 2 + 2
        table.foreach(row, function(_, value)
            width = width + value
        end)
        tableWidth = max(tableWidth, width)
    end
    local colWidths = function(row)
        table.foreach(row, function(idx, value)
            colData[idx] = max(colData[idx] or 0, #value + padding)
        end)
        rowWidth(colData)
    end
    local resolveSymbol = function(key)
        if not overrides[key] then
            overrides[key] = true
            return '-'
        end
        return '^'
    end
    local resolveValue = function(dataType, value)
        if     dataType == 'string'  then return '"' .. value .. '"'
        elseif dataType == 'number'  then return '' .. value
        elseif dataType == 'boolean' then return value and 'true' or 'false'
        else                              return '<' .. dataType .. '>'
        end
    end
    local addRowToTableData = function(mt, key, value)
        if string.sub(key, 0, 2) ~= '__' then
            local dataType = type(value)
            local symbol = mt.__module ~= false and '+' or resolveSymbol(key)
            local value = resolveValue(dataType, value)
            local row = {
                '[' .. symbol .. ']', mt.__name, mt.__namespace, dataType, key, value
            }
            colWidths(row)
            table.insert(tableData, row)
        end
    end
    buildTableData = function(mt)
        if mt == nil then return end
        table.foreach(mt, function(key, value)
            addRowToTableData(mt, key, value)
        end)
        return buildTableData(getmetatable(mt))
    end
    local buildMixinData = function(mt)
        table.foreach(mt.__mixins, function(_k, mixin)
            table.foreach(mixin, function(key, value)
                addRowToTableData(mixin, key, value)
            end)
        end)
    end
    local display = function()
        local out = string.rep('-', tableWidth) .. '\n'
        table.foreach(tableData, function(idx, row)
            table.foreach(row, function(key, value)
                out = out .. '| ' .. value .. string.rep(' ', colData[key] - #value)
            end)
            out = out .. ' |\n'
            if idx == 1 then
                out = out .. string.rep('-', tableWidth) .. '\n'
            end
        end)
        return out .. string.rep('-', tableWidth)
    end

    buildTableData(self)
    buildMixinData(self)

    return display()
end

--[[
    Equality check.

    @param  mixed(other)
    @return boolean
]]--
function Modern:__eq(other)
    return self.__namespace == other.__namespace
end

return Modern