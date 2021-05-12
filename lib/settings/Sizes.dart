import 'package:flutter/widgets.dart';

extension Sizes on BuildContext{
  double get appHeight => MediaQuery.of(this).size.height * 0.9;
  double get appWidth => MediaQuery.of(this).size.height * 0.9;
}