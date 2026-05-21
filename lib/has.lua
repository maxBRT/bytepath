--- Expects a single table where the first element is the target instance,
--- followed by any number of traits to compose into it.
local function has(args)
	local target = args[1]

	for i = 2, #args do
		local trait = args[i]

		for key, value in pairs(trait) do
			target[key] = value
		end
	end
end

return has
