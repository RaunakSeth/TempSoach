

import 'package:flutter/material.dart';
import 'news_card.dart'; // Adjust the path as needed
import '../../ApiManagerClass.dart'; // Adjust the path as needed

class NewsBox extends StatefulWidget {
  const NewsBox({Key? key}) : super(key: key);

  @override
  _NewsBoxState createState() => _NewsBoxState();
}

class _NewsBoxState extends State<NewsBox> {
  late Future<List<dynamic>> _newsFuture;
  List<dynamic> _filteredNews = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  void _fetchNews() {
    setState(() {
      _newsFuture = NewsService().fetchNews();
      _newsFuture.then((news) {
        setState(() {
          _filteredNews = news.take(5).toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.005),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'News',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.green),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.green, size: 32),
                  onPressed: _fetchNews,
                ),
              ],
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: _newsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return _buildLoadingWidget(); // Show loading widget
              } else if (snapshot.hasError) {
                return Center(child: Text('Failed to load news: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No news available'));
              } else {
                return IntrinsicHeight(
                  child: Column(
                    children: _filteredNews.map((article) => NewsCard(article: article)).toList(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
