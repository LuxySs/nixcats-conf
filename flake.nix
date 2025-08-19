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

            lsp = rec {
              c = [
                clang-tools
                neocmakelsp
              ];
              cpp = c;
              bash = [ bash-language-server ];
              go = [ gopls ];
              java = [ jdt-language-server ];
              lua = [ lua-language-server ];
              python = [ pyright ];
              rust = [ rust-analyzer ];
              latex = [ texlab ];
              typescript = [ typescript-language-server ];
            };

            linting = {
              python = [ ruff ];
              markdown = [ markdownlint-cli ];
            };

            formatting = {
              lua = [ stylua ];
              python = [ isort ];
            };

            debugging = rec {
              c = [ gdb ];
              cpp = c;
              rust = c;
            };

            latex = [ zathura ];

            plantuml = [ plantuml ];
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = with pkgs.vimPlugins; {
            general = {
              lazy = [ lazy-nvim ];

              colorschemes = [
                catppuccin-nvim
                gruvbox-nvim
                onedark-nvim
                tokyonight-nvim
                vague-nvim
              ];

              autopairs = [ nvim-autopairs ];

              codesnap = [ codesnap-nvim ];

              colorizer = [ nvim-colorizer-lua ];

              comment = [ comment-nvim ];

              lualine = [
                lualine-nvim
                nvim-web-devicons
              ];

              mini-ai = [ mini-ai ];

              mini-bracketed = [ mini-bracketed ];

              mini-surround = [ mini-surround ];

              vim-tmux-navigator = [ vim-tmux-navigator ];

              oil = [
                nvim-web-devicons
                oil-nvim
              ];

              snacks = [ snacks-nvim ];

              todo-comments = [
                plenary-nvim
                todo-comments-nvim
              ];

              ufo = [
                nvim-ufo
                promise-async
              ];

              which-key = [ which-key-nvim ];
            };

            completion = {
              blink = [ blink-cmp ];

              luasnip = [
                luasnip
                friendly-snippets
              ];
            };

            lsp = {
              fidget = [ fidget-nvim ];

              lazydev = [ lazydev-nvim ];

              jdtls = [ nvim-jdtls ];

              lspconfig = [ nvim-lspconfig ];

              otter = [ otter-nvim ];
            };

            linting = {
              nvim-lint = [ nvim-lint ];
            };

            formatting = {
              conform = [ conform-nvim ];
            };

            debugging = {
              dap = [
                nvim-dap
                nvim-dap-ui
                nvim-nio
                nvim-dap-virtual-text
                nvim-dap-python
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
            };

            markdown = {
              markdown-preview = [ markdown-preview-nvim ];

              markview = [
                markview-nvim
                nvim-web-devicons
              ];
            };

            latex = {
              vimtex = [ vimtex ];
            };

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
              completion = true;

              treesitter = true;

              lsp = true;
              formatting = true;
              linting = true;
              debug = true;

              git = true;

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
