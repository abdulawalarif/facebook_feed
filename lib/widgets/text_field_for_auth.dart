import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GetTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  bool hasFocus;
  FocusNode? nextTextFieldFocusNode;
  FocusNode? currentTextFieldFocusNode;
  TextInputAction? textInputAction;




  GetTextFormField({
    required this.controller,
    required this.hintName,
    required this.hasFocus,
    this.nextTextFieldFocusNode,
    this.currentTextFieldFocusNode,
    this.textInputAction = TextInputAction.done,

  });

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        key: ValueKey(hintName),
        validator: (value) {
          if(hintName=="Email"){
            if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                .hasMatch(value??"")){
              return 'Please enter a valid email address.';
            }
          }else{
            if(value!.isEmpty){
              return 'Please enter $hintName';
            }else{
              return null;
            }
          }

        },
        maxLines: 1,
        controller: controller,
        focusNode: currentTextFieldFocusNode,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 3.w), // Increase top and bottom padding

          hintText: "Enter your $hintName",

          fillColor: Colors.white,
          filled: true,
          label: Text(
            hintName,
            style: TextStyle(
                color: hasFocus
                    ? Colors.black
                    : Colors.black54),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Set the border radius

            borderSide:
            BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Set the border radius

            borderSide: BorderSide(
                color: Colors.black54, width: 1.0),
          ),
        ),
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(nextTextFieldFocusNode),
      ),
    );
  }
}