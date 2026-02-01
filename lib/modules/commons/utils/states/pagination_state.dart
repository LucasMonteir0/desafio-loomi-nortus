import "package:equatable/equatable.dart";

import "../../core/domain/entities/base_error.dart";
import "../../core/domain/entities/pagination.dart";
import "../errors/errors.dart";

sealed class PaginationState<T> extends Equatable {
  const PaginationState();
}

final class PaginationInitialState<T> extends PaginationState<T> {
  const PaginationInitialState();

  @override
  List<Object?> get props => [];
}

final class PaginationLoadingState<T> extends PaginationState<T> {
  final List<T> currentItems;
  final bool isLoadingMore;

  const PaginationLoadingState({
    this.currentItems = const [],
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [currentItems, isLoadingMore];
}

final class PaginationSuccessState<T> extends PaginationState<T> {
  final List<T> items;
  final Pagination<T> pagination;
  final bool hasMore;

  const PaginationSuccessState({
    required this.items,
    required this.pagination,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [items, pagination, hasMore];
}

final class PaginationErrorState<T> extends PaginationState<T> {
  final BaseError error;
  final List<T> currentItems;

  PaginationErrorState({BaseError? error, this.currentItems = const []})
    : error = error ?? UnknownError();

  @override
  List<Object?> get props => [error, currentItems];
}

extension PaginationStateExtension<T> on PaginationState<T> {
  bool get isInitial => this is PaginationInitialState<T>;
  bool get isLoading => this is PaginationLoadingState<T>;
  bool get isSuccess => this is PaginationSuccessState<T>;
  bool get isError => this is PaginationErrorState<T>;
}
