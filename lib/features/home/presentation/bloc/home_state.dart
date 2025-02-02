part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ListLoading extends HomeState {}

final class ListLoaded extends HomeState {
  final List<ImageEntity> images;

  ListLoaded(this.images);
}

final class ListFailure extends HomeState {
  final String message;

  ListFailure(this.message);
}

final class UploadLoading extends HomeState {}

final class UploadSuccess extends HomeState {}

final class UploadFailure extends HomeState {
  final String message;

  UploadFailure(this.message);
}

final class ViewInitial extends HomeState {}

final class ViewLoading extends HomeState {}

final class ViewImage extends HomeState {
  final String url;
  ViewImage(this.url);
}

final class ViewFailure extends HomeState {
  final String message;

  ViewFailure(this.message);
}