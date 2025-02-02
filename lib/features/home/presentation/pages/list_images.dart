import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/widgets/image_card.dart';

class ListImagesPage extends StatelessWidget {
  const ListImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Images"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is ListFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          debugPrint("State: $state");
          switch (state) {
            case ListLoaded():
              return state.images.isEmpty
                  ? const Center(
                      child: Text("No Images"),
                    )
                  : ListView.builder(
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        final image = state.images[index];
                        return ImageCard(image: image);
                      },
                    );
            case ListFailure():
              return const Center(
                child: Text("Failed to fetch images"),
              );
            case ListLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return ElevatedButton(
                onPressed: () {
                  context.read<HomeBloc>().getImages();
                },
                child: const Text("Fetch Images"),
              );
          }
        },
      ),
    );
  }
}
