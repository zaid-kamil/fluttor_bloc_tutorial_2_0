import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/repositories/image_repository.dart';

class ImageOperations {
  final ImageRepository repository;

  ImageOperations(this.repository);

  Future<List<ImageEntity>> getImages() async {
    return await repository.getImages();
  }

  Future<void> uploadImages(String image) async {
    return await repository.uploadImage(image);
  }

  Future<void> uploadImagesWeb(String name, Uint8List imageBytes) async {
    return await repository.uploadImageWeb(name, imageBytes);
  }

  Future<void> deleteImage(ImageEntity image) async {
    return await repository.deleteImage(image);
  }
}
