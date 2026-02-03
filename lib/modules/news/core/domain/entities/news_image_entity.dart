import "package:equatable/equatable.dart";

class NewsImageEntity extends Equatable {
  final String src;
  final String alt;

  const NewsImageEntity({required this.src, required this.alt});

  @override
  List<Object?> get props => [src, alt];
}
