import 'package:flutter/material.dart';
import 'package:flutter_animation/bottom_navigator.dart';
import 'package:flutter_animation/home_screen.dart';
import 'package:flutter_animation/profile_screen.dart';
import 'package:flutter_animation/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _currentIndex.value = _pageController.page?.toInt() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentIndex,
      builder: (context, value, child) {
        return Scaffold(
          body: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index) {
              _currentIndex.value = index;
            },
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return HomeScreen();
                case 1:
                  return SearchScreen();
                case 2:
                  return ProfileScreen();
              }
            },
          ),
          bottomNavigationBar: BottomNavigator(
            onItemSelected: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            selectedIndex: value,
          ),
          floatingActionButton:
              value == 0 ? _buildFloatingActionButton() : null,
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    final ValueNotifier<bool> onTapDown = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: onTapDown,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {},
          onTapDown: (details) {
            onTapDown.value = true;
          },
          onTapUp: (details) {
            onTapDown.value = false;
          },
          onTapCancel: () {
            onTapDown.value = false;
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: value ? Colors.blue.shade200 : Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white, size: 35),
          ),
        );
      },
    );
  }
}
