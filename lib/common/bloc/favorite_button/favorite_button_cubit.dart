import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/bloc/favorite_button/favorite_butoon_state.dart';
import 'package:spotify_project/domain/usecases/song/add_or_remove_favorite.dart';
import 'package:spotify_project/service_locater.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void updateFavorite(String songId) async {
    var result = await sl<AddOrRemoveToFavoritesUseCase>().call(params: songId);
    result.fold(
      (l) => null,
      (isFavorite) => emit(FavoriteButtonUpdated(isFavorite: isFavorite)),
    );
  }
}
