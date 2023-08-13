// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/main.dart';
import 'package:untitled/shared/network/remote/services/auth/update_profile_service.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import '../../shared/functions/custom_dialog.dart';
import '../../shared/functions/custom_snack_bar.dart';
import '../../shared/models/firebase_models/chat_user.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/firebase/firebase_apis.dart';
import '../../shared/network/remote/services/auth/logout_service.dart';
import '../login_screen/login_screen.dart';

class ProfileView extends StatefulWidget {
  static const route = 'ProfileView';
  final ChatUser user;

  const ProfileView({super.key, required this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var formKey = GlobalKey<FormState>();
  String? _image;
  String? _name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            CustomDialog.showProgressBar(context);
            await FirebaseAPIs.updateActiveStatus(false);
            await FirebaseAPIs.auth.signOut().then(
              (value) async {
                (await LogOutService.logout(
                  token: await CacheHelper.getData(key: 'Token'),
                ))
                    .fold(
                  (failure) {
                    CustomeSnackBar.showSnackBar(
                      context,
                      msg: 'Something Went Wrong, Please Try Again',
                      color: Colors.red,
                    );
                  },
                  (success) async {
                    await CacheHelper.deletData(key: 'Token');

                    Navigator.popAndPushNamed(context, LoginView.route);
                  },
                );
              },
            );
          },
          label: const Text(
            'LogOut',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * .05,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(screenSize.height * .2),
                              child: Image.file(
                                File(_image!),
                                width: screenSize.height * .2,
                                height: screenSize.height * .2,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(screenSize.height * .2),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: screenSize.height * .2,
                                height: screenSize.height * .2,
                                imageUrl: widget.user.image,
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            _showBottomSheet(context);
                          },
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.edit,
                            color: AppColors.defaultColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenSize.height * .05),
                  Text(
                    widget.user.email,
                    style: const TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  SizedBox(height: screenSize.height * .05),
                  TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _name = newValue;
                      FirebaseAPIs.me.name = newValue ?? '';
                    },
                    initialValue: widget.user.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'eg. Abdullah Nahlawi',
                      label: const Text('name'),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: AppColors.defaultColor,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .05),
                  TextFormField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required';
                      }
                      return null;
                    },
                    onSaved: (newValue) =>
                        FirebaseAPIs.me.about = newValue ?? '',
                    initialValue: widget.user.about,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "eg. Feeling Happy",
                      label: const Text('about'),
                      prefixIcon: const Icon(
                        Icons.info_outline,
                        color: AppColors.defaultColor,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * .05),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size(
                        screenSize.width * .4,
                        screenSize.height * .055,
                      ),
                    ),
                    onPressed: () {
                      CustomDialog.showProgressBar(context);
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        FirebaseAPIs.updateUserInfo().then(
                          (value) async {
                            (await UpdateProfileService.updateProfile(
                                    newName: _name!,
                                    email: FirebaseAPIs.me.email))
                                .fold(
                              (failure) {
                                Navigator.pop(context);
                                CustomeSnackBar.showErrorSnackBar(context,
                                    msg:
                                        'Something Went Wrong, Please Try Again');
                              },
                              (success) {
                                Navigator.pop(context);
                                CustomeSnackBar.showSnackBar(
                                  context,
                                  msg: 'Information Updated Successfully',
                                  color: Colors.green,
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                      color: AppColors.defaultColor,
                    ),
                    label: const Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 20, color: AppColors.defaultColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
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
          padding: EdgeInsets.symmetric(vertical: screenSize.height * .03),
          children: [
            const Text(
              'Pick Profile Piture',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenSize.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(
                      screenSize.width * .3,
                      screenSize.height * .15,
                    ),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 80);
                    if (image != null) {
                      log('Image Path : ${image.path} -- Mime Type : ${image.mimeType}');

                      setState(() {
                        _image = image.path;
                      });

                      FirebaseAPIs.updateProfilePicture(File(_image!));

                      //for hiding bottom sheet
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('assets/images/camera.png'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(
                      screenSize.width * .3,
                      screenSize.height * .15,
                    ),
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery, imageQuality: 80);
                    if (image != null) {
                      log('Image Path : ${image.path} -- Mime Type : ${image.mimeType}');

                      setState(() {
                        _image = image.path;
                      });

                      FirebaseAPIs.updateProfilePicture(File(_image!));

                      //for hiding bottom sheet
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('assets/images/picture.png'),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
