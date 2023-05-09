import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  final int itemId;

  const NewsDetail({Key? key, required this.itemId}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News detail page'),
      ),
      body: const Center(
        child: Text('This is news detail page'),
      ),
    );
  }
}
