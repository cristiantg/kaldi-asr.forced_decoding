#!/bin/bash
if [[ $# -ne 9 ]]; then
    echo "Please set 9 parameters: results_folder, wav_folder, prompt_folder, prompt_extension and aux_folder, graph_s, tdnn1a_sp_bi_online; tdnn1a_sp_bi_online/conf; 20"
    # nohup time ./uber_nl.sh $current $wav_folder $prompt_folder $prompt_ext $aux_folder $graph_s $model_s $conf_s 20 &
    exit 2
fi

. ./cmd.sh
. ./path.sh


results_folder=$1
wav_folder=$2
prompt_folder=$3
prompt_ext=$4
aux_folder=$5
graph_s="$6"
model_s="$7"
conf_s="$8"
beam="$9"

for d in $wav_folder/*; do
    filename=$(basename -- "$d")
    #extension="${filename##*.}"
    filename="${filename%.*}"
    #ls -lt 
    ./run_nl.sh $d "`cat $prompt_folder/$filename$prompt_ext`" $aux_folder $results_folder $graph_s $model_s $conf_s $beam
done

rm -r $aux_folder