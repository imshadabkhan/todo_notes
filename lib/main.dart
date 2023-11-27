import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:todo_notes/controller/theme_Controller.dart';
import 'package:todo_notes/model/addtolist_model.dart';
import 'package:todo_notes/model/notes_model.dart';
import 'package:todo_notes/view/home_view/home.dart';
import 'package:path_provider/path_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>("Todo");
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  ThemeController _themeController = Get.put(ThemeController());
  // TaskData taskData=TaskData();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        buttonTheme: ButtonThemeData(buttonColor:Color(0xffFFDD43),
        ),
       iconTheme: IconThemeData(color: Colors.black),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffFFDD43),
          foregroundColor: Colors.black,
        ),
      ),
       darkTheme: ThemeData.dark(),
       themeMode: _themeController.theme_value.value?ThemeMode.light:ThemeMode.dark,
       home: Home_View(),
    );
  }
}