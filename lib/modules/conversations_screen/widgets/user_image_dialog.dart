import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import '../../../shared/models/firebase_models/chat_user.dart';
import '../../users_profile_screen.dart/users_profile_screen.dart';

class UserImageDialog extends StatelessWidget {
  final ChatUser chatUser;
  const UserImageDialog({super.key, required this.chatUser});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      content: SizedBox(
        width: screenSize.width * .6,
        height: screenSize.height * .4,
        child: Stack(
          children: [
            Positioned(
              top: screenSize.height * .08,
              left: screenSize.width * .1,
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(screenSize.height * .3),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: screenSize.width * .5,
                    height: screenSize.height * .27,
                    imageUrl: chatUser.image,
                    errorWidget: (context, url, error) => const CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenSize.width * .04,
              top: screenSize.height * .02,
              width: screenSize.width * .5,
              child: Text(
                chatUser.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfileView(user: chatUser),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
