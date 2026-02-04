import "../../domain/entities/read_also_entity.dart";

class ReadAlsoModel extends ReadAlsoEntity {
  const ReadAlsoModel({required super.id, required super.title});

  factory ReadAlsoModel.fromJson(Map<String, dynamic> json) {
    return ReadAlsoModel(id: json["id"] as int, title: json["title"] as String);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title};
  }
}
