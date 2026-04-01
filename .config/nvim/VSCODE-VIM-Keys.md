"vim.normalModeKeyBindingsNonRecursive": [
// NAVIGATION
// switch b/w buffers
{
"before": [
"<S-h>"
],
"commands": [
":bprevious"
]
},
{
"before": [
"<S-l>"
],
"commands": [
":bnext"
]
},
// File Tree
{
"before": [
"<leader>",
"e"
],
"commands": [
"workbench.view.explorer"
]
},
// splits
{
"before": [
"leader",
"w",
"v"
],
"commands": [
":vsplit"
]
},
{
"before": [
"leader",
"w",
"h"
],
"commands": [
":split"
]
},
// panes
{
"before": [
"<C-h>"
],
"commands": [
"workbench.action.focusLeftGroup"
]
},
{
"before": [
"<C-j>"
],
"commands": [
"workbench.action.focusBelowGroup"
]
},
{
"before": [
"<C-k>"
],
"commands": [
"workbench.action.focusAboveGroup"
]
},
{
"before": [
"<C-l>"
],
"commands": [
"workbench.action.focusRightGroup"
]
},
// NICE TO HAVE
{
"before": [
"leader",
"f",
"w"
],
"commands": [
":w!"
]
},
{
"before": [
"leader",
"f",
"q"
],
"commands": [
":q!"
]
},
{
"before": [
"leader",
"f",
"x"
],
"commands": [
":x!"
]
},
{
"before": [
"[",
"d"
],
"commands": [
"editor.action.marker.prev"
]
},
{
"before": [
"]",
"d"
],
"commands": [
"editor.action.marker.next"
]
},
{
"before": [
"<leader>",
"c",
"a"
],
"commands": [
"editor.action.quickFix"
]
},
{
"before": [
"leader",
"f",
"f"
],
"commands": [
"workbench.action.quickOpen"
]
},
{
"before": [
"leader",
"f"
],
"commands": [
"editor.action.formatDocument"
]
},
{
"before": [
"g",
"h"
],
"commands": [
"editor.action.showDefinitionPreviewHover"
]
},
// NAVIGATION
// go to match Tag
{
"before": [
"g",
"m",
"t"
],
"commands": [
"editor.emmet.action.matchTag"
]
},
// go to closing bracket/parentheses
{
"before": [
"g",
"m",
"b"
],
"commands": [
"editor.action.jumpToBracket"
]
},
// Collaps all functions
{
"before": [
"c",
"a",
"f"
],
"commands": [
"editor.foldAll"
],
"after": []
},
// Unfold all functions
{
"before": [
"u",
"a",
"f"
],
"commands": [
"editor.unfoldAll"
],
"after": []
},
// Move a file and Move Active file using filebunny
{
"before": [
"leader",
"a",
"f"
],
"command": "filebunny.MoveActiveFile",
"after": []
},
{
"before": [
"leader",
"m",
"f"
],
"command": "filebunny.MoveFile",
"after": []
}
],
"vim.visualModeKeyBindings": [
// Stay in visual mode while indenting
{
"before": [
"<"
],
"commands": [
"editor.action.outdentLines"
]
},
{
"before": [
">"
],
"commands": [
"editor.action.indentLines"
]
},
// toggle comment selection
{
"before": [
"leader",
"c"
],
"commands": [
"editor.action.commentLine"
]
}
],
"vim.insertModeKeyBindings": [
// exit insert mode
{
"before": [
"k",
"j"
],
"commands": [
"extension.vim_escape"
]
},
{
"before": [
"j",
"k"
],
"commands": [
"extension.vim_escape"
]
},
// Tab accept auto complete suggestion
{
"before": [
"<tab>"
],
"commands": [
"acceptSelectedSuggestion"
]
}
],

---

