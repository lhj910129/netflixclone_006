import 'package:flutter/material.dart';
import 'package:netflixclone_006/model/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflixclone_006/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie>? movies;
  CarouselImage({this.movies});
  _CaroueselImagesState createState() => _CaroueselImagesState();
}

class _CaroueselImagesState extends State<CarouselImage> {
  List<Movie>? movies;
  List<Widget>? images;
  List<String>? keywords;
  List<bool>? likes;
  int _currenetPage = 0;
  String? _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies?.map((e) => Image.network(e.poster)).toList();
    keywords = movies?.map((e) => e.keyword).toList();
    likes = movies?.map((e) => e.like).toList();
    _currentKeyword = keywords?[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
        ),
        CarouselSlider(
          items: images,
          options: CarouselOptions(onPageChanged: (index, reason) {
            setState(() {
              _currenetPage = index;
              _currentKeyword = keywords?[_currenetPage];
            });
          }),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
          child: Text(
            _currentKeyword!,
            style: TextStyle(fontSize: 11),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    likes?[_currenetPage] == true
                        ? IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () { //찜했을때
                              setState(() {
                                likes![_currenetPage] = false;
                                movies![_currenetPage]
                                    .reference!
                                    .update({'like': false});
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () { //찜 안했을때
                              setState(() {
                                likes![_currenetPage] = true;
                                movies![_currenetPage]
                                    .reference!
                                    .update({'like': true});
                              });
                            },
                          ),
                    Text(
                      '내가 찜한 콘텐츠',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: FlatButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.all(3),
                      ),
                      Text(
                        '재생',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return DetailScreen(
                                  movie: movies![
                                      _currenetPage]); //    movies?[_currenetPage] as List<Movie>?);
                            }));
                      },
                    ),
                    Text(
                      '정보',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: makeIndicator(likes, _currenetPage),
          ),
        )
      ]),
    );
  }
}

List<Widget> makeIndicator(List<bool>? list, int _currentPage) {
  List<Widget> results = [];

  for (var i = 0; i < (list == null ? 0 : list.length); i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }

  return results;
}
