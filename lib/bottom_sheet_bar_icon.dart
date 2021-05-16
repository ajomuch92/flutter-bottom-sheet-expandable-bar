library bottom_sheet_expandable_bar;

import 'package:flutter/material.dart';

class BottomSheetBarIcon extends StatelessWidget {
  final Color color;
  final Icon icon;
  final Function onTap;
  final bool isActive;

  const BottomSheetBarIcon(
      {Key key,
      @required this.icon,
      @required this.onTap,
      this.color = Colors.black,
      this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          child: this.icon,
          backgroundColor: this.color.withOpacity(this.isActive ? 1 : 0.5),
          mini: true,
          elevation: 0.0,
          onPressed: this.onTap,
        ),
        AnimatedContainer(
          width: this.isActive ? 10.0 : 0.0,
          height: this.isActive ? 5.0 : 0.0,
          decoration: BoxDecoration(
            color: this.isActive ? this.color : Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        )
      ],
    );
  }
}
