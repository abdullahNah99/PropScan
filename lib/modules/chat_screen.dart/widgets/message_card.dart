import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/main.dart';
import 'package:untitled/shared/functions/custom_snack_bar.dart';
import '../../../shared/helper/my_date_util.dart';
import '../../../shared/models/firebase_models/message.dart';
import '../../../shared/network/remote/firebase/firebase_apis.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = FirebaseAPIs.user.uid == message.fromId;
    return InkWell(
      onLongPress: () {
        FocusScope.of(context).unfocus();
        _showBottomSheet(context, isMe);
      },
      child: isMe ? _greenMessage(context) : _blueMessage(context),
    );
  }

  //sender or another user message
  Widget _blueMessage(BuildContext context) {
    if (message.read.isEmpty) {
      FirebaseAPIs.updateMessageReadStatus(message);
      log('message read updated');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(
              message.type == Type.text
                  ? screenSize.width * .04
                  : screenSize.width * .025,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * .04,
              vertical: screenSize.height * .01,
            ),
            child: message.type == Type.text
                ? Text(
                    message.msg,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image,
                        size: 70,
                      ),
                    ),
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: screenSize.width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(context, time: message.sent),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  //our or user message
  Widget _greenMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: screenSize.width * .04),
            if (message.read.isNotEmpty)
              const Icon(
                Icons.done_all_rounded,
                color: Colors.blue,
                size: 20,
              ),
            const SizedBox(width: 2),
            Text(
              MyDateUtil.getFormattedTime(context, time: message.sent),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              border: Border.all(color: Colors.lightGreen),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(message.type == Type.text
                ? screenSize.width * .04
                : screenSize.width * .025),
            margin: EdgeInsets.symmetric(
              horizontal: screenSize.width * .04,
              vertical: screenSize.height * .01,
            ),
            child: message.type == Type.text
                ? Text(
                    message.msg,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image,
                        size: 70,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  //bottom sheet for modifying message details
  void _showBottomSheet(BuildContext context, bool isMe) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 4,
              margin: EdgeInsets.symmetric(
                vertical: screenSize.height * .015,
                horizontal: screenSize.width * .4,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            message.type == Type.text
                ? _OptionItem(
                    icon: const Icon(
                      Icons.copy_all_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: 'Copy Text',
                    onTap: () async {
                      await (Clipboard.setData(
                              ClipboardData(text: message.msg)))
                          .then((value) {
                        Navigator.pop(context);
                        CustomeSnackBar.showSnackBar(
                          context,
                          msg: 'Text Copied',
                          duration: const Duration(milliseconds: 500),
                        );
                      });
                    },
                  )
                : _OptionItem(
                    icon: const Icon(
                      Icons.download_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: 'Save Image',
                    onTap: () {},
                  ),
            if (isMe)
              Divider(
                color: Colors.black54,
                endIndent: screenSize.width * .04,
                indent: screenSize.width * .04,
              ),
            if (message.type == Type.text && isMe)
              _OptionItem(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 26,
                ),
                name: 'Edit Message',
                onTap: () {
                  Navigator.pop(context);
                  _showMessageUpdateDialog(context);
                },
              ),
            if (isMe)
              _OptionItem(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 26,
                ),
                name: 'Delete Message',
                onTap: () async {
                  Navigator.pop(context);
                  CustomeSnackBar.showSnackBar(
                    context,
                    msg: 'Message Deleted',
                    duration: const Duration(milliseconds: 500),
                  );
                  await FirebaseAPIs.deleteMessage(message);
                  // .then((value) {
                  //   Navigator.pop(context);
                  //   Dialogs.showSnackBar(context, msg: 'Message Deleted');
                  // });
                },
              ),
            Divider(
              color: Colors.black54,
              endIndent: screenSize.width * .04,
              indent: screenSize.width * .04,
            ),
            _OptionItem(
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.blue,
                size: 26,
              ),
              name:
                  'Sent At: ${MyDateUtil.getMessageTime(context, time: message.sent)}',
            ),
            _OptionItem(
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.green,
                size: 26,
              ),
              name: message.read.isNotEmpty
                  ? 'Read At: ${MyDateUtil.getMessageTime(context, time: message.read)}'
                  : 'Not Seen Yet',
            ),
          ],
        );
      },
    );
  }

  void _showMessageUpdateDialog(BuildContext context) {
    String updatedMsg = message.msg;
    showDialog(
      context: context,
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
                Icons.message,
                color: Colors.blue,
                size: 28,
              ),
              Text('   Update Message'),
            ],
          ),
          content: TextFormField(
            initialValue: updatedMsg,
            maxLines: null,
            onChanged: (value) => updatedMsg = value,
            decoration: InputDecoration(
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
              onPressed: () {
                Navigator.pop(context);
                FirebaseAPIs.updateMessage(message, updatedMsg);
              },
              child: const Text(
                'Update',
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

class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback? onTap;
  const _OptionItem({
    required this.icon,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenSize.width * .05,
          top: screenSize.height * .015,
          bottom: screenSize.height * .015,
        ),
        child: Row(
          children: [
            icon,
            Flexible(
              child: Text(
                '     $name',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
