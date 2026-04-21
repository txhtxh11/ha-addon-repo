# 极简推送指南

## 首次推送
```bash
cd /home/t/ha-addon-repo
git init
git add .
git commit -m "first"
git remote add origin https://令牌@github.com/用户名/ha-addon-repo.git
git push -u origin main
```

## 后续推送（用脚本）
```bash
cd /home/t/ha-addon-repo
./push.sh "更新描述"
```

## 脚本用法
```bash
./push.sh                  # 默认提交信息"update"
./push.sh "修复bug"        # 自定义提交信息
```

## 个人令牌配置
1. GitHub → Settings → Developer settings → Personal access tokens
2. 创建token，勾选repo权限
3. 复制token
4. 在remote URL中使用：`https://令牌@github.com/用户名/仓库.git`

## 三行命令搞定一切
```bash
cd /home/t/ha-addon-repo
git add . && git commit -m "update" && git push
```

完成！