import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';

FirebaseStorage storageReference = FirebaseStorage.instance;

Future<String> uploadPhoto(
    String type, BuildContext context, bool camera) async {
  final configure = Provider.of<ControllersProvider>(context, listen: false);
  try {
    File image = await ImagePicker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery);
    configure.isLoading = true;
    String path = image.path.split("/")[image.path.split("/").length - 1];
    StorageReference ref = storageReference.ref().child("$type/$path");
    StorageUploadTask uploadTask = ref.putFile(image);

    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    final uri = await storageTaskSnapshot.ref.getDownloadURL();
    configure.isLoading = false;
    return uri;
  } catch (e) {
    print("excepcion: " + e.toString());
    configure.isLoading = false;
    return "";
  }
}
