part of 'upload_bloc.dart';

@immutable
sealed class UploadEvent {}

final class UploadImageEvent extends UploadEvent {
  final String imagePath;

  UploadImageEvent(this.imagePath);
}

final class UploadImageWebEvent extends UploadEvent {
  final String imgName;
  final Uint8List imageBytes;

  UploadImageWebEvent(
    this.imgName,
    this.imageBytes,
  );
}

final class ResetUploadEvent extends UploadEvent {}
