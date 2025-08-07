import 'package:app_10_github_search/models/profile.dart';
import 'package:app_10_github_search/pages/profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;

  const ProfileTile({super.key, required this.profile});
  
  void navigate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage(login: profile.login,)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => navigate(context),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: profile.avatarUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                imageBuilder: (context, imageProvider) => Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(width: 8),

              Text(
                profile.login,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ],
          )
        ),
      ),
    );
  }
}
