import "package:flutter_bloc/flutter_bloc.dart";

import "../../../commons/utils/cache/app_cache.dart";
import "../../../commons/utils/states/base_state.dart";

class SignOutBloc extends Cubit<BaseState> {
  SignOutBloc() : super(const InitialState());

  void call() async {
    emit(const LoadingState());

    await Future.delayed(const Duration(seconds: 3));
    AppCache.instance.setIsLogged(false);
    AppCache.instance.setRememberUser(false);
    AppCache.instance.setProfile(null);

    emit(const SuccessState<bool>(true));
  }
}
