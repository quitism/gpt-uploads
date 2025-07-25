--!optimize 2
--!strict

--!native

--[[
	LimitedTable v2.0.0
	https://github.com/arythmitical/LimitedTable
	
	Constructor of Luau tables with size limits.
	
	Copyright (c) 2025 arythmitical

	Permission is hereby granted, free of charge, to any person obtaining a copy of
	this software and associated documentation files (the "Software"), to deal in the
	Software without restriction, including without limitation the rights to use, copy,
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
	and to permit persons to whom the Software is furnished to do so, subject to the
	following conditions:

	The above copyright notice and this permission notice shall be included in all copies
	or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
	PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
	USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local weak = { __mode = "v" }

--[=[
	Table with a total size limit.

	@class LimitedTable
]=]
local LimitedTable = {}
LimitedTable.__index = LimitedTable

--[=[
	@readonly
	@prop contents { [any]: any }
	@within LimitedTable

	Real contents of [LimitedTable](#).
]=]

--[=[
	@prop maximumSize number
	@within LimitedTable

	Determines the maximum allowed size of data inside
	[LimitedTable](#), in bytes.

	:::danger
	Reducing the size of this property is dangerous. Make sure the new
	size is not smaller than [`LimitedTable._currentSize`](#_currentSize).
	:::
]=]

--[=[
	@prop sizeLimitError string | () -> ()
	@within LimitedTable

	Determines the error message that will be raised when the
	maximum size is exceeded. Alternatively, it can be a **function**
	that will be invoked instead of raising an error.

	Default: `maximum size of %s bytes exceeded`
]=]

--[=[
	@private
	@readonly
	@prop _currentSize number
	@within LimitedTable

	Determines the current size of the data inside the [LimitedTable](#).
]=]

--[=[
	@private
	@readonly
	@prop _attached { @metatable { __mode: "v" }, { LimitedTable } }
	@within LimitedTable
	@since 2.0.0

	Weak internal list of all attached [LimitedTable](#)s, including self.
]=]

export type LimitedTable = typeof(setmetatable(
	{} :: {
		contents: { [any]: any },
		maximumSize: number,
		sizeLimitError: string | () -> (),
		_currentSize: number,
		_attached: typeof(setmetatable({} :: { LimitedTable }, weak)),
	},
	LimitedTable
))

--[[
	Tries to update size of LimitedTable
	and LimitedTables attached to it.

	It will fail if the size change will exceed the maximum
	memory size of any of the LimitedTables.
]]
local function tryUpdateSize(self: LimitedTable, delta: number): ()
	local exceeds = false

	if delta > 0 then
		for _, attached: LimitedTable in ipairs(self._attached :: any) do
			if attached._currentSize + delta > attached.maximumSize then
				exceeds = true
				break
			end
		end
	end

	if exceeds then
		if typeof(self.sizeLimitError) == "function" then
			self.sizeLimitError()
		else
			error(string.format(self.sizeLimitError, self.maximumSize), 3)
		end
	else
		for _, attached: LimitedTable in ipairs(self._attached :: any) do
			attached._currentSize += delta
		end
	end
end

--[[
	Returns a deep copy of `target`, with all
	LimitedTables turned into normal tables
	and all found metatables removed.
]]
local function deepCopyTable(target: LimitedTable | { [any]: any }, visited)
	if visited[target] ~= nil then
		return visited[target]
	end

	local clone: typeof(table.clone(target.contents)) = {}
	visited[target] = clone

	for key: any, value: any in
		pairs(if getmetatable(target :: any) == LimitedTable then target.contents else target)
	do
		clone[key] = if typeof(value) == "table" then deepCopyTable(value, visited) else value
	end

	return clone
end

--[=[
	Construct a new [LimitedTable](#).

	Example:
	```lua
	local lt = LimitedTable.new(1024 * 1000)
	```

	@param maximumSize number
	@param attached { LimitedTable }? -- array of attached LimitedTables (default: {})
	@param sizeLimitError (string | () -> ())? -- error message/function (default: "maximum size of %s bytes exceeded")
]=]
function LimitedTable.new(
	maximumSize: number,
	attached: { LimitedTable }?,
	sizeLimitError: (string | () -> ())?
): LimitedTable
	assert(typeof(maximumSize) == "number", "expected argument #1 to be a number")
	assert(attached == nil or typeof(attached) == "table", "expected argument #2 to be a table")
	assert(
		sizeLimitError == nil
			or typeof(sizeLimitError) == "string"
			or typeof(sizeLimitError) == "function",
		"expected argument #3 to be a string or a function"
	)

	local self = {}
	self.contents = {}
	self.maximumSize = maximumSize
	self.sizeLimitError = sizeLimitError or "maximum size of %s bytes exceeded"
	self._currentSize = 0
	self._attached = setmetatable(if attached ~= nil then table.clone(attached) else {}, weak)

	table.insert(self._attached :: any, 1, self)

	setmetatable(self, LimitedTable) -- setting last because of LimitedTable.__newindex

	return self
end

--[=[
	Construct a new [LimitedTable](#) from a
	shallow copy of given `original` table.

	Example:
	```lua
	local lt = LimitedTable.convert({ 1, 2, 3, 4, 5 }, 1024 * 1000)
	print(lt.contents) --> { 1, 2, 3, 4, 5 }
	```

	@since 2.0.0
	@param original { [any]: any } -- the original table to copy
	@param maximumSize number
	@param attached { LimitedTable }? -- array of attached LimitedTables (default: {})
	@param sizeLimitError (string | () -> ())? -- error message/function (default: "maximum size of %s bytes exceeded")
]=]
function LimitedTable.convert(
	original: { [any]: any },
	maximumSize: number,
	attached: { LimitedTable }?,
	sizeLimitError: (string | () -> ())?
): LimitedTable
	assert(typeof(original) == "table", "expected argument #1 to be a table")
	assert(typeof(maximumSize) == "number", "expected argument #2 to be a number")
	assert(attached == nil or typeof(attached) == "table", "expected argument #3 to be a table")
	assert(
		sizeLimitError == nil
			or typeof(sizeLimitError) == "string"
			or typeof(sizeLimitError) == "function",
		"expected argument #4 to be a string or a function"
	)

	local size = 0

	for key, value in pairs(original) do
		size += 16 + LimitedTable.sizeOf(key) + LimitedTable.sizeOf(value)
	end

	local self = {}
	self.contents = table.clone(original)
	self.maximumSize = maximumSize
	self.sizeLimitError = sizeLimitError or "maximum size of %s bytes exceeded"
	self._currentSize = 0
	self._attached = setmetatable(if attached ~= nil then table.clone(attached) else {}, weak)

	table.insert(self._attached :: any, 1, self)

	setmetatable(self, LimitedTable) -- setting last because of LimitedTable.__newindex

	tryUpdateSize(self, size)

	return self
end

--[=[
	Checks if the given `object` is a [LimitedTable](#) created by this libary.
	
	Example:
	```lua
	print(LimitedTable.is(LimitedTable.new(1024 * 1000))) --> true
	print(LimitedTable.is({})) --> false
	```
]=]
function LimitedTable.is(object: any): boolean
	return typeof(object) == "table" and getmetatable(object) == LimitedTable
end

--[=[
	Sets `key` of the [LimitedTable](#) to `value` and returns the previous value.
	
	Example:
	```lua
	local lt = LimitedTable.new(1024 * 1000)

	lt:set("a", "hi")
	lt:set(1, "lol")

	lt:set("myArray", { 1, 2, 3 })
	
	lt:set("myArray", LimitedTable.new(1024 * 1000, nil, { lt }))
	```
]=]
function LimitedTable.set(self: LimitedTable, key: any, value: any): any
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')

	local oldValue: any = self.contents[key]
	local delta: number = LimitedTable.sizeOf(value) - LimitedTable.sizeOf(oldValue)

	if oldValue == nil then
		-- entry did not exist
		delta += LimitedTable.sizeOf(key) + 16 -- 16 bytes overhead for each entry
	end

	if value == nil then
		-- entry is being deleted
		delta -= LimitedTable.sizeOf(key) + 16 -- 16 bytes overhead for each entry
	end

	tryUpdateSize(self, delta)
	self.contents[key] = value

	return oldValue
end

--[=[
	Inserts `value` at `position` of the [LimitedTable](#).

	Example:
	```lua
	local lt = LimitedTable.new(1024 * 1000)

	for i = 1, 10 do
		lt:insert(i)
	end

	print(lt.contents) --> { 1, 2, 3, ..., 10 }
	```

	@param position number? -- (default: end of the array)
]=]
function LimitedTable.insert(self: LimitedTable, value: any, position: number?): ()
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')

	if value ~= nil then -- inserting nil will only update keys, meaning there won't be size change
		tryUpdateSize(self, LimitedTable.sizeOf(value) + 24) -- value size + key meta (16) + key size (8)
	end

	if position == nil then
		table.insert(self.contents, value)
	else
		table.insert(self.contents, position, value)
	end
end

--[=[
	Removes the specified element at given `position` from [LimitedTable](#),
	shifting later elements down to fill in the empty space if possible.
	Returns the removed element.

	Example:
	```lua
	local lt = LimitedTable.new(1024 * 1000)
	lt:set("myArray", {
		"milk",
		"eggs",
		"cheese",
	})

	lt:remove(lt.table.myArray) -- remove last element
	lt:remove(lt.table.myArray, 1)

	print(lt.table.myArray) --> { "eggs" }
	```

	@param position number? -- (default: end of the array)
]=]
function LimitedTable.remove(self: LimitedTable, position: number?): ()
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')

	local contents = self.contents

	local targetValue = contents[position or table.maxn(contents)]
	if targetValue ~= nil then
		local delta = LimitedTable.sizeOf(targetValue) + 24 -- value size + key meta (16) + key size (8)

		-- tryUpdateSize is not used because subtraction will never exceed size limit
		for _, attached: LimitedTable in ipairs(self._attached :: any) do
			attached._currentSize -= delta
		end
	end

	table.remove(contents, position)

	return targetValue
end

--[=[
	Sets all keys in the [LimitedTable](#) to nil.

	Example:
	```lua
	print(lt.contents) --> { 1, 2, 3, 4, 5 }
	lt:clear()
	print(lt.contents) --> {}
	```

	@since 2.0.0
]=]
function LimitedTable.clear(self: LimitedTable): ()
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')

	tryUpdateSize(self, -self._currentSize)
	table.clear(self.contents)
end

--[=[
	Tries to attach the [LimitedTable](#) to another LimitedTable.
	If the LimitedTable is already attached, does nothing.

	:::danger
	Because attaching a LimitedTable increases the size of the
	second LimitedTable, **this function will error if doing so
	will exceed second LimitedTable's limits.**
	:::
	
	:::tip
	**Always** attach an empty LimitedTable or first check the
	[`LimitedTable._currentSize`](#_currentSize) of _both_ LimitedTables.
	:::

	[**Learn more**](../../docs/What_Is_Attaching)

	Example:
	```lua
	local parent = LimitedTable.new(1024 * 1000)
	local child = LimitedTable.new(1024 * 1000)
	
	child:attachTo(parent)
	parent:insert(child)
	```

	@since 2.0.0
	@param attachTo LimitedTable -- the LimitedTable to attach to
]=]
function LimitedTable.attachTo(self: LimitedTable, attachTo: LimitedTable): ()
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')
	assert(LimitedTable.is(attachTo), "expected argument #2 to be LimitedTable")

	if table.find(self._attached :: any, attachTo) == nil then
		tryUpdateSize(attachTo, self._currentSize)
		table.insert(self._attached :: any, attachTo)
	end
end

--[=[
	Detaches the [LimitedTable](#) from another LimitedTable.
	If the LimitedTable is not attached, does nothing.

	:::note
	Detaching from a LimitedTable reduces its size.
	:::

	[**Learn more**](../../docs/What_Is_Attaching)

	Example:
	```lua
	parent:remove(1) -- removes child
	child:detachFrom(parent)
	```

	@since 2.0.0
	@param detachFrom LimitedTable -- the LimitedTable to detach from
]=]
function LimitedTable.detachFrom(self: LimitedTable, detachFrom: LimitedTable): ()
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')
	assert(LimitedTable.is(detachFrom), "expected argument #2 to be LimitedTable")
	assert(self ~= detachFrom, "argument #2 must not equal to self")

	local pos = table.find(self._attached :: any, detachFrom)

	if pos ~= nil then
		table.remove(self._attached :: any, pos)
		detachFrom._currentSize -= self._currentSize
	end
end

--[=[
	Detaches the [LimitedTable](#) from all attached LimitedTables.

	:::note
	Detaching from a LimitedTable reduces its size.
	:::

	[**Learn more**](../../docs/What_Is_Attaching)

	Example:
	```lua
	child:detachFromAll()
	```

	@since 2.0.0
]=]
function LimitedTable.detachFromAll(self: LimitedTable): ()
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')

	local size = self._currentSize
	local attached = self._attached

	while true do
		local pos, detachFrom = next(attached, 1)

		if pos == nil then
			break
		end

		detachFrom._currentSize -= size
		attached[pos] = nil
	end
end

--[=[
	Returns a __deep__ copy of [LimitedTable](#),
	with all LimitedTables turned into normal tables
	and all found metatables removed.
	
	:::tip
	If you need a shallow copy, use
	[`table.clone(lt.contents)`](https://create.roblox.com/docs/reference/engine/libraries/table#clone).
	:::
	
	Example:
	```lua
	local lt = LimitedTable.new(1024 * 1000)
	lt:insert(1)
	lt:insert(2)
	lt:insert(3)

	local raw = lt:deepCopy()
	print(raw) --> { 1, 2, 3 }
	print(raw == lt.contents) --> false
	```
]=]
function LimitedTable.deepCopy(self: LimitedTable): { [any]: any }
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')

	return deepCopyTable(self, {})
end

--[=[
	Fully [detaches](#detachFromAll) & renders the [LimitedTable](#) unusable.
	
	:::warning
	Make sure to delete _all_ references to LimitedTable,
	otherwise it will stay in the memory forever!
	:::

	Example:
	```lua
	local lt = LimitedTable.new(1024 * 1000)

	local references = setmetatable(
		{ lt, lt.contents },
		{ __mode = "v" }
	)
	
	lt:destroy()
	lt = nil
	
	task.wait(8)
	print(`deleted: {#references == 0}!`) --> true
	```
]=]
function LimitedTable.destroy(self: LimitedTable): ()
	assert(LimitedTable.is(self), 'must be called via ":" not ".", or provide LimitedTable')

	self:detachFromAll()
	table.clear(self.contents)

	table.clear(self :: any)
	setmetatable(self :: any, nil)
end

--[=[
	Calculates the size of `data`. For objects,
	returns their reference size.
	
	This is how [LimitedTable](#) calculates sizes.
	It may not be 100% accurate to the actual memory
	size but i tried my best.

	Example:
	```lua
	print(LimitedTable.sizeOf("hi!")) --> 3
	print(LimitedTable.sizeOf({})) --> 40
	print(LimitedTable.sizeOf({ 1, 2, 3 })) --> 40
	```
]=]
function LimitedTable.sizeOf(data: any): number
	local type = type(data)

	if type == "nil" then
		return 0 -- does not exist
	elseif type == "string" then
		return string.len(data)
	elseif type == "number" then
		return 8 -- 64-bit double-precision floating-point number
	elseif type == "boolean" then
		return 1 -- true/false
	elseif type == "table" then
		return 40 -- reference size + headers
	elseif type == "function" then
		return 8 -- memory address
	elseif type == "userdata" then
		return 16 -- engine reference size, nothing else can be measured
	elseif type == "vector" then
		return 24 -- 3 numbers
	elseif type == "buffer" then
		return buffer.len(data)
	else
		warn(type .. " is not yet supported") -- should not occur unless a new built-in type was added
		return 0
	end
end

--[[
	Protection against creating unknown properties
	in LimitedTable class (not LimitedTable.contents).
]]
function LimitedTable.__newindex(_, key: string): ()
	error(
		'attempt to set unknown key "'
			.. key
			.. '" of LimitedTable. perhaps, you meant to use LimitedTable:set()',
		2
	)
end

return table.freeze(LimitedTable)
