// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/modules/conversations_screen/widgets/user_image_dialog.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import '../../../shared/helper/my_date_util.dart';
import '../../../shared/models/firebase_models/chat_user.dart';
import '../../../shared/models/firebase_models/message.dart';
import '../../chat_screen.dart/chat_screen.dart';

class ChatUserCard extends StatelessWidget {
  final ChatUser user;
  Message? _message;
  ChatUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: screenSize.width * .02,
        vertical: 4,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      color: Colors.blue.shade50,
      child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(user: user),
              ),
            );
          },
          child: StreamBuilder(
            stream: FirebaseAPIs.getLastMessages(user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                _message = list[0];
              }
              return ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                leading: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => UserImageDialog(chatUser: user),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: screenSize.height * .055,
                      height: screenSize.height * .055,
                      imageUrl: user.image,
                      // placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),

                //user name
                title: Text(user.name),

                //last message
                subtitle: Text(
                  _message != null
                      ? _message!.type == Type.image
                          ? 'image'
                          : _message!.msg
                      : user.about,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                //last message time
                trailing: _message == null
                    ? null //show nothing when no message is sent
                    : _message!.read.isEmpty &&
                            _message!.fromId != FirebaseAPIs.user.uid
                        //show for unread message
                        ? Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.greenAccent,
                            ),
                          )

                        //message sent time
                        : Text(
                            MyDateUtil.getLastMessageTime(context,
                                time: _message!.sent),
                            style: const TextStyle(color: Colors.black54),
                          ),
              );
            },
          )),
    );
  }
}
