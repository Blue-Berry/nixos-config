
local function free_services()
     require("cmp").suspend()
     require("noice").disable()
     local api = require("supermaven-nvim.api")
     api.stop()
     print("services freed")
end

vim.api.nvim_create_autocmd({'BufWinEnter'}, {
   once=true,
   callback = function(_)
     local timer = vim.uv.new_timer()
     timer:start(1000, 0, vim.schedule_wrap(free_services))
   end
 })

