import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState(); // 상태를 만듦

}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  double prev = 0;
  double height = 300;
  // 추가
  double op = 1.0;

  @override
  void initState() {
    _controller.addListener((){
      scrollListener();
    }); // 익명
    super.initState();
  }

  void scrollListener(){
    print("스크롤 동작중");
    double currentOffset = _controller.offset;
    //bool keepScrollOffset = _controller.keepScrollOffset;
    print("currentOffset : $currentOffset");
    //print("keepScrollOffset : $keepScrollOffset");

    // 실습

    if(currentOffset < 300) {
      setState(() {
        height = 300 - currentOffset; // Container의 height 가 동적으로 변한다
        op = (300 - currentOffset) / 300; // co가 100이면 2 / 3 , 200 이면 1 / 3 -> 내려갈수록 0 에 가까워져서 투명해진다.
        if(height < 56) {
          height = 56; // Container 가 소멸되지않게? 최소 높이 설정
        }
      });
    }
    // 301             0
    if(currentOffset > prev) {
      print("아래로 내려가요");
    }
    //
    if(currentOffset < prev) {
      print("위로 올라가요");
    }

    if(currentOffset == _controller.position.maxScrollExtent){
      print("가장 하단");
    }

    if(currentOffset == _controller.position.minScrollExtent){
      print("가장 상단");
    }
    prev = currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(255, 0, 0, op),
              height: height,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Good",
                  style: TextStyle(color: Colors.white, fontSize: height / 3),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: 100,
                itemBuilder: (context, index) => Text("제목 $index"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
