import "package:flutter_bloc/flutter_bloc.dart";

import "../../../commons/config/dependency_injection.dart";
import "../../../commons/core/domain/entities/pagination.dart";
import "../../../commons/utils/states/pagination_state.dart";
import "../../core/domain/entities/news_item_entity.dart";
import "../../core/domain/use_cases/get_news/get_news_use_case.dart";

class GetNewsBloc extends Cubit<PaginationState<NewsItemEntity>> {
  late final GetNewsUseCase _useCase;

  List<NewsItemEntity> _items = [];
  Pagination<NewsItemEntity>? _pagination;
  int _currentPage = 0;

  GetNewsBloc() : super(const PaginationInitialState()) {
    _useCase = getIt<GetNewsUseCase>();
  }

  bool get _hasMore => _pagination?.hasNextPage ?? true;

  void load({bool refresh = false}) async {
    if (refresh) {
      _items = [];
      _currentPage = 0;
      _pagination = null;
    }

    if (state.isLoading) {
      return;
    }
    if (!_hasMore && !refresh) {
      return;
    }

    emit(
      PaginationLoadingState(
        currentItems: _items,
        isLoadingMore: _items.isNotEmpty,
      ),
    );

    final result = await _useCase.call(_currentPage + 1);

    if (result.isSuccess) {
      _currentPage = result.data!.page;
      _pagination = result.data!;
      _items = [..._items, ...result.data!.data];
      emit(
        PaginationSuccessState(
          items: _items,
          pagination: _pagination!,
          hasMore: _pagination!.hasNextPage,
        ),
      );
      return;
    }

    emit(PaginationErrorState(error: result.error, currentItems: _items));
  }

  void refresh() => load(refresh: true);
}
