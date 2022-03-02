import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone_006/screen/home_screen.dart';
import 'package:netflixclone_006/widget/bottom_bat.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '효플릭스',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), //스크롤해도 움직이지 않도록
            children: <Widget>[
              HomeScreen(),
              Container(
                child: Center(child: Text('검색')),
              ),
              Container(
                child: Center(child: Text('더보기')),
              ),
              Container(
                child: Center(child: Text('저장된 콘텐츠 목록')),
              ),

            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
