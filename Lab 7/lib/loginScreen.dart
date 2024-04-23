import 'package:flutter/material.dart';
import 'topTab.dart';
import 'bottomTab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;
  bool _passwordVisible = false;
  bool? _isChecked = false;
  String? name;
  String? email;
  String? imgName;
  String? phone;
  bool biometric = false;
  String? address;

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 216, 215, 215),
        child: Center(
          child: loggedIn ? _buildSuccess() : _buildLoginForm(),
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                backgroundColor: Color.fromARGB(233, 107, 103, 103),
              radius: 50,
                child: SizedBox(
                    child: CircleAvatar(radius: 100,
                backgroundImage: AssetImage(
                    "pfp.png",
                  ),
                ))),
            SizedBox(height: 10),
            Text(
              '$name',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.phone,color: Colors.deepPurple),
                    Text(
                      '  Phone',
                      style: TextStyle(fontSize: 15
                    ),
                    )
                  ],
                ),
                Text(
                  '$phone',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
                     SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.email,color: Colors.deepPurple),
                    Text(
                      '  Email',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Text(
                  '$email',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
                     SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.fingerprint,color: Colors.deepPurple),
                    Text(
                      '  Biometric',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Transform.scale(
                    scale: 2,
                    child: Switch(
                      onChanged: toggleSwitch,
                      value: biometric,
                      activeColor:  Colors.deepPurple,
                      activeTrackColor: Color.fromARGB(255, 164, 163, 163),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Color.fromARGB(255, 199, 198, 198),
                    )),
              ],
            ),
                     SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_city,color: Colors.deepPurple),
                    Text(
                      '  Address',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Text(
                  '$address',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              height: 40,
              child: ElevatedButton(
                child: Text('Top Tab Navigation'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const topTab()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary:  Colors.deepPurple,
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
              ),
            ),
              SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              height: 40,
              child: ElevatedButton(
                child: Text('Bottom Tab Navigation'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const bottomTab()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary:   Colors.deepPurple,
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
              ),
            )
          ],
        ));
  }

  Widget _buildLoginForm() {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 55,
                    child: SizedBox(
                        child: CircleAvatar(radius: 50,
                backgroundImage: AssetImage(
                        "pfp.png",
                      ),
                    ))),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                       labelStyle: TextStyle(color: Colors.deepPurple),
                               focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),

          ),
                      prefixIcon: new Icon(Icons.email_outlined,color: Colors.deepPurple,)),
                  validator: (text) {
                    if (text != null && text.isEmpty) {
                      const snackBar = SnackBar(
                        content: Text('Enter Email',),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return '';
                    }
                    final regex = RegExp('[^@]+@[^\.]+\..+');
                    if (!regex.hasMatch(text!)) {
                      const snackBar = SnackBar(
                        content: Text('Enter a valid email'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return '';
                    }
                    return null;
                  },
                ),
                 SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.deepPurple),
    
                                                          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),

          ),
                    prefixIcon: new Icon(Icons.lock_outlined, color: Colors.deepPurple,),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color:  Colors.deepPurple,
                      ),
                      onPressed: () {                     
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (text) {
                    if (text != null && text.isEmpty) {
                      const snackBar = SnackBar(
                        content: Text('Enter Password'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return '';
                    }
                    final regex = RegExp(
                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
                    if (!regex.hasMatch(text!)) {
                      const snackBar = SnackBar(
                        content: Text('Enter a valid password'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return '';
                    }

                    return null;
                  },
                ),
                 SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                          height: 40,
                          width: 24,
                          child: Theme(
                            data: ThemeData(
                                colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.deepPurple),
                                unselectedWidgetColor:
                                    Colors.deepPurple
                                ),
                            child: Checkbox(
                              activeColor:  Colors.deepPurple,
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  this._isChecked = value;
                                });
                              },
                            ),
                          )),
                      SizedBox(width: 10.0),
                      const Text("Remember Me",
                          style: TextStyle(
                              color: Color(0xff646464),
                              fontSize: 12,
                              fontFamily: 'Rubic'))
                    ]),
                    TextButton(
                      onPressed: () {
                      
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: _validate,
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.purple[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ],
            )));
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }
    setState(() {
      loggedIn = true;
      email = _emailController.text;
      name = 'your name';
      phone = '090078601';
      address = 'Gryffindor Dormitory, Hogwarts';
    });
  }

  void toggleSwitch(bool value) {
    if (biometric == false) {
      setState(() {
        biometric = true;
      });
    } else {
      setState(() {
        biometric = false;
      });
    }
  }
}