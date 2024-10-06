#!/bin/bash

#
# tmux stuff
#

# 0. Install tmux ----
sudo apt install -y tmux

# 1. Create a new session
tmux new -s <session_name> # e.g. mysession


# 2. Detach/re-attach from session ----

# For detach: press `Ctrl+b` then `d`
# For re-attach: 
# -- to last session
tmux a
# -- to specific session
tmux ls # list all sessions
tmux attach -t <session_name> # re-attach to session


# 3. Split window ----
# For horizontal split: press `Ctrl+b` then `%`
# For vertical split: press `Ctrl+b` then `"`

# To navigate between panes: press `Ctrl+b` then arrow keys

# To close pane: press `Ctrl+b` then `x`


# 4. Kill session ----
# Inside tmux: press `Ctrl+b` then `:kill-session`

# Outside tmux:
tmux kill-session -t myname

# References ----
# 1. https://linuxize.com/post/getting-started-with-tmux/
# 2. https://gist.github.com/MohamedAlaa/2961058
