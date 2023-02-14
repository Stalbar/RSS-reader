// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rss_reader/services/xml_parser.dart';
import 'package:rss_reader/services/news_model.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getNews() async {
    XmlParser parser = XmlParser();
    List<NewsModel> news = await parser.parseXml('https://habr.com/ru/rss/all/');
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'news': news,
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0x3a, 0xaf, 0xa9, 1),
        body: Center(
          child: SpinKitCircle(
            color: Color.fromRGBO(0x17, 0x25, 0x2a, 1),
            size: 60,
          )
        ),
      ),
    );
  }
}