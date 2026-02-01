import "package:equatable/equatable.dart";

import "../../core/domain/entities/base_error.dart";
import "../errors/errors.dart";

sealed class BaseState extends Equatable {
  const BaseState();
}

final class LoadingState extends BaseState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

final class SuccessState<T> extends BaseState {
  final T data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

final class InitialState<T> extends BaseState {
  final T? data;

  const InitialState([this.data]);

  @override
  List<Object?> get props => [data];
}

final class ErrorState extends BaseState {
  final BaseError error;

  ErrorState(BaseError? e) : error = (e ?? UnknownError());

  @override
  List<Object?> get props => [error];
}

extension BaseStateExtension on BaseState {
  bool get isInitial => this is InitialState;
  bool get isLoading => this is LoadingState;
  bool get isSuccess => this is SuccessState;
  bool get isError => this is ErrorState;
}
