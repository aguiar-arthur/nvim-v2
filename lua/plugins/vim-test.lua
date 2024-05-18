return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },


  config = function()
    local opts = {desc = "which_key_ignore"}
    vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", opts)
    vim.keymap.set("n", "<leader>T", ":TestFile<CR>", opts)
    vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", opts)
    vim.keymap.set("n", "<leader>l", ":TestLast<CR>", opts)
    vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", opts)
    vim.cmd("let test#strategy = 'vimux'")
  end,
}
