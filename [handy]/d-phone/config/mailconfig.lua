Mailconfig = {}

Mailconfig.enabled = true
Mailconfig.debug = false


Mailconfig.domain = "@hopelife.com"


Mailconfig.jobs = {
    -- ["police"] = {
    --     name = "police",
    --     label = "LSPD",
    --     domain = "@lspd",
    --     -- every rank which is in the list has an addressbook where they can see the mail from every user
    --     hasmaillist = {
    --         "boss",
    --     },
    -- },
    -- ["ambulance"] = {
    --     name = "ambulance",
    --     label = "Ambulance",
    --     domain = "@ambulance",
    --     hasmaillist = {
    --         "boss",
    --     },
    -- },
    -- ["mechanic"] = {
    --     name = "mechanic",
    --     label = "Mechanic",
    --     domain = "@mechanic",
    --     hasmaillist = {
    --         "boss",
    --     },
    -- },
}

-- Create mai
Mailconfig.createmail = function (source)
    local Data = UserData[source]

    local f = string.lower(string.sub(Data.firstname, 1, 1))
    local l = string.lower(string.sub(Data.lastname, 1, 1))
    --Mail.print("Create Mail", "f " .. f)
    local prefix = string.format("%s%s%s", f, l, math.random(1, 300))
    --Mail.print("Create Mail", "prefix " .. prefix)

    local mail = string.format("%s%s", prefix, Mailconfig.domain)

    return mail
end

