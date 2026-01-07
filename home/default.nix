{
  config,
  pkgs,
  inputs,
  flakeLocation,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./modules/niri
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ludihan";
    homeDirectory = "/home/ludihan";
    preferXdgDirectories = true;
    sessionVariables =
      let
        data = d: "${config.home.homeDirectory}/.local/share/${d}";
        cache = d: "${config.home.homeDirectory}/.cache/${d}";
        state = d: "${config.home.homeDirectory}/.local/state/${d}";
        configDir = d: "${config.home.homeDirectory}/.config/${d}";
      in
      {
        GOPATH = data "go";
        PYTHONUSERBASE = data "python";
        CARGO_HOME = data "cargo";
        RUSTUP_HOME = data "rustup";
        OPAMROOT = data "opam";

        CUDA_CACHE_PATH = cache "nv";
        PYTHONPYCACHEPREFIX = cache "python";
        NUGET_PACKAGES = cache "NuGetPackages";

        PYTHON_HISTORY = state "python_history";
        PSQL_HISTORY = state "psql_history";
        SQLITE_HISTORY = state "sqlite_history";
        NODE_REPL_HISTORY = state "node_repl_history";

        NPM_CONFIG_USERCONFIG = configDir "npm/npmrc";
        DOCKER_CONFIG = configDir "docker";
        OMNISHARPHOME = configDir "omnisharp";
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.home.homeDirectory}/.config/java";

        GHCUP_USE_XDG_DIRS = "true";
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      # Provide a nice prompt if the terminal supports it.
      if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
        PROMPT_COLOR="1;31m"
        ((UID)) && PROMPT_COLOR="1;32m"
        if [ -n "$INSIDE_EMACS" ]; then
          # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
          PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
        else
          PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
        fi
        if test "$TERM" = "xterm"; then
          PS1="\[\033]2;\h:\u:\w\007\]$PS1"
        fi
      fi
      export PATH=$PATH:$HOME/.local/bin
      export PATH=$PATH:$CARGO_HOME/bin
      export PATH=$PATH:$GOPATH/bin
    '';
  };
  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.LS_COLORS = (vivid generate gruvbox-dark)
      $env.config.edit_mode = 'vi'
      $env.config = {
          show_banner: false,
          table: {
              header_on_separator: true,
              mode: 'single'
          }
      }
    '';
  };
  # programs.carapace.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    #iconTheme = {
    #name = "Obsidian-Sand";
    #};
    cursorTheme = {
      name = "Adwaita";
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
  dconf = {
    enable = true;
    settings = {
      #"org/gnome/desktop/background" = {
      #picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      #};
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    discord
    wget
    curl
    jq
    jo
    fd
    ripgrep
    bat
    grim
    slurp
    gcc
    # rustup
    # dotnet-sdk
    # go
    gopls
    nil
    rust-analyzer
    godot
    nodejs
    python3
    uv
    blender
    vivid
    osu-lazer-bin
    docker-compose
    docker-buildx
    hyprpicker
    spotify
    wl-clipboard
    brightnessctl
    imv
    inxi
    papers
    gnome-text-editor
    nautilus
    krita
    # love
    mednafen
    lf
    pavucontrol
    networkmanagerapplet
    unzip
    unrar
    zip
    tuxpaint
    woomer
    xwayland-satellite
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    ffmpegthumbnailer
    nixfmt
    nixfmt-tree
    nix-output-monitor
    nvd
    wl-mirror
    sunvox
    cmus
    kew
    nicotine-plus
    ncdu
    mangohud
    file
    kdePackages.qtdeclarative
    socat
    foliate
    htop
    typst
    tinymist
    nurl
    nix-init
    vintagestory
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.todo
    # inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.bookokrat
  ];

  programs.firefox.enable = true;

  programs.quickshell.enable = true;

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka:size=12";
        resize-by-cells = false;
      };
      # gruvbox
      colors = {
        background = "282828";
        foreground = "ebdbb2";
        regular0 = "282828";
        regular1 = "cc241d";
        regular2 = "98971a";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "a89984";
        bright0 = "928374";
        bright1 = "fb4934";
        bright2 = "b8bb26";
        bright3 = "fabd2f";
        bright4 = "83a598";
        bright5 = "d3869b";
        bright6 = "8ec07c";
        bright7 = "ebdbb2";
      };

      colors2 = {
        background = "fbf1c7";
        foreground = "3c3836";
        regular0 = "fbf1c7";
        regular1 = "cc241d";
        regular2 = "98971a";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "7c6f64";
        bright0 = "928374";
        bright1 = "9d0006";
        bright2 = "79740e";
        bright3 = "b57614";
        bright4 = "076678";
        bright5 = "8f3f71";
        bright6 = "427b58";
        bright7 = "3c3836";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ludihan";
        email = "65617704+ludihan@users.noreply.github.com";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      core = {
        autocrlf = "input";
      };
    };
  };
  programs.discord.enable = true;
  programs.home-manager.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set-window-option -g mode-keys vi
      set-option -g focus-events on
      set-option -sg escape-time 10
      set-option -g default-terminal "screen-256color"
      bind C-p swapw -d -t -1
      bind C-n swapw -d -t +1

      bind h selectp -L
      bind j selectp -D
      bind k selectp -U
      bind l selectp -R

      bind -r H resizep -L 5
      bind -r J resizep -D 5
      bind -r K resizep -U 5
      bind -r L resizep -R 5

      bind o splitw -h
      bind i splitw -v
    '';
  };
  programs.zellij.enable = true;
  services.mako = {
    enable = true;
    extraConfig = ''
      default-timeout=10000
      background-color=#222222
      border-color=#666666
      text-color=#ffffff

      [urgency=low]
      default-timeout=5000

      [urgency=critical]
      ignore-timeout=1
    '';
  };

  services.easyeffects.enable = true;

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      # obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.mpv = {
    enable = true;
    config = {
      keep-open = true;
    };
  };

  programs.nh = {
    enable = true;
    flake = flakeLocation;
  };

  xdg = {
    enable = true;
    configFile =
      let
        link =
          name: config.lib.file.mkOutOfStoreSymlink "${flakeLocation}/config/${name}";
      in
      {
        nvim.source = link "nvim";
        npm.source = link "npm";
        quickshell.source = link "quickshell";
        zellij.source = link "zellij";
      };
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      publicShare = null;
    };
    mime.enable = true;
    mimeApps = {
      #enable = true;
      #defaultApplications = {
      #"inode/directory" = "org.gnome.Nautilus.desktop";
      #"application/pdf" = "org.gnome.Papers.desktop";
      #"application/epub+zip" = "foliate.desktop";
      #"application/epub" = "foliate.desktop";
      #"application/mobi" = "foliate.desktop";
      #"image/jpg" = "imv.desktop";
      #"image/jpeg" = "imv.desktop";
      #"image/png" = "imv.desktop";
      #"image/webp" = "imv.desktop";
      #"text/*" = "org.gnome.TextEditor.desktop";
      #"text/plain" = "org.gnome.TextEditor.desktop";
      #};
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
