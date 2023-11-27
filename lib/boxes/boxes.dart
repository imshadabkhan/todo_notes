import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import '../model/notes_model.dart';
class Boxes{
  static Box<NotesModel> getData() => Hive.box("Todo");}