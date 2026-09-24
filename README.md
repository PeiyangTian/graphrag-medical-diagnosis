# GraphRAG Medical Diagnosis

> 基于 [GraphRAG](https://github.com/microsoft/graphrag) 的知识图谱医学诊断问答系统

一个前后端分离的医学诊断问答系统：用户在桌面客户端输入症状描述，后端调用微软 GraphRAG 对本地医学知识图谱进行全局检索，返回诊断建议。

A GraphRAG-powered medical diagnosis Q&A system — a Flutter desktop client talks to a FastAPI backend, which queries a local GraphRAG knowledge graph built from medical corpus.

---

## ✨ 功能特性 Features

- **医学症状问答**：输入症状描述，返回基于知识图谱的诊断结果
- **GraphRAG 全局检索**：基于 `--method global` 的全局问答
- **桌面端 UI**：Flutter 侧边栏导航 + 问答交互界面
- **前后端分离**：Flutter（HTTP）↔ FastAPI（`/process`）↔ GraphRAG

## 🏗️ 系统架构 Architecture

```
Flutter 客户端 (lib/)
   │  HTTP POST /process  { userInput: "..." }
   ▼
FastAPI 服务端 (class_project_server/)
   │  graphrag query --root <索引> --method global -q "..."
   ▼
GraphRAG 知识图谱索引
```

## 📁 目录结构 Structure

```
class_project/
├── lib/                        # Flutter 客户端
│   ├── main.dart               # 应用入口
│   └── screen/
│       ├── main_screen.dart    # 主框架（侧边栏导航）
│       ├── sidebar/            # 导航侧边栏
│       └── page/
│           ├── home_page.dart  # 主界面
│           ├── sender.dart     # 问答界面（HTTP 请求）
│           └── user_page.dart  # 用户页
├── class_project_server/       # FastAPI 后端
│   ├── server.py               # /process 接口
│   ├── query.py                # 调用 graphrag query
│   ├── test.py                 # 本地测试脚本
│   └── requirements.txt        # Python 依赖
└── pubspec.yaml                # Flutter 依赖
```

## 🔧 环境要求 Prerequisites

- Flutter SDK（Dart `^3.10.0`）
- Python 3.10+
- [graphrag](https://github.com/microsoft/graphrag)（Microsoft GraphRAG）
- 一个已构建好的 GraphRAG 索引目录

## 🚀 安装与运行 Getting Started

### 1. 后端 Backend

```bash
cd class_project_server
pip install -r requirements.txt

# 设置 GraphRAG 索引目录（改成你自己的索引路径）
# Windows (PowerShell)
$env:GRAPHRAG_ROOT = "C:/path/to/your/graphrag/index"
# Linux / macOS
export GRAPHRAG_ROOT=/path/to/your/graphrag/index

# 启动服务（默认端口 8000）
python server.py
```

### 2. 前端 Frontend

```bash
cd class_project
flutter pub get
flutter run -d windows   # 或 -d macos / -d chrome
```

打开应用后，进入「输入内容发送」页面，输入症状描述，点击「确认并发送」。

## ⚙️ 配置 Configuration

后端通过环境变量配置，均提供默认值：

| 环境变量 | 默认值 | 说明 |
| --- | --- | --- |
| `GRAPHRAG_ROOT` | `ragtest1` | GraphRAG 索引根目录 |
| `GRAPHRAG_METHOD` | `global` | 检索方式：`global`（全局）/ `local`（局部） |

前端 API 地址在 `lib/screen/page/sender.dart` 中配置，默认为 `http://127.0.0.1:8000/process`。

## 🧪 测试 Test

```bash
cd class_project_server
python test.py   # 直接调用 query() 测试 GraphRAG 查询
```

## 📝 注意事项 Notes

- 后端依赖本机已安装 `graphrag` 命令，请确保其位于 PATH 中。
- GraphRAG 索引需提前构建（`graphrag index`），本项目不包含索引数据。
- 诊断结果仅供参考，不构成医疗建议。
