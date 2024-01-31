import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'app_colors.dart';

class CircleImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final Color? placeHolderColor;
  final Color? placeBorderColor;

  const CircleImage(
      {Key? key,
      required this.imageUrl,
      this.width,
      this.height,
      this.placeHolderColor,
      this.placeBorderColor})
      : super(key: key);

  @override
  State<CircleImage> createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000.0),
      child: CachedNetworkImage(
        alignment: Alignment.topCenter,
        imageUrl: widget.imageUrl.toString().replaceAll(' ', '&'),
        width: widget.width ?? 5.h,
        height: widget.height ?? 5.h,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => SizedBox(
          width: widget.width ?? 5.h,
          height: widget.height ?? 5.h,
          child: Container(
            width: widget.width ?? 5.h,
            height: widget.height ?? 5.h,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              size: widget.height,
              Icons.person,
              color: widget.placeHolderColor ?? AppColors.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