// Place your key bindings in this file to override the defaults
[
// Terminal
{
"key": "ctrl+shift+r",
"command": "workbench.action.terminal.rename",
"when": "terminalFocus"
},
{
"key": "ctrl+shift+n",
"command": "workbench.action.terminal.focusNext",
"when": "terminalFocus"
},
{
"key": "ctrl+shift+p",
"command": "workbench.action.terminal.focusPrevious",
"when": "terminalFocus"
},
{
"key": "ctrl+shift+j",
"command": "workbench.action.togglePanel"
},
{
"key": "ctrl+shift+a",
"command": "workbench.action.terminal.new",
"when": "terminalFocus"
},
{
"key": "ctrl+shift+q",
"command": "workbench.action.terminal.kill",
"when": "terminalFocus"
},
{
"key": "ctrl+shift+m",
"command": "workbench.action.toggleMaximizedPanel",
"when": "terminalFocus"
},
// FILE TREE
{
"command": "workbench.action.toggleSidebarVisibility",
"key": "ctrl+e"
},
{
"command": "workbench.files.action.focusFilesExplorer",
"key": "ctrl+e",
"when": "editorTextFocus"
},
{
"key": "n",
"command": "explorer.newFile",
"when": "filesExplorerFocus && !inputFocus"
},
{
"command": "renameFile",
"key": "r",
"when": "filesExplorerFocus && !inputFocus"
},
{
"key": "shift+n",
"command": "explorer.newFolder",
"when": "explorerViewletFocus"
},
{
"command": "deleteFile",
"key": "d",
"when": "filesExplorerFocus && !inputFocus"
},
{
"key": "ctrl+j",
"command": "selectNextSuggestion",
"when": "suggestWidgetVisible"
},
{
"key": "ctrl+k",
"command": "selectPrevSuggestion",
"when": "suggestWidgetVisible"
},
{
"key": "ctrl+j",
"command": "workbench.action.quickOpenSelectNext",
"when": "inQuickOpen"
},
{
"key": "ctrl+k",
"command": "workbench.action.quickOpenSelectPrevious",
"when": "inQuickOpen"
},
{
"key": "enter",
"command": "list.select",
"when": "listFocus && !inputFocus"
},
{
"key": "shift+k",
"command": "editor.action.showHover",
"when": "editorTextFocus && vim.active && vim.mode != 'Insert'"
},
{
"key": "shift+alt+r",
"command": "editor.action.referenceSearch.trigger",
"when": "editorTextFocus && vim.active && vim.mode != 'Insert'"
},
{
"key": "alt+j",
"command": "editor.action.moveLinesDownAction",
"when": "editorTextFocus && !editorReadonly"
},
{
"key": "alt+k",
"command": "editor.action.moveLinesUpAction",
"when": "editorTextFocus && !editorReadonly"
},
{
"key": "shift+alt+j",
"command": "editor.action.copyLinesDownAction",
"when": "editorTextFocus && !editorReadonly"
},
{
"key": "shift+alt+k",
"command": "editor.action.copyLinesUpAction",
"when": "editorTextFocus && !editorReadonly"
},
// EXTRA
{
"key": "ctrl+shift+5",
"command": "editor.emmet.action.matchTag"
},
{
"key": "ctrl+z",
"command": "workbench.action.toggleZenMode"
},
// Jupyter notebook
{
"key": "i n",
"command": "notebook.cell.edit",
"when": "notebookCellListFocused && notebookEditable && !inputFocus && vim.active && vim.mode != 'Insert'"
},
// { "key": "space l n",
// "command": "notebook.toggleLineNumbers",
// "when": "notebookEditorFocused && !inputFocus"
// },
// edits for disabling default keybindings
{
"key": "shift+l",
"command": "-notebook.toggleLineNumbers",
"when": "notebookEditorFocused && !inputFocus"
},
{
"key": "ctrl+k",
"command": "editor.action.triggerSuggest",
"when": "editorHasCompletionItemProvider && textInputFocus && !editorReadonly && !suggestWidgetVisible"
},
{
"key": "ctrl+space",
"command": "-editor.action.triggerSuggest",
"when": "editorHasCompletionItemProvider && textInputFocus && !editorReadonly && !suggestWidgetVisible"
},
{
"key": "cmd+i",
"command": "composerMode.agent"
},
// edits for disabling default keybindings
// quick new file short cut to ctrl + command + n
{
"key": "cmd+n",
"command": "extension.advancedNewFile"
},
// Move file using file bunny when vim is in normal mode
{
"key": "m f",
"command": "filebunny.moveFile",
"when": "editorTextFocus && vim.mode == 'Normal' && !sideBarFocus "
},
{
"key": "m a f",
"command": "filebunny.moveActiveFile",
"when": "editorTextFocus && vim.mode == 'Normal' && !sideBarFocus"
}
]
