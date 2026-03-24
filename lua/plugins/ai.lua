return {
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
          },
        },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "MeanderingProgrammer/render-markdown.nvim",
    },
    config = function()
      local map = vim.keymap.set
      map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
      map({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanion Chat Toggle" })
      map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "CodeCompanion Chat Add" })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
          agent = {
            adapter = "copilot",
          },
        },
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-3.5-sonnet",
                },
              },
            })
          end,
        },
      })
    end,
  },
}
