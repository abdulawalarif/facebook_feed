import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:facebook_feed/models/post_model.dart';
import 'package:facebook_feed/providers/post_provider.dart';

class Comments extends StatefulWidget {
  final int index;
  PostModel postModel;
  Comments({super.key, required this.index, required this.postModel});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController comment = TextEditingController();
  List<String> comments = [];
  @override
  void initState() {
    super.initState();
    comments = widget.postModel.comments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, posts, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Comments',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var individualComments = comments;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    usersInfFOrShowingPosts(index: index),
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: Text(
                        individualComments[index] ?? '',
                        style: const TextStyle(),
                      ),
                    )
                  ,],
                ),
              );
            },
          ),
          bottomSheet: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: comment,
                      decoration: const InputDecoration(
                          hintText: 'Type your comment here',),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      comments.add(comment.text);
                    });
                    posts.updatePost(
                        widget.index,
                        PostModel(
                            posts: widget.postModel.posts,
                            color: widget.postModel.color,
                            selectedBgAsImage:
                                widget.postModel.selectedBgAsImage,
                            images: widget.postModel.images,
                            comments: comments,),);
                    comment.clear();
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget usersInfFOrShowingPosts({required int index}) {
    final posts = Provider.of<PostProvider>(context, listen: false);
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/avatar.jpg',
            width: 9.w,
            height: 4.h,
            fit: BoxFit.cover, // Adjust the fit as needed
          ),
        ),
        Gap(2.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Abdul Awal Arif',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Row(
              children: [Text('1h')],
            )
          ,],
        ),
        const Spacer(),
        PopupMenuButton<SelectedOptionForUpdateDelete>(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),),
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
                comment.text = comments[index];
                setState(() {
                  comments.removeAt(index);
                });

              case SelectedOptionForUpdateDelete.delete:
                setState(() {
                  comments.removeAt(index);
                });
            }
          },
        ),
      ],
    );
  }
}

enum SelectedOptionForUpdateDelete {
  update,
  delete,
}
