#!/bin/bash
for dir in /root /home/*; do
  src="$dir/.mongodb/mongosh/mongosh_repl_history"
  dst="$dir/.mongodb/mongosh/mongosh_repl_history_reversed"
  if [[ -f "$src" ]]; then
    # append only new lines: filebeat tails the file, so mv/truncate would reset its read position
    existing_lines=$(wc -l < "$dst" 2>/dev/null || echo 0)
    skip=$((existing_lines + 1))
    # echo ensures file ends with a newline; tac would otherwise merge the last two lines
    (cat "$src"; echo) | tac | tail -n +"$skip" >> "$dst"
  fi
done
