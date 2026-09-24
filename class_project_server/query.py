import os
import subprocess

# GraphRAG 索引根目录：通过环境变量配置，避免写死本机路径。
# 例如：
#   Windows (PowerShell): $env:GRAPHRAG_ROOT = "C:/path/to/your/graphrag/index"
#   Windows (cmd):        set GRAPHRAG_ROOT=C:/path/to/your/graphrag/index
#   Linux/macOS:          export GRAPHRAG_ROOT=/path/to/your/graphrag/index
GRAPHRAG_ROOT = os.environ.get("GRAPHRAG_ROOT", "ragtest1")

# 查询方式：global（全局检索）或 local（局部检索）
GRAPHRAG_METHOD = os.environ.get("GRAPHRAG_METHOD", "global")


def query(query: str) -> str:
    """
    调用 graphrag 执行查询并提取最终结果（过滤过程信息）

    参数:
        query: 要执行的查询字符串

    返回:
        提取后的最终结果；若失败则返回错误信息
    """
    try:
        result = subprocess.run(
            [
                "graphrag", "query",
                "--root", GRAPHRAG_ROOT,
                "--method", GRAPHRAG_METHOD,
                "-q", query,
            ],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )

        # 处理编码（兼容 Windows）
        try:
            full_output = result.stdout.decode("utf-8")
        except UnicodeDecodeError:
            full_output = result.stdout.decode("gbk", errors="replace")

        return full_output.strip()

    except subprocess.CalledProcessError as e:
        try:
            error_msg = e.stderr.decode("utf-8")
        except UnicodeDecodeError:
            error_msg = e.stderr.decode("gbk", errors="replace")
        return f"命令执行失败: {error_msg}"
    except Exception as e:
        return f"发生错误: {str(e)}"
