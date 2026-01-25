-- function to get paths of selected elements or the hovered element
local get_paths = ya.sync(function()
    local paths = {}
    -- get selected files
    for _, u in pairs(cx.active.selected) do
        paths[#paths + 1] = tostring(u)
    end
    -- if no files are selected, get hovered file
    if #paths == 0 then
        if cx.active.current.hovered then
            paths[1] = tostring(cx.active.current.hovered.url)
        else
            ya.err("no selected or hovered paths")
        end
    end

    return paths
end)

local function is_hidden(file_path)
    local res, err = Command("attrib"):arg(file_path):stdout(Command.PIPED):output()

    if err then
        ya.err("Error running attrib command: " .. err)
        return nil
    end

    local out = res.stdout

    -- Check if the output contains the 'H' attribute
    if out:match("%sH%s") then
        return true
    else
        return false
    end
end

return {
    entry = function(self, job)
        if ya.target_family() ~= "windows" then
            ya.notify {
                title = "whide error",
                content = "whide only works on windows",
                timeout = 3.0,
                level = "error",
            }
            return
        end

        local mode = job.args[1]
        local cmd_arg = ""

        if mode == "hide" then
            cmd_arg = "+h"
        elseif mode == "unhide" then
            cmd_arg = "-h"
        elseif mode ~= "toggle" then
            ya.err("whide: no valid arg: " .. (mode or ""))
            return
        end

        local items = get_paths()
        local refre = false

        for _, it in ipairs(items) do
            if cmd_arg == "" then
                if is_hidden(it) then
                    cmd_arg = "-h"
                else
                    cmd_arg = "+h"
                end
            end

            local _, err = Command("attrib"):arg(cmd_arg):arg(it):output()
            if err ~= nil then
                ya.err("whide: command error")
            end
            if cmd_arg == "+h" then
                refre = true
            end
        end

        if refre then
            -- doesn't work
            ya.mgr_emit("refresh", {})
        end
    end,
}
