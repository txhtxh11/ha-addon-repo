#!/bin/bash
# push.sh - 智能推送脚本（支持首次和后续推送）
# 用法: ./push.sh "提交描述"

cd /home/t/ha-addon-repo

# 设置提交信息
if [ $# -eq 0 ]; then
    commit_msg="update"
else
    commit_msg="$1"
fi

echo "📦 检查Git仓库..."

# 检查是否是首次推送
if [ ! -d ".git" ]; then
    echo "🆕 首次推送：初始化Git仓库..."
    git init
    git add .
    git commit -m "首次提交"
    
    echo "🔗 请设置远程仓库URL："
    echo "git remote add origin https://令牌@github.com/用户名/ha-addon-repo.git"
    echo "git branch -M main"
    echo "git push -u origin main"
    echo ""
    echo "⚠️  请先运行上面的命令完成首次推送"
    exit 1
fi

# 检查是否有远程仓库
if ! git remote | grep -q origin; then
    echo "❌ 未设置远程仓库"
    echo "请运行：git remote add origin https://令牌@github.com/用户名/ha-addon-repo.git"
    exit 1
fi

# 正常推送流程
echo "📦 添加文件..."
git add .

echo "💾 提交: $commit_msg"
git commit -m "$commit_msg"

echo "🚀 推送到GitHub..."
git push

echo "✅ 完成!"