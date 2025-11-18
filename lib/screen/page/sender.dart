import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputSenderPage extends StatefulWidget {
  const InputSenderPage({super.key});

  @override
  State<InputSenderPage> createState() => _InputSenderPageState();
}

class _InputSenderPageState extends State<InputSenderPage> {
  // 文本输入控制器
  final TextEditingController _inputController = TextEditingController();
  
  // 存储服务器返回的结果
  String _responseMessage = '';
  
  // 加载状态标识
  bool _isLoading = false;

  // 发送HTTP POST请求
  Future<void> _submitData() async {
    // 检查输入是否为空
    if (_inputController.text.trim().isEmpty) {
      _showNotification('请输入内容后再提交');
      return;
    }

    // 开始加载状态
    setState(() {
      _isLoading = true;
      _responseMessage = '正在发送请求...';
    });

    try {
      // 替换为您的实际API地址
      const String apiUrl = 'http://127.0.0.1:8000/process';
      
      // 构建请求体
      final Map<String, dynamic> requestData = {
        'userInput': _inputController.text.trim(),
      };

      // 发送POST请求
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          // 可以添加其他必要的请求头
        },
        body: jsonEncode(requestData),
      );

      // 处理响应
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // 假设服务器返回的数据中有"result"字段是需要显示的内容
        setState(() {
          _responseMessage = responseData['result'] ?? '服务器返回了数据，但未找到指定内容';
        });
      } else {
        setState(() {
          _responseMessage = '请求失败，状态码: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseMessage = '请求发生错误: ${e.toString()}';
      });
    } finally {
      // 结束加载状态
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 显示通知提示
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '输入内容发送',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // 文字输入框
                TextField(
                  controller: _inputController,
                  decoration: const InputDecoration(
                    labelText: '请输入内容',
                    hintText: '在这里输入要发送的文字...',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  enabled: !_isLoading,
                ),
                const SizedBox(height: 16),

                // 确认按钮
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    '确认并发送',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  '服务器返回:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                // 响应内容显示区域
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _responseMessage.isEmpty ? '等待发送请求...' : _responseMessage,
                        style: TextStyle(
                          fontSize: 16,
                          color: _responseMessage.startsWith('请求失败') || 
                                 _responseMessage.startsWith('请求发生错误')
                              ? Colors.red
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 加载状态遮罩
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 4,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}