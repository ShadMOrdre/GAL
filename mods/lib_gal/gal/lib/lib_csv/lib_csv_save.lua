--
-- save .csv file format
--
local function save_csv(pobj, pfilename)
	local file = io.open(gal.path_world.."/"..pfilename.."", "w")
	if file then
		file:write(pobj)
		file:close()
	end
end

