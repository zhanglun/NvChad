local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local logo = [[
  ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
  ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
  ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
  ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
  ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
]]


-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
  dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
  dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
  dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}
dashboard.section.header.val = vim.split(logo, "\n")
-- stylua: ignore
dashboard.section.buttons.val = {
  dashboard.button("SPC f f", " " .. " Find file", ":Telescope find_files<CR>"),
  dashboard.button("SPC f n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
  dashboard.button("SPC f o", " " .. " Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("SPC f w", " " .. " Find word", ":Telescope live_grep<CR>"),
  dashboard.button("SPC f s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
  dashboard.button("SPC c h", " " .. " Cheatsheet  ", ":NvCheatsheet<CR>"),
  dashboard.button("SPC t h", " " .. " Themes  ", ":Telescope themes<CR>"),
  dashboard.button("SPC e s", " " .. " Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
  dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
}

dashboard.opts.layout[1].val = 10

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

vim.api.nvim_create_autocmd("User", {
  once = true,
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    local info = {}
    local fortune = require("fortune").get_fortune()
    info[1] = "           ⚡ Neovim loaded "
        .. stats.loaded
        .. "/"
        .. stats.count
        .. " plugins in "
        .. ms
        .. "ms"

    info[2] = " "
    local footer = vim.list_extend(info, fortune)
    dashboard.section.footer.val = footer
    pcall(vim.cmd.AlphaRedraw)
  end,
})
