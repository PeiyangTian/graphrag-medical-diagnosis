import 'package:flutter/material.dart';
import 'sender.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '主界面',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          
          // 主内容区域（模板）
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.dashboard_outlined,
                    size: 120,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '主内容区域模板',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // 主界面按钮点击事件
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InputSenderPage()),
                      );
                    },
                    child: const Text('添加内容'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}