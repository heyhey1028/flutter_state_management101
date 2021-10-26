import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  MainAppBar({
    Key key,
    this.title,
    this.onPressed,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.visibility),
        ),
      ],
    );
  }
}
