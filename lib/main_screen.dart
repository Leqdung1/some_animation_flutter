import 'package:flutter/material.dart';
import 'package:flutter_animation/widgets/bottom_navigator.dart';
import 'package:flutter_animation/screen/home_screen.dart';
import 'package:flutter_animation/screen/profile_screen.dart';
import 'package:flutter_animation/screen/search_screen.dart';

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
              return null;
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
        );
      },
    );
  }
}
