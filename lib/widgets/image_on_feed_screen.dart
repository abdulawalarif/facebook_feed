import 'package:facebook_feed/widgets/image_preview.dart';
import 'package:flutter/material.dart';

class ImageOnFeedScreen extends StatelessWidget {
  final List<String?>? listOfImages;
  const ImageOnFeedScreen({
    super.key,
    required this.listOfImages,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: listOfImages?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: ImagePreview(
            imagePath: listOfImages?[index] ?? '',
            height: 190,
            width: 190,
          ),
        );
      },
    );
  }
}
