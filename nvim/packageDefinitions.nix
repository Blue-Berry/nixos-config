{
  inputs,
  nixpkgs,
  utils,
  ...
}: {
  # the name here is the name of the package
  # and also the default command name for it.
  n = {pkgs, ...} @ misc: {
    # these also recieve our pkgs variable
    # see :help nixCats.flake.outputs.packageDefinitions
    settings = {
      # The name of the package, and the default launch name,
      # and the name of the .desktop file, is `nixCats`,
      # or, whatever you named the package definition in the packageDefinitions set.
      aliases = ["vim" "vimcat"];

      # explained below in the `regularCats` package's definition
      # OR see :help nixCats.flake.outputs.settings for all of the settings available
      wrapRc = true;
      configDirName = "nixCats-nvim";
      # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    };
    # enable the categories you want from categoryDefinitions
    categories = {
      markdown = true;
      general = true;
      lint = true;
      format = true;
      languages = true;
      debug = true;
      neovide = true;
      noice = true;

      # enabling this category will enable the go category,
      # and ALSO debug.go and debug.default due to our extraCats in categoryDefinitions.
      # go = true; # <- disabled but you could enable it with override or module on install

      # this does not have an associated category of plugins,
      # but lua can still check for it
      lspDebugMode = false;
      # you could also pass something else:
      # see :help nixCats
      themer = true;
      colorscheme = "catppuccin";
      cacheDir = "/tmp/cache/catppuccin/";
      merlinPath = pkgs.ocamlPackages.merlin;
    };
    extra = {
      # to keep the categories table from being filled with non category things that you want to pass
      # there is also an extra table you can use to pass extra stuff.
      # but you can pass all the same stuff in any of these sets and access it in lua
      nixdExtras = {
        nixpkgs = nixpkgs;
      };
    };
  };
  regularCats = {pkgs, ...} @ misc: {
    settings = {
      # IMPURE PACKAGE: normal config reload
      # include same categories as main config,
      # will load from vim.fn.stdpath('config')
      wrapRc = false;
      # or tell it some other place to load
      # unwrappedCfgPath = "/some/path/to/your/config";

      # configDirName: will now look for nixCats-nvim within .config and .local and others
      # this can be changed so that you can choose which ones share data folders for auths
      # :h $NVIM_APPNAME
      configDirName = "nixCats-nvim";

      aliases = ["testCat"];

      # If you wanted nightly, uncomment this, and the flake input.
      # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
      # Probably add the cache stuff they recommend too.
    };
    categories = {
      markdown = true;
      general = true;
      lint = true;
      format = true;
      test = true;
      neovide = true;
      lspDebugMode = false;
      themer = true;
      colorscheme = "catppuccin-latte";
    };
    extra = {
      # nixCats.extra("path.to.val") will perform vim.tbl_get(nixCats.extra, "path" "to" "val")
      # this is different from the main nixCats("path.to.cat") in that
      # the main nixCats("path.to.cat") will report true if `path.to = true`
      # even though path.to.cat would be an indexing error in that case.
      # this is to mimic the concept of "subcategories" but may get in the way of just fetching values.
      nixdExtras = {
        nixpkgs = ''import ${pkgs.path} {}'';
        # or inherit nixpkgs;
      };
      # yes even tortured inputs work.
      theBestCat = "says meow!!";
      theWorstCat = {
        thing'1 = ["MEOW" '']]' ]=][=[HISSS]]"[[''];
        thing2 = [
          {
            thing3 = ["give" "treat"];
          }
          "I LOVE KEYBOARDS"
          (utils.n2l.types.inline-safe.mk ''[[I am a]] .. [[ lua ]] .. type("value")'')
        ];
        thing4 = "couch is for scratching";
      };
    };
  };
}
