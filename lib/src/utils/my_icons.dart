 

 
 import 'package:flutter/material.dart';


class MyIcons extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? size;
  final void Function()? onPressed;
   const MyIcons(this.icon,{super.key,    this.color,  this.size, this.onPressed});
 
   @override
   Widget build(BuildContext context) {
     return IconButton(onPressed: onPressed??()=>Navigator.of(context).pop(), icon:
     
     Icon(icon?? Icons.circle, color:color??Colors.black,
     
     size: size??20.0,
     ));
   }
 }