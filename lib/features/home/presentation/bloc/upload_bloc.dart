import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/domain/use_cases/image_operations.dart';

part 'upload_event.dart';

part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ImageOperations operations;

  UploadBloc({required this.operations}) : super(UploadInitial()) {
    on<UploadImageEvent>(_onUploadImage);
    on<UploadImageWebEvent>(_onUploadImageWeb);
    on<ResetUploadEvent>(_onResetUpload);
  }

  void _onUploadImage(
    UploadImageEvent event,
    Emitter<UploadState> emit,
  ) async {
    emit(UploadLoading());
    try {
      debugPrint('Uploading image... ${event.imagePath}');
      await operations.uploadImages(event.imagePath);
      emit(UploadSuccess());
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }

  void _onUploadImageWeb(
    UploadImageWebEvent event,
    Emitter<UploadState> emit,
  ) async {
    emit(UploadLoading());
    try {
      debugPrint('Uploading image... ${event.imgName}');
      await operations.uploadImagesWeb(
        event.imgName,
        event.imageBytes,
      );
      emit(UploadSuccess());
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }

  void _onResetUpload(
    ResetUploadEvent event,
    Emitter<UploadState> emit,
  ) {
    emit(UploadInitial());
  }
}
