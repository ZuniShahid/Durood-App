import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import 'home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _buildNavItem('Home', Assets.imagesHomeIcon, 0),
          _buildNavItem('Durood', Assets.imagesHeadphones, 1),
          _buildNavItem('Videos', Assets.imagesVideoCam, 2),
          _buildNavItem('Profile', Assets.imagesUser, 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String label, String iconPath, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: _currentIndex == index ? Colors.black : const Color(0xFFB5B5B5),
      ),
      label: label,
    );
  }
}
