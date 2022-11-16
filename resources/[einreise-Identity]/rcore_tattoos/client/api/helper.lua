function isPlayerJobMatching(tattooJobs, playerJob)
    if not playerJob or not playerJob.name then
        dbg.info('isPlayerJobMatching: playerJob not passed!')
        return false
    end

    for _, tattooJob in pairs(tattooJobs) do
        if not tattooJob.name then
            dbg.error('isPlayerJobMatching: Missing job name in tattoo permissions config!')
            break
        end

        if tattooJob.name == playerJob.name then
            if playerJob.grade == nil and tattooJob.grade == nil then
                return true
            end
            
            if tattooJob.grade == nil then
                return true
            end

            if playerJob.grade ~= nil and playerJob.grade >= tattooJob.grade then
                return true
            end
        end
    end
end
