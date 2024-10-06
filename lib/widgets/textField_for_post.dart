import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class TextFieldForPostWhiteBG extends StatelessWidget {
  final TextEditingController postController;
  final FocusNode postFocusNode;

  const TextFieldForPostWhiteBG({
    super.key,
    required this.postController,
    required this.postFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: postController,
      focusNode: postFocusNode,
      inputFormatters: [CapitalizeFirstLetterInputFormatter()],
      decoration: InputDecoration(
        hintText: "What's on your mind?",
        contentPadding: EdgeInsets.only(
          left: 5.w,
          top: 4.h,
          bottom: 4.h,
        ),
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

  const TextFieldForPostWithDifferentBG({
    super.key,
    required this.postController,
    required this.postFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: postController,
      focusNode: postFocusNode,
      cursorColor: Colors.white,
      inputFormatters: [CapitalizeFirstLetterInputFormatter()],
      decoration: InputDecoration(
        hintText: "What's on your mind ?!",
        contentPadding: EdgeInsets.only(
          left: 5.w,
          top: 4.h,
          bottom: 4.h,
        ),
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

class CapitalizeFirstLetterInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (text.isEmpty) {
      return newValue;
    }

    StringBuffer buffer = StringBuffer();
    bool capitalizeNext = true;
    int selectionIndex = newSelection.end;

    for (int i = 0; i < text.length; i++) {
      String currentChar = text[i];

      if (capitalizeNext && currentChar != ' ') {
        buffer.write(currentChar.toUpperCase());
        if (i == selectionIndex - 1) {
          selectionIndex = buffer.length;
        }
        capitalizeNext = false;
      } else {
        buffer.write(currentChar);
        if (i == selectionIndex - 1) {
          selectionIndex = buffer.length;
        }
      }

      if (currentChar == '.' || currentChar == '?' || currentChar == '!') {
        capitalizeNext = true;
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
