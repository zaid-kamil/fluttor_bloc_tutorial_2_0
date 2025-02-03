
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';

abstract class ImageRepository {
  Future<List<ImageEntity>> getImages();
  Future<void> uploadImage(String image);
  Future<void> uploadImageWeb(String name, Uint8List imageBytes);
  Future<void> deleteImage(ImageEntity image);
}