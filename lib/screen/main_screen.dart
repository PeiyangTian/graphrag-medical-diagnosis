import 'package:flutter/material.dart';
import 'sidebar/navigation_sidebar.dart';
import 'page/user_page.dart';
import 'page/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 控制导航栏是否展开
  bool _isSidebarExpanded = true;
  // 当前选中的页面索引（0: 用户页, 1: 主界面, 可扩展更多）
  int _selectedIndex = 0;

  // 页面列表（与导航项对应）
  final List<Widget> _pages = const [
    UserPage(),
    HomePage(),
  ];

  // 切换导航栏展开状态
  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  // 切换选中页面
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 左侧导航栏
          NavigationSidebar(
            isExpanded: _isSidebarExpanded,
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
            onToggle: _toggleSidebar,
          ),
          
          // 右侧主内容区
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}