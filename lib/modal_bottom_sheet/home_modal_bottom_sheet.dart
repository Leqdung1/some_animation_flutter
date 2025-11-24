import 'package:flutter/material.dart';

import '../widgets/button/app_button.dart';

class HomeModalBottomSheet extends StatelessWidget {
  const HomeModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Expanded(child: Text('Add New Item')),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: AppButton(
                  title: 'Cancel',
                  icon: Icons.cancel,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  onTap: () => Navigator.pop(context),
                  width: double.infinity,
                ),
              ),
              Expanded(
                child: AppButton(
                  title: 'Save',
                  icon: Icons.save,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  onTap: () => Navigator.pop(context),
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension HomeModalBottomSheetExtension on BuildContext {
  void showHomeModalBottomSheet() {
    showModalBottomSheet(
      context: this,
      builder: (context) => HomeModalBottomSheet(),
    );
  }
}
