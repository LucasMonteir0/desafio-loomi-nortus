import "package:flutter_bloc/flutter_bloc.dart";

import "../../../commons/config/dependency_injection.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/entities/news_detail_entity.dart";
import "../../core/domain/use_cases/get_news_detail/get_news_detail_use_case.dart";

class GetNewsDetailBloc extends Cubit<BaseState> {
  late final GetNewsDetailUseCase _useCase;

  GetNewsDetailBloc() : super(const InitialState()) {
    _useCase = getIt<GetNewsDetailUseCase>();
  }

  void call(int id) async {
    emit(const LoadingState());

    final result = await _useCase.call(id);

    if (result.isSuccess) {
      emit(SuccessState<NewsDetailEntity>(result.data!));
      return;
    }

    emit(ErrorState(result.error));
  }
}
