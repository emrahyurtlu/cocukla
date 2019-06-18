import 'package:flutter/material.dart';

class DimensionUtility {
  EdgeInsetsGeometry padding;
  EdgeInsetsGeometry margin;
  BuildContext context;

  DimensionUtility(this.context,
      [this.padding = const EdgeInsets.all(0),
      this.margin = const EdgeInsets.all(0)]);

  double setWidthRel({double add = 0, double subtract = 0}) {
    return MediaQuery.of(context).size.width -
        (padding.horizontal + margin.horizontal) +
        add -
        subtract;
  }

  double setHeightRel({double add = 0, double subtract = 0}) {
    return MediaQuery.of(context).size.height -
        (padding.vertical + margin.vertical) +
        add -
        subtract;
  }
}
