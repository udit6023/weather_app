import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Screens/homeScreen.dart';
import 'package:weather_app/provider/weatherProvider.dart';

class SignIN extends StatefulWidget {
  const SignIN({super.key});

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _userName;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Billabong',
                  fontSize: 50.0,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (input) => input!.trim().isEmpty
                            ? 'Please enter a valid name'
                            : null,
                        onSaved: (input) => _name = input!,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (input) => input!.trim().isEmpty
                            ? 'Please enter a valid username'
                            : null,
                        onSaved: (input) => _userName = input!,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (input) => !input!.contains('@')
                              ? 'Please enter a valid email'
                              : null,
                          onChanged: (input) {
                            setState(() {
                              _email = input;
                            });
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) => input!.length < 6
                            ? 'Must be at least 6 characters'
                            : null,
                        onChanged: (input) {
                          setState(() {
                            _password = input;
                          });
                        },
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : TextButton(
                                onPressed: () async {
                                  print(_email);
                                  print(_password);
                                  await Provider.of<WeatherProvider>(context,
                                          listen: false)
                                      .signUp(
                                          email: _email, password: _password);

                                          Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomeScreen()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Back to Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
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
      ),
    );
  }
}
