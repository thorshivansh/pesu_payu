import 'package:flutter/material.dart';
class PaymentRoutes{
static Future<void> preventDuplicate(dynamic pageName , BuildContext context)async{
   Navigator.popUntil(context, ModalRoute.withName(pageName));
    //  Get.toNamed(pageName);
    Navigator.pushNamed(context, pageName);

}
}