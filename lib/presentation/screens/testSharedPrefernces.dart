import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestSharedPrefernces extends StatefulWidget {
  const TestSharedPrefernces({super.key});

  @override
  State<TestSharedPrefernces> createState() => _TestSharedPreferncesState();
}

class _TestSharedPreferncesState extends State<TestSharedPrefernces> {

  Future<String?> getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName'); // Replace 'key' with the specific key used to save the value.
  }

  String? storedValue;

  @override
  void initState() {
    super.initState();
    loadValue();
  }

  void loadValue() async {
    storedValue = await getValue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            storedValue != null
                ? Text('Stored Value: $storedValue')
                : CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
