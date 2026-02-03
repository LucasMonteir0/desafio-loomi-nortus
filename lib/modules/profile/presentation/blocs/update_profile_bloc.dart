import "package:flutter_bloc/flutter_bloc.dart";

import "../../../commons/config/dependency_injection.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/entities/profile_entity.dart";
import "../../core/domain/entities/update_profile_entity.dart";
import "../../core/domain/use_cases/update_profile/update_profile_use_case.dart";

class UpdateProfileBloc extends Cubit<BaseState> {
  late final UpdateProfileUseCase _useCase;

  UpdateProfileBloc() : super(const InitialState()) {
    _useCase = getIt<UpdateProfileUseCase>();
  }

  void update(UpdateProfileEntity profile) async {
    emit(const LoadingState());

    final result = await _useCase.call(profile);

    if (result.isSuccess) {
      emit(SuccessState<ProfileEntity>(result.data!));
      return;
    }

    emit(ErrorState(result.error));
  }
}
