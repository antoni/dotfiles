#!/usr/bin/env bash

# Check for required arguments
if [[ $# -lt 1 ]]; then
	echo "Usage: $0 <audio_file> [model_size]"
	echo "Example: $0 audio.mp3 medium"
	exit 1
fi

# Input audio file and model
AUDIO_INPUT="$1"
MODEL_SIZE="${2:-medium}" # default to "medium" if not specified

# Ensure required packages are installed
# echo "🔧 Installing dependencies..."
# sudo apt update
# sudo apt install -y build-essential cmake git ffmpeg wget

# # Clone whisper.cpp if not already present
# if [[ ! -d whisper.cpp ]]; then
#   echo "📦 Cloning whisper.cpp..."
#   git clone https://github.com/ggerganov/whisper.cpp
# fi

# cd whisper.cpp || exit 1

# # Build whisper.cpp if not already built
# if [[ ! -f main ]]; then
#   echo "🛠️ Building whisper.cpp..."
#   make
# fi

# # Download model if not already present
# MODEL_FILE="models/ggml-${MODEL_SIZE}.bin"
# if [[ ! -f "$MODEL_FILE" ]]; then
#   echo "⬇️ Downloading model: $MODEL_SIZE..."
#   ./models/download-ggml-model.sh "$MODEL_SIZE"
# fi

# Convert input audio to WAV format if necessary
# WAV_FILE="../converted.wav"
# echo "🎧 Converting input audio to WAV format..."
# ffmpeg -y -i "$AUDIO_INPUT" -ar 16000 -ac 1 -c:a pcm_s16le "$WAV_FILE"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/antoni/tmp/whisper.cpp/build/src/

# Transcribe audio
echo "📝 Transcribing audio to Polish..."
./bin/whisper-cli -m "$MODEL_FILE" -f "$WAV_FILE" -l pl >../transcription.txt

echo "✅ Transcription saved to transcription.txt"
