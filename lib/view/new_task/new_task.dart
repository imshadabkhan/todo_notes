import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:todo_notes/boxes/boxes.dart';
import 'package:todo_notes/controller/addingtolist_controller.dart';
import 'package:todo_notes/model/addtolist_model.dart';
import 'package:todo_notes/model/notes_model.dart';
import 'package:todo_notes/view/home_view/home.dart';
import 'package:speech_to_text/speech_to_text.dart';

class New_Task extends StatefulWidget {
  @override
  State<New_Task> createState() => _New_TaskState();
}

class _New_TaskState extends State<New_Task> {


  bool _speechEnabled = false;
  var isListening = false;
  var titleController = TextEditingController();
  AddingToListController addingToListController =
      Get.put(AddingToListController());
  SpeechToText _speechToText = SpeechToText();
  var text;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // TODO: implement widget

  void _speechIntialize() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
    titleController.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30.0),
        child: AvatarGlow(
          endRadius: 40.0,
          glowColor: Colors.black12,
          duration: Duration(milliseconds: 2000),
          repeat: isListening,
          repeatPauseDuration: Duration(milliseconds: 300),
          child: GestureDetector(
            onTapDown: (_) {
              isListening = true;
              _speechIntialize();
              _speechToText.listen(onResult: (result) {
                setState(() {
                  text = result.recognizedWords;
                });
              });
            },
            onTapUp: (_) {
              isListening = false;
              _stopListening();
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xffFFDD43),
              child: Icon(isListening ? Icons.mic_none : Icons.mic),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Text(
          "New Task",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("ADD TASK",style: TextStyle(color:Colors.black,fontSize: 20),),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Add Task Here..",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 90,
            ),
            Container(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFDD43),
                      elevation: 0,
                    ),
                    onPressed: () {
                      final data = NotesModel(title: titleController.text);
                      final box = Boxes.getData();

                      box.add(data);
                      data.save();

                      // addingToListController.addToList( titleController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_View()));
                    },
                    child: Text(
                      "Add Task",
                      style: TextStyle(color: Colors.black),
                    ),),),
           
          ],
        ),
      ),
    );
  }
}
