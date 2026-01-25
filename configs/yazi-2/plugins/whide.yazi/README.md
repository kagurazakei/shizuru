# whide.yazi

A plugin for [yazi](https://github.com/sxyazi/yazi) to hide/unhide files or folders in windows.

## Installation

```sh
ya pkg add 'Tyarel8/whide'
```

## Usage

Add this to your `keymap.toml`:

```toml
[manager]
prepend_keymap = [
  { on   = [ "'", "h" ], run  = "plugin whide --args='hide'", desc = "Hide files" },
  { on   = [ "'", "H" ], run  = "plugin whide --args='unhide'", desc = "Unhide files" },
  { on   = [ "'", "<A-h>" ], run  = "plugin whide --args='toggle'", desc = "Toggle hidden status" },
]
```

It will apply to all selected or hovered if there is no selection.

> [!IMPORTANT]
> When hiding a file, yazi will either show the file still normal, or show the file hidden
> along with the previous normal file until you do something
> like opening a new tab or closing yazi and opening it again.


