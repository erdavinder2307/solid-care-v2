import 'package:flutter/material.dart';
import 'package:solidcare/components/app_loader.dart';
import 'package:solidcare/main.dart';
import 'package:nb_utils/nb_utils.dart';

class Body extends StatelessWidget {
  final Widget child;
  final bool? visibleOn;
  final double? size;
  final Widget? loadingWidget;

  const Body(
      {Key? key,
      required this.child,
      this.visibleOn = false,
      this.size,
      this.loadingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      height: context.height(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          if (loadingWidget != null)
            loadingWidget.visible(visibleOn ?? false).center()
          else
            AppLoader(
                    visibleOn: visibleOn ?? appStore.isLoading,
                    loaderSize: size)
                .center(),
        ],
      ),
    );
  }
}
