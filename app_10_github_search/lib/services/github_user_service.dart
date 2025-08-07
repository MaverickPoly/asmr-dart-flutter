import 'dart:convert';

import 'package:app_10_github_search/models/profile.dart';
import 'package:app_10_github_search/models/repository.dart';
import "package:http/http.dart" as http;

class GithubUserService {
  // https://api.github.com/search/users?q=Maverick+in:login
  // https://api.github.com/users/user/followers
  // https://api.github.com/users/user/repos

  // Search Users by login
  Future<List<Profile>?> fetchProfiles(String login) async {
    var response = await http.get(
      Uri.parse("https://api.github.com/search/users?q=$login+in:login"),
    );

    if (response.statusCode != 200) {
      return null;
    }
    print(response.body);
    var jsonData = jsonDecode(response.body);
    List<Profile> profiles = [];
    for (var item in jsonData["items"]) {
      Profile profile = Profile(
        login: item["login"],
        name: item["name"],
        bio: item["bio"],
        avatarUrl: item["avatar_url"],
        blog: item["blog"],
        htmlUrl: item["html_url"],
        location: item["location"],

        followers: item["followers"],
        following: item["following"],
        publicRepos: item["public_repos"],
      );
      print("Profile:");
      print(profile);
      profiles.add(profile);
    }

    print("Profiles length");
    print(profiles.length);
    return profiles;
  }

  // Fetch User's Repositories
  Future<List<Repository>?> fetchRepos(Profile user) async {
    var response = await http.get(
      Uri.parse("https://api.github.com/users/${user.login}/repos"),
    );
    if (response.statusCode != 200) {
      return null;
    }
    var jsonData = jsonDecode(response.body);
    List<Repository> repositories = [];
    for (var item in jsonData) {
      Repository repo = Repository(
        name: item["name"],
        htmlUrl: item["html_url"],
        description: item["description"],
        createdAt: item["created_at"],
        language: item["language"],
        forksCount: item["forks_count"],
        defaultBranch: item["default_branch"],
      );
      repositories.add(repo);
    }

    return repositories;
  }

  // Fetch User's followers
  Future<List<Profile>?> fetchFollowers(Profile user) async {
    var response = await http.get(
      Uri.parse("https://api.github.com/users/${user.login}/followers"),
    );
    if (response.statusCode != 200) {
      return null;
    }
    var jsonData = jsonDecode(response.body);
    List<Profile> followers = [];
    for (var item in jsonData) {
      Profile follower = Profile(
        login: item["login"],
        name: item["name"],
        bio: item["bio"],
        avatarUrl: item["avatar_url"],
        blog: item["blog"],
        htmlUrl: item["html_url"],
        location: item["location"],

        followers: item["followers"],
        following: item["following"],
        publicRepos: item["public_repos"],
      );
      followers.add(follower);
    }
    return followers;
  }

  // Fetch Specific Users Profile
  Future<Profile?> fetchProfile(String login) async {
    var response = await http.get(
      Uri.parse("https://api.github.com/users/$login"),
    );
    if (response.statusCode != 200) {
      return null;
    }

    var jsonData = jsonDecode(response.body);
    Profile profile = Profile(
      login: jsonData["login"],
      name: jsonData["name"],
      bio: jsonData["bio"],
      avatarUrl: jsonData["avatar_url"],
      blog: jsonData["blog"],
      htmlUrl: jsonData["html_url"],
      location: jsonData["location"],

      followers: jsonData["followers"],
      following: jsonData["following"],
      publicRepos: jsonData["public_repos"],
    );
    return profile;
  }
}
