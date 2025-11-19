import subprocess
import shlex

def query(query: str) -> str:
    """
    调用graphrag执行查询并提取最终结果（过滤过程信息）
    
    参数:
        query: 要执行的查询字符串
        
    返回:
        提取后的最终结果；若失败则返回错误信息
    """
    try:
        # 构建命令（可尝试添加--quiet等参数减少过程输出，需先确认graphrag是否支持）
        command = f'graphrag query --root C:/Users/qiu38/ragtest1 --method global -q "{query}"'
        
        # 执行命令，获取字节流输出
        result = subprocess.run(
            shlex.split(command),
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        
        # 处理编码（兼容Windows）
        try:
            full_output = result.stdout.decode('utf-8')
        except UnicodeDecodeError:
            full_output = result.stdout.decode('gbk', errors='replace')
        
        # --------------------------
        # 核心：提取最终结果（需根据实际输出格式调整）
        # --------------------------
        # 示例1：假设结果在输出的最后几行（例如最后3行）
        # lines = full_output.splitlines()
        # final_result = '\n'.join(lines[-3:]).strip()  # 取最后3行
        
        # 示例2：假设结果以"Final Answer:"为前缀
        # if "Final Answer:" in full_output:
        #     final_result = full_output.split("Final Answer:")[-1].strip()
        # else:
        #     final_result = "未找到明确结果，完整输出：\n" + full_output
        
        # 示例3：如果结果是输出的最后一段（无明显标记，直接取全部非空内容）
        final_result = full_output.strip()  # 去除首尾空行和空格
        
        return final_result
        
    except subprocess.CalledProcessError as e:
        try:
            error_msg = e.stderr.decode('utf-8')
        except UnicodeDecodeError:
            error_msg = e.stderr.decode('gbk', errors='replace')
        return f"命令执行失败: {error_msg}"
    except Exception as e:
        return f"发生错误: {str(e)}"