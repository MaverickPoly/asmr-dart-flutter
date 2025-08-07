class Repository {
  final String name;
  final String htmlUrl;
  final String? description;
  final String createdAt;
  final String? language;
  final int forksCount;
  final String? defaultBranch;

  Repository({
    required this.name,
    required this.htmlUrl,
    required this.description,
    required this.createdAt,
    required this.language,
    required this.forksCount,
    required this.defaultBranch,
  });
}