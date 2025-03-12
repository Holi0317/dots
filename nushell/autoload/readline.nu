$env.config.edit_mode = 'vi'

def _fzf_history [] {
  history
  | each { $in.command }
  | uniq
  | reverse
  | str join (char -i 0)
  | fzf --scheme=history --read0 --tiebreak=chunk --layout=reverse --height=70% -q (commandline)
  | decode utf-8
  | str trim
  | commandline edit --replace $in
}

def _fzf_path [] {
  let line = commandline
  | str substring 0..(commandline get-cursor)

  let query = if ($line | str ends-with ' ') {''} else {
    $line
    | split words
    | reverse
    | get 0?
    | default ''
  }

  fzf --height=40% --layout=reverse --walker=file,dir,follow,hidden -m --scheme=path -q $query
  | decode utf-8
  | str trim
  | commandline edit -i $in
}

$env.config.keybindings = $env.config.keybindings?
| default []
| append [
  {
    name: clear_line
    modifier: control
    keycode: char_u
    mode: [emacs, vi_insert, vi_normal]
    event: { edit: Clear }
  }

  # # Search history with fzf
  # # See https://github.com/nushell/nushell/issues/1616#issuecomment-1902732666
  # {
  #   name: fzf_history
  #   modifier: control
  #   keycode: char_r
  #   mode: [emacs, vi_insert, vi_normal]
  #   event: {
  #     send: executehostcommand
  #     cmd: "_fzf_history"
  #   }
  # }

  {
    name: fzf_path
    modifier: control
    keycode: char_t
    mode: [emacs, vi_insert, vi_normal]
    event: {
      send: executehostcommand
      cmd: "_fzf_path"
    }
  }
]

$env.config.menus = $env.config.menus?
| default []
| append [
  {
    name: completion_menu
    only_buffer_difference: false # Search is done on the text written after activating the menu
    marker: "| "                  # Indicator that appears with the menu is active
    type: {
      layout: columnar          # Type of menu
      columns: 4                # Number of columns where the options are displayed
      col_width: 20             # Optional value. If missing all the screen width is used to calculate column width
      col_padding: 2            # Padding between columns
    }
    style: {
      text: default
      selected_text: green_reverse
      description_text: yellow
    }
  }
]
