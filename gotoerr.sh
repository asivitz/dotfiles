#!/bin/zsh

# If you have vim in pane 0 and ghcid in pane 1, this will jump to the first error/warning

OP=`tmux capture-pane -p -t 1 | vims -s 'v/:\<enter>nelyVGp:%s/\\\\n//g\<enter>0f:d$0Ps) \<esc>0s+call\\\\ cursor(\<esc>f:r,'`

tmux send-keys Escape
tmux send-keys ":e $OP"
tmux send-keys Enter
tmux send-keys 'zz'
