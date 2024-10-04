import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFieldForPostWhiteBG extends StatelessWidget {
  final TextEditingController postController;
  final FocusNode postFocusNode;

  const TextFieldForPostWhiteBG(
      {super.key, required this.postController, required this.postFocusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: postController,
      focusNode: postFocusNode,
      decoration: InputDecoration(
        hintText: "What's on your mind?",
        contentPadding: EdgeInsets.only(left: 5.w, top: 4.h, bottom: 4.h),
        border: InputBorder.none,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      maxLines: null,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
    );
  }
}

class TextFieldForPostWithDifferentBG extends StatelessWidget {
  final TextEditingController postController;
  final FocusNode postFocusNode;

  const TextFieldForPostWithDifferentBG(
      {super.key, required this.postController, required this.postFocusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: postController,
      focusNode: postFocusNode,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "What's on your mind?",
        contentPadding: EdgeInsets.only(left: 5.w, top: 4.h, bottom: 4.h),
        border: InputBorder.none,
        hintStyle: const TextStyle(
          height: 3,
          // Set the font size for the hint
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      maxLines: null,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
