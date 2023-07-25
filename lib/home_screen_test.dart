import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'data_storage/db_helper.dart';


class HomeScreenTest extends StatefulWidget {
  const HomeScreenTest({super.key});

  @override
  State<HomeScreenTest> createState() => _HomeScreenTestState();
}

class _HomeScreenTestState extends State<HomeScreenTest> {

  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

// Get All Data From Database
  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

// Add Data
  Future<void> _addData() async {
    await SQLHelper.createData(_descController.text);
    _refreshData();
  }

// Update Data
  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(id, _descController.text);
    _refreshData();
  }

  final TextEditingController _descController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
      _allData.firstWhere((element) => element['id'] == id);
      _descController.text = existingData['desc'];
    }

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
                  controller: _descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "입력하세요",
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addData();
                      }
                      if (id != null) {
                        await _updateData(id);
                      }

                      _descController.text = "";

                      Navigator.of(context).pop();
                      print("Data Added");
                    },
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(id == null ? "저장" : "수정",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final List<int> number = <int>[1, 2, 3];
    final List<String> title = <String>['감사한 일', '다행인 일', '잘한 일'];

    return Scaffold(
      appBar: AppBar(
        title: Text('DataStorage_test'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
            //mainAxisAlignment: MainAxisAlignment.center,
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
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: number.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    height: 100,
                                    padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${number[index]}. ${title[index]}',
                                          style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
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
                                              showBottomSheet(_allData[index]['id']);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
    );
  }
}