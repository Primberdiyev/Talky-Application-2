import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/controller_and_conditions_provider.dart';

class CompleteButton extends StatelessWidget {
  const CompleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TalkyProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 163, right: 28),
        child: TextButton(
          style: TextButton.styleFrom(
              fixedSize: const Size(394, 54),
              backgroundColor: const Color(0xFF377DFF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null && provider.image != null) {
              try {
                final ref = FirebaseStorage.instance
                    .ref()
                    .child('users/${user.email}/profile_image.jpg');
                UploadTask uploadTask = ref.putFile(File(provider.image!.path));
                final snapshot = await uploadTask.whenComplete(() => null);

                final downloadUrl = await snapshot.ref.getDownloadURL();

                await FirebaseFirestore.instance
                    .collection("User")
                    .doc(user.uid)
                    .update({
                  'name': provider.nameController.text,
                  'description': provider.descriptionController.text,
                  'imgUrl': downloadUrl,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ma'lumot muvaffaqiyatli saqlandi"),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Xatolik yuz berdi2: $e"),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text("Rasm tanlanmagan yoki foydalanuvchi topilmadi"),
                ),
              );
            }
          },
          child: const Text(
            'Complete',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }
}
