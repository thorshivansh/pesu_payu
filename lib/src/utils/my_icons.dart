 

 
 import 'package:flutter/material.dart';
import 'package:pesu_payu/src/utils/color/colors.dart';

class MyIcons extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double? size;
   const MyIcons(this.icon,{super.key,    this.color,  this.size});
 
   @override
   Widget build(BuildContext context) {
     return Icon(icon?? Icons.circle, color:color??Colors.black,
     
     size: size??8.0,
     );
   }
 }