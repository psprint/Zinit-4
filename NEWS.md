# Zinit 4 extra features

Zinit 4 comes with the following features that are different from Zinit (@zdharma-continuum fork).

## Ver. 4.0.8
- each plugin has a separate function defined: `@[plugin-id]`; so for example the plugin `psprint/xzmsg` has a function `@psprint/xzmsg`; the function allows quick actions for all plugins, being:
    - `cd` – change directory to plugin dir,
  '  - `load` – load the plugin,
    - `unload` – unload plugin,
    - `update` – update the plugin,
    - `status` – show plugin status (↔ zinit statuus …),
    - `run` – run a command in the plugin dir,
    - `dispose` – `rm -fr` on the plugin dir;

    to run the action pass it as first argument of the plugin *`@function`* of your choice, e.g.: `@psprint/xzmsg cd` (in this example the shell will change CWD to `xzmsg` directory); presentation: [![asciicast](https://asciinema.org/a/609154.svg)](https://asciinema.org/a/609154)
- each plugin (+ some other, distinct location) has a special alias (Zsh internal feature) of the form: `~[plugin-name]`; so for example `psprnit/xzmsg` has `~[psprint/xzmsg]` defined, ponting to the **plugin directory**; you can use the `~[…]` alias in all commands, e.g.: for `cd`; the feature is called "*dynamic directoies*" in zsh documentation,
- the mentioned distinct location are:
    - `~[zplug]` – the plugin dir (`$ZINIT[PLUGINS_DIR`),
    - `~[zsnip]` – the plugin dir (`$ZINIT[SNIPPETS_DIR]`),
    - `~[zcomp]` – the completion dir (`$ZINIT[COMPLETIONS_DIR`),
    - `~[data]` – `~/.local/share` or `$XDG_DATA_HOME`, if set,
    - `~[cache]` – `~/.cache` or `$XDG_CACHE_HOME`, if set,
    - `~[cfg]` – the same, but for `$XDG_CONFIG_HOME`,
    - many others, see the complete list after pressing TAB with cursor after: `~[…]`.

## Ver. 4.0.3
- AppImage distribution ([release link](https://github.com/psprint/Zinit-4/releases/tag/v4.0.1)),
- action complete – press `Alt-Shift-A` or `Alt-Shift-C` to **complete** plugin names and ice modifiers at the command line; asciicast on action-complete9:
  [![asciicast](https://asciinema.org/a/609096.svg)](https://asciinema.org/a/609096)
- themes – set `$ZITHEME` to one of `default`, `blue`.`gold` and `pastel` to pick a color set to use for **`Zinit 4`** messages:
    - default theme:
    ![default](https://github.com/psprint/Zinit-4/blob/main/doc/img/def-in.png?raw=true)
    ![default](https://github.com/psprint/Zinit-4/blob/main/doc/img/def-w.png?raw=true)

    - blue theme:
    ![default](https://github.com/psprint/Zinit-4/blob/main/doc/img/blue-in.png?raw=true)
    ![default](https://github.com/psprint/Zinit-4/blob/main/doc/img/blue-w.png?raw=true)

    - gold theme:
    ![default](https://github.com/psprint/Zinit-4/blob/main/doc/img/gold-in.png?raw=true)
    ![default](https://github.com/psprint/Zinit-4/blob/main/doc/img/gold-w.png?raw=true)

- new ice `build''` which is equivalent of three other ices: `null configure make'install` and simply builds the project from sources, with support for autotools/CMake/Meson/Scons; the project will be installed to `~/.z4` (the default `$ZPFX`, which is cutomizable), see a presentation: [![asciicast](https://asciinema.org/a/609101.svg)](https://asciinema.org/a/609101)
