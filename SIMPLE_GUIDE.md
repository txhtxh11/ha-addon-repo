# 最简单GitHub推送指南

## 📍 文件位置
所有操作都在：`/home/t/ha-addon-repo`

## 🚀 首次推送（第一次）

### 1. 准备GitHub仓库
1. 登录 https://github.com
2. 点击右上角 "+" → "New repository"
3. 填写：
   - Repository name: `ha-addon-repo`
   - **重要**：不要勾选 "Initialize this repository with a README"
4. 点击 "Create repository"

### 2. 设置Git身份（一次性的）
```bash
cd /home/t/ha-addon-repo
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
```

### 3. 初始化并推送
```bash
cd /home/t/ha-addon-repo
git init
git add .
git commit -m "第一次提交"
git branch -M main
git remote add origin git@github.com:你的用户名/ha-addon-repo.git
git push -u origin main
```

## 🔄 后续更新推送

### 1. 修改文件后推送
```bash
cd /home/t/ha-addon-repo
# 修改你的文件...

git add .
git commit -m "更新描述"
git push
```

### 2. 三行命令搞定更新
```bash
cd /home/t/ha-addon-repo
git add . && git commit -m "更新" && git push
```

## ⚡ 超简版命令总结

### 首次推送（按顺序执行）：
```bash
cd /home/t/ha-addon-repo
git init
git add .
git commit -m "first"
git branch -M main
git remote add origin git@github.com:用户名/ha-addon-repo.git
git push -u origin main
```

### 后续更新（每次都这样）：
```bash
cd /home/t/ha-addon-repo
git add .
git commit -m "update"
git push
```

## ❗ 常见问题

### 如果推送失败：
```bash
# 1. 拉取最新代码
git pull origin main

# 2. 重新推送
git push
```

### 如果忘记GitHub地址：
```bash
git remote -v
```

### 如果文件太多，只推送某个文件：
```bash
git add 文件名
git commit -m "更新某个文件"
git push
```

## ✅ 验证成功
1. 刷新你的GitHub页面：https://github.com/你的用户名/ha-addon-repo
2. 看到文件列表 = 成功！

---

**记住**：所有操作都在 `/home/t/ha-addon-repo` 目录下进行。

**更新流程永远三步骤**：
1. `git add .`
2. `git commit -m "描述"`
3. `git push`

完成！ 🎉