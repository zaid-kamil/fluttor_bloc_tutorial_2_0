part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class LoadList extends HomeEvent {}

final class UploadImage extends HomeEvent {
  final String imagePath;

  UploadImage(this.imagePath);
}

final class ViewImageEvent extends HomeEvent {
  final String imagePath;

  ViewImageEvent(this.imagePath);
}
