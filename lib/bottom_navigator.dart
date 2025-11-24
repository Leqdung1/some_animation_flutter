import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  final ValueChanged<int> onItemSelected;
  final int selectedIndex;
  const BottomNavigator({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(Icons.home, 0, selectedIndex, onItemSelected),
          _buildIconButton(Icons.search, 1, selectedIndex, onItemSelected),
          _buildIconButton(Icons.person, 2, selectedIndex, onItemSelected),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    int index,
    int selectedIndex,
    ValueChanged<int> onItemSelected,
  ) {
    return IconButton(
      onPressed: () {
        onItemSelected(index);
      },
      icon: Icon(
        icon,
        color: index == selectedIndex ? Colors.blue : Colors.grey.shade700,
      ),
    );
  }
}
