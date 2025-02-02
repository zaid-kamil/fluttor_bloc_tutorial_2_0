// firebase image model

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';

class FireImage {
  final String url;
  final String name;
  final Timestamp createdAt;

  FireImage({
    required this.url,
    required this.name,
    required this.createdAt,
  });

  factory FireImage.fromMap(Map<String, dynamic> data, String documentId) {
    final String url = data['url'];
    final String name = data['name'];
    final Timestamp createdAt = data['createdAt'];

    return FireImage(
      url: url,
      name: name,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'createdAt': createdAt,
    };
  }

  // toString
  @override
  String toString() {
    return 'FireImage{url: $url, name: $name, createdAt: $createdAt}';
  }
}
