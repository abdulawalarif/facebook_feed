import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import '../routes/routes_name.dart';
import 'profile_and_name.dart';

class FeedMakePostWidget extends StatelessWidget {
  const FeedMakePostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RoutesName.createPostScreen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(2.w),
            CircularProfilePicture(
              url: 'https://avatar.iran.liara.run/public',
            ),
            Gap(2.w),
            _buildPostTextField(context),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                FontAwesomeIcons.solidImages,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPostTextField(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color.fromARGB(255, 159, 159, 159)),
        ),
        child: const Text('What\'s on your mind?'),
      ),
    );
  }
}

