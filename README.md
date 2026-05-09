<<<<<<< HEAD
# App 发布页 — Windows XP 风格

纯黑 → Teal 蓝背景，Windows XP 经典风格的应用下载页面。

## 项目结构

```
ReleasePage/
├── index.html     ← 发布页（核心文件）
├── README.md      ← 本说明文件
├── sync.bat       ← 一键同步脚本（双击运行）
├── sync.ps1       ← 同步脚本（由 sync.bat 调用）
└── app/           ← 存放你的 app 文件
    └── myapp.exe  ← 占位文件，可替换为你自己的 app
```

## 一键同步（推荐）

### 1. 放入 App 文件

将你的 app 文件（`.exe`、`.apk`、`.dmg` 等）放到 `app/` 文件夹中，替换掉 `myapp.exe`。

如需自定义图标，将图片命名为 `logo.png`（推荐 64×64 像素）也放到 `app/` 文件夹内。

### 2. 双击 sync.bat

双击 `sync.bat`，脚本会自动扫描 `app/` 文件夹并更新网页信息：

| 自动更新的内容 | 说明 |
|:---|:---|
| App 名称 | 从文件名自动提取（如 `MyApp_v2.4.1.exe` → 名称 `MyApp`） |
| 版本号 | 从文件名自动提取（如 `MyApp_v2.4.1.exe` → 版本 `v2.4.1`） |
| 文件大小 | 自动计算并格式化显示 |
| 下载链接 | 自动指向 `app/` 中的文件 |
| App 图标 | 如果存在 `logo.png`，自动嵌入到页面 |

> **文件名格式建议**：`名称_版本号.扩展名`，例如 `WeChat_v3.8.5.exe`

### 3. 刷新发布页

双击 `index.html` 即可在浏览器中查看更新后的页面。

## 手动修改

如果你不想使用同步脚本，也可以直接编辑 `index.html`：

| 字段 | 查找位置 | 修改方法 |
|------|----------|----------|
| App 名称 | `id="appName"` | 修改中间文字 |
| 版本号 | `id="appVersion"` | 修改版本号 |
| 文件名 | `id="fileName"` | 改为实际文件名 |
| 文件大小 | `id="fileSize"` | 改为实际大小 |
| 版本 | `id="fileVersion"` | 修改为实际版本号 |
| 下载链接 | `id="downloadBtn"` 的 `href` | 改为 `./app/你的文件名.exe` |
| App 图标 | `class="app-icon"` | 将 emoji 📦 替换为 `<img>` 标签 |

## 自定义样式

- **窗口颜色**：修改 `body` 的 `background` 渐变色
- **标题栏颜色**：修改 `.xp-titlebar` 的 `background`
- **按钮文字**：修改 `.xp-action-btn-primary` 中的 "立即下载"
- **提示文字**：修改 `.xp-prompt-text` 中的 "C:\>"

## 浏览器兼容

支持所有现代浏览器（Chrome、Edge、Firefox、Safari），**无需任何服务端环境**，纯静态页面。
=======
# app下载网页

#### 介绍
app-download-webpage

#### 软件架构
软件架构说明


#### 安装教程

1.  xxxx
2.  xxxx
3.  xxxx

#### 使用说明

1.  xxxx
2.  xxxx
3.  xxxx

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
>>>>>>> 66f859949eacd58175f48dd93300006445080502
