#!/bin/bash
#SBATCH --job-name=wiki-splade-test
#SBATCH --partition=csedu
#SBATCH --account=csedui00041
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=00:30:00
#SBATCH --output=wiki_smoke_%j.log

cd /vol/csedu-nobackup/course/I00041_informationretrieval/users/lolamiranda/project/total-recall-qa

source .venv312/bin/activate

export HF_HOME="$PWD/data/hf_cache"
export OMP_NUM_THREADS=4
mkdir -p "$HF_HOME"

python c2_corpus_creation/index_builder.py \
    --retrieval_method spladepp \
    --corpus_path data/wiki/wiki_smoke_100.jsonl \
    --save_dir data/wiki/smoke_index \
    --batch_size 4 \
    --max_length 256
