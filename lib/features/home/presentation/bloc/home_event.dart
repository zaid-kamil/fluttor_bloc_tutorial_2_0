part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class LoadListEvent extends HomeEvent {}

final class UploadImageEvent extends HomeEvent {
  final String imagePath;
  UploadImageEvent(this.imagePath);
}

final class ViewImageEvent extends HomeEvent {
  final String url;

  ViewImageEvent(this.url);
}
