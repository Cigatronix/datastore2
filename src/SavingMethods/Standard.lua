-- Standard saving of data stores
-- The key you provide to DataStore2 is the name of the store with GetDataStore
-- GetAsync/UpdateAsync are then called based on the user ID
	local DataStoreService = game:GetService("DataStoreService")
	local Promise = require(script.Parent.Parent.Promise)
	
	local Standard = {}
	Standard.__index = Standard
	
	function Standard:Get()
		print('Getting for ' .. self.userId)
		return Promise.async(function(resolve)
			resolve(self.dataStore:GetAsync(self.userId))
		end)
	end
	
	function Standard:Set(value)
		print('Setting for ' .. self.userId)
		return Promise.async(function(resolve)
			self.dataStore:UpdateAsync(self.userId, function()
				return value
			end)
	
			resolve()
		end)
	end
	
	function Standard.new(dataStore2)
		return setmetatable({
			dataStore = DataStoreService:GetDataStore(dataStore2.Name),
			userId = dataStore2.UserId,
		}, Standard)
	end
	
	return Standard
	