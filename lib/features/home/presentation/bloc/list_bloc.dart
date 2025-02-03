import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/data/model/firebase_image.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/entities/image_entity.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/use_cases/image_operations.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<BlocEvent, ListState> {
  final ImageOperations operations;

  ListBloc({required this.operations}) : super(HomeInitial()) {
    on<LoadListEvent>(_onLoadList);
    on<ViewImageEvent>(_onViewImage);
    on<DeleteImageEvent>(_onDeleteImage);
  }

  void _onLoadList(LoadListEvent event, Emitter<ListState> emit) async {
    emit(ListLoading());
    try {
      final images = await operations.getImages();
      emit(ListLoaded(images));
    } catch (e) {
      emit(ListFailure(e.toString()));
    }
  }

  void _onViewImage(ViewImageEvent event, Emitter<ListState> emit) async {
    emit(ViewLoading());
    try {
      emit(ViewImage(event.url));
    } catch (e) {
      emit(ViewFailure(e.toString()));
    }
  }

  void _onDeleteImage(DeleteImageEvent event, Emitter<ListState> emit) async {
    emit(ListLoading());
    try {
      await operations.deleteImage(event.image);
      final images = await operations.getImages();
      emit(ListLoaded(images));
    } catch (e) {
      emit(ListFailure(e.toString()));
    }
  }
}
