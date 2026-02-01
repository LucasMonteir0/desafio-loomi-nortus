class Pagination<T> {
  final int page;
  final int pageSize;
  final int totalPages;
  final int totalItems;
  final List<T> data;

  const Pagination({
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalItems,
    required this.data,
  });

  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;
}
