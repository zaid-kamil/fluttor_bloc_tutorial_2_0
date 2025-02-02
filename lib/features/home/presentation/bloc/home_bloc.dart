import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/use_cases/get_images.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/use_cases/upload_image.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetImages getImages;
  final UploadImage uploadImage;

  HomeBloc({required this.getImages, required this.uploadImage})
      : super(HomeInitial()) {
    on<LoadListEvent>(_onLoadList);
    on<UploadImageEvent>(_onUploadImage);
    on<ViewImageEvent>(_onViewImage);
  }

  void _onLoadList(LoadListEvent event, Emitter<HomeState> emit) async {
    emit(ListLoading());
    try {
      final images = await getImages();
      emit(ListLoaded(images));
    } catch (e) {
      emit(ListFailure(e.toString()));
    }
  }

  void _onUploadImage(UploadImageEvent event, Emitter<HomeState> emit) async {
    emit(UploadLoading());
    try {
      await uploadImage(event.imagePath);
      emit(UploadSuccess());
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }

  void _onViewImage(ViewImageEvent event, Emitter<HomeState> emit) async {
    emit(ViewLoading());
    try {
      emit(ViewImage(event.url));
    } catch (e) {
      emit(ViewFailure(e.toString()));
    }
  }
}
