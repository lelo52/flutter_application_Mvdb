import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_kmdb/movie_api.dart';
import 'movie_Form.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late var controller = TextEditingController();
  dynamic body = Center(
    child: Text('!Select Movies!', style: TextStyle(fontSize: 20)),
  );

  void searchMovie(String keyword) async {
    MovieApi movieApi = MovieApi();
    var movies = movieApi.search(keyword);

    setState(() {
      body = FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var movieData = snapshot.data;
            return ListView.separated(
                itemBuilder: (context, index) {
                  return MovieForm(movie: movieData[index]);
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: movieData!.length);
          } else {
            return CircularProgressIndicator();
          }
        },
      );
      // body = ListView.separated(
      //     itemBuilder: (context, index) {
      //       return MovieForm(movie: movies[index]);
      //     },
      //     separatorBuilder: (context, index) => Divider(),
      //     itemCount: movies.length);
    });
  }

  void showSearchPage() async {
    var result = showModalBottomSheet(
      backgroundColor: Colors.pink,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 200,
        child: Column(
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                icon: Icon(Icons.close),
                label: Text('닫기')),
            TextFormField(
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  searchMovie(controller.text);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                child: Text('검색하기'))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: showSearchPage,
        child: Icon(Icons.search),
      ),
    );
  }
}
