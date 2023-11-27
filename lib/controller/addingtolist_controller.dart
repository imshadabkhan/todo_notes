import 'package:get/get.dart';


class AddingToListController extends GetxController {
  RxList addlist = [].obs;
  void addToList(task){
    addlist.add(task);

  }


}