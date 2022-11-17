local loadedObject = false
OnObjectLoadedVariable = {}

function OnObjectLoaded(cb)
    if loadedObject then
        cb()
    end
    table.insert(OnObjectLoadedVariable, cb)
end

function GetCoreObject(framework, resourceName, callBack)
    -- Your custom
    if framework == 0 then
        callBack()
        loadedObject = true
        for _, fun in pairs(OnObjectLoadedVariable) do
            fun()
        end
    end

    -- ES_EXTENDED
    if framework == 1 then
        xpcall(function()
            callBack(exports[resourceName or 'es_extended']['getSharedObject']())
            loadedObject = true
            for _, fun in pairs(OnObjectLoadedVariable) do
                fun()
            end
        end, function(error)
            if not IsDuplicityVersion() then
                CreateThread(function()
                    local tries = 10
                    local ESX
                    while not ESX do
                        Wait(100)
                        TriggerEvent(Framework.ESX_SHARED_OBJECT, function(obj)
                            ESX = obj
                        end)
                        tries = tries - 1
                        if tries == 0 then
                            print("You forgot to change ESX shared object in config, please do it now or the script wont work properly.")
                            return
                        end
                    end
                    callBack(ESX)
                    loadedObject = true
                    for _, fun in pairs(OnObjectLoadedVariable) do
                        fun()
                    end
                end)
            else
                TriggerEvent(Framework.ESX_SHARED_OBJECT, function(obj)
                    callBack(obj)
                    loadedObject = true
                    for _, fun in pairs(OnObjectLoadedVariable) do
                        fun()
                    end
                end)
            end
        end)
    end

    -- QBCORE
    if framework == 2 then
        xpcall(function()
            callBack(exports[resourceName or 'qb-core']['GetCoreObject']())
            loadedObject = true
            for _, fun in pairs(OnObjectLoadedVariable) do
                fun()
            end
        end, function(error)
            xpcall(function()
                callBack(exports[resourceName or 'qb-core']['GetSharedObject']())
                loadedObject = true
                for _, fun in pairs(OnObjectLoadedVariable) do
                    fun()
                end
            end, function(error)

                if not IsDuplicityVersion() then
                    CreateThread(function()
                        local tries = 10
                        local QBC
                        while not QBC do
                            Wait(100)
                            TriggerEvent(Framework.QBCORE_SHARED_OBJECT, function(obj)
                                QBC = obj
                            end)
                            tries = tries - 1
                            if tries == 0 then
                                print("You forgot to change QBC shared object in config, please do it now or the script wont work properly.")
                                return
                            end
                        end
                        callBack(QBC)
                        loadedObject = true
                        for _, fun in pairs(OnObjectLoadedVariable) do
                            fun()
                        end
                    end)
                else
                    TriggerEvent(Framework.QBCORE_SHARED_OBJECT, function(obj)
                        callBack(obj)
                        loadedObject = true
                        for _, fun in pairs(OnObjectLoadedVariable) do
                            fun()
                        end
                    end)
                end
            end)
        end)
    end

    -- Your custom
    if framework == 3 then

    end
end