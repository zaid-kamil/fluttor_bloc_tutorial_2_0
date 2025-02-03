import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_tutorial/features/home/data/model/firebase_image.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';

class RemoteDataSource {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  RemoteDataSource();

  Future<List<FireImage>> getImages() async {
    // final snapshot = await fireStore.collection('images').get();
    // debugPrint("RemoteDataSource getImages called");
    // return snapshot.docs.map((e) => FireImage.fromMap(e.data(), e.id)).toList();
    // get images in real-time
    return fireStore.collection('images').snapshots().map((snapshot) {
      return snapshot.docs
          .map((e) => FireImage.fromMap(e.data(), e.id))
          .toList();
    }).first;
  }

  Future<void> uploadImageUsingPath(String imagePath) async {
    debugPrint("RemoteDataSource uploadImage called: $imagePath");

    final ref = storage.ref().child('images').child(DateTime.now().toString());
    final file = File(imagePath);
    await ref.putFile(file).then((value) async {
      final url = await value.ref.getDownloadURL();
      await fireStore.collection('images').add({
        'url': url,
        'name': file.path.split('/').last,
        'createdAt': Timestamp.now(),
      });
    });
  }

  Future<void> uploadImageUsingBytes(String name, Uint8List imageBytes) async {
    debugPrint("RemoteDataSource uploadImageWeb called: name is $name");
    final ref = storage.ref().child('images').child(name);
    await ref.putData(imageBytes).then((value) async {
      final url = await value.ref.getDownloadURL();
      await fireStore.collection('images').add({
        'url': url,
        'name': name,
        'createdAt': Timestamp.now(),
      });
    });
  }

  Future<void> deleteImage(ImageEntity image) async {
    await storage.refFromURL(image.url).delete();
    await fireStore
        .collection('images')
        .where('url', isEqualTo: image.url)
        .get()
        .then((value) {
      for (var element in value.docs) {
        fireStore.collection('images').doc(element.id).delete();
      }
    });
  }
}
