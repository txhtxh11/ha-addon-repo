# Home Assistant Addon 仓库重建与GitHub推送指南

## 简介
这个指南将帮助你手动重建Home Assistant Addon仓库并推送到GitHub。即使你是小白用户，按照步骤操作也能成功。

## 第一步：环境准备

### 1.1 安装必要工具
```bash
# 更新系统
sudo apt update && sudo apt upgrade -y

# 安装Git
sudo apt install git -y

# 安装Docker（用于构建插件）
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

# 将用户添加到docker组（避免每次用sudo）
sudo usermod -aG docker $USER
# 注：需要重新登录生效
```

### 1.2 配置Git
```bash
# 设置你的Git身份
git config --global user.name "你的名字"
git config --global user.email "你的邮箱@example.com"

# 生成SSH密钥（用于GitHub认证）
ssh-keygen -t ed25519 -C "你的邮箱@example.com"
# 按Enter接受默认设置
# 可以设置密码（可选）

# 查看公钥并复制
cat ~/.ssh/id_ed25519.pub
```

### 1.3 将SSH密钥添加到GitHub
1. 登录GitHub
2. 点击右上角头像 → Settings
3. 左侧菜单选择 SSH and GPG keys
4. 点击 New SSH key
5. 粘贴刚才复制的公钥
6. 点击 Add SSH key

## 第二步：手动重建仓库

### 2.1 创建项目目录
```bash
# 创建目录
mkdir -p ~/ha-addon-repo
cd ~/ha-addon-repo
```

### 2.2 创建repository.json
```bash
cat > repository.json << 'EOF'
{
    "name": "ESPHome YAML Generator",
    "url": "https://github.com/你的用户名/ha-addon-repo",
    "maintainer": "你的名字 <你的邮箱@example.com>"
}
EOF
```

### 2.3 创建插件目录结构
```bash
# 创建插件目录
mkdir -p esphome_yaml_generator

# 创建config.yaml（插件配置文件）
cat > esphome_yaml_generator/config.yaml << 'EOF'
name: "ESPHome YAML Generator"
version: "1.0.0"
slug: "esphome_yaml_generator"
description: "Generate ESPHome YAML configurations with HomeKit support"
arch:
  - armhf
  - armv7
  - aarch64
  - amd64
  - i386
startup: "application"
boot: "auto"
ports:
  "8080/tcp": 8080
ports_description:
  "8080/tcp": "Web interface"
host_network: false
host_dbus: false
privileged:
  - SYS_ADMIN
  - SYS_RAWIO
full_access: false
apparmor: false
options:
  log_level: info
schema:
  log_level: list(info|warning|error)
EOF

# 创建Dockerfile
cat > esphome_yaml_generator/Dockerfile << 'EOF'
ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache python3 py3-pip git curl bash
WORKDIR /app
COPY . /app
RUN pip3 install flask pyyaml esphome
RUN chmod a+x /app/run.sh
EXPOSE 8080
CMD [ "/app/run.sh" ]
EOF

# 创建启动脚本
cat > esphome_yaml_generator/run.sh << 'EOF'
#!/usr/bin/env bash
set -e
echo "Starting ESPHome YAML Generator..."
python3 /app/app.py
EOF

# 创建简单的Python应用
cat > esphome_yaml_generator/app.py << 'EOF'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "ESPHome YAML Generator is running!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
EOF

# 设置脚本权限
chmod +x esphome_yaml_generator/run.sh
```

### 2.4 验证目录结构
```bash
# 检查创建的文件
ls -la
ls -la esphome_yaml_generator/

# 应该看到：
# repository.json
# esphome_yaml_generator/
#   ├── config.yaml
#   ├── Dockerfile
#   ├── run.sh
#   └── app.py
```

## 第三步：推送到GitHub

### 3.1 在GitHub创建仓库
1. 登录GitHub
2. 点击右上角 "+" → "New repository"
3. 填写信息：
   - Repository name: `ha-addon-repo`
   - Description: `Home Assistant Addon for ESPHome YAML Generator`
   - 选择 Public（公开）或 Private（私有）
   - **重要**：不要勾选 "Initialize this repository with a README"
   - 不要添加 .gitignore 或 license
4. 点击 "Create repository"

### 3.2 初始化本地Git仓库
```bash
cd ~/ha-addon-repo

# 初始化Git
git init

# 添加所有文件
git add .

# 提交更改
git commit -m "Initial commit: ESPHome YAML Generator addon"

# 查看状态
git status
```

