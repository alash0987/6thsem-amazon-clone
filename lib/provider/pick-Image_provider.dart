// ignore_for_file: file_names

import 'dart:io';

import 'package:amazonclone/constants/utils.dart';
import 'package:flutter/material.dart';

class PickImageProvider extends ChangeNotifier {
  List<File> _images = [];
  List<File> get images => _images;

  selectImages() async {
    var res = await pickImageFromGallery();
    if (res.isNotEmpty) {
      _images = res;
    }
    notifyListeners();
  }
}
