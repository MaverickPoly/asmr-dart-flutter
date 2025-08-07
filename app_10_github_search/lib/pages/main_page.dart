import 'package:app_10_github_search/components/profile_tile.dart';
import 'package:app_10_github_search/models/profile.dart';
import 'package:app_10_github_search/services/github_user_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GithubUserService service = GithubUserService();
  List<Profile> profiles = [];
  bool _loading = false;
  final controller = TextEditingController();

  Future<void> fetchUsers() async {
    final login = controller.text;
    if (login.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Username is missing!")));
      return;
    }
    setState(() {
      _loading = true;
    });
    var result = await service.fetchProfiles(login);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error fetching users..."),
          backgroundColor: Colors.red.shade600,
        ),
      );
      return;
    }
    setState(() {
      profiles = result;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              // Input
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  MaterialButton(
                    onPressed: fetchUsers,
                    color: Colors.grey.shade300,
                    child: Text("Search"),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // List of users
              Expanded(
                child: () {
                  if (_loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (profiles.isEmpty) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, size: 32),
                          SizedBox(width: 10),
                          Text(
                            "No results found!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: profiles.length,
                      itemBuilder: (context, index) {
                        final profile = profiles[index];
                        return ProfileTile(profile: profile);
                      },
                    );
                  }
                }(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
