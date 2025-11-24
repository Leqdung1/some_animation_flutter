import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation/modal_bottom_sheet/home_modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;
  late Animation<double> translateAnimation;

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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView.builder(
        itemCount: 50,
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
            onTap: () {},
          );
        },
      ),
      floatingActionButton: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, translateAnimation.value * 2),
            child: _buildFloatingActionButton(),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    final ValueNotifier<bool> onTapDown = ValueNotifier(false);
    return ValueListenableBuilder(
      valueListenable: onTapDown,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            context.showHomeModalBottomSheet();
          },
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
            child: Transform.rotate(
              angle: animation.value * 2 * pi,
              child: Icon(Icons.add, color: Colors.white, size: 35),
            ),
          ),
        );
      },
    );
  }
}
