library bottom_sheet_expandable_bar;

import 'package:flutter/material.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_bar_icon.dart';

/// enum for expandable button position
enum ButtonBottomBarPosition { center, end }

/// Class to generate the bottom bar sheet widget
class BottomBarSheet extends StatefulWidget {
  /// List of BottomSheetBarIcon to show whitin the widget
  final List<BottomSheetBarIcon> children;

  /// Value to indicate the position of the expandable button (center, end)
  final ButtonBottomBarPosition? buttonPosition;

  /// Bottom bar calor
  final Color? backgroundBarColor;

  /// Color for container when is expanded
  final Color? backgroundColor;

  /// Boolean value to show the expandable button
  final bool showExpandableButton;

  /// Widget to render into the bottom sheet
  final Widget? innerChild;

  /// Double value to indicate when radius for corner on bottom bar
  final double bottomRadius;

  /// Value to indicate the bottom bar height
  final double? bottomBarHeight;

  /// Value to indicate the bottom bar width
  final double? bottomBarWidth;

  /// Indicate the duration when expand bottom sheet
  final Duration? duration;

  /// Double value to indicate the bottom sheet height
  final double? bottomSheetHeight;

  /// Icon to show into expandable button
  final Widget? iconExpand;

  /// Color for expandable button
  final Color? iconColor;

  /// Function trigger when close bottom sheet
  final Function()? onClose;

  /// Value to indicate what icon tab is selected
  final int? currentIndex;

  /// Curve to use on animation
  final Curve curve;

  /// children: List of BottomSheetBarIcon to show whitin the widget
  /// buttonPosition: Value to indicate the position of the expandable button (center, end)
  /// backgroundColor: Color for container when is expanded
  /// backgroundBarColor: Bottom bar calor
  /// showExpandableButton: Boolean value to show the expandable button
  /// innerChild: Widget to render into the bottom sheet
  /// bottomRadius: Double value to indicate when radius for corner on bottom bar
  /// bottomBarHeight: Value to indicate the bottom bar height
  /// bottomBarWidth: Value to indicate the bottom bar width
  /// duration: Indicate the duration when expand bottom sheet
  /// bottomSheetHeight: Double value to indicate the bottom sheet height
  /// iconExpand: Icon to show into expandable button
  /// iconColor: Color for expandable button
  /// onClose: Function trigger when close bottom sheet
  /// currentIndex: Value to indicate what icon tab is selected
  /// curve: Curve to use on animation
  BottomBarSheet({
    Key? key,
    this.children = const [],
    this.buttonPosition = ButtonBottomBarPosition.center,
    this.backgroundColor = Colors.white,
    this.backgroundBarColor = Colors.white,
    this.showExpandableButton = true,
    this.innerChild,
    this.bottomRadius = 50.0,
    this.bottomBarHeight = 60.0,
    this.bottomBarWidth,
    this.duration = const Duration(milliseconds: 250),
    this.bottomSheetHeight,
    this.iconExpand = const Icon(Icons.navigation),
    this.iconColor = Colors.green,
    this.onClose,
    this.currentIndex,
    this.curve = Curves.ease,
  }) : super(key: key);

  @override
  _BottomBarSheetState createState() => _BottomBarSheetState();
}

class _BottomBarSheetState extends State<BottomBarSheet> {
  /// Boolean value to toggle first or second child on AnimatedCrossFade
  bool _showSecond = false;

  List<Widget> _getChildren() {
    List<Widget> _children = [];
    int middle = (widget.children.length / 2).ceil();
    int _index = 0;
    for (BottomSheetBarIcon el in widget.children) {
      int i = widget.children.indexOf(el);
      BottomSheetBarIcon _icon = BottomSheetBarIcon(
          icon: el.icon,
          onTap: () {
            el.onTap!();
          },
          isActive: widget.currentIndex == i,
          color: el.color);
      _children.add(_icon);
      _index++;
      if (_index == middle &&
          widget.buttonPosition == ButtonBottomBarPosition.center &&
          widget.showExpandableButton) {
        _children.add(_getShowButton());
      }
    }
    if (widget.buttonPosition == ButtonBottomBarPosition.end &&
        widget.showExpandableButton) {
      _children.add(_getShowButton());
    }
    return _children;
  }

  Widget _getShowButton() {
    return FloatingActionButton(
      child: widget.iconExpand,
      elevation: 0.0,
      backgroundColor: widget.iconColor,
      onPressed: () => setState(() => _showSecond = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BottomSheet(
      /// when on close is null, take an empty function
      onClosing: widget.onClose ?? () {},
      builder: (BuildContext context) => AnimatedContainer(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: !_showSecond
                ? widget.backgroundBarColor
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(30)),
        child: AnimatedCrossFade(
            firstChild: Container(
              height: widget.bottomBarHeight,
              width: widget.bottomBarWidth ?? (_size.width * 0.9),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.bottomRadius)),
                // color: widget.backgroundBarColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getChildren(),
              ),
            ),
            secondChild: Container(
                // color: widget.backgroundColor,
                constraints: BoxConstraints.expand(
                  height: widget.bottomSheetHeight ?? (_size.height * 0.75),
                ),
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Container(
                      child: widget.innerChild,
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: CloseButton(
                          color: Colors.redAccent,
                          onPressed: () {
                            setState(() => _showSecond = false);
                          },
                        ))
                  ],
                )),
            crossFadeState: _showSecond
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: widget.duration ?? Duration(milliseconds: 250)),
        duration: widget.duration ?? Duration(milliseconds: 250),
        curve: widget.curve,
      ),
    );
  }
}
