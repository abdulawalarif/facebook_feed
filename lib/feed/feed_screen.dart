import 'package:facebook_feed/widgets/image_on_feed_screen.dart';
import 'package:facebook_feed/widgets/profile_and_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:facebook_feed/providers/post_provider.dart';
import 'package:facebook_feed/widgets/reactions_data.dart' as data;
import 'package:facebook_feed/models/post_model.dart';
import 'package:facebook_feed/routes/routes_name.dart';
import 'package:facebook_feed/widgets/make_post_widget.dart';
import 'package:facebook_feed/widgets/reactions_data.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final GlobalKey _popupMenuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, posts, _) {
        return Scaffold(
          body: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: posts.allPosts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                // The first item is FeedMakePostWidget
                return const FeedMakePostWidget();
              } else {
                final post = posts.allPosts[index - 1];
                // You can create a custom widget to display each post, e.g., PostItemWidget
                return PostItemWidget(post: post, index: index - 1);
              }
            },
          ),
        );
      },
    );
  }

  Widget PostItemWidget({required PostModel post, required int index}) {
    return post.color == Colors.white
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              usersInfFOrShowingPosts(post: post, index: index),
              post.posts!.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      child: Text(
                        post.posts!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
              ImageOnFeedScreen(
                listOfImages: post.images,
              ),
              Container(
                height: 55,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReactionButton<String>(
                      itemSize: const Size.square(40),
                      onReactionChanged: (Reaction<String>? reaction) {
                        debugPrint('Selected value: ${reaction?.value}');
                      },
                      reactions: reactions,
                      placeholder: data.defaultInitialReaction,
                      selectedReaction: reactions.first,
                    ),
                    CommentsWidget(post, index),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.share,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        : Column(
            children: [
              usersInfFOrShowingPosts(post: post, index: index),
              Gap(1.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Container(
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: post.color,
                    image: post.selectedBgAsImage!.isEmpty
                        ? null
                        : DecorationImage(
                            image: AssetImage(post.selectedBgAsImage!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  child: Center(
                    child: Text(
                      post.posts!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(1.h),
              Container(
                height: 55,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReactionButton<String>(
                      itemSize: const Size.square(40),
                      onReactionChanged: (Reaction<String>? reaction) {
                        debugPrint('Selected value: ${reaction?.value}');
                      },
                      reactions: reactions,
                      placeholder: data.defaultInitialReaction,
                      selectedReaction: reactions.first,
                    ),
                    CommentsWidget(post, index),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.share,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Gap(1.h),
            ],
          );
  }

  Widget usersInfFOrShowingPosts(
      {required PostModel post, required int index}) {
    final posts = Provider.of<PostProvider>(context, listen: false);
    return Row(
      children: [
        CircularProfilePicture(
          url: 'https://avatar.iran.liara.run/public',
        ),
        Gap(2.w),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ronald',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            Row(
              children: [Text('1h')],
            ),
          ],
        ),
        const Spacer(),
        PopupMenuButton<SelectedOptionForUpdateDelete>(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          icon: const Icon(Icons.more_horiz),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: SelectedOptionForUpdateDelete.update,
              child: Text('Update'),
            ),
            const PopupMenuItem(
              value: SelectedOptionForUpdateDelete.delete,
              child: Text('Delete'),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case SelectedOptionForUpdateDelete.update:
                Map<String, dynamic> arguments = {
                  'postModel': post,
                  'index': index,
                };
                Navigator.of(context).pushNamed(RoutesName.updatePostScreen,
                    arguments: arguments);
              case SelectedOptionForUpdateDelete.delete:
                posts.removePost(index);
            }
          },
        )
      ],
    );
  }

  Widget CommentsWidget(PostModel post, int index) {
    Map<String, dynamic> arguments = {
      'postModel': post,
      'index': index,
    };
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutesName.comments, arguments: arguments);
      },
      child: const Row(
        children: [
          Icon(
            Icons.message,
            size: 16,
            color: Colors.black87,
          ),
          SizedBox(width: 5),
          Text(
            'Comment',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

enum SelectedOptionForUpdateDelete {
  update,
  delete,
}

Widget likeCommentsWidgets() {
  return Row(
    children: [
      GestureDetector(
        onTap: () {},
        onLongPress: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              const Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.black87,
              ),
              Gap(2.w),
              const Text(
                'Like',
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      ),
      Gap(3.w),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Row(
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              color: Colors.black87,
            ),
            Gap(2.w),
            const Text(
              'Comments',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    ],
  );
}
