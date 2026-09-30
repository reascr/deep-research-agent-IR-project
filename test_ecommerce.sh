#!/bin/bash
#SBATCH --job-name=trqa-ecommerce
#SBATCH --partition=csedu
#SBATCH --account=csedui00041
#SBATCH --qos=csedu-normal
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=01:00:00
#SBATCH --output=ecommerce_%j.log

set -e

cd /vol/csedu-nobackup/course/I00041_informationretrieval/users/lolamiranda/project/total-recall-qa

source .venv312/bin/activate

export HF_HOME="$PWD/data/hf_cache"
mkdir -p "$HF_HOME"

python c5_task_evaluation/run_evalution.py \
    --pipeline retrieval \
    --dataset synthetic_ecommerce \
    --subset test \
    --retriever spladepp \
    --index_dir data/ecommerce \
    --corpus_path data/trqa/data/ecommerce/corpus_ecommerce_rewritten.jsonl \
    --dataset_file dataset/TRQA/E-Commerce/test/queries_ecommerce_test.jsonl \
    --qrel_file dataset/TRQA/E-Commerce/test/trec_qrels_ecommerce_test.txt \
    --retrieval_eval_ks 3 10 100 1000 \
    --devices 0 \
    --run ecommerce_full

