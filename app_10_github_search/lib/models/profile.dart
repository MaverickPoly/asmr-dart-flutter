class Profile {
  final String login;
  final String? name;
  final String? bio;
  final String avatarUrl;
  final String? blog;
  final String htmlUrl;
  final String? location;

  final int? followers;
  final int? following;
  final int? publicRepos;

  Profile({
    required this.login,
    this.name,
    this.bio,
    required this.avatarUrl,
    this.blog,
    required this.htmlUrl,
    this.location,

    this.followers,
    this.following,
    this.publicRepos,
  });
}
