
import 'package:flutter/material.dart';

enum _selectedOptionForAPostLikesType {
  Like,
  Heart,
  Care,
  Haha,
  Woow,
  Sad,
  Angry,
}


class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_selectedOptionForAPostLikesType>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      icon: Icon(Icons.more_horiz),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          child: Text("Like"),
          value: _selectedOptionForAPostLikesType.Like,
        ),
        const PopupMenuItem(
          child: Text("Heart"),
          value: _selectedOptionForAPostLikesType.Heart,
        ),  const PopupMenuItem(
          child: Text("Care"),
          value: _selectedOptionForAPostLikesType.Care,
        ),  const PopupMenuItem(
          child: Text("Haha"),
          value: _selectedOptionForAPostLikesType.Haha,
        ),  const PopupMenuItem(
          child: Text("Wow"),
          value: _selectedOptionForAPostLikesType.Woow,
        ),  const PopupMenuItem(
          child: Text("Sad"),
          value: _selectedOptionForAPostLikesType.Sad,
        ), const PopupMenuItem(
          child: Text("Angry"),
          value: _selectedOptionForAPostLikesType.Angry,
        ),
      ],
      onSelected: (value) {

        switch (value) {
          case  _selectedOptionForAPostLikesType.Like:
            print("like is pressed");
          case  _selectedOptionForAPostLikesType.Heart:
            print("like is pressed");
            case  _selectedOptionForAPostLikesType.Care:
            print("Care is pressed");
            case  _selectedOptionForAPostLikesType.Haha:
            print("Haha is pressed");
            case  _selectedOptionForAPostLikesType.Woow:
            print("Woow is pressed");
            case  _selectedOptionForAPostLikesType.Sad:
            print("Sad is pressed");
            case  _selectedOptionForAPostLikesType.Angry:
            print("Angry is pressed");
        }
      },
    );
  }
}
