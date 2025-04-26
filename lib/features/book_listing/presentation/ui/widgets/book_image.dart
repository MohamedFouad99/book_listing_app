import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookImage widget which is used to display a book's image.
class BookImage extends StatelessWidget {
  final String? imageUrl;

  const BookImage({super.key, required this.imageUrl});

  @override
  /// Builds the BookImage widget which displays a book's image.
  ///
  /// The widget is a [Container] with a rounded border and a grey background color.
  /// The image is loaded using [CachedNetworkImage] and is displayed with a
  /// [BoxFit.cover] fit.
  ///
  /// While the image is loading a [CircularProgressIndicator] is displayed
  /// with a color of [ColorsManager.primary] and a stroke width of 2.
  ///
  /// If there is an error loading the image an [Icon] of a broken image is
  /// displayed with a size of 40 and a color of [ColorsManager.primary].
  ///
  /// If [imageUrl] is null an [Icon] of a broken image is displayed with a
  /// size of 40 and a color of [ColorsManager.primary].
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 100.h,
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.shade300,
      ),
      clipBehavior: Clip.antiAlias,
      child:
          imageUrl != null
              ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          color: ColorsManager.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Icon(
                      Icons.broken_image,
                      size: 40.w,
                      color: Colors.grey,
                    ),
              )
              : Icon(Icons.broken_image, size: 40.w, color: Colors.grey),
    );
  }
}
