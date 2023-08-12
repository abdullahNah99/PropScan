import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../../shared/componentes/componentes.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<login> {
  var emailController = TextEditingController();

  var PassController = TextEditingController();

  final formkey = GlobalKey<FormState>();
// late RiveAnimationController _controller;
/////////////////////////////////////////////////////////
  var animationLink = 'assets/animation/login2.riv';
  late SMITrigger trigFail, trigSuccess;
  late SMIBool isChecking, isHandsUp;
  late SMINumber numLook;
  Artboard? artboard;
  late StateMachineController stateMachineController;
  @override
  void initState() {
    super.initState();
    initartboard();
  }

  initartboard() {
    rootBundle.load(animationLink).then((value) {
      try {
        final file = RiveFile.import(value);
        final art = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(art, "Login Machine")!;
        if (stateMachineController != null) {
          art.addController(stateMachineController);
          for (var element in stateMachineController.inputs) {
            if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "trigSuccess") {
              trigSuccess = element as SMITrigger;
            } else if (element.name == "trigFail") {
              trigFail = element as SMITrigger;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          }
        }
        setState(() {
          artboard = art;
        });
      } catch (e) {
        print('Error importing Rive file: $e');
      }
    });
  }

  checking() {
    isHandsUp.change(false);
    isChecking.change(true);
    numLook.change(0);
  }

  moveEYES(Value) {
    numLook.change(Value.length);
  }

  handsUp() {
    isHandsUp.change(true);
    isChecking.change(false);
  }

  login() {
    isHandsUp.change(false);
    isChecking.change(false);
    if (emailController.text == "admin ") {
      trigSuccess.fire();
    } else {
      trigFail.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'LOGIN',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child:
                      artboard != null
                          ? SizedBox(
                              width: 400,
                              height: 300,
                              child: Rive(artboard: artboard!),
                            )
                          :
                      SizedBox(
                              width: 400,
                              height: 300,
                            ),
                    ),
                    defaultextformfield(
                        controlle: emailController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email mustn\'t be empty';
                          } else if (!value.contains('@')) {
                            return 'You forget \'@\'';
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                        onChange: (value) {
                         moveEYES(value);
                          print(value);
                        },
                        onTap: () {
                         checking();
                        },
                        onSubmit: (value) {
                          print(value);
                        },
                        label: 'Email',
                        prefixIcon: Icons.email_outlined,
                        ispassword: false),
                    SizedBox(
                      height: 15,
                    ),
                    defaultextformfield(
                      controlle: PassController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                      onChange: (value) {
                        print(value);
                      },
                      onTap: () {
                        handsUp();
                      },
                      onSubmit: (value) {
                        print(value);
                      },
                      ispassword: true,
                      type: TextInputType.visiblePassword,
                      label: 'Password',
                      prefixIcon: Icons.lock_outlined,
                      // suffixIcon: AppCubit.get(context).suffixPass,
                      // suffixPressed: () {
                      //   AppCubit.get(context).changePassvisiblity();
                      // },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        background: Colors.blueGrey,
                        function: () {
                          login();
                        },
                        text: " LOGIN")
                  ]),
            ),
          ],
        ),
      ),
    ));
  }
}
