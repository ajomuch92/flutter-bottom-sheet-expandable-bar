library bottom_sheet_expandable_bar;

import 'package:flutter/material.dart';

/// Class to generate the icons widget for bottom bar
class BottomSheetBarIcon extends StatelessWidget {
  /// Icon color, when is not active appers with opacity
  final Color? color;

  /// Icon to show within the widget
  final Icon? icon;

  /// Function trigger when pressed the icon
  final Function()? onTap;

  /// Boolean value to indicate when an icon is active
  final bool? isActive;

  /// icon: Icon color, when is not active appers with opacity
  /// color: Icon to show within the widget
  /// onTap: Function trigger when pressed the icon
  const BottomSheetBarIcon(
      {Key? key,
      @required this.icon,
      this.onTap,
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
          backgroundColor:
              this.color?.withOpacity(this.isActive == true ? 1 : 0.5),
          mini: true,
          elevation: 0.0,
          onPressed: this.onTap,
        ),
        AnimatedContainer(
          width: this.isActive == true ? 10.0 : 0.0,
          height: this.isActive == true ? 5.0 : 0.0,
          decoration: BoxDecoration(
            color: this.isActive == true ? this.color : Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        )
      ],
    );
  }
}