### 3.3 连接到GitHub远程仓库
```bash
# 添加远程仓库（替换YOUR_USERNAME为你的GitHub用户名）
git remote add origin git@github.com:YOUR_USERNAME/ha-addon-repo.git

# 验证连接
git remote -v
# 应该显示：
# origin  git@github.com:YOUR_USERNAME/ha-addon-repo.git (fetch)
# origin  git@github.com:YOUR_USERNAME/ha-addon-repo.git (push)
```

### 3.4 推送代码
```bash
# 首次推送（设置上游分支）
git branch -M main
git push -u origin main

# 如果看到类似以下输出，说明成功：
# Enumerating objects: 15, done.
# Counting objects: 100% (15/15), done.
# Writing objects: 100% (15/15), 2.34 KiB | 2.34 MiB/s, done.
# Total 15 (delta 0), reused 0 (delta 0), pack-reused 0
# To github.com:YOUR_USERNAME/ha-addon-repo.git
#  * [new branch]      main -> main
# Branch 'main' set up to track remote branch 'main' from 'origin'.
```

### 3.5 验证推送成功
1. 刷新你的GitHub仓库页面
2. 应该能看到所有文件
3. 可以点击文件查看内容

## 第四步：在Home Assistant中使用

### 4.1 添加仓库到Home Assistant
1. 打开Home Assistant
2. 进入 Supervisor → Add-on Store
3. 点击右上角三个点 → Repositories
4. 添加你的仓库URL：`https://github.com/你的用户名/ha-addon-repo`
5. 点击 "Add"

### 4.2 安装插件
1. 刷新页面
2. 应该能看到 "ESPHome YAML Generator" 插件
3. 点击插件 → Install
4. 等待安装完成
5. 点击 Start 启动插件

### 4.3 访问插件
1. 插件启动后，点击 "Open Web UI"
2. 或者访问：`http://你的ha地址:8080`
3. 应该看到 "ESPHome YAML Generator is running!"

## 常见问题解决

### 问题1: Git推送权限被拒绝
```
错误: Permission denied (publickey)
```
**解决：**
```bash
# 测试SSH连接
ssh -T git@github.com
# 应该看到: Hi USERNAME! You've successfully authenticated...

# 如果没有，检查SSH代理
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### 问题2: 分支名称错误
```
错误: error: src refspec main does not match any
```
**解决：**
```bash
# 查看当前分支
git branch

# 如果显示master而不是main
git branch -M master main
# 或者
git push -u origin master
```

### 问题3: 远程仓库已存在内容
```
错误: Updates were rejected because the remote contains work...
```
**解决：**
```bash
# 拉取远程更改并合并
git pull origin main --allow-unrelated-histories
# 解决可能的冲突
git push
```

### 问题4: 忘记GitHub仓库URL
```bash
# 查看已配置的远程仓库
git remote -v

# 如果没有，重新添加
git remote add origin git@github.com:YOUR_USERNAME/ha-addon-repo.git
```

## 后续维护

### 更新插件
```bash
cd ~/ha-addon-repo

# 修改文件
# 例如更新版本号：编辑 esphome_yaml_generator/config.yaml

# 提交更改
git add .
git commit -m "更新到版本 x.x.x"
git push
```

### 从GitHub克隆（在其他电脑上）
```bash
# 克隆仓库
git clone git@github.com:YOUR_USERNAME/ha-addon-repo.git

# 或使用HTTPS
git clone https://github.com/YOUR_USERNAME/ha-addon-repo.git
```

### 备份项目
```bash
# 创建压缩备份
cd ~
tar -czf ha-addon-repo-backup-$(date +%Y%m%d).tar.gz ha-addon-repo/

# 备份到其他位置
scp ha-addon-repo-backup-*.tar.gz user@backup-server:/backup/
```

## 快速命令参考

```bash
# Git基础命令
git init                    # 初始化仓库
git add .                   # 添加所有文件
git commit -m "消息"        # 提交更改
git push                    # 推送到远程
git pull                    # 拉取更新
git status                  # 查看状态

# 目录操作
pwd                        # 显示当前目录
ls -la                     # 列出文件
cd 目录名                  # 切换目录
mkdir 目录名               # 创建目录

# 文件操作
cat 文件名                 # 查看文件
vim 文件名                 # 编辑文件
cp 源文件 目标文件         # 复制文件
rm 文件名                  # 删除文件
```

## 需要帮助？

1. **查看GitHub文档**: https://docs.github.com
2. **搜索错误信息**: 复制错误到Google搜索
3. **检查文件权限**: `ls -la` 查看文件
4. **验证网络连接**: `ping github.com`

---

**完成标志**：
✅ 在GitHub看到你的仓库
✅ Home Assistant能添加这个仓库
✅ 插件能正常安装和启动

按照这个指南，你应该能成功重建并推送到GitHub。如果有问题，回头检查对应步骤。

祝你好运！ 🚀