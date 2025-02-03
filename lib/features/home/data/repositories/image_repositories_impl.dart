import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_tutorial/features/home/data/data_sources/remote_data_source.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final RemoteDataSource remoteDataSource;

  ImageRepositoryImpl(this.remoteDataSource);

  DateTime convertToDateTime(Timestamp timestamp) => timestamp.toDate();

  Timestamp convertToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  @override
  Future<List<ImageEntity>> getImages() {
    return remoteDataSource.getImages().then((value) {
      debugPrint("ImageRepositoryImpl getImages called");
      return value
          .map((e) => ImageEntity(
                url: e.url,
                name: e.name,
              ))
          .toList();
    });
  }

  @override
  Future<void> uploadImage(String image) {
    return remoteDataSource.uploadImageUsingPath(image);
  }

  @override
  Future<void> uploadImageWeb(String name, Uint8List imageBytes) {
    return remoteDataSource.uploadImageUsingBytes(name, imageBytes);
  }

  @override
  Future<void> deleteImage(ImageEntity image) {
    return remoteDataSource.deleteImage(image);
  }
}
