#!/bin/bash
#SBATCH --job-name=o1-wiki1
#SBATCH --partition=csedu
#SBATCH --account=csedui00041
#SBATCH --qos=csedu-normal
#SBATCH --gres=gpu:2
#SBATCH --cpus-per-task=4
#SBATCH --mem=24G
#SBATCH --time=02:00:00
#SBATCH --output=search_o1_wiki1_%j.log

set -e

PROJECT=/vol/csedu-nobackup/course/I00041_informationretrieval/users/lolamiranda/project/deep-research-agent-IR-project
REPO=$PROJECT/total-recall-qa

cd "$REPO"

source "$PROJECT/.venv312/bin/activate"

export OPENAI_API_KEY="password_random"

export HF_HOME="$PROJECT/data/hf_cache"
mkdir -p "$HF_HOME"

export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

python c5_task_evaluation/run_evalution.py \
    --pipeline generation \
    --dataset wikidata \
    --subset test \
    --model Qwen/Qwen2.5-7B-Instruct \
    --generation_method deep_research \
    --deep_research_model search_o1 \
    --retriever spladepp \
    --index_dir data/wiki/full_index \
    --corpus_path data/wiki/data/shared/corpus_wikipedia_en-20251001_rewritten_partial.jsonl \
    --dataset_file dataset/TRQA/Wiki1/test/queries_wiki1_test.jsonl \
    --qrel_file dataset/TRQA/Wiki1/test/trec_qrels_wiki1_test.txt \
    --retrieval_topk 3 \
    --retrieval_eval_ks 3 10 100 1000 \
    --max_iter 20 \
    --devices 0 \
    --run search_o1_wiki1_smoke
