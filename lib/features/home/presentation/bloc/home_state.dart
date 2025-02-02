part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ListLoading extends HomeState {}

final class ListLoadedSuccess extends HomeState {
  final List<String> images;

  ListLoadedSuccess(this.images);
}

final class ListLoadedFailure extends HomeState {
  final String message;

  ListLoadedFailure(this.message);
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
  final String image;
  ViewImage(this.image);
}

final class ViewFailure extends HomeState {
  final String message;

  ViewFailure(this.message);
}