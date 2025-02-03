import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/bloc/list_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/bloc/list_bloc.dart';

class ImageCard extends StatelessWidget {
  final ImageEntity image;

  const ImageCard({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(image.name),
              ElevatedButton(
                onPressed: () {
                  context.read<ListBloc>().add(DeleteImageEvent(image));
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
