import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facebook_feed/models/post_model.dart';
import 'package:facebook_feed/providers/post_provider.dart';
import 'package:facebook_feed/widgets/image_preview.dart';

import '../widgets/image_picker.dart';
import '../widgets/profile_and_name.dart';
import '../widgets/textField_for_post.dart';

class UpdatePostScreen extends StatefulWidget {
  PostModel postModel;
  final int index;
  UpdatePostScreen({super.key, required this.postModel, required this.index});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  Color currentColor = Colors.white;
  late TextEditingController _postController;
  late FocusNode _postFocusNode;

  int numberOfLines = 1;
  String bgImagePath = '';
  bool imageSelectedAsBackground = false;
  List<String>? images = [];
  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
    _postFocusNode = FocusNode();

    currentColor = widget.postModel.color!;
    _postController.text = widget.postModel.posts!;
    bgImagePath = widget.postModel.selectedBgAsImage ?? "";
    imageSelectedAsBackground =
        widget.postModel.selectedBgAsImage!.isEmpty ? false : true;

    images = widget.postModel.images;
    _postController.addListener(_updateLineCount);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postFocusNode.requestFocus();
    });

  }
  void _updateLineCount() {
    final text = _postController.text;
    final lines = text.split('\n').length;
    setState(() {
      numberOfLines = lines;
      if (numberOfLines > 5) {
        currentColor = Colors.white;
        imageSelectedAsBackground = false;
        bgImagePath = '';
      }
    });
  }
  @override
  void dispose() {
    _postController.removeListener(_updateLineCount);
    _postController.dispose();
    _postFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<PostProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Update Post'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                if (_postController.text.isEmpty && images!.isEmpty) {
                  const snackBar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Nothing to Update'),
                    duration: Duration(seconds: 2),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  const snackBar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Post updated'),
                    duration: Duration(seconds: 2),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    posts.updatePost(
                      widget.index,
                      PostModel(
                        posts: _postController.text,
                        color: images!.isEmpty ? currentColor : Colors.white,
                        selectedBgAsImage: bgImagePath,
                        images: images,
                        comments: widget.postModel.comments,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                  right: 4.w,
                ),
                child: Container(
                  height: 4.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      ' Update',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body:  ListView(
          children: [
            Gap(1.h),
            const ProfileAndName(),
            Gap(1.h),
            currentColor == Colors.white
                ? TextFieldForPostWhiteBG(
              postController: _postController,
              postFocusNode: _postFocusNode,
            )
                : Container(
              height: 30.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: currentColor,
                image: imageSelectedAsBackground
                    ? DecorationImage(
                  image: AssetImage(bgImagePath),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: Center(
                child: TextFieldForPostWithDifferentBG(
                  postController: _postController,
                  postFocusNode: _postFocusNode,
                ),
              ),
            ),
            Gap(1.h),
            numberOfLines > 5 || images!.isNotEmpty
                ? const SizedBox()
                : SizedBox(
              height: 6.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.white;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.black;
                          imageSelectedAsBackground = true;
                          bgImagePath = 'assets/images/bg_image2.jpg';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image:
                            AssetImage('assets/images/bg_image2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.black;
                          imageSelectedAsBackground = true;
                          bgImagePath = 'assets/images/img5.jpg';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/img5.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.black;
                          imageSelectedAsBackground = true;
                          bgImagePath = 'assets/images/bg_image1.jpg';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image:
                            AssetImage('assets/images/bg_image1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.red;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.green;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.blueAccent;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.black;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.teal;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.pink;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentColor = Colors.purple;
                          imageSelectedAsBackground = false;
                          bgImagePath = '';
                        });
                      },
                      child: Container(
                        height: 3.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: images?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    children: [
                      ImagePreview(
                        imagePath: images![index],
                        height: 190,
                        width: 190,
                      ),
                      Positioned(
                        top: 15,
                        right: 12,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              images!.remove(images![index]);
                            });
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        bottomSheet: SizedBox(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: .5.h),
                child: InkWell(
                  onTap: () async {
                    await selectImage();
                    setState(() {});
                  },
                  child: Icon(
                    images!.length < 1 ? Icons.image : Icons.add,
                    color: Colors.green,
                    size: 37,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectImage() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ), //this right here
          child: SizedBox(
            height: 25.h,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select Image From !',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String selectedImagePathProfile =
                              await ImagePickerClass.selectImageFromGallery();
                          if (selectedImagePathProfile != '') {
                            Navigator.pop(context);
                            setState(() {
                              images!.add(selectedImagePathProfile);
                              if (images!.isNotEmpty) {
                                currentColor = Colors.white;
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No Image Selected !'),
                              ),
                            );
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/gallery.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text('Gallery'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gap(5.w),
                      GestureDetector(
                        onTap: () async {
                          String selectedImagePathProfile =
                              await ImagePickerClass.selectImageFromCamera();
                          if (selectedImagePathProfile != '') {
                            Navigator.pop(context);
                            setState(() {
                              images!.add(selectedImagePathProfile);
                              if (images!.isNotEmpty) {
                                currentColor = Colors.white;
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No Image Captured !'),
                              ),
                            );
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/camera.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text('Camera'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
