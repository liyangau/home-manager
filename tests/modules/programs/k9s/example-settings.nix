{ config, ... }: {
  programs.k9s = {
    enable = true;
    package = config.lib.test.mkStubPackage { };

    settings = {
      k9s = {
        refreshRate = 2;
        maxConnRetry = 5;
        enableMouse = true;
        headless = false;
        ui.skin = "default";
      };
    };
    hotkey = {
      hotKeys = {
        shift-0 = {
          shortCut = "Shift-0";
          description = "Viewing pods";
          command = "pods";
        };
      };
    };
    skins = {
      "default" = {
        k9s = {
          body = {
            fgColor = "dodgerblue";
            bgColor = "#ffffff";
            logoColor = "#0000ff";
          };
          info = {
            fgColor = "lightskyblue";
            sectionColor = "steelblue";
          };
        };
      };
      "alt-skin" = {
        k9s = {
          body = {
            fgColor = "orangered";
            bgColor = "#ffffff";
            logoColor = "#0000ff";
          };
          info = {
            fgColor = "red";
            sectionColor = "mediumvioletred";
          };
        };
      };
    };
    aliases = { aliases = { pp = "v1/pods"; }; };
    plugin = {
      plugins = {
        fred = {
          shortCut = "Ctrl-L";
          description = "Pod logs";
          scopes = [ "po" ];
          command = "kubectl";
          background = false;
          args =
            [ "logs" "-f" "$NAME" "-n" "$NAMESPACE" "--context" "$CLUSTER" ];
        };
      };
    };
    views = {
      views = {
        "v1/pods" = {
          columns = [ "AGE" "NAMESPACE" "NAME" "IP" "NODE" "STATUS" "READY" ];
        };
      };
    };
  };

  nmt.script = ''
    assertFileExists home-files/.config/k9s/config.yaml
    assertFileContent \
      home-files/.config/k9s/config.yaml \
      ${./example-config-expected.yaml}
    assertFileExists home-files/.config/k9s/skins/default.yaml
    assertFileContent \
      home-files/.config/k9s/skins/default.yaml \
      ${./example-skin-expected.yaml}
    assertFileExists home-files/.config/k9s/skins/alt-skin.yaml
    assertFileContent \
      home-files/.config/k9s/skins/alt-skin.yaml \
      ${./example-skin-expected-alt.yaml}
    assertFileExists home-files/.config/k9s/hotkeys.yaml
    assertFileContent \
      home-files/.config/k9s/hotkeys.yaml \
      ${./example-hotkey-expected.yaml}
    assertFileExists home-files/.config/k9s/aliases.yaml
    assertFileContent \
      home-files/.config/k9s/aliases.yaml \
      ${./example-aliases-expected.yaml}
    assertFileExists home-files/.config/k9s/plugins.yaml
    assertFileContent \
      home-files/.config/k9s/plugins.yaml \
      ${./example-plugin-expected.yaml}
    assertFileExists home-files/.config/k9s/views.yaml
    assertFileContent \
      home-files/.config/k9s/views.yaml \
      ${./example-views-expected.yaml}
  '';
}
