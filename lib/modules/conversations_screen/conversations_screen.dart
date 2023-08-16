import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/main.dart';
import 'package:untitled/modules/conversations_screen/widgets/chat_user_card.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import '../../shared/models/firebase_models/chat_user.dart';
import '../profile_screen/profile_screen.dart';

class ConversationsView extends StatefulWidget {
  static const route = 'ConversationsView';
  const ConversationsView({super.key});

  @override
  State<ConversationsView> createState() => _ConversationsViewState();
}

class _ConversationsViewState extends State<ConversationsView> {
  List<ChatUser> list = [];

  final List<ChatUser> searchList = [];

  bool isSearching = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FirebaseAPIs.getSelfInfo();

    //for updating user avtive status according to lifecycle events
    //resume -- avtive or online
    //pause -- lastacive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (FirebaseAPIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          FirebaseAPIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          FirebaseAPIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //if search is on & back button is pressed then close search
        //or else simple close current screen on back button click
        onWillPop: () {
          if (isSearching) {
            setState(() {
              isSearching = !isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: isSearching
                ? TextField(
                    autofocus: true,
                    style: const TextStyle(fontSize: 17, letterSpacing: 1),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name, Email, ...',
                    ),
                    onChanged: (value) {
                      searchList.clear();
                      for (var i in list) {
                        if (i.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            i.email
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          searchList.add(i);
                        }
                      }
                      setState(() {
                        // searchList;
                      });
                    },
                  )
                : const Text('We Chat'),
            // leading: const Icon(CupertinoIcons.home),
            actions: [
              IconButton(
                icon: Icon(
                    isSearching ? CupertinoIcons.clear_circled : Icons.search),
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileView(user: FirebaseAPIs.me),
                    ),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addUserDialog();
            },
            child: const Icon(Icons.add_comment_rounded),
          ),
          body: StreamBuilder(
            stream: FirebaseAPIs.getMyUsersId(),

            //get id of only know users
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                //if data is Loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
                //if some or all data loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  return StreamBuilder(
                    stream: FirebaseAPIs.getAllUsers(
                      snapshot.data?.docs.map((e) => e.id).toList() ?? [],
                    ),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        //if data is Loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                        // return const Center(child: CircularProgressIndicator());

                        //if some or all data loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          list = data
                                  ?.map((e) => ChatUser.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (list.isNotEmpty) {
                            return ListView.builder(
                              padding: EdgeInsets.only(
                                top: screenSize.height * .01,
                                bottom: screenSize.height * .01,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  isSearching ? searchList.length : list.length,
                              itemBuilder: (context, index) {
                                // return Text('Name : ${list[index]}');
                                return ChatUserCard(
                                    user: isSearching
                                        ? searchList[index]
                                        : list[index]);
                              },
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'No Chats Yet',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }
                      }
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  void _addUserDialog() {
    String email = '';
    showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: 10,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(
                Icons.person_add,
                color: Colors.blue,
                size: 28,
              ),
              Text('   Add User'),
            ],
          ),
          content: TextFormField(
            keyboardType: TextInputType.emailAddress,
            maxLines: null,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.blue,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                Navigator.pop(context);
                if (email.isNotEmpty) {
                  await FirebaseAPIs.addChatUser(email).then((value) {
                    if (!value) {
                      CustomeSnackBar.showSnackBar(_scaffoldKey.currentContext!,
                          msg: 'User Does Not Exists');
                    }
                  });
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
