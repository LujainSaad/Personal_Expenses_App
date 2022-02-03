import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButtons extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  AdaptiveButtons({ 
  required this.text, 
  required this.handler});

  Widget build(BuildContext context) {
    return Platform.isIOS? CupertinoButton(
      child: Text(text,
        style: TextStyle(
        color: Theme.of(context).primaryColor),
        ),
        onPressed: handler,
      ):TextButton(
        child: Text(text,
        style: TextStyle(
        color: Theme.of(context).primaryColor),
        ),
        onPressed: handler,
        );
  }
}