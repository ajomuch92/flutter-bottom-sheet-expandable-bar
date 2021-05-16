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
  final ButtonBottomBarPosition buttonPosition;

  /// Bottom bar calor
  final Color backgroundBarColor;

  /// Color for container when is expanded
  final Color backgroundColor;

  /// Boolean value to show the expandable button
  final bool showExpandableButton;

  /// Widget to render into the bottom sheet
  final Widget innerChild;

  /// Double value to indicate when radius for corner on bottom bar
  final double bottomRadius;

  /// Value to indicate the bottom bar height
  final double bottomBarHeight;

  /// Value to indicate the bottom bar width
  final double bottomBarWidth;

  /// Indicate the duration when expand bottom sheet
  final Duration duration;

  /// Double value to indicate the bottom sheet height
  final double bottomSheetHeight;

  /// Icon to show into expandable button
  final Widget iconExpand;

  /// Color for expandable button
  final Color iconColor;

  /// Function trigger when close bottom sheet
  final Function onClose;

  BottomBarSheet({
    Key key,
    @required this.children,
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
  }) : super(key: key);

  @override
  _BottomBarSheetState createState() => _BottomBarSheetState(
      children: this.children,
      buttonPosition: this.buttonPosition,
      backgroundColor: this.backgroundColor,
      backgroundBarColor: this.backgroundBarColor,
      showExpandableButton: this.showExpandableButton,
      innerChild: this.innerChild,
      bottomRadius: this.bottomRadius,
      bottomBarHeight: this.bottomBarHeight,
      bottomBarWidth: this.bottomBarWidth,
      duration: this.duration,
      bottomSheetHeight: this.bottomSheetHeight,
      iconExpand: this.iconExpand,
      iconColor: this.iconColor,
      onClose: onClose);
}

class _BottomBarSheetState extends State<BottomBarSheet> {
  /// Boolean value to toggle first or second child on AnimatedCrossFade
  bool _showSecond = false;

  /// Value to indicate what child is selected
  int _indexSelected = 0;
  
  /// List of BottomSheetBarIcon to show whitin the widget
  final List<BottomSheetBarIcon> children;
  
  /// Value to indicate the position of the expandable button (center, end)
  final ButtonBottomBarPosition buttonPosition;
  
  /// Bottom bar calor
  final Color backgroundColor;
  
  /// Color for container when is expanded
  final Color backgroundBarColor;
  
  /// Boolean value to show the expandable button
  final bool showExpandableButton;
  
  /// Widget to render into the bottom sheet
  final Widget innerChild;
  
  /// Double value to indicate when radius for corner on bottom bar
  final double bottomRadius;
  
  /// Value to indicate the bottom bar height
  final double bottomBarHeight;
  
  /// Value to indicate the bottom bar width
  final double bottomBarWidth;
  
  /// Indicate the duration when expand bottom sheet
  final Duration duration;
  
  /// Double value to indicate the bottom sheet height
  final double bottomSheetHeight;
  
  /// Icon to show into expandable button
  final Widget iconExpand;
  
  /// Color for expandable button
  final Color iconColor;
  
  /// Function trigger when close bottom sheet
  final Function onClose;

  _BottomBarSheetState(
      {this.children,
      this.buttonPosition,
      this.backgroundColor,
      this.backgroundBarColor,
      this.showExpandableButton,
      this.innerChild,
      this.bottomRadius,
      this.bottomBarHeight,
      this.bottomBarWidth,
      this.duration,
      this.bottomSheetHeight,
      this.iconExpand,
      this.iconColor,
      this.onClose});

  List<Widget> _getChildren() {
    List<Widget> _children = [];
    int middle = (this.children.length / 2).ceil();
    int _index = 0;
    for (BottomSheetBarIcon el in this.children) {
      int i = this.children.indexOf(el);
      BottomSheetBarIcon _icon = BottomSheetBarIcon(
          icon: el.icon,
          onTap: () {
            setState(() {
              _indexSelected = i;
            });
            el.onTap();
          },
          isActive: _indexSelected == i,
          color: el.color);
      _children.add(_icon);
      _index++;
      if (_index == middle &&
          this.buttonPosition == ButtonBottomBarPosition.center &&
          this.showExpandableButton) {
        _children.add(_getShowButton());
      }
    }
    if (this.buttonPosition == ButtonBottomBarPosition.end &&
        this.showExpandableButton) {
      _children.add(_getShowButton());
    }
    return _children;
  }

  Widget _getShowButton() {
    return FloatingActionButton(
      child: this.iconExpand,
      elevation: 0.0,
      backgroundColor: this.iconColor,
      onPressed: () => setState(() => _showSecond = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return BottomSheet(
      /// when on close is null, take an empty function
      onClosing: this.onClose??(){},
      builder: (BuildContext context) => AnimatedContainer(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: !_showSecond ? Colors.transparent : this.backgroundColor,
            borderRadius: BorderRadius.circular(30)),
        child: AnimatedCrossFade(
            firstChild: Container(
              height: this.bottomBarHeight,
              width: this.bottomBarWidth ?? (_size.width * 0.9),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(this.bottomRadius)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _getChildren(),
              ),
            ),
            secondChild: Container(
                constraints: BoxConstraints.expand(
                  height: this.bottomSheetHeight ?? (_size.height * 0.75),
                ),
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    Container(
                      child: this.innerChild,
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
            duration: this.duration),
        duration: this.duration,
      ),
    );
  }
}
