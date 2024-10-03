import 'package:spotify_project/core/usecase/usecase.dart';

import '../../../service_locater.dart';
import '../../repository/auth/auth.dart';

class CheckSignedInUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    final result =  sl<AuthRepository>().checkSignedInUser();
    return result.fold((l) => false, (r) => true);
  }
}
