import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../generated/assets.dart';
import '../auth/post_login/add_personal_info.dart';
import '../custom_room/create_custom_room.dart';
import '../home/pick_voices.dart';
import 'home_page.dart';
import 'spirtual_videos.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const PickVoicesScreen(),
    const SpirtualVideoScreen(),
    const AddPersonalInfoScreen(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Do you really want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);

                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  }
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
        floatingActionButton: _currentIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateCustomRoom(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
