import 'package:flutter/material.dart';

class NavigationSidebar extends StatelessWidget {
  final bool isExpanded;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final VoidCallback onToggle;

  const NavigationSidebar({
    super.key,
    required this.isExpanded,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onToggle,
  });

  // 导航项数据（可扩展添加更多页面）
  final List<NavigationItem> _items = const [
    NavigationItem(
      icon: Icons.person,
      label: '用户中心',
    ),
    NavigationItem(
      icon: Icons.home,
      label: '主界面',
    ),
    // 可在此处添加更多导航项
    // NavigationItem(icon: Icons.settings, label: '设置'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 240 : 80, // 展开/收起宽度
      color: Colors.grey[900],
      child: Column(
        children: [
          // 导航栏标题/切换按钮
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isExpanded)
                  const Text(
                    '导航菜单',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: Colors.white,
                  ),
                  onPressed: onToggle,
                ),
              ],
            ),
          ),
          
          // 导航项列表
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return _buildNavItem(
                  context,
                  icon: item.icon,
                  label: item.label,
                  isSelected: selectedIndex == index,
                  onTap: () => onItemTapped(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 构建单个导航项
  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        color: isSelected ? Colors.blue[700] : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// 导航项数据模型
class NavigationItem {
  final IconData icon;
  final String label;

  const NavigationItem({
    required this.icon,
    required this.label,
  });
}