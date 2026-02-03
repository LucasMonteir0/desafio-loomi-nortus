import "package:equatable/equatable.dart";

class ReadAlsoEntity extends Equatable {
  final int id;
  final String title;

  const ReadAlsoEntity({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}
