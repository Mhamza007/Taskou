import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

/// Add OnTap property to widget
extension WidgetTapped on Widget {
  Widget onTap(Function()? onTap) => GestureDetector(
        onTap: onTap,
        child: this,
      );
}

/// Centeralize Widget
extension EcnterWidget on Widget {
  Widget center() => Center(
        child: this,
      );
}

/// Background Image - Container decration
extension DecorateContainer on Widget {
  Widget decorateWidget(Decoration decoration) => Container(
        decoration: decoration,
        child: this,
      );
}

/// Visible Widget
extension VisibleWidget on Widget {
  Widget visibility({
    required bool visible,
  }) =>
      Visibility(
        visible: visible,
        child: this,
      );
}

/// Show widget above other Widget
extension AboveWidget on Widget {
  Widget aboveWidget(
    Widget? widget, {
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    MainAxisSize mainAxisSize: MainAxisSize.min,
  }) =>
      Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: [
          widget ?? SizedBox.shrink(),
          this,
        ],
      );
}

/// Visible Widget
extension OnWillPop on Widget {
  Widget onWillPop({
    required Future<bool> Function()? onWillPop,
  }) =>
      WillPopScope(
        onWillPop: onWillPop,
        child: this,
      );
}
