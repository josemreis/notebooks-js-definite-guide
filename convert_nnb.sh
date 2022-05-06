# !/bin/bash

# store current path
current_path="$PWD"
# cd to root dir
cd 
# check if the nnb_converter dir is present
nnb_converter_path=$(find "$(cd ..; pwd)" -name "nnb_converter")
# back to current dir
cd "$(dirname "$current_path/$0")"
# clone it
# # if not git clone it
if [ -z "${nnb_converter_path}" ]; then
    # clone it
    git clone git@github.com:josemreis/nnb_converter.git
    nnb_converter_path="$PWD/nnb_converter"
fi
## Loop across each sub-directory and convert to md and js
for d in */ ; do
    for file in $d*.nnb ; do
        to_convert="$current_path/$file"
        echo $to_convert
        python3 "$nnb_converter_path/nnb_converter.py" -f "$to_convert" -o "md" # to markdown
        python3 "$nnb_converter_path/nnb_converter.py" -f "$to_convert" -o "js" # convert to js
    done
done