# Force_decoding scripts
Scripts for using the Kaldi tool: force_decoding https://github.com/cristiantg/kaldi-asr.forced_decoding

'''
vim path.sh 
'''

# English:
You need to modify the wav file path inside this file:

'''
./run.sh
'''

# Dutch:

./run_nl.sh

'''
nohup time ./uber_nl.sh $current $wav_folder $prompt_folder $prompt_ext $aux_folder $graph_s $model_s $conf_s 20 &

'''