import 'package:flutter/material.dart';
import 'package:solidcare/components/loader_widget.dart';
import 'package:solidcare/main.dart';
import 'package:nb_utils/nb_utils.dart';

class AppLoader extends StatelessWidget {
  final bool? visibleOn;
  final double? loaderSize;

  AppLoader({this.visibleOn, this.loaderSize});

  @override
  Widget build(BuildContext context) {
    return LoaderWidget(size: loaderSize)
        .visible(visibleOn ?? appStore.isLoading);
  }
}
