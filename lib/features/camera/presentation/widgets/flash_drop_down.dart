import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'flash_drop_down_items.dart';

class FlashDropDown extends StatefulWidget {
  final int defaultFashItemIndex;
  final Function(FlashMode) onFlashItemChanged;

  const FlashDropDown({
    required this.onFlashItemChanged,
    this.defaultFashItemIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  _FlashDropDownState createState() => _FlashDropDownState();
}

class _FlashDropDownState extends State<FlashDropDown> {
  final List<FlashItem> _flasItems = [
    const FlashItem(
      name: 'Always',
      icon: Icons.flash_on,
      index: 0,
      flashMode: FlashMode.always,
    ),
    const FlashItem(
      name: 'auto',
      icon: Icons.flash_auto,
      index: 1,
      flashMode: FlashMode.auto,
    ),
    const FlashItem(
      name: 'torch',
      icon: Icons.flashlight_on,
      index: 2,
      flashMode: FlashMode.torch,
    ),
    const FlashItem(
      name: 'off',
      icon: Icons.flash_off,
      index: 3,
      flashMode: FlashMode.off,
    )
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.defaultFashItemIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          dropdownColor: Colors.black,
          value: _selectedIndex,
          isDense: true,
          iconSize: 0.0,
          // selectedItemBuilder: (BuildContext context) {
          //   return _flasItems.map<Widget>((FlashItem flashItem) {
          //     return Center(
          //       child: _flashItemWidget(flashItem),
          //     );
          //   }).toList();
          // },
          // icon: Icon(
          //   _flasItems[_selectedIndex].icon,
          //   color: Colors.purple,
          // ),
          // hint: Text(
          //   'data',
          //   style: TextStyle(color: Colors.white),
          // ),
          onChanged: _onFlashItemChanged,
          style: const TextStyle(
            color: Colors.white,
          ),
          items: _flasItems.map<DropdownMenuItem<int>>((FlashItem flashItem) {
            return DropdownMenuItem<int>(
              value: flashItem.index,
              child: _flashItemWidget(flashItem),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onFlashItemChanged(int? index) {
    if (_selectedIndex != index && index != null) {
      setState(() {
        _selectedIndex = index;
      });
      widget.onFlashItemChanged(_flasItems[index].flashMode);
    }
  }

  Widget _flashItemWidget(FlashItem flashItem) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            flashItem.name,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            flashItem.icon,
            size: 16,
            color: flashItem.index == _selectedIndex
                ? Colors.blueAccent
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}
