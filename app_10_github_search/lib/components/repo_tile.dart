import 'package:app_10_github_search/models/repository.dart';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class RepoTile extends StatelessWidget {
  final Repository repo;

  const RepoTile({super.key, required this.repo});

  Future<void> _launchUrl(String url, BuildContext context) async {
    if (!await launchUrl(Uri.parse(url))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Could not launch url.",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _launchUrl(repo.htmlUrl, context),
              child: Text(
                repo.name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.green.shade600,
                ),
              ),
            ),
            if (repo.description != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(repo.description!, style: TextStyle()),
              ),

            SizedBox(height: 8),

            Row(
              children: [
                if (repo.language != null)
                  Text(
                    repo.language!,
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                SizedBox(width: 14),
                if (repo.defaultBranch != null)
                  Text(
                    repo.defaultBranch!,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                SizedBox(width: 14),
                Icon(Icons.call_split),
                Text(repo.forksCount.toString()),
                SizedBox(width: 14),

                Text(
                  repo.createdAt.split("T")[0],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Divider(),
          ],
        ),
      ),
    );
  }
}
