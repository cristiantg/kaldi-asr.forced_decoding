  #!/bin/bash
  . ./cmd.sh
  . ./path.sh
  
  # Set the paths accordingly:
  model=/vol/tensusers4/ctejedor/lanewcristianmachine/opt/kaldi/egs/aspire/s5/exp/tdnn_7b_chain_online
  words=$model/graph_pp/words.txt
  hclg=$model/graph_pp/HCLG.fst
  config=$model/conf/online.conf
  mdl=$model/final.mdl
  wav_input="100101.G_TTS.wav"
  output=result.txt
  
  wav_output=_$wav_input
  sox $wav_input -r 8000 -c 1 -b 16 $wav_output
  echo "utterance-id1 $PWD/$wav_output" > $PWD/wav.scp
  
  online2-wav-nnet3-latgen-faster-force \
      --do-endpointing=true \
      --frames-per-chunk=20 \
      --extra-left-context-initial=0 \
      --online=false \
      --frame-subsampling-factor=3 \
      --config=$config \
      --min-active=200 \
      --max-active=6000 \
      --beam=16 \
      --lattice-beam=6.0 \
      --acoustic-scale=1.0 \
      --word-symbol-table=$words \
      $mdl \
      $hclg \
      $PWD/wav.scp \
      $PWD/$output \
      'would you like chicken or beef'
  
  cat $output
