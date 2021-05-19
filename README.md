# Bottom Sheet Expandable Bar

This package create a bottom navigation bar with the capability to show a bottom sheet.

<img src="https://raw.githubusercontent.com/ajomuch92/flutter-bottom-sheet-expandable-bar/master/assets/demo.gif" width="200" height="429"/>

## Instalation
Include `bottom_sheet_expandable_bar` in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  bottom_sheet_expandable_bar: version
```

## Usage

To use this package, just import it into your file and enjoy it.

```dart
import 'package:bottom_sheet_expandable_bar/bottom_sheet_bar_icon.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_expandable_bar.dart';

...

bottomSheet: BottomBarSheet(
  children: [
    BottomSheetBarIcon(
      icon: Icon(Icons.home),
      color: Colors.redAccent, 
      onTap: (){
      },
    ),
    BottomSheetBarIcon(
      icon: Icon(Icons.person),
      color: Colors.blueAccent, 
      onTap: (){
      },
    ),
    BottomSheetBarIcon(
      icon: Icon(Icons.edit),
      color: Colors.blue[800], 
      onTap: (){
      },
    ),
    BottomSheetBarIcon(
      icon: Icon(Icons.star),
      color: Colors.orangeAccent, 
      onTap: (){
      },
    ),
  ],
),

...

```

IMPORTANT: Add this line to your theme to avoid an unexpected behaviour

```dart
theme: ThemeData(
  /// Add this line
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
),

```

### BottomSheetBarIcon
This widget allow to generate a dynamic icon

**Properties**

|  Name | Description   | Required   | Default   |
| ------------ | ------------ | ------------ | ------------ |
| icon  | Widget to put as button icon | False   |   |
| color  | Color to indicate icon color | False   |  Colors.black |
| onTap  | Function to handle button on tap | True   |   |

### BottomBarSheet
This widget allow to generate a bottom bar with the capability to expanto to a bottom sheet

**Properties**

|  Name | Description   | Required   | Default   |
| ------------ | ------------ | ------------ | ------------ |
| children  | List of BottomSheetBarIcon widget to show icons within the bar | False   |   |
| buttonPosition  | ButtonBottomBarPosition to indicate expandable button position (center, end) |  False  | ButtonBottomBarPosition.center   |
| backgroundBarColor  | Color to indicate bottom bar background color | False   |  Colors.white |
| backgroundColor  | Color to indicate bottom sheet color | False   | Colors.white  |
| showExpandableButton  | Boolean value to indicate when to show or hide expandable button | False   |  False |
| innerChild  | Widget to show into the bottom sheet | False   |   |
| bottomRadius  | Double value to indicate the corners radius for the bottom bar | False   |  50.0 |
| bottomBarHeight  | Double value to indicate the bottom bar height | False   |  60.0 |
| bottomBarWidth  | Double value to indicate the bottom bar height | False   | Screen width * 0.9 |
| duration  | Duration between show or hide the bottom sheet | False   | 250 milliseconds |
| bottomSheetHeight  | Double value to indicate the bottom sheet height | False   | Screen height * 0.75  |
| iconExpand  | Icon to show into the expandable button | False   | Icon(Icons.navigation) |
| iconColor  | Expandable button color | False   | Colors.green |
| onClose  | Function to call when bottom sheet is closed | False   | (){}  |
| currentIndex  | Integer value to indicatet which tab is selected | False   | 0  |
| curve  | Curve to use on enter bottom sheet animation | False   |   |

### Expandable button at center

![](https://github.com/ajomuch92/flutter-bottom-sheet-expandable-bar/blob/master/assets/Screenshot_1.jpg)

### Expandable button at end

![](https://github.com/ajomuch92/flutter-bottom-sheet-expandable-bar/blob/master/assets/Screenshot_2.jpg)

### As a simple navigation bar

![](https://github.com/ajomuch92/flutter-bottom-sheet-expandable-bar/blob/master/assets/Screenshot_3.jpg)