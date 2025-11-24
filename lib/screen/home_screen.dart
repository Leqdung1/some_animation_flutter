import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/modal_bottom_sheet/home_modal_bottom_sheet.dart';

import '../widgets/button/app_circle_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;
  late Animation<double> translateAnimation;
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<double> scrollPosition = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    translateAnimation = Tween<double>(
      begin: 100,
      end: 0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    controller.forward();
    scrollController.addListener(() {
      scrollPosition.value = scrollController.position.pixels;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Stack(
        children: [
          ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            itemCount: 200,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset('assets/images/img_dog.jpg'),
                title: Text('Item $index'),
                subtitle: Text('Subtitle $index'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey.shade700,
                ),
                onTap: () {
                  // Move to detail screen
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: scrollPosition,
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                bottom: value > 100 ? 20 : -100,
                left: 0,
                right: 0,
                child: AppCircleButton(
                  size: 40,
                  iconSize: 20,
                  icon: Icons.arrow_upward,
                  onTap: () {
                    scrollController.animateTo(
                      0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, translateAnimation.value * 2),
            child: _buildFloatingActionButton(
              icon: Icons.add,
              onTap: () {
                context.showHomeModalBottomSheet();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton({
    required VoidCallback onTap,
    required IconData icon,
    double? size,
    double? iconSize,
  }) {
    final ValueNotifier<bool> onTapDown = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: onTapDown,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: onTap,
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
            width: size ?? 60,
            height: size ?? 60,
            decoration: BoxDecoration(
              color: value ? Colors.blue.shade200 : Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: animation.value * 2 * pi,
              child: Icon(icon, color: Colors.white, size: iconSize ?? 35),
            ),
          ),
        );
      },
    );
  }
}
