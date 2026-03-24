require("tree-sitter").setup_buffer()
vim.lsp.enable("gdscript")

local function get_godot_project_root()
  local current_file = vim.fn.expand("%:p")
  local search_dir = vim.fn.fnamemodify(current_file, ":h")

  if current_file == "" then search_dir = vim.fn.getcwd() end

  local found = vim.fs.find("project.godot", {
    path = search_dir,
    upward = true,
    type = "file",
    limit = 1,
  })

  if #found > 0 then return vim.fn.fnamemodify(found[1], ":h") end

  return nil
end

local godot_project_root = get_godot_project_root()

if godot_project_root then
  local server_pipe = godot_project_root .. "/server.pipe"
  local is_server_running = vim.uv.fs_stat(server_pipe) ~= nil

  if not is_server_running then vim.fn.serverstart(server_pipe) end
end
