import 'package:dartz/dartz.dart';

abstract class PlaylistRepository{
  Future<Either> getAllPlaylists();
}