import 'dart:io';

import 'package:amazonclone/constants/global_variable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      duration: const Duration(seconds: 3),
      backgroundColor: appPrimaryColor,
      animation: CurvedAnimation(
        parent: AnimationController(
          vsync: ScaffoldMessenger.of(context),
          duration: const Duration(milliseconds: 300),
        ),
        curve: Curves.easeInOutCubicEmphasized,
        reverseCurve: Curves.easeOut,
      ),
    ),
  );
}

//  pick Images from gallery
Future<List<File>> pickImageFromGallery() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return images;
}
