import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';

abstract class ImageRepository {
  Future<List<ImageEntity>> getImages();
  Future<void> uploadImage(String image);
}