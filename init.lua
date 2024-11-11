-- 设置行号
vim.o.number = true  -- 等价于 set number

-- 启用语法高亮
vim.cmd('syntax on')  -- 使用 vim.cmd 执行 Vim 脚本命令

-- 设置缩进宽度为 4
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true  -- 将 Tab 转换为空格

-- 启用鼠标支持
vim.o.mouse = 'a'

-- 设置颜色主题
vim.cmd('colorscheme desert')

-- 自动安装 packer.nvim
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
    use 'neovim/nvim-lspconfig'  -- LSP 配置
    use 'nvim-treesitter/nvim-treesitter'  -- 树木语法解析器
    -- 在这里添加更多插件
end)

