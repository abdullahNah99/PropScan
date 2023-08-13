// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../shared/helper/my_date_util.dart';
import '../../shared/models/firebase_models/chat_user.dart';

class UserProfileView extends StatefulWidget {
  final ChatUser user;

  const UserProfileView({super.key, required this.user});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.user.name),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Joined On: ',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              MyDateUtil.getLastMessageTime(context,
                  time: widget.user.createdAt, showYear: true),
              style: const TextStyle(fontSize: 17, color: Colors.black54),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * .05,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenSize.height * .2),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: screenSize.height * .2,
                    height: screenSize.height * .2,
                    imageUrl: widget.user.image,
                    errorWidget: (context, url, error) => const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * .05),
                Text(
                  widget.user.email,
                  style: const TextStyle(fontSize: 20, color: Colors.black87),
                ),
                SizedBox(height: screenSize.height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'About: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.user.about,
                      style:
                          const TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
