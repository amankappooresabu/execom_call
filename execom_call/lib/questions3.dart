import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:execom_call/finish.dart';

class Questions3 extends StatefulWidget {
  @override
  _Questions3State createState() => _Questions3State();
}

class _Questions3State extends State<Questions3> {
  final TextEditingController _volunteeringController = TextEditingController();
  final TextEditingController _differentSelectionController = TextEditingController();

  Future<void> submitData() async {
    String url = 'http://192.168.161.43:5000/submit';
    
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, String> body = {
      
      'volunteering_experiences': _volunteeringController.text,
      'what_would_you_do_differently': _differentSelectionController.text,
    };

    String jsonString = json.encode(body);

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonString,
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
        // Handle response if needed
      } else {
        print('Failed to send data. Error: ${response.statusCode}');
        // Handle error
      }
    } catch (e) {
      print('Error sending data: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: LinearProgressIndicator(
                value: 0.8,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB760D5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Previous volunteering experiences :",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
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
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _volunteeringController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your previous volunteering experiences",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "What would you do differently if you were selected ? ",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
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
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _differentSelectionController,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your answer here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 93.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
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
                        submitData();
                        // Navigate to the finish page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFB760D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        "Finish",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



