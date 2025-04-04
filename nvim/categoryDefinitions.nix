{
  inputs,
  ...
}: {
  pkgs,
  settings,
  categories,
  extra,
  name,
  mkNvimPlugin,
  ...
} @ packageDef: let
  fallbackPackage = originalPackage: let
    originalName = originalPackage.name;
    fallbackName = "${originalName}-fallback";
  in
    pkgs.writeShellScriptBin fallbackName ''
      exec ${pkgs.lib.getExe originalPackage} "$@"
    '';
in let
  fallbackSet = packageSet:
    builtins.mapAttrs (
      name: pkg: (fallbackPackage pkg)
    )
    packageSet;
in rec {
  # to define and use a new category, simply add a new list to a set here,
  # and later, you will include categoryname = true; in the set you
  # provide when you build the package using this builder function.
  # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

  fallbackLsps = fallbackSet {
    ocaml = pkgs.ocamlPackages.ocaml-lsp;
  };

  # lspsAndRuntimeDeps:
  # this section is for dependencies that should be available
  # at RUN TIME for plugins. Will be available to PATH within neovim terminal
  # this includes LSPs
  lspsAndRuntimeDeps = with pkgs; {
    # some categories of stuff.
    general = [
      universal-ctags
      ripgrep
      fd
      # ocamlPackages.ocaml-lsp
      tree-sitter
    ];
    languages = {
      go = [
        delve #Debugger
        # gopls
        # gotools
        # go-tools
        # gccgo
      ];
      ocaml = with pkgs.ocamlPackages; [
        merlin
        # ocaml-lsp
        fallbackLsps.ocaml
        # (fallbackPackage ocaml-lsp)
      ];
      bash = [
        bash-language-server
      ];
      latex = [
        python3Packages.pylatexenc
      ];
      lua = [
        lua-language-server
        stylua
      ];
      nix = [
        nix-doc
        alejandra
        nixd
      ];
    };
  };

  # This is for plugins that will load at startup without using packadd:
  startupPlugins = with pkgs.vimPlugins; {
    debug = [
      nvim-nio
    ];
    general = {
      # you can make subcategories!!!
      # (always isnt a special name, just the one I chose for this subcategory)
      always = [
        lze
        lzextras
        vim-repeat
        plenary-nvim
        nvim-notify
      ];
      extra = [
        oil-nvim
        nvim-web-devicons
        snacks-nvim
      ];
    };
    languages.latex = [
      vimtex
    ];
    # You can retreive information from the
    # packageDefinitions of the package this was packaged with.
    # :help nixCats.flake.outputs.categoryDefinitions.scheme
    themer = with pkgs.vimPlugins; (
      builtins.getAttr (categories.colorscheme or "catppuccin") {
        # Theme switcher without creating a new category
        "onedark" = onedark-nvim;
        "catppuccin" = catppuccin-nvim;
        "tokyonight" = tokyonight-nvim;
        "tokyonight-day" = tokyonight-nvim;
        "nightfox" = nightfox-nvim;
      }
    );
    # This is obviously a fairly basic usecase for this, but still nice.
  };

  # not loaded automatically at startup.
  # use with packadd and an autocommand in config to achieve lazy loading
  # or a tool for organizing this like lze or lz.n!
  # to get the name packadd expects, use the
  # `:NixCats pawsible` command to see them all
  optionalPlugins = with pkgs.vimPlugins; {
    debug = with pkgs.vimPlugins; {
      # it is possible to add default values.
      # there is nothing special about the word "default"
      # but we have turned this subcategory into a default value
      # via the extraCats section at the bottom of categoryDefinitions.
      default = [
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
      ];
      go = [nvim-dap-go];
    };
    lint = with pkgs.vimPlugins; [
      nvim-lint
    ];
    format = with pkgs.vimPlugins; [
      conform-nvim
    ];
    markdown = with pkgs.vimPlugins; [
      markdown-preview-nvim
    ];
    languages = {
      lua = [
        lazydev-nvim
      ];
    };
    general = {
      cmp = with pkgs.vimPlugins; [
        # cmp stuff
        which-key-nvim
        nvim-cmp
        luasnip
        friendly-snippets
        cmp_luasnip
        cmp-buffer
        cmp-path
        cmp-nvim-lua
        cmp-nvim-lsp
        cmp-cmdline
        cmp-nvim-lsp-signature-help
        cmp-cmdline-history
        lspkind-nvim
        ctrlp-vim
      ];
      treesitter = with pkgs.vimPlugins; [
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
        # This is for if you only want some of the grammars
        (nvim-treesitter.withPlugins (
          plugins:
            with plugins; [
              nix
              lua
              ocaml
              rust
              go
              lua
              c
              commonlisp
            ]
        ))
      ];
      telescope = with pkgs.vimPlugins; [
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        telescope-file-browser-nvim
        telescope-zoxide
        catppuccin-nvim
        telescope-nvim
      ];
      noice = with pkgs.vimPlugins; [
        noice-nvim
        nui-nvim
        nvim-notify
      ];
      always = with pkgs.vimPlugins; [
        nvim-lspconfig
        lualine-nvim
        gitsigns-nvim
        vim-sleuth
        vim-fugitive
        vim-rhubarb
        nvim-surround
        guess-indent-nvim
        git-conflict-nvim
      ];
      extra = with pkgs.vimPlugins; [
        fidget-nvim
        # lualine-lsp-progress
        comment-nvim
        undotree
        indent-blankline-nvim
        vim-startuptime
        supermaven-nvim
        yazi-nvim
        nvterm
        nvim-bqf
        flash-nvim
        trouble-nvim
        todo-comments-nvim
        rainbow-delimiters-nvim
        dropbar-nvim
        nvim-autopairs
        vim-ocaml
        mini-nvim
        render-markdown-nvim
        obsidian-nvim
        # If it was included in your flake inputs as plugins-hlargs,
        # this would be how to add that plugin in your config.
        # pkgs.neovimPlugins.hlargs
        pkgs.neovimPlugins.ocaml
        inputs.alloc_scan.packages.${pkgs.system}.default
      ];
    };
  };

  # shared libraries to be added to LD_LIBRARY_PATH
  # variable available to nvim runtime
  sharedLibraries = {
  };

  # environmentVariables:
  # this section is for environmentVariables that should be available
  # at RUN TIME for plugins. Will be available to path within neovim terminal
  environmentVariables = {
  };

  # If you know what these are, you can provide custom ones by category here.
  # If you dont, check this link out:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
  extraWrapperArgs = {
  };

  # lists of the functions you would have passed to
  # python.withPackages or lua.withPackages

  # get the path to this python environment
  # in your lua config via
  # vim.g.python3_host_prog
  # or run from nvim terminal via :!<packagename>-python3
  extraPython3Packages = {
    test = _: [];
  };
  # populates $LUA_PATH and $LUA_CPATH
  extraLuaPackages = {
    general = [(_: [])];
  };

  # see :help nixCats.flake.outputs.categoryDefinitions.default_values
  # this will enable test.default and debug.default
  # if any subcategory of test or debug is enabled
  # WARNING: use of categories argument in this set will cause infinite recursion
  # The categories argument of this function is the FINAL value.
  # You may use it in any of the other sets.
  extraCats = {
    test = [
      ["test" "default"]
    ];
    debug = [
      ["debug" "default"]
    ];
  };
}
