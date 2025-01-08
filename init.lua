vim.cmd('syntax on')

vim.o.number = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true  
vim.o.mouse = 'a'

vim.cmd('colorscheme desert')


-- 快捷键映射
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })









-- 自动安装 packer.nvim
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

ensure_packer()

-- 初始化 packer 并加载插件
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'windwp/nvim-autopairs'  
    use 'nvim-telescope/telescope.nvim' 
    use 'nvim-lualine/lualine.nvim'
    use {
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', 
    }
}
end)

--配置 Tree 文件目录
require('nvim-tree').setup({
    view = {
        width = 30,
        side = 'left',
    },
    filters = {
        dotfiles = false,
    },
})


