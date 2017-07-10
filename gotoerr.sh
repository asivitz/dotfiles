#!/bin/zsh

# If you have vim in pane 0 and ghcid in pane 1, this will jump to the first error/warning

OP=`tmux capture-pane -p -t 1 | vims -s 'v/:\<enter>nnyVGpVGJ0:s/ //\<enter>0f:d$0P0f:ct/ \<esc>0r+'`

tmux send-keys Escape
tmux send-keys ":e $OP"
tmux send-keys Enter
tmux send-keys 'zz'
