import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class NewsDetailPage extends StatelessWidget {
  final dynamic article;

  const NewsDetailPage({super.key, required this.article});

  String formatDate(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('EEEE, dd MMMM yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
  String formatTime(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat.jm().format(dateTime); // Format to display only time
    } catch (e) {
      return 'Unknown time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white,toolbarHeight: 60,backgroundColor: Color(0xFF11AB2F)),
      backgroundColor: Colors.white.withOpacity(0.88),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article['urlToImage'] != null &&(!(article['urlToImage'].startsWith('https://bl'))&&
                  !(article['urlToImage'].startsWith('https://bm'))))
                ClipRRect(
                  child: Image.network(
                    article['urlToImage'],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text(
                      'No Image Available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 170),
                      Text(

                        article['content'] ?? 'No content available',
                        style:GoogleFonts.nunito(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.25),
                borderRadius: BorderRadius.circular(36.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDate(article['publishedAt'] ?? ''),
                          style: const TextStyle(color: Colors.black45, fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article['title'] ?? 'No title',
                          style: GoogleFonts.ptSerif( textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Published by ${article['author'] ?? 'Unknown author'}',
                          style: const TextStyle(color: Colors.black45, fontSize: 12, fontWeight: FontWeight.w700),
                           maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2,),
                        Text(formatTime(article['publishedAt']??'..'),
                        style: const TextStyle(color: Colors.black45, fontSize: 12, fontWeight: FontWeight.w700),
                         maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
