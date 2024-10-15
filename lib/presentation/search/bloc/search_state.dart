part of 'search_cubit.dart';




abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SongEntity> songs;

  SearchLoaded({required this.songs});
}

class SearchNoResults extends SearchState {}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure({required this.message});
}