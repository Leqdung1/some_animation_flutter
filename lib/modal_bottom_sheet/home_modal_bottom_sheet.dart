import 'package:flutter/material.dart';

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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(children: [Text('Add New Item')]),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            ),
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
