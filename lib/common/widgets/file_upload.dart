import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileUpload {
  static forFileUpload() async {
    var cloudinary = CloudinaryPublic('dc3wulwt8', 'kbachau', cache: false);
    final ImagePicker picker = ImagePicker();
    List<String> urls = [];
    final List<XFile?> image = await picker.pickMultiImage();
    for (var i = 0; i < image.length; i++) {
      File file = File(image[i]!.path);

      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            file.path,
            resourceType: CloudinaryResourceType.Image,
          ),
        );
        urls.add(response.secureUrl);
        debugPrint(response.secureUrl);
      } on CloudinaryException catch (e) {
        debugPrint(e.message);
        debugPrint(e.request.toString());
      }
    }
  }
}
