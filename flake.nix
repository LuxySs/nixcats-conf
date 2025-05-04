{
  description = "LuxySs's NixCats/Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        # allowUnfree = true;
      };

      dependencyOverlays = # (import ./overlays inputs) ++
        [
          # This overlay grabs all the inputs named in the format
          # `plugins-<pluginName>`
          # Once we add this overlay to our nixpkgs, we are able to
          # use `pkgs.neovimPlugins`, which is a set of our plugins.
          (utils.standardPluginOverlay inputs)
        ];

      categoryDefinitions =
        {
          pkgs,
          settings,
          categories,
          extra,
          name,
          mkNvimPlugin,
          ...
        }@packageDef:
        {
          # lspsAndRuntimeDeps:
          # this section is for dependencies that should be available
          # at RUN TIME for plugins. Will be available to PATH within neovim terminal
          # this includes LSPs
          lspsAndRuntimeDeps = with pkgs; {
            general = [
              fd
              fzf
              nix-doc
              nixd
              nixfmt-rfc-style
              ripgrep
            ];

            programming = {
              lsp = [
                bash-language-server
                clang-tools
                gopls
                jdt-language-server
                lua-language-server
                neocmakelsp
                pyright
                rust-analyzer
                texlab
              ];

              linting = [
                shellcheck
                ruff
              ];

              formatting = [
                stylua
                isort
              ];

              debug = [ gdb ];
            };

            markdown = [ markdownlint-cli ];

            latex = [ zathura ];

            plantuml = [ plantuml ];
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = with pkgs.vimPlugins; {
            general = {
              colorschemes = [
                catppuccin-nvim
                gruvbox-nvim
                onedark-nvim
                tokyonight-nvim
              ];

              statusLine = [
                lualine-nvim
                nvim-web-devicons
              ];

              lazy = [ lazy-nvim ];
            };

            completion = [
              blink-cmp

              luasnip
              friendly-snippets
            ];

            programming = {
              lsp = [
                fidget-nvim
                lazydev-nvim
                nvim-jdtls
                nvim-lspconfig
                otter-nvim
              ];

              linting = [
                nvim-lint
              ];

              formatting = [
                conform-nvim
              ];

              debug = [
                nvim-dap
                nvim-dap-ui
                nvim-nio
              ];
            };

            treesitter = [
              nvim-treesitter-textobjects
              nvim-treesitter.withAllGrammars
              # This is for if you only want some of the grammars
              # (nvim-treesitter.withPlugins (
              #   plugins: with plugins; [
              #     nix
              #     lua
              #   ]
              # ))
            ];

            git = {
              gitsigns = [ gitsigns-nvim ];
              neogit = [
                neogit
                plenary-nvim
                diffview-nvim
                telescope-nvim
              ];
            };

            ui = {
              alpha = [
                alpha-nvim
                nvim-web-devicons
              ];

              indent-blankline = [
                indent-blankline-nvim
              ];

              noice = [
                noice-nvim
                nui-nvim
              ];

              todo-comments = [
                plenary-nvim
                todo-comments-nvim
              ];

              which-key = [
                which-key-nvim
              ];
            };

            utils = {
              autopairs = [ nvim-autopairs ];

              mini-bracketed = [ mini-bracketed ];

              codesnap = [ codesnap-nvim ];

              colorizer = [ nvim-colorizer-lua ];

              comment = [ comment-nvim ];

              harpoon = [
                harpoon2
                plenary-nvim
              ];

              mini-ai = [ mini-ai ];

              mini-surround = [ mini-surround ];

              neo-tree = [
                neo-tree-nvim
                nui-nvim
                nvim-web-devicons
                plenary-nvim
              ];

              oil = [
                nvim-web-devicons
                oil-nvim
              ];

              telescope = [
                telescope-nvim
                plenary-nvim
                nvim-web-devicons
                telescope-fzf-native-nvim
                telescope-ui-select-nvim
              ];

              telescope-undo = [
                telescope-undo-nvim
              ];

              vim-tmux-navigator = [ vim-tmux-navigator ];

              toggleterm = [ toggleterm-nvim ];

              ufo = [
                nvim-ufo
                promise-async
              ];
            };

            markdown = {
              markdown-preview = [ markdown-preview-nvim ];
              markview = [
                markview-nvim
                nvim-web-devicons
              ];
            };

            latex = [ vimtex ];

            plantuml = [ plantuml-syntax ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          # NOTE: this template is using lazy.nvim so, which list you put them in is irrelevant.
          # startupPlugins or optionalPlugins, it doesnt matter, lazy.nvim does the loading.
          # I just put them all in startupPlugins. I could have put them all in here instead.
          optionalPlugins = { };

          # shared libraries to be added to LD_LIBRARY_PATH
          # variable available to nvim runtime
          sharedLibraries = {
            general = with pkgs; [
              libgit2
            ];
          };

          # environmentVariables:
          # this section is for environmentVariables that should be available
          # at RUN TIME for plugins. Will be available to path within neovim terminal
          environmentVariables = { };

          # If you know what these are, you can provide custom ones by category here.
          # If you dont, check this link out:
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
          extraWrapperArgs = { };

          # lists of the functions you would have passed to
          # python.withPackages or lua.withPackages

          # get the path to this python environment
          # in your lua config via
          # vim.g.python3_host_prog
          # or run from nvim terminal via :!<packagename>-python3
          extraPython3Packages = {
            test = (_: [ ]);
          };
          # populates $LUA_PATH and $LUA_CPATH
          extraLuaPackages = {
            test = [ (_: [ ]) ];
          };
        };

      # And then build a package with specific categories from above here:
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions = {
        # These are the names of your packages
        # you can include as many as you wish.
        nixCats =
          { pkgs, ... }:
          {
            # they contain a settings set defined above
            # see :help nixCats.flake.outputs.settings
            settings = {
              wrapRc = true;
              # IMPORTANT:
              # your alias may not conflict with your other packages.
              aliases = [
                "nixcats"
                "nvim"
                "vim"
                "nv"
                "v"
              ];
              # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            };
            # and a set of categories that you want
            # (and other information to pass to lua)
            categories = {
              general = true;
              programming = true;
              completion = true;
              treesitter = true;
              git = true;
              ui = true;
              utils = true;
              markdown = true;
              latex = true;
              plantuml = true;
            };
          };
      };
      # In this section, the main thing you will need to do is change the default package name
      # to the name of the packageDefinitions entry you wish to use as the default.
      defaultPackageName = "nixCats";
    in

    # see :help nixCats.flake.outputs.exports
    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        # this is just for using utils such as pkgs.mkShell
        # The one used to build neovim is resolved inside the builder
        # and is passed to our categoryDefinitions and packageDefinitions
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # these outputs will be wrapped with ${system} by utils.eachSystem

        # this will make a package out of each of the packageDefinitions defined above
        # and set the default package to the one passed in here.
        packages = utils.mkAllWithDefault defaultPackage;

        # choose your package for devShell
        # and add whatever else you want in it.
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = '''';
          };
        };

      }
    )
    // (
      let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
        # and the same for home manager
        homeModule = utils.mkHomeModules {
          inherit
            defaultPackageName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extra_pkg_config
            nixpkgs
            ;
        };
      in
      {

        # these outputs will be NOT wrapped with ${system}

        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      }
    );
}
