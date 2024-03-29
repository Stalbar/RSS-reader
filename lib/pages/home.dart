// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:rss_reader/services/news_model.dart';
import 'package:rss_reader/pages/loading.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    data = ModalRoute.of(context)!.settings.arguments as Map;
    List<NewsModel> news = data['news'];

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(0x3a, 0xaf, 0xa9, 1),
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                controller:  searchController,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Link",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onSubmitted: (string) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Loading(url: string,)));
                },
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(0x3a, 0xaf, 0xa9, 1),
          body: ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return news.length > 0 && news[0].newsTitle == 'no inet connection' ? Text('No internet connection') : Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                child: ListTile(
                  tileColor: const Color.fromRGBO(0xde, 0xf2, 0xf1, 0.8),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromRGBO(0x17, 0x25, 0x2a, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/webview', arguments: {
                      'url': news[index].newsUrl,
                    });
                  },
                  title: Text(news[index].newsTitle,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0x17, 0x25, 0x2a, 1))),
                  subtitle: Text(
                    news[index].newsPubDate,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
