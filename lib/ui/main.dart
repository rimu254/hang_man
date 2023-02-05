import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hang_man/utils/game.dart';
import 'package:hang_man/utils/letter.dart';
import 'colors.dart';
import 'widget/figure_image.dart';
import 'package:english_words/english_words.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget{
  const HomeApp({Key? key}): super(key:key);

  @override
  _HomeAppState createState() => _HomeAppState();

}

class _HomeAppState extends State<HomeApp>{

  final _random = new Random();
  final String wordPair =  WordPair.random().toString().toUpperCase();
 // final int randomInt = _random.nextInt(2);
  final String word = _random.nextInt(2).toString() == 0
      ? WordPair.random().first.toString().toUpperCase()
      : WordPair.random().second.toString().toUpperCase();

  List<String> alphabets = [
    "A","B","C","D","E","F","G","H","I","J", "K","L","M",
    "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
  ];
  @override

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("HangMan"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Stack(
            children: [

              figureImage(Game.tries >= 0 ,"assets/1st.png"),
              figureImage(Game.tries >= 1 ,"assets/2nd.png"),
              figureImage(Game.tries >= 2 ,"assets/3rd.png"),
              figureImage(Game.tries >= 3 ,"assets/4th.png"),
              figureImage(Game.tries >= 4 ,"assets/6th.png"),
              figureImage(Game.tries >= 5 ,"assets/7th.png"),
              figureImage(Game.tries >= 6 ,"assets/8th.png"),
              figureImage(Game.tries >= 7 ,"assets/9th.png"),
            ],
          ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                    !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),

          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                padding: EdgeInsets.all(8.0),
              children: alphabets.map((e){
                return RawMaterialButton(onPressed: Game.selectedChar.contains(e)?null: (){
                  setState(() {
                    Game.selectedChar.add(e);
                    print(Game.selectedChar);
                    if(!word.split('').contains(e.toUpperCase())){
                      Game.tries++;
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0) ),
                  child: Text(e, style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                  ),) ,
                  fillColor: Game.selectedChar.contains(e)
                      ?Colors.black12:
                      Colors.white,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}