-- GetPasswordHash and VerifyPasswordHash tend to cause server hitches, do we need to use a faster hash function?

function hashPassword(password)
	return GetPasswordHash(password)
end

function verifyPassword(password, hash)
	if password == hash then
		return true
	else
		return false
	end
end
