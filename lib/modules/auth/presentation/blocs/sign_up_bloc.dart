import "package:flutter_bloc/flutter_bloc.dart";

import "../../../commons/config/dependency_injection.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/use_cases/sign_up/sign_up_use_case.dart";

class SignUpBloc extends Cubit<BaseState> {
  late final SignUpUseCase useCase;
  SignUpBloc() : super(const InitialState()) {
    useCase = getIt<SignUpUseCase>();
  }

  void call(String login, String password) async {
    emit(const LoadingState());

    final result = await useCase.call(login, password);

    if (result.isSuccess) {
      emit(SuccessState<bool>(result.data!));
      return;
    }
    emit(ErrorState(result.error));
  }
}
