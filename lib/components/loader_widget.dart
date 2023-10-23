import 'package:flutter/material.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/widgets/spining_lines.dart';

class LoaderWidget extends StatelessWidget {
  final double? size;

  LoaderWidget({this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(color: primaryColor, size: size ?? 56);
  }
}
