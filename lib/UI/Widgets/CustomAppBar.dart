import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final double? size;
  final double? leadingPadding;
  final double? leadingWidth;
  // final Color

  const CustomAppBar({super.key, this.leadingWidth,this.title,this.titleWidget,this.bottom, this.size,this.actions,this.centerTitle = true,this.leadingPadding});

  @override
  Size get preferredSize =>  Size.fromHeight(size??55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark,statusBarIconBrightness: Brightness.dark,statusBarColor: Colors.transparent),
      elevation: 0,
      centerTitle: centerTitle,

      title: titleWidget??Text(
        title??'',
        softWrap: true,
        maxLines: 2,

        style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width * .045,fontWeight: FontWeight.normal),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      leadingWidth: leadingWidth,
      actions: actions,
      bottom: bottom,
      titleSpacing: leadingPadding,
    ); // Your custom widget implementation.
  }
}
