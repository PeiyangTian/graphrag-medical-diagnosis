from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
# from query import query

app = FastAPI()

# 定义请求体模型（自动验证字段）
class UserRequest(BaseModel):
    userInput: str

# 测试
def query(question: str) -> str:
    return "HELLO"

@app.post('/process')
def process_request(req: UserRequest):
    try:
        # 直接通过模型获取userInput
        user_input = req.userInput
        # 显示用户输入
        print("用户输入: ", user_input)
        # 调用处理函数
        result = query(user_input)
        # 返回结果
        return {'result': result}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == '__main__':
    # 启动服务，端口8000
    import uvicorn

    uvicorn.run(app, host='0.0.0.0', port=8000)