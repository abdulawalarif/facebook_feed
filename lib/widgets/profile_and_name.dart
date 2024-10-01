import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAndName extends StatelessWidget {
  const ProfileAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(2.w),
        CircularProfilePicture(
          url: 'https://avatar.iran.liara.run/public',
        ),
        Gap(2.w),
        const Text(
          'Tom Hardy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CircularProfilePicture extends StatelessWidget {
  final String url;

  static final Map<String, CircularProfilePicture> _cache = {};

  const CircularProfilePicture._internal({required this.url});

  factory CircularProfilePicture({required String url}) {
    if (_cache.containsKey(url)) {
      return _cache[url]!;
    }

    final instance = CircularProfilePicture._internal(url: url);
    _cache[url] = instance;
    return instance;
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: 9.w,
        height: 4.h,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            height: 4.h,
            width: 8.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
        ),
      ),
    );
  }
}
