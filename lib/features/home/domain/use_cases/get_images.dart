import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/repositories/image_repository.dart';

class GetImages{
  final ImageRepository repository;

  GetImages(this.repository);

  Future<List<ImageEntity>> call() async{
    debugPrint("GetImages called");
    return await repository.getImages();
  }
}