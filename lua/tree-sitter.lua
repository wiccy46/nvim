-- On Fedora make sure c++, c and c32 compilers are installed
-- sudo dnf install gcc libgcc.i686 glibc-devel.i686 gcc-c++
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "cpp", "lua", "rust", "python", "java", "javascript" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
