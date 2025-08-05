import 'package:app_08_news/models/new.dart';
import 'package:flutter/material.dart';
import "package:cached_network_image/cached_network_image.dart";
import 'package:url_launcher/url_launcher.dart';

class NewCard extends StatefulWidget {
  final New newItem;
  const NewCard({super.key, required this.newItem});

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.newItem.url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Could not launch Url")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3, 4),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.newItem.urlToImage ?? "",
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 18),
            Text(
              widget.newItem.title ?? "",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              widget.newItem.description ?? "",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700,
              ),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text(
                      widget.newItem.publishedAt.split("T")[0],
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _launchUrl,
                      child: Text(
                        "Read",
                        style: TextStyle(
                          color: Colors.blue.shade500,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
