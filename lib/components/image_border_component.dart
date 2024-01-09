import 'package:flutter/material.dart';
import 'package:solidcare/components/cached_image_widget.dart';
import 'package:solidcare/components/zoom_image_screen.dart';
import 'package:solidcare/main.dart';
import 'package:solidcare/utils/colors.dart';
import 'package:solidcare/utils/extensions/widget_extentions.dart';
import 'package:nb_utils/nb_utils.dart';

class ImageBorder extends StatelessWidget {
  final String src;
  final double height;
  final double? width;
  final bool isCircle;
  final double? borderRadius;
  final String? nameInitial;

  ImageBorder(
      {required this.src,
      required this.height,
      this.width,
      this.isCircle = true,
      this.borderRadius,
      this.nameInitial});

  @override
  Widget build(BuildContext context) {
    return GradientBorder(
      gradient: LinearGradient(
          colors: [primaryColor, appSecondaryColor], tileMode: TileMode.mirror),
      strokeWidth: 2,
      borderRadius: borderRadius ?? 80,
      child: src.isNotEmpty
          ? CachedImageWidget(
              url: src,
              circle: isCircle,
              height: height,
              width: width,
              radius: borderRadius,
              fit: BoxFit.cover,
            ).appOnTap(
              () {
                if (src.isNotEmpty)
                  ZoomImageScreen(galleryImages: [src], index: 0).launch(
                      context,
                      pageRouteAnimation: pageAnimation,
                      duration: pageAnimationDuration);
              },
            )
          : PlaceHolderWidget(
              shape: BoxShape.circle,
              height: height,
              width: width ?? height,
              alignment: Alignment.center,
              child: Text(nameInitial.capitalizeFirstLetter() ?? '',
                  style: boldTextStyle(color: Colors.black)),
            ),
    );
  }
}
