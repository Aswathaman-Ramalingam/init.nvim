neovim-project-init
====================

Interactive Neovim plugin to bootstrap new projects (React, Vite, Maven, Angular, Vue) using a Telescope picker and a single command.

Quick start
-----------

1. Add to your runtime path or plugin manager.
2. Ensure dependencies are available in `$PATH` (npm, npx, mvn, etc.).
3. Launch `:Init` and pick a stack.

Features
--------

- Interactive stack selection via Telescope (falls back to inputlist).
- Prompts for project name and target directory.
- Executes scaffold commands using system tools.
- Extensible generators via `lua/project-init/generators/`.

Commands
--------

- `:Init` — Open the project initializer picker.
- `:InitStacks` — Show available stacks.
- `:InitHere` — Initialize a project in the current working directory.

Configuration
-------------

You can pass a config table to `require('project-init').setup({ ... })` with custom stacks.

Example:

```lua
require('project-init').setup({
  stacks = {
    react = { label = 'React (CRA)' },
  },
  post_actions = {
    open_dir = true,
  },
})
```

License
-------

MIT

