import 'package:flutter/material.dart';

enum SelectedOptionForAPostLikesType {
  like,
  heart,
  care,
  haha,
  wow,
  sad,
  angry,
}

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SelectedOptionForAPostLikesType>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      icon: const Icon(Icons.more_horiz),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: SelectedOptionForAPostLikesType.like,
          child: Text('Like'),
        ),
        const PopupMenuItem(
          value: SelectedOptionForAPostLikesType.heart,
          child: Text('Heart'),
        ),
        const PopupMenuItem(
          value: SelectedOptionForAPostLikesType.care,
          child: Text('Care'),
        ),
        const PopupMenuItem(
          value: SelectedOptionForAPostLikesType.haha,
          child: Text('Haha'),
        ),
        const PopupMenuItem(
          value: SelectedOptionForAPostLikesType.wow,
          child: Text('Wow'),
        ),
        const PopupMenuItem(
          value: SelectedOptionForAPostLikesType.sad,
          child: Text('Sad'),
        ),
        const PopupMenuItem(
          value: SelectedOptionForAPostLikesType.angry,
          child: Text('Angry'),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case SelectedOptionForAPostLikesType.like:
          case SelectedOptionForAPostLikesType.heart:
          case SelectedOptionForAPostLikesType.care:
          case SelectedOptionForAPostLikesType.haha:
          case SelectedOptionForAPostLikesType.wow:
          case SelectedOptionForAPostLikesType.sad:
          case SelectedOptionForAPostLikesType.angry:
        }
      },
    );
  }
}
