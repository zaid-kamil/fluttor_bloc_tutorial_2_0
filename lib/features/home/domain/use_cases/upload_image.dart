// lib/domain/use_cases/upload_image.dart

import 'package:flutter_bloc_tutorial/features/home/domain/repositories/image_repository.dart';

class UploadImage {
  final ImageRepository repository;

  UploadImage(this.repository);

  Future<void> call(String image) async {
    return await repository.uploadImage(image);
  }
}
