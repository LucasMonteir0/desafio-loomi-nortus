import "package:flutter_bloc/flutter_bloc.dart";

import "../../../commons/config/dependency_injection.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/entities/profile_entity.dart";
import "../../core/domain/use_cases/get_profile/get_profile_use_case.dart";

class GetProfileBloc extends Cubit<BaseState> {
  late final GetProfileUseCase _useCase;

  GetProfileBloc() : super(const InitialState()) {
    _useCase = getIt<GetProfileUseCase>();
  }

  void call() async {
    emit(const LoadingState());

    final result = await _useCase.call();

    if (result.isSuccess) {
      emit(SuccessState<ProfileEntity>(result.data!));
      return;
    }

    emit(ErrorState(result.error));
  }
}
