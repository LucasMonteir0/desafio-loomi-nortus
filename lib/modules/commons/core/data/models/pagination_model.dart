import "../../domain/entities/pagination.dart";

class PaginationModel<T> extends Pagination<T> {
  const PaginationModel({
    required super.page,
    required super.pageSize,
    required super.totalPages,
    required super.totalItems,
    required super.data,
  });

  static Pagination<T> fromResponse<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final paginationJson = json["pagination"] as Map<String, dynamic>;
    final dataJson = json["data"] as List<dynamic>;

    return PaginationModel<T>(
      page: paginationJson["page"] as int,
      pageSize: paginationJson["pageSize"] as int,
      totalPages: paginationJson["totalPages"] as int,
      totalItems: paginationJson["totalItems"] as int,
      data: dataJson.map((e) => fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
