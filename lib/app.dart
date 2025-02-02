import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/data/data_sources/remote_data_source.dart';
import 'package:flutter_bloc_tutorial/features/home/data/repositories/image_repositories_impl.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/use_cases/upload_image.dart';
import 'package:flutter_bloc_tutorial/features/home/presentation/pages/home.dart';

import 'features/home/domain/use_cases/get_images.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

class ImageShareApp extends StatelessWidget {
  const ImageShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteDataSource = RemoteDataSource();
    final imageRepository = ImageRepositoryImpl(remoteDataSource);
    final getImages = GetImages(imageRepository);
    final uploadImage = UploadImage(imageRepository);
    return BlocProvider(
      create: (_) => HomeBloc(
        getImages: getImages,
        uploadImage: uploadImage,
      )..add(LoadListEvent()),
      child: MaterialApp(
        title: 'Image Share',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          // for the web
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.unknown,
          },
        ),
        home: HomePage(),
      ),
    );
  }
}
