#!/bin/bash

# 上传镜像文件到 Hugging Face
# 仓库: fuyikun/Mac-in-docker-OpenClaw

set -e

# 配置
REPO_ID="fuyikun/Mac-in-docker-OpenClaw"

# 要上传的文件列表
FILE1="/home/fuyikun/Documents/ckpt/vone/mac_hdd_ng.img"
FILE2="/home/fuyikun/Documents/BaseSystem.img"

# 添加 PATH
export PATH="$HOME/.local/bin:$PATH"

echo "=========================================="
echo "上传文件到 Hugging Face"
echo "=========================================="
echo "仓库: $REPO_ID"
echo ""

# 检查文件是否存在
for FILE in "$FILE1" "$FILE2"; do
    if [ ! -f "$FILE" ]; then
        echo "错误: 文件不存在 - $FILE"
        exit 1
    fi
    FILE_SIZE=$(ls -lh "$FILE" | awk '{print $5}')
    echo "文件: $FILE ($FILE_SIZE)"
done
echo ""

# 登录 Hugging Face
echo "正在登录 Hugging Face..."
hf auth login --token "$HF_TOKEN"
echo ""

# 上传文件1: mac_hdd_ng.img (45GB)
echo "=========================================="
echo "[1/2] 正在上传 mac_hdd_ng.img (45GB，可能需要较长时间)..."
echo "=========================================="
hf upload "$REPO_ID" "$FILE1" "mac_hdd_ng.img" \
    --commit-message "Upload mac_hdd_ng.img disk image"
echo ""

# 上传文件2: BaseSystem.img (827MB)
echo "=========================================="
echo "[2/2] 正在上传 BaseSystem.img (827MB)..."
echo "=========================================="
hf upload "$REPO_ID" "$FILE2" "BaseSystem.img" \
    --commit-message "Upload BaseSystem.img"
echo ""

echo "=========================================="
echo "所有文件上传完成!"
echo "查看仓库: https://huggingface.co/$REPO_ID"
echo "=========================================="
