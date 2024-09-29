import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facebook_feed/models/post_model.dart';
import 'package:facebook_feed/providers/post_provider.dart';
import 'package:facebook_feed/widgets/image_preview.dart';

class UpdatePostScreen extends StatefulWidget {
  PostModel postModel;
  final int index;
   UpdatePostScreen({super.key, required this.postModel, required this.index});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  Color currentColor= Colors.white;
  late TextEditingController _postController;
  int numberOfLines = 1;
  String bgImagePath='';
  bool imageSelectedAsBackground = false;
  List<String>?images=[];
  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
    currentColor= widget.postModel.color!;
    _postController.text= widget.postModel.posts!;
    bgImagePath= widget.postModel.selectedBgAsImage??"";
    imageSelectedAsBackground = widget.postModel.selectedBgAsImage!.isEmpty?false: true;

    images=widget.postModel.images;
  }

  @override
  Widget build(BuildContext context) {
    final posts =
    Provider.of<PostProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title:  Text("Update Post"),
          centerTitle: true,
          actions: [
            Padding(padding: EdgeInsets.only(right: 4.w, top: 1.h, bottom: 1.h),
              child: GestureDetector(
                onTap: (){
                  if(_postController.text.isEmpty &&images!.isEmpty){
                    final snackBar = SnackBar(
                      backgroundColor: Colors.black,
                      content: Text('Nothing to Update'),
                      duration: Duration(seconds: 2),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                    final snackBar = SnackBar(
                      backgroundColor: Colors.black,
                      content: Text('Post updated'),
                      duration: Duration(seconds: 2),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      posts.updatePost(widget.index,PostModel(posts: _postController.text, color:images!.isEmpty? currentColor:Colors.white,selectedBgAsImage: bgImagePath, images: images ));

                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  height: 2.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text(' Update',style: TextStyle(
                        fontWeight: FontWeight.bold,

                    ),),
                  ),
                ),
              ),


            )
          ],
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Gap(1.h),
            Row(
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
                const Text(
                  'Tom Hardy',
                  style:
                  TextStyle(  fontWeight: FontWeight.bold),
                )
              ],
            ),
            Gap(1.h),

            currentColor ==Colors.white? Flexible(

              child: TextField(
                autofocus: true,
                controller: _postController,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  contentPadding:
                  EdgeInsets.only(left: 5.w, top: 4.h, bottom: 4.h),
                  border: InputBorder.none,
                  hintStyle:const TextStyle(

                      fontWeight: FontWeight.bold,
                      color: Colors.black54

                  ),

                ),
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,


                onChanged: (val){
                  final lines = val.split('\n');
                  numberOfLines = lines.length;
                  setState(() {
                    numberOfLines = lines.length;
                  });

                },
              ),
            ):Container(
              height: 30.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: currentColor,
                image: imageSelectedAsBackground?  DecorationImage(
                  image: AssetImage(bgImagePath),
                  fit: BoxFit.cover,
                ):null,
              ),
              child: TextField(
                autofocus: true,
                controller: _postController,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  contentPadding:
                  EdgeInsets.only(left: 5.w, top: 4.h, bottom: 4.h),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(
                      height: 3,

                      fontWeight: FontWeight.bold,
                      color: Colors.black54

                  ),

                ),
                maxLines: 3,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                style: const TextStyle(
                     // Set the font size for the input text
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                ),
                onChanged: (val){
                  final lines = val.split('\n');
                  numberOfLines = lines.length;
                  if(numberOfLines>3){
                    setState(() {
                      currentColor = Colors.white;
                      bgImagePath = '';
                    });
                  }

                },
              ),
            ),
            Gap(1.h),
            numberOfLines < 4? SizedBox(
              height: 6.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  ///ba img 1
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child:GestureDetector(
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
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg_image2.jpg'),
                            fit: BoxFit.cover,
                          ),

                        ),
                      ),
                    ),
                  ),
                  ///ba img 2
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child:GestureDetector(
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
                          image: DecorationImage(
                            image: AssetImage('assets/images/img5.jpg'),
                            fit: BoxFit.cover,
                          ),

                        ),
                      ),
                    ),
                  ),
                  ///ba img 3
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child:GestureDetector(
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
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg_image1.jpg'),
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
                            borderRadius: BorderRadius.circular(10)),
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
                            borderRadius: BorderRadius.circular(10)),
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
                            borderRadius: BorderRadius.circular(10)),
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
                            borderRadius: BorderRadius.circular(10)),
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
                            borderRadius: BorderRadius.circular(10)),
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
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child:  GestureDetector(
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
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ):SizedBox(),


            GridView.builder(
              physics: NeverScrollableScrollPhysics(),

              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: images?.length??0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5),
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
                              images!.remove(
                                  images![index]);

                            });
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                BorderRadius
                                    .circular(20)),
                            child: const Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),


                    ],
                  ),
                );
              },
            )



          ],
        ),

        bottomSheet: SizedBox(
          child: Row(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w, vertical: .5.h),
                child: InkWell(
                  onTap: () async {
                    await selectImage();
                    setState(() {});
                  },
                  child: Icon(images!.length<1?Icons.image:Icons.add, color: Colors.green,size: 37,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            String selectedImagePathProfile =
                            await selectImageFromGallery();
                            if (selectedImagePathProfile != '') {
                              Navigator.pop(context);
                              setState(() {
                                images!.add(selectedImagePathProfile);
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Selected !"),
                              ));
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
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            String   selectedImagePathProfile =
                            await selectImageFromCamera();
                            if (selectedImagePathProfile != '') {
                              Navigator.pop(context);
                              setState(() {
                                images!.add(selectedImagePathProfile);
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Captured !"),
                              ));
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
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

}
