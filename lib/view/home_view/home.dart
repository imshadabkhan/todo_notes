import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo_notes/controller/addingtolist_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_notes/controller/theme_Controller.dart';
import 'package:todo_notes/model/notes_model.dart';
import 'package:todo_notes/view/new_task/new_task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../boxes/boxes.dart';
class Home_View extends StatefulWidget {
  @override
  State<Home_View> createState() => _Home_ViewState();
}

class _Home_ViewState extends State<Home_View> {
  var dialogBoxTitleController = TextEditingController();
  ThemeController themeController = Get.put(ThemeController());
  String? text;
  // Home_View(this.taskData);
  AddingToListController addingtolistcontroller =
      Get.put(AddingToListController());
  void _delete(NotesModel notesmodel) async {
    return await notesmodel.delete();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Route _createRoute() {
    //navigation animation
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => New_Task(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          backgroundColor: Color(0xffFFDD43),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFDD43),
        title: Text(
          "Todo App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.light_mode_outlined,
                  color: Colors.black,
                ),
                Obx(
                  () => Switch(
                      activeColor: Colors.black12,
                      inactiveThumbColor: Colors.white,
                      value: Get.find<ThemeController>().theme_value.value,
                      onChanged: (value) {
                        setState(() {});
                        Get.find<ThemeController>().changeTheme();
                      }),
                ),
                Icon(Icons.dark_mode_outlined, color: Colors.black),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return Column(
              children: [
                Expanded(
                  child: Card(
                    child: Container(
                      child: data.length > 0
                          ? ListView.builder(
                              itemCount: Boxes.getData().length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0,
                                          left: 8,
                                          right: 8,
                                          top: 8),
                                      child: Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(0xffFFDD43),
                                        ),
                                        child: Slidable(
                                          endActionPane: ActionPane(
                                            motion: ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: (_) {
                                                  _delete(data[index]);
                                                },
                                                backgroundColor:
                                                    Color(0xFFFE4A49),
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete,
                                              ),
                                              SlidableAction(
                                                onPressed: (_) {
                                                  Get.dialog(
                                                    AlertDialog(
                                                      title: Text("Edit"),
                                                      content: TextFormField(
                                                        controller:
                                                            dialogBoxTitleController,
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Cancel"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            var box =
                                                                Boxes.getData()
                                                                    .getAt(
                                                                        index);
                                                            box?.title = dialogBoxTitleController.text;
                                                            box?.save();
                                                            // Replace 'index' with the correct index
                                                            // Update the title and save

                                                            Navigator.pop(
                                                                context); //
                                                            dialogBoxTitleController.clear();
                                                          },
                                                          child: Text("Edit"),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                backgroundColor:
                                                    Color(0xFFFE7B34),
                                                foregroundColor: Colors.white,
                                                icon: Icons.edit,
                                              ),
                                              SlidableAction(
                                                onPressed: (_) {},
                                                backgroundColor:
                                                    Color(0xFF21B7CA),
                                                foregroundColor: Colors.white,
                                                icon: Icons.share,
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                            onDoubleTap: () {
                                              _delete(data[index]);
                                              Get.snackbar("Task Completed",
                                                  "Successfully");
                                            },
                                            child: ListTile(
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                  data[index].title.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              subtitle: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    formattedDate,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    formattedTime,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
                          : Center(
                              child: Container(
                                height: 250,
                                width: 200,
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/homepage_image-removebg.png"),
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => Text(
                                        "Nothing To Do .....",
                                        style: TextStyle(
                                            color: Get.find<ThemeController>()
                                                .changetxtTheme(),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                //
              ],
            );
          },
        ),
      ),
    );
  }
}
