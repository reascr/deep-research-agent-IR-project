#!/bin/bash
#SBATCH --job-name=trqa-wiki1
#SBATCH --partition=csedu
#SBATCH --account=csedui00041
#SBATCH --qos=csedu-normal
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=01:00:00
#SBATCH --output=wiki1_%j.log

set -e

cd /vol/csedu-nobackup/course/I00041_informationretrieval/users/lolamiranda/project/total-recall-qa

source .venv312/bin/activate

export HF_HOME="$PWD/data/hf_cache"
mkdir -p "$HF_HOME"

python c5_task_evaluation/run_evalution.py \
    --pipeline retrieval \
    --dataset wikidata \
    --subset test \
    --retriever spladepp \
    --index_dir data/wiki/full_index \
    --corpus_path data/wiki/data/shared/corpus_wikipedia_en-20251001_rewritten_partial.jsonl \
    --dataset_file dataset/TRQA/Wiki1/test/queries_wiki1_test.jsonl \
    --qrel_file dataset/TRQA/Wiki1/test/trec_qrels_wiki1_test.txt \
    --retrieval_eval_ks 3 10 100 1000 \
    --devices 0 \
    --run wiki1_full