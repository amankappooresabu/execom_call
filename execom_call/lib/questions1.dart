import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:execom_call/position_selection.dart';
import 'package:execom_call/questions2.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int selectedAnswer = -1; // -1 indicates no selection
  TextEditingController _membershipIdController = TextEditingController();
  TextEditingController _previousPositionsController = TextEditingController();
  bool isBackButtonSelected = false;
  double progress = 0.25; // Initial progress, assuming it's the first page

  Future<void> submitData() async {
    final response = await http.post(
      Uri.parse('http://192.168.161.43:5000/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'previous_positions': _previousPositionsController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print("Response: ${response.body}");
    } else {
      // Handle error response
      print('Failed to submit data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 60.0),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB760D5)),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 5.0,
                    right: 115.0,
                  ),
                  child: Text(
                    "Are you an IEEE member ? ",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedAnswer = 0;
                            });
                          },
                          child: Container(
                            width: 65.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: selectedAnswer == 0
                                  ? Color(0xFFB760D5)
                                  : Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                "Yes",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedAnswer = 1;
                            });
                          },
                          child: Container(
                            width: 65.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: selectedAnswer == 1
                                  ? Color(0xFFB760D5)
                                  : Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 5.0,
                right: 160.0,
              ),
              child: Text(
                "IEEE Membership ID : ",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  controller: _membershipIdController,
                  decoration: InputDecoration(
                    hintText: "Enter your IEEE Membership ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 5.0,
                right: 130.0,
              ),
              child: Text(
                " Previous positions held : ",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  controller: _previousPositionsController,
                  maxLines: 7,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your previous positions held",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 130.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        submitData(); // Submit data to backend
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PositionSelection()),
                        );
                        setState(() {
                          isBackButtonSelected = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isBackButtonSelected
                            ? Color(0xFFB760D5)
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        submitData(); // Submit data to backend
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Questions2()),
                        );
                        setState(() {
                          isBackButtonSelected = false;
                          progress = 0.5; // Increase progress to half when navigating to next page
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: !isBackButtonSelected
                            ? Color(0xFFB760D5)
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





