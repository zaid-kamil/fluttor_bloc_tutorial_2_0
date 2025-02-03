part of 'upload_bloc.dart';

@immutable
sealed class UploadState {}

final class UploadInitial extends UploadState {}

final class UploadLoading extends UploadState {
  final dynamic data;

  UploadLoading({this.data});
}

final class UploadSuccess extends UploadState {}

final class UploadFailure extends UploadState {
  final String message;

  UploadFailure(this.message);
}
