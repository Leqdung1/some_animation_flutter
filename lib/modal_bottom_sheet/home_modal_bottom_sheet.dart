import 'package:flutter/material.dart';

import '../widgets/button/app_button.dart';
import '../widgets/button/app_circle_button.dart';

class HomeModalBottomSheet extends StatefulWidget {
  const HomeModalBottomSheet({super.key});

  @override
  State<HomeModalBottomSheet> createState() => _HomeModalBottomSheetState();
}

class _HomeModalBottomSheetState extends State<HomeModalBottomSheet> {
  final ValueNotifier<int> quantity = ValueNotifier(0);
  bool isAddToList = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: quantity,
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              Text('Add New Item'),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child:
                    !isAddToList
                        ? _buildButtons(context)
                        : _buildAddToList(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddToList(BuildContext context) {
    return Column(
      key: ValueKey(isAddToList),
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: AppCircleButton(
                icon: Icons.remove,
                onTap: () {
                  quantity.value--;
                  if (quantity.value < 0) {
                    quantity.value = 0;
                  }
                },
                size: 40,
                iconSize: 20,
                color: Colors.red,
              ),
            ),
            Text(
              quantity.value.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: AppCircleButton(
                icon: Icons.add,
                onTap: () {
                  quantity.value++;
                },
                size: 40,
                iconSize: 20,
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 100),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: AppButton(
                title: 'Cancel',
                icon: Icons.cancel,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                onTap: () {
                  setState(() {
                    isAddToList = false;
                  });
                },
                width: double.infinity,
              ),
            ),
            Expanded(
              child: AppButton(
                title: 'Save',
                icon: Icons.save,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                onTap: () {},
                width: double.infinity,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      key: ValueKey(isAddToList),
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        AppButton(
          title: 'Add to list',
          icon: Icons.add,
          backgroundColor: Colors.green.shade400,
          textColor: Colors.white,
          onTap: () {
            setState(() {
              isAddToList = true;
            });
          },
          width: double.infinity,
        ),

        AppButton(
          title: 'Cancel',
          icon: Icons.cancel,
          backgroundColor: Colors.red.shade400,
          textColor: Colors.white,
          onTap: () => Navigator.pop(context),
          width: double.infinity,
        ),
      ],
    );
  }
}

extension HomeModalBottomSheetExtension on BuildContext {
  void showHomeModalBottomSheet() {
    showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HomeModalBottomSheet(),
    );
  }
}
