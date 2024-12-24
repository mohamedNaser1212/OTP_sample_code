import 'package:flutter/material.dart';

void main() {
  runApp(const OTPApp());
}

class OTPApp extends StatelessWidget {
  const OTPApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OTPPage(),
    );
  }
}

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  @override
  void dispose() {
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }

  void _onChanged(String value, FocusNode currentFocusNode, FocusNode nextFocusNode, FocusNode previousFocusNode) {
    if (value.isNotEmpty) {
      nextFocusNode.requestFocus();
    } else {
      previousFocusNode.requestFocus();
    }
  }

  void _validateFields() {
    if (_otpController1.text.isEmpty ||
        _otpController2.text.isEmpty ||
        _otpController3.text.isEmpty ||
        _otpController4.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the OTP fields.')),
      );
    } else {
      String otp = _otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text;
      print('Entered OTP: $otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Page')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OTPField(
                  controller: _otpController1,
                  focusNode: _focusNode1,
                  nextFocusNode: _focusNode2,
                  previousFocusNode: _focusNode1, // No previous field
                  onChanged: (value) => _onChanged(value, _focusNode1, _focusNode2, _focusNode1),
                ),
                OTPField(
                  controller: _otpController2,
                  focusNode: _focusNode2,
                  nextFocusNode: _focusNode3,
                  previousFocusNode: _focusNode1,
                  onChanged: (value) => _onChanged(value, _focusNode2, _focusNode3, _focusNode1),
                ),
                OTPField(
                  controller: _otpController3,
                  focusNode: _focusNode3,
                  nextFocusNode: _focusNode4,
                  previousFocusNode: _focusNode2,
                  onChanged: (value) => _onChanged(value, _focusNode3, _focusNode4, _focusNode2),
                ),
                OTPField(
                  controller: _otpController4,
                  focusNode: _focusNode4,
                  nextFocusNode: _focusNode4, // Last field
                  previousFocusNode: _focusNode3,
                  onChanged: (value) => _onChanged(value, _focusNode4, _focusNode4, _focusNode3),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateFields,
              child: const Text('Submit OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final FocusNode previousFocusNode;
  final Function(String) onChanged;

  const OTPField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.nextFocusNode,
    required this.previousFocusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center, 
        textInputAction: TextInputAction.next,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
