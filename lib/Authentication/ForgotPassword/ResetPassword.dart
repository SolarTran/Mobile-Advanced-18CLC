import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  void click() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              Row(
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                      onPressed: () {},
                      style: TextButton.styleFrom (
                          textStyle: const TextStyle(fontSize: 20),
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10)
                      )
                    )
                  ]
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 325,
                height: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create New Password",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your new password must be different from previous used password.\n",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      "New Password",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,

                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(
                      width: 360,
                      height: 60,
                      child: TextField(
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Confirm New Password",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,

                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(
                      width: 360,
                      height: 60,
                      child: TextField(
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        width: 360,
                        height: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF8A2387),
                                  Color(0xFFE94057),
                                  Color(0xFFF27121),
                                ]
                            )
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
