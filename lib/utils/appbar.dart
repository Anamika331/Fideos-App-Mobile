import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key, this.leading, this .title, this.actions});
  final Widget? leading;
  final Widget? title;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: leading,
    
      title: title,
      actions: [Padding(
        padding: const EdgeInsets.only(right: 10),
        child: actions!,
      )],
    );
  }
}