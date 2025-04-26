import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

class BookImage extends StatelessWidget {
  final String? imageUrl;

  const BookImage({super.key, required this.imageUrl});

  @override
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
