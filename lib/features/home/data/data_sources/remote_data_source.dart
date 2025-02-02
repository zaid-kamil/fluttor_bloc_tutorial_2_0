import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_tutorial/features/home/data/model/firebase_image.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';

class RemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  RemoteDataSource();

  Future<List<FireImage>> getImages() async {
    final snapshot = await firestore.collection('images').get();
    debugPrint("RemoteDataSource getImages called");
    return snapshot.docs
        .map((e) => FireImage.fromMap(e.data(), e.id))
        .toList();
  }

  Future<void> uploadImage(String imagePath) async {
    final ref = storage.ref().child('images').child(DateTime.now().toString());
    final file = File(imagePath);
    await ref.putFile(file).then((value) async {
      final url = await value.ref.getDownloadURL();
      await firestore.collection('images').add({
        'url': url,
        'name': file.path.split('/').last,
        'createdAt': Timestamp.now(),
      });
    });
  }
}
