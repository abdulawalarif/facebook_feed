import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ProfileAndName extends StatefulWidget {
  const ProfileAndName({super.key});

  @override
  State<ProfileAndName> createState() => _ProfileAndNameState();
}

class _ProfileAndNameState extends State<ProfileAndName> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gap(2.w),
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: 'https://avatar.iran.liara.run/public',
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
