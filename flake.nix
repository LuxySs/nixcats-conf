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
            portableExtras = [
              wl-clipboard
              git
              nix
              coreutils-full
              curl
            ];
            general = {
              core = [
                universal-ctags
                ripgrep
                fd
                jq
              ];
            };
            markdown = [
              markdownlint-cli
            ];
            java = [
              jdt-language-server
            ];
            web = {
              JS = with nodePackages; [
                typescript-language-server
                eslint
                prettier
              ];
            };
            rust = [
              rust-analyzer
            ];
            lua = [
              lua-language-server
            ];
            typst = [
              tinymist
              websocat
            ];
            nix = [
              nix-doc
              nixd
              nixfmt-rfc-style
            ];
            bash = [
              bash-language-server
            ];
            python = [
              isort
              pyright
              ruff
            ];
            C = [
              clang-tools
              neocmakelsp
              #TODO: add cmake-format
            ];
            latex = [
              texlab
            ];
            plantuml = [
              plantuml
            ];
          };

          # This is for plugins that will load at startup without using packadd:
          startupPlugins = with pkgs.vimPlugins; {
            # TODO: colorscheme

            # colorschemes = [
            #   catppuccin-nvim
            #   gruvbox-nvim
            #   onedark-nvim
            #   tokyonight-nvim
            #   vague-nvim
            # ];

            general = [
              lazy-nvim
              mini-ai
              mini-bracketed
              mini-surround
              nvim-autopairs
              oil-nvim
              snacks-nvim
              vim-tmux-navigator
              nvim-web-devicons

              blink-cmp
              luasnip
              friendly-snippets

              nvim-treesitter.withAllGrammars
              lualine-nvim
              gitsigns-nvim
              nvim-lint
              conform-nvim
              fidget-nvim
              nvim-lspconfig
              lazydev-nvim
            ];

            otter = [
              otter-nvim
            ];
            # java = [
            #   nvim-jdtls
            # ];
            typst = [
              typst-preview-nvim
            ];
            debug = [
              nvim-dap
              nvim-dap-ui
              nvim-dap-virtual-text
            ];
            other = [
              plenary-nvim
              todo-comments-nvim
              which-key-nvim
              nvim-ufo
              nvim-highlight-colors
              comment-nvim
            ];
            markdown = [
              markview-nvim
            ];
            latex = [
              vimtex
            ];
            python = [
              nvim-dap-python
            ];
            # plantuml = [
            #   plantuml-syntax
            # ];
            # codesnap = [
            #   codesnap-nvim
            # ];
          };

          # not loaded automatically at startup.
          # use with packadd and an autocommand in config to achieve lazy loading
          # NOTE: no difference between this and startupPlugins since lazy is
          # in charge of the lazy loading side of things.
          optionalPlugins = with pkgs.vimPlugins; {
          };

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
              portableExtras = true;

              general = true;
              typst = true;
              markdown = true;

              # java = true;
              # web = true;
              # rust = true;
              # lua = true;
              # nix = true;
              # bash = true;
              python = true;
              # C = true;
              latex = true;
              # plantuml = true;
              otter = true;
              debug = true;
              other = true;
              # codesnap = true;
              # colorscheme = "gruvbox";
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
