--[[
  Lua Utilities for Table and String Manipulation
  TODO: Add more metatable examples
]]--

-- Version information
local VERSION = "1.5.2"

-- FIXME: This function doesn't handle nested tables properly
local function table_size(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

-- Merge two tables together
-- NOTE: Second table values override first table
local function merge_tables(t1, t2)
  local result = {}
  for k, v in pairs(t1) do
    result[k] = v
  end
  for k, v in pairs(t2) do
    result[k] = v
  end
  return result
end

-- Deep copy a table
-- TODO: Handle circular references
local function deep_copy(t)
  if type(t) ~= "table" then
    return t
  end
  
  local copy = {}
  for k, v in pairs(t) do
    copy[k] = deep_copy(v)
  end
  
  return setmetatable(copy, getmetatable(t))
end

-- FIXME: This doesn't handle empty tables gracefully
local function find_max(t)
  local max_val = t[1]
  for i = 2, #t do
    if t[i] > max_val then
      max_val = t[i]
    end
  end
  return max_val
end

local function find_min(t)
  local min_val = t[1]
  for i = 2, #t do
    if t[i] < min_val then
      min_val = t[i]
    end
  end
  return min_val
end

-- Filter table elements based on predicate
-- NOTE: Returns new table, doesn't modify original
local function filter(t, predicate)
  local result = {}
  for k, v in pairs(t) do
    if predicate(v) then
      table.insert(result, v)
    end
  end
  return result
end

-- Map function over table elements
local function map(t, fn)
  local result = {}
  for k, v in pairs(t) do
    result[k] = fn(v)
  end
  return result
end

-- Reduce/fold operation
-- TODO: Add initial value support
local function reduce(t, fn)
  local acc = t[1]
  for i = 2, #t do
    acc = fn(acc, t[i])
  end
  return acc
end

-- String utilities
-- FIXME: Unicode handling is not correct
local function split_string(str, delimiter)
  local result = {}
  local pattern = "([^" .. delimiter .. "]+)"
  
  for match in str:gmatch(pattern) do
    table.insert(result, match)
  end
  
  return result
end

-- Join table of strings with delimiter
local function join_strings(t, delimiter)
  return table.concat(t, delimiter)
end

-- Capitalize first letter of string
local function capitalize(str)
  return str:gsub("^%l", string.upper)
end

-- TODO: Add case-insensitive matching
local function starts_with(str, prefix)
  return str:sub(1, #prefix) == prefix
end

local function ends_with(str, suffix)
  return str:sub(-#suffix) == suffix
end

-- NOTE: Simple regex-like pattern matching
local function contains(str, pattern)
  return string.find(str, pattern) ~= nil
end

-- Class/Object-oriented Lua
-- FIXME: Doesn't support inheritance properly
local Object = {}
Object.__index = Object

function Object:new()
  local obj = {}
  setmetatable(obj, self)
  return obj
end

function Object:initialize()
  -- Override in subclasses
end

-- Example class
local Counter = Object:new()
Counter.count = 0

function Counter:increment()
  self.count = self.count + 1
end

function Counter:decrement()
  self.count = self.count - 1
end

function Counter:reset()
  self.count = 0
end

function Counter:get_value()
  return self.count
end

-- Stack implementation
-- TODO: Add bounds checking
local Stack = {}

function Stack:new()
  return {items = {}, size = 0}
end

function Stack:push(value)
  table.insert(self.items, value)
  self.size = self.size + 1
end

function Stack:pop()
  if self.size == 0 then
    return nil
  end
  self.size = self.size - 1
  return table.remove(self.items)
end

function Stack:peek()
  if self.size == 0 then
    return nil
  end
  return self.items[self.size]
end

function Stack:is_empty()
  return self.size == 0
end

-- Queue implementation
-- FIXME: Not optimized for large queues
local Queue = {}

function Queue:new()
  return {items = {}, front = 1, rear = 0}
end

function Queue:enqueue(value)
  self.rear = self.rear + 1
  self.items[self.rear] = value
end

function Queue:dequeue()
  if self.front > self.rear then
    return nil
  end
  
  local value = self.items[self.front]
  self.items[self.front] = nil
  self.front = self.front + 1
  
  return value
end

function Queue:is_empty()
  return self.front > self.rear
end

-- Configuration module
-- NOTE: Loads key-value pairs
local Config = {}

function Config:load_file(filename)
  local config = {}
  
  local file = io.open(filename, "r")
  if not file then
    return nil
  end
  
  -- TODO: Add error handling for malformed lines
  for line in file:lines() do
    if line ~= "" and not line:match("^%s*#") then
      local key, value = line:match("([%w_]+)%s*=%s*(.*)")
      if key then
        config[key] = value
      end
    end
  end
  
  file:close()
  return config
end

function Config:get(key, default)
  return self[key] or default
end

-- FIXME: Doesn't validate values before saving
function Config:save_file(filename)
  local file = io.open(filename, "w")
  
  for key, value in pairs(self) do
    file:write(string.format("%s=%s\n", key, value))
  end
  
  file:close()
end

-- Main execution
print("Lua Utilities v" .. VERSION)

-- Test examples
local numbers = {3, 1, 4, 1, 5, 9, 2, 6}
print("Max: " .. find_max(numbers))
print("Min: " .. find_min(numbers))

local doubled = map(numbers, function(x) return x * 2 end)
print("Doubled: " .. table.concat(doubled, ", "))

local evens = filter(numbers, function(x) return x % 2 == 0 end)
print("Evens: " .. table.concat(evens, ", "))

-- Test counter
local counter = Counter:new()
counter:increment()
counter:increment()
print("Counter: " .. counter:get_value())

-- Test stack
local stack = Stack:new()
stack:push(1)
stack:push(2)
stack:push(3)
print("Stack peek: " .. stack:peek())