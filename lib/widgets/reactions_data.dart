import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

const defaultInitialReaction = Reaction<String>(
  value: null,
  icon: Icon(Icons.thumb_up_alt_outlined),
);

final List<Reaction<String>> reactions = [
  Reaction<String>(
    value: 'Like',
    previewIcon: Image.asset(
      'assets/images/thumb_up.png',
    ),
    icon: Image.asset(
      'assets/images/thumb_up.png',
    ),
  ),
  Reaction<String>(
    value: 'Happy',
    previewIcon: Image.asset(
      'assets/images/happy.png',
    ),
    icon: Image.asset(
      'assets/images/happy.png',
    ),
  ),
  Reaction<String>(
    value: 'In love',
    previewIcon: Image.asset(
      'assets/images/in-love.png',
    ),
    icon: Image.asset(
      'assets/images/in-love.png',
    ),
  ),
  Reaction<String>(
    value: 'Sad',
    previewIcon: Image.asset(
      'assets/images/sad.png',
    ),
    icon: Image.asset(
      'assets/images/sad.png',
    ),
  ),
  Reaction<String>(
    value: 'Surprised',
    previewIcon: Image.asset(
      'assets/images/surprised.png',
    ),
    icon: Image.asset(
      'assets/images/surprised.png',
    ),
  ),
  Reaction<String>(
    value: 'Mad',
    previewIcon: Image.asset(
      'assets/images/mad.png',
    ),
    icon: Image.asset(
      'assets/images/mad.png',
    ),
  ),
];
