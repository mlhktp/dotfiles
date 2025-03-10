#! /bin/bash

bar=" ▁▂▃▄▅▆▇█"
dict="s/;//g;"

# Build the sed substitution dictionary.
i=0
while [ $i -lt ${#bar} ]; do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i+1))
done

# Ensure the pipe is fresh.
pipe="/tmp/cava.fifo"
[ -p "$pipe" ] && unlink "$pipe"
mkfifo "$pipe"

# Write cava config.
config_file="/tmp/polybar_cava_config"
cat <<EOF > "$config_file"
[general]
bars = 60

[output]
method = raw
raw_target = $pipe
data_format = ascii
ascii_max_range = 8
EOF

# Start cava in the background.
cava -p "$config_file" &

# Read and process data from the FIFO using a single sed instance.
sed -u "$dict" < "$pipe"

