part of 'list_bloc.dart';

@immutable
sealed class ListState {}

final class HomeInitial extends ListState {}

final class ListLoading extends ListState {}

final class ListLoaded extends ListState {
  final List<ImageEntity> images;

  ListLoaded(this.images);
}

final class ListFailure extends ListState {
  final String message;

  ListFailure(this.message);
}


final class ViewInitial extends ListState {}

final class ViewLoading extends ListState {}

final class ViewImage extends ListState {
  final String url;
  ViewImage(this.url);
}

final class ViewFailure extends ListState {
  final String message;

  ViewFailure(this.message);
}