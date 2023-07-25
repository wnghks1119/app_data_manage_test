import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('DataStorage_test'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    "캘린더 선택 날짜 표시 예정",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              color: Colors.amberAccent,
              child: Column(
                children: [
                  // StarBox(),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.favorite,
                      color: Colors.pinkAccent,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextInputBox(
                          title: '1. 감사한 일',
                        ),
                        TextInputBox(
                          title: '2. 다행인 일',
                        ),
                        TextInputBox(
                          title: '3. 잘한 일',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextInputBox extends StatelessWidget {
  final String title;

  const TextInputBox({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            //padding: EdgeInsets.fromLTRB(0, 0, 25, 35),
            child: ElevatedButton(
              child: Text("입력"),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                primary: Colors.black,
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 17),
              ),

              onPressed: () {
                showModalBottomSheet(
                  elevation: 5,
                  isScrollControlled: true,
                  context: context,
                  builder: (_) =>
                      Container(
                        padding: EdgeInsets.only(
                          top: 30,
                          left: 15,
                          right: 15,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "입력하세요.",
                              ),
                              maxLines: 5,
                            ),

                            SizedBox(height: 20),

                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  print("Data Added");
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(18),
                                  child: Text("저장",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}