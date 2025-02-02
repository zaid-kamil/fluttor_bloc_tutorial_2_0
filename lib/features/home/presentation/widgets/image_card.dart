import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/features/home/data/model/firebase_image.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';

class ImageCard extends StatelessWidget {
  final ImageEntity image;

  const ImageCard({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            image.url,
            fit: BoxFit.cover,
          ),
          Text(image.name),
        ],
      ),
    );
  }
}
