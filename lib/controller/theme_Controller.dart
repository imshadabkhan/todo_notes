import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController{
  RxBool theme_value = false.obs;
  RxBool txtcolor = true.obs;
  Color ? color;
   changeTheme(){

    theme_value.value=!theme_value.value;
    Get.changeThemeMode(theme_value.value ? ThemeMode.dark:ThemeMode.light);


  }
  changetxtTheme() {
    txtcolor.value != txtcolor.value;
    if(txtcolor.value==txtcolor.value){color=Colors.black;} else {color=Colors.white;}
         }

}