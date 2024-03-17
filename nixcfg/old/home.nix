{ config, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      shellAliases = {
        ll = "ls -aF";
        update = "sudo nixos-rebuild switch";
        updatehm = "home-manager switch";
        garbcol = "sudo nix-collect-garbage";
        cleanupdate = "update && garbcol";
        reloadd = "sudo systemctl --user daemon-reload";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
        ];
      };
      initExtra = ''
        eval "$(starship init zsh)"
    '';
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[x](bold red)";
          vimcmd_symbol = "[<](bold green)";
        };
        git_commit = {
          tag_symbol = " tag ";
        };
        git_status = {
          ahead = ">";
          behind = "<";
          diverged = "<>";
          renamed = "r";
          deleted = "x";
        };
        aws = {
          symbol = "aws ";
        };
        azure = {
          symbol = "az ";
        };
        bun = {
          symbol = "bun ";
        };
        c = {
          symbol = "C ";
        };
        cobol = {
          symbol = "cobol ";
        };
        conda = {
          symbol = "conda ";
        };
        crystal = {
          symbol = "cr ";
        };
        cmake = {
          symbol = "cmake ";
        };
        daml = {
          symbol = "daml ";
        };
        dart = {
          symbol = "dart ";
        };
        deno = {
          symbol = "deno ";
        };
        dotnet = {
          symbol = ".NET ";
        };
        directory = {
          read_only = " ro";
        };
        docker_context = {
          symbol = "docker ";
        };
        elixir = {
          symbol = "exs ";
        };
        elm = {
          symbol = "elm ";
        };
        fennel = {
          symbol = "fnl ";
        };
        ssil_branch = {
          symbol = "fossil ";
        };
        gcloud = {
          symbol = "gcp ";
        };
        git_branch = {
          symbol = "git ";
        };
        golang = {
          symbol = "go ";
        };
        gradle = {
          symbol = "gradle ";
        };
        guix_shell = {
          symbol = "guix ";
        };
        hg_branch = {
          symbol = "hg ";
        };
        java = {
          symbol = "java ";
        };
        julia = {
          symbol = "jl ";
        };
        kotlin = {
          symbol = "kt ";
        };
        lua = {
          symbol = "lua ";
        };
        nodejs = {
          symbol = "nodejs ";
        };
        memory_usage = {
          symbol = "memory ";
        };
        meson = {
          symbol = "meson ";
        };
        nim = {
          symbol = "nim ";
        };
        nix_shell = {
          symbol = "nix ";
        };
        ocaml = {
          symbol = "ml ";
        };
        opa = {
          symbol = "opa ";
        };
        os.symbols = {
          Alpaquita = "alq ";
          Alpine = "alp ";
          Amazon = "amz ";
          Android = "andr ";
          Arch = "rch ";
          Artix = "atx ";
          CentOS = "cent ";
          Debian = "deb ";
          DragonFly = "dfbsd ";
          Emscripten = "emsc ";
          EndeavourOS = "ndev ";
          Fedora = "fed ";
          FreeBSD = "fbsd ";
          Garuda = "garu ";
          Gentoo = "gent ";
          HardenedBSD = "hbsd ";
          Illumos = "lum ";
          Linux = "lnx ";
          Mabox = "mbox ";
          Macos = "mac ";
          Manjaro = "mjo ";
          Mariner = "mrn ";
          MidnightBSD = "mid ";
          Mint = "mint ";
          NetBSD = "nbsd ";
          NixOS = "nix ";
          OpenBSD = "obsd ";
          OpenCloudOS = "ocos ";
          openEuler = "oeul ";
          openSUSE = "osuse ";
          OracleLinux = "orac ";
          Pop = "pop ";
          Raspbian = "rasp ";
          Redhat = "rhl ";
          RedHatEnterprise = "rhel ";
          Redox = "redox ";
          Solus = "sol ";
          SUSE = "suse ";
          Ubuntu = "ubnt ";
          Unknown = "unk ";
          Windows = "win ";
        };
        package = {
          symbol = "pkg ";
        };
        perl = {
          symbol = "pl ";
        };
        php = {
          symbol = "php ";
        };
        pijul_channel = {
          symbol = "pijul ";
        };
        pulumi = {
          symbol = "pulumi ";
        };
        purescript = {
          symbol = "purs ";
        };
        python = {
          symbol = "py ";
        };
        raku = {
          symbol = "raku ";
        };
        ruby = {
          symbol = "rb ";
        };
        rust = {
          symbol = "rs ";
        };
        scala = {
          symbol = "scala ";
        };
        spack = {
          symbol = "spack ";
        };
        solidity = {
          symbol = "solidity ";
        };
        status = {
          symbol = "[x](bold red)";
        };
        sudo = {
          symbol = "sudo ";
        };
        swift = {
          symbol = "swift ";
        };
        terraform = {
          symbol = "terraform ";
        };
        zig = {
          symbol = "zig ";
        };
      };
    };
    git = {
      enable = true;
      userName = "Zubbbz";
      userEmail = "37497090+Zubbbz@users.noreply.github.com";
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "/home/nathan/.ssh/keys/Git.pub";
        init.defaultBranch = "main";
        color.ui = "auto";
        pull.rebase = false;
      };
    };
    ssh = {
      enable = true;
      forwardAgent = true;
      matchBlocks = {

        "tas" = {
          hostname = "54.37.244.2";
          user = "zubbbz";
          port = 8326;
          identityFile = "~/.ssh/keys/TAServers.pub";
          extraOptions = {
            "PubkeyAuthentication" = "yes";
          };
        };

        "homeserv" = {
          hostname = "192.168.1.33";
          user = "nathan";
          port = 22;
          extraOptions = {
            "PubkeyAuthentication" = "no";
          };
        };

        "vps" = {
          hostname = "135.148.149.120";
          user = "ubuntu";
          port = 62484;
          identityFile = "~/.ssh/keys/OVH.pub";
          extraOptions = {
            "PubkeyAuthentication" = "yes";
          };
        };

        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/keys/Git.pub";
          extraOptions = {
            "PubkeyAuthentication" = "yes";
          };
        };

        "router" = {
          hostname = "192.168.0.1";
          user = "root";
        };
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 1800;
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nathan";
  home.homeDirectory = "/home/nathan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this valque, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # home.packages = with pkgs; [
  # ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nathan/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
