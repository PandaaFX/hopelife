--[[
	Custom license

	Copyright (c) 2021-2022 Philipp Decker

    timerTasks.lua by Discord user Kiminaze#9097

    You are free to use this file for any of your projects. This whole comment needs to be included 
	when doing so.

    The AddTask[...] functions can be used to add a timed task on server side.

	AddTask(task, hours, minutes)
		Takes a time of day and a function that should be run at that time.

	AddTaskForEveryHour(task)
		Takes a function that should be run once every single hour.

	AddTaskForEveryMinute(task)
		Takes a function that should be run once every single minute.
--]]

local function GetTimeFormatted()
	local dateTime = os.time()

	return {
		hours	= tonumber(os.date("%H", dateTime)),
		minutes	= tonumber(os.date("%M", dateTime))
	}
end

local lastTime = GetTimeFormatted()

local dayTasks		= {}
local hourTasks		= {}
local minuteTasks	= {}

local function OnTimeChanged(time)
	for i, taskData in ipairs(dayTasks) do
		if (taskData.hours == time.hours and taskData.minutes == time.minutes) then
			taskData.task()
		end
	end
end
local function OnHourChanged()
	for i, taskData in ipairs(hourTasks) do
		taskData.task()
	end
end
local function OnMinuteChanged()
	for i, taskData in ipairs(minuteTasks) do
		taskData.task()
	end
end

Citizen.CreateThread(function()
	local currentTime = nil

	while (true) do
		Citizen.Wait(500)

		currentTime = GetTimeFormatted()

		if (currentTime.minutes ~= lastTime.minutes) then
			OnTimeChanged(currentTime)

			if (currentTime.hours ~= lastTime.hours) then
				OnHourChanged()
			end

			if (currentTime.minutes ~= lastTime.minutes) then
				OnMinuteChanged()
			end

			lastTime = currentTime
		end
	end
end)



function AddTask(task, h, m, s)
	assert(task ~= nil and type(task) == "function", "Parameter \"task\" must be a function!")

	table.insert(dayTasks, {
		hours	= math.floor(h and h or 0),
		minutes	= math.floor(m and m or 0),
		seconds	= math.floor(s and s or 0),
		task	= task
	})
end

function AddTaskForEveryHour(task)
	assert(task ~= nil and type(task) == "function", "Parameter \"task\" must be a function!")

	table.insert(hourTasks, {
		task = task
	})
end

function AddTaskForEveryMinute(task)
	assert(task ~= nil and type(task) == "function", "Parameter \"task\" must be a function!")

	table.insert(minuteTasks, {
		task = task
	})
end

exports("AddTask", AddTask)
exports("AddTaskForEveryHour", AddTaskForEveryHour)
exports("AddTaskForEveryMinute", AddTaskForEveryMinute)
