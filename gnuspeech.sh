# This script allows you to simple run a command like
#
# gnuspeech "Speak a test string" to output a sentence as an mp3
#

function gnuspeech {
  speech_string=$@
  mp3_name=${speech_string// /_}.mp3
  touch trm_param_file.txt;
  gnuspeech_sa -c /gnuspeech/data/en/ -p trm_param_file.txt -o output.wav \"$speech_string\"
  lame -V2 output.wav $mp3_name
  rm output.wav
}
