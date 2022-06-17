#!/bin/bash
if [[ $# -ne 8 ]]; then
    echo "Please set 8 parameters: audio file; prompt string; aux-folder;  output folder; HCLG folder; mdl folder; conf folder; beam"
    echo "./run_nl.sh audios/fn000049_1_001.wav "`cat prompts/fn000049_1_001.prompt`" sox results exp/tdnn1a_sp_bi_online/graph_s exp/tdnn1a_sp_bi_online exp/tdnn1a_sp_bi_online/conf 20"
    exit 2
fi

###. ./cmd.sh
###. ./path.sh

wav_input=$1
prompt=$2
sox=$3
output_folder=$4
mkdir -p $sox $output_folder
graph_s="$5"
model_s="$6"
conf_s="$7"
words=$graph_s/words.txt
hclg=$graph_s/HCLG.fst
mdl=$model_s/final.mdl
config=$conf_s/online.conf



#############################
aux_name=`basename "$wav_input"`
output=$output_folder/$aux_name.txt
wav_output=$sox/$aux_name
sox $wav_input -r 16000 -c 1 -b 16 $wav_output
scp_output=$wav_output.scp

echo "utterance-id1 $wav_output" > $scp_output

online2-wav-nnet3-latgen-faster-force \
    --do-endpointing=false \
    --frames-per-chunk=20 \
    --extra-left-context-initial=0 \
    --online=false \
    --frame-subsampling-factor=3 \
    --config=$config \
    --min-active=200 \
    --max-active=7000 \
    --beam="$8" \
    --lattice-beam=7.0 \
    --acoustic-scale=1.0 \
    --word-symbol-table=$words \
    $mdl \
    $hclg \
    $scp_output \
    $output \
    "$prompt"

#cat $output
