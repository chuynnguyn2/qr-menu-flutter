import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_menu/mainScreens/home_screen.dart';
import 'package:qr_menu/widgets/error_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loggingin = false;
  bool _paswordHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loggin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text.trim());

    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.toString(),
            );
          });
    });
    if (currentUser != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const HomeScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff5800FF),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loggingin,
        child: SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('images/food_slider1.png'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height*0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.cyan,
                        ),
                        focusColor: Theme
                            .of(context)
                            .primaryColor,
                        hintText: "Email/Số Điện Thoại",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "A valid email is required!";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.05,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height*0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey)),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _paswordHidden,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.cyan,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _paswordHidden ? Icons.visibility_off : Icons
                                .visibility,
                            color: Colors.cyan,
                          ),
                          onPressed: () {
                            setState(() {
                              _paswordHidden = !_paswordHidden;
                            });
                          },
                        ),
                        focusColor: Theme
                            .of(context)
                            .primaryColor,
                        hintText: "Mật Khẩu",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "A valid password is required!";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.05,
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              height: MediaQuery.of(context).size.height*0.08,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loggingin = true;
                    });
                    loggin();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff5800FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5.0,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Đăng Nhập',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text(
                      "Quên Mật Khẩu?",
                      style: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),

          ],
      ),
        ),
    ),

    );
  }
}
