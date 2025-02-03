part of 'list_bloc.dart';

@immutable
sealed class BlocEvent {}

final class LoadListEvent extends BlocEvent {}

final class ViewImageEvent extends BlocEvent {
  final String url;

  ViewImageEvent(this.url);
}

final class DeleteImageEvent extends BlocEvent {
  final ImageEntity image;

  DeleteImageEvent(this.image);
}
