import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '用户中心',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          
          // 登录/用户信息区域（模板）
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 此处可添加登录表单或用户信息卡片
                  const Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '登录区域模板',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // 登录按钮点击事件
                    },
                    child: const Text('登录'),
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