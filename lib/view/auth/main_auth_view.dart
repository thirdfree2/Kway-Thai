import 'package:buffalo_thai/mainwrapper.dart';
import 'package:buffalo_thai/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

class MainAuthView extends StatefulWidget {
  const MainAuthView({super.key});

  @override
  State<MainAuthView> createState() => _MainAuthViewState();
}

class _MainAuthViewState extends State<MainAuthView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainWrapper()));
    // if (_formKey.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Logging in...')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background-2.jpg"),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StrokeText(
                  text: "เข้าสู่ระบบ ควายไทย",
                  textStyle: TextStyle(
                      fontSize: ScreenUtils.calculateFontSize(context, 28),
                      color: Colors.red),
                  strokeColor: Colors.white,
                  strokeWidth: 6,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.yellow,
                    labelText: 'สมาชิก',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add more validation if necessary
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.yellow,
                    labelText: 'รหัสผ่าน',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // Add more validation if necessary
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: _login,
                  child: const Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
