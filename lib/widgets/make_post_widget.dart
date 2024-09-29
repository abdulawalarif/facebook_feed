import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import '../routes/routes_name.dart';

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
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(2.w),
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  width: 9.w,
                  height: 4.h,
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
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

class RoundProfileTile extends StatelessWidget {
  const RoundProfileTile({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Color(0xFFC9CCD3),
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}
