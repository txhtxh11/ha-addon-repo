# TXH Add-ons — Home Assistant 加载项仓库

> 自用 Home Assistant add-on 仓库。目前包含 **ESPHome YAML 生成器**：在浏览器里点选生成 ESP8266 / ESP32 的 ESPHome + HomeKit 双协议 YAML，内置中移铁通 CMPOWER W1 智能排插的完整配置。

![截图](https://github.com/user-attachments/assets/ba6c6a25-65bf-48e0-8647-eaeb4de39dfe)

## 安装

1. Home Assistant → **设置** → **加载项** → **加载项商店**
2. 右上角 `⋮` → **仓库**，填入：

   ```
   https://github.com/txhtxh11/ha-addon-repo
   ```

3. 刷新后搜索 **ESPHome YAML 生成器** → 安装 → 启动
4. 打开 Web UI（已开启 ingress，也可用 `8080` 端口）

## 仓库结构

```
repository.json                  # add-on 仓库清单
esphome_yaml_generator/          # ESPHome YAML 生成器 add-on
├── config.json                  # add-on 元数据（ingress / 端口 / 权限）
├── Dockerfile
├── run.sh
└── data/index.html              # 生成器页面
```

## 相关仓库

- [ha-hacs-esphome-generator](https://github.com/txhtxh11/ha-hacs-esphome-generator) —— 同功能的 HACS 集成版
- [homekit](https://github.com/txhtxh11/homekit) —— ESPHome 的 HomeKit 外部组件
- [cmpower](https://github.com/txhtxh11/cmpower) —— CMPOWER W1 智能排插固件配置

## 许可证

本项目采用 MIT 许可证，详见 [LICENSE](LICENSE)。