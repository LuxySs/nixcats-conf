return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'harpoon' },

  -- fix different name from url for nixCats
  name = 'harpoon2',
  dev = require('nixCatsUtils').lazyAdd(false, true),

  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    local map = vim.keymap.set

    map('n', '<leader>n', function()
      harpoon:list():add()
    end)

    map('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- <leader>1..<leader>5 to move to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      map('n', string.format('<leader>%d', idx), function()
        harpoon:list():select(idx)
      end)
    end

    --[[ telescope extension ]]
    --
    -- basic telescope configuration
    -- local conf = require('telescope.config').values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require('telescope.pickers')
    --     .new({}, {
    --       prompt_title = 'Harpoon',
    --       finder = require('telescope.finders').new_table {
    --         results = file_paths,
    --       },
    --       previewer = conf.file_previewer {},
    --       sorter = conf.generic_sorter {},
    --     })
    --     :find()
    -- end

    -- map("n", "<C-e>", function()
    -- 	toggle_telescope(harpoon:list())
    -- end, { desc = "Open harpoon window" })
  end,
}
