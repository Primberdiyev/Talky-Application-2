import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/profile/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class CompleteButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  const CompleteButton(
      {required this.nameController,
      required this.descriptionController,
      super.key});

  @override
  State<CompleteButton> createState() => _CompleteButtonState();
}

class _CompleteButtonState extends State<CompleteButton> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfilePageProvider>();
    return Padding(
      padding: const EdgeInsets.only(
        top: 163,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: const Size(394, 54),
          backgroundColor: const Color(0xFF377DFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          final name = widget.nameController.text;
          final description = widget.descriptionController.text;
          if (name.isNotEmpty) {
            try {
              await provider.saveUserProfile(
                  name: name, description: description);

              await Future.delayed(Duration.zero, () {
                Navigator.pushNamed(context, NameRoutes.main);
              });
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error.toString(),
                  ),
                ),
              );
            }
          }
        },
        child: !provider.state.isLoading
            ? const Text(
                'Complete',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
