#!/bin/bash
#SBATCH --job-name=wiki-splade-full
#SBATCH --partition=csedu
#SBATCH --account=csedui00041
#SBATCH --qos=csedu-large
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=24:00:00
#SBATCH --output=wiki_full_%j.log

cd /vol/csedu-nobackup/course/I00041_informationretrieval/users/lolamiranda/project/total-recall-qa

source .venv312/bin/activate

export HF_HOME="$PWD/data/hf_cache"
export OMP_NUM_THREADS=4
mkdir -p "$HF_HOME"

python c2_corpus_creation/index_builder.py \
    --retrieval_method spladepp \
    --corpus_path data/wiki/data/shared/corpus_wikipedia_en-20251001_rewritten_partial.jsonl \
    --save_dir data/wiki/full_index \
    --batch_size 4 \
    --max_length 256
