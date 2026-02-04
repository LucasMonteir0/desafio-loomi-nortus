import "dart:typed_data";

import "package:equatable/equatable.dart";

class NewsImageEntity extends Equatable {
  final String src;
  final String alt;
  final Uint8List? bytes;

  const NewsImageEntity({required this.src, required this.alt, this.bytes});

  @override
  List<Object?> get props => [src, alt, bytes];
}
