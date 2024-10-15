import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/repository/song/song.dart';

import '../../../domain/entities/song/song.dart';
import '../../../service_locater.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {

  SearchCubit() : super(SearchInitial());

  void searchSongs(String query) async {
    emit(SearchLoading());
    final result = await sl<SongsRepository>().searchSongs(query);
    result.fold(
      (failure) => emit(SearchFailure(message: failure.toString())),
      (songs) {
        // if (songs.isEmpty) {
        //   emit(SearchNoResults());
        // } else {
        //   emit(SearchLoaded(songs: songs));
        // }
        emit(SearchLoaded(songs: songs));
      },
    );
  }
}