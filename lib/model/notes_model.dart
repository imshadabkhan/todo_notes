
import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject{
  @HiveField(0)
  String title;
  NotesModel({required this.title} );


  }