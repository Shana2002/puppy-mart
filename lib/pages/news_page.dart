import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puppymart/class/news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
        width: _deviceWidth! * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "News",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              width: _deviceWidth,
              height: _deviceHeight! * 0.75,
              child: _newsList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _newsList() {
    return StreamBuilder<QuerySnapshot>(
        stream: News().getNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List _news = snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.builder(
                itemCount: _news.length,
                itemBuilder: (context, index) {
                  Map news = _news[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: _deviceHeight!*0.01),
                    padding: EdgeInsets.symmetric(vertical: _deviceHeight!*0.005,horizontal: _deviceWidth!*0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 20, // Increased blur radius
                        offset: Offset(0, 4),
                      )
                    ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: _deviceWidth! * 0.95,
                          height: _deviceHeight! * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(news['image'])),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: _deviceWidth! * 0.03),
                            child: Text(
                              news['name'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: _deviceWidth! * 0.03),
                          child: Text(
                            news['description'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
