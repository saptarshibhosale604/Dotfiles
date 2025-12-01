#!/bin/bash

# Ask for user input
# read -p "Enter the string: " input
# Take the first command line argument as input
input="$1"
# input="Hey there"
# printf "$input"

# Generate figlet output and save to an array
mapfile -t figlet_lines < <(figlet "$input")
# printf "$figlet_lines"
# exit
# Find the max length of the figlet output lines
max_len=0
for line in "${figlet_lines[@]}"; do
  (( ${#line} > max_len )) && max_len=${#line}
done

# Set padding and box width
padding=2
# box_width=$((max_len + padding * 2))
# printf "max len $max_len \n"
box_width=$((max_len + padding * 2))

# Function to print top or bottom border line
print_border() {
	for ((i=0; i<(box_width+4)/2; i++)); do
    printf "# "
  done
  printf "\n"
}

# Print title
printf "## ${input} ##\n"

# Print the box with figlet content
print_border
for line in "${figlet_lines[@]}"; do
  # Pad each line to max length
  printf "# %-${box_width}s #\n" "  $line"
done

# Print an empty padded line after figlet
printf "# %-${box_width}s #\n" ""

print_border

