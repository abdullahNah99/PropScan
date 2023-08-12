import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../shared/constant/const.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor(dg),
          title: Text(
            'SIGN UP',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 530,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: HexColor(bp),
                        spreadRadius: 8,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(30),
                  child: Column(children: [
                    Container(
                      width: 240,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: HexColor(bp),
                            spreadRadius: 8,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_2_outlined,
                                color: HexColor(dg),
                              ),
                              label: Text(
                                "First Name",
                                style: TextStyle(color: HexColor(dg)),
                              ),
                              border: InputBorder.none)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 240,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: HexColor(bp),
                            spreadRadius: 8,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_2_outlined,
                                color: HexColor(dg),
                              ),
                              label: Text(
                                "Last Name",
                                style: TextStyle(color: HexColor(dg)),
                              ),
                              border: InputBorder.none)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 240,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: HexColor(bp),
                            spreadRadius: 8,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email_outlined,
                                color: HexColor(dg),
                              ),
                              label: Text(
                                "Email",
                                style: TextStyle(color: HexColor(dg)),
                              ),
                              border: InputBorder.none)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 240,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: HexColor(bp),
                            spreadRadius: 8,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock_outline,
                                color: HexColor(dg),
                              ),
                              label: Text(
                                "Password",
                                style: TextStyle(color: HexColor(dg)),
                              ),
                              border: InputBorder.none)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 240,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: HexColor(bp),
                            spreadRadius: 8,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.phone_android_outlined,
                                  color: HexColor(dg)),
                              label: Text(
                                "Phone Number",
                                style: TextStyle(color: HexColor(dg)),
                              ),
                              border: InputBorder.none)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [HexColor(dg), HexColor(dp)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Creat Account",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [HexColor(dg), HexColor(dp)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
