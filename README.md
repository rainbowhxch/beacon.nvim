# beacon.nvim

Whenever cursor jumps some distance or moves between windows, it will flash so you can see where it is. This plugin is just rewrited from [beacon.nvim](https://github.com/DanilaMihailov/beacon.nvim) in Lua.

## Requirements
- Neovim latest stable version or nightly

## Installation
You can install `beacon.nvim` with your favorite package manager.

vim-plug:
```lua
Plug 'rainbowhxch/beacon.nvim'
```
packer.nvim:
```lua
use { 'rainbowhxch/beacon.nvim' }
```

After installation, it should be used out of the box. Just enjoy it.

## Configuration
If you stasify the default configuration, nothing is need to changed. Otherwise you can call 'require("beacon").setup()' to change the its behavior. The default configuration is:

```lua
require('beacon').setup({
	enable = true,
	size = 40,
	fade = true,
	minimal_jump = 10,
	show_jumps = true,
	focus_gained = false,
	shrink = true,
	timeout = 500,
	ignore_buffers = {},
	ignore_filetypes = {},
})
```

All configuration is here:

- `enable`	    bool (default:true)

Whether to enable the plugin. When beacon is disabled, you can still use
|:Beacon| command to highlight cursor.

- `size` - int (default:40)

Beacon size.

- `fade` - bool (default:true)

Whether to enable fading animation.

- `minimal_jump` - int (default:10)

The jump length which beacon considers significant jump.

- `show_jumps` - bool (default:true)

When set `false`, it will ignore jumps inside buffer.

- `focus_gained` - bool (default:false)

Whether to flash when focus is gained.

- `shrink` - bool (default:true)

Whether to enable shrinking animation.

- `timeout` - int (default:500)

Flash timeout.

- `ignore_buffers` - list (default:{})

To ignore a buffer you can add its name to this list.

- `ignore_filetypes` - list (default:{})

TO ignore a filetype you can add it to this list.

## Commands
- `:Beacon`: highlight current position (even if plugin is disabled)
- `:BeaconToggle`: toggle beacon enable/disable

## Highlights
Beacon is highlighted by `Beacon` group, so you can change it like this:

```vim
    highlight Beacon guibg=white ctermbg=15
```

## Copyright
This plugin is distributed under MIT License.

    Copyright (c) 2022 rainbowhxch

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
    of the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
    INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
    PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
    THE USE OR OTHER DEALINGS IN THE SOFTWARE.
