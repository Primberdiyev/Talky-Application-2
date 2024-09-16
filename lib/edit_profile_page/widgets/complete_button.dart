import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/edit_profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class CompleteButton extends StatelessWidget {
  const CompleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditPageProvider>();
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
          provider.updateIsNameEmpty(provider.nameController.text.isEmpty);
          if (!provider.isNameEmpty) {
            try {
              provider.setIsLoading();
              await provider.saveUserProfile();
              provider.setIsLoading();
              Navigator.pushNamed(context, NameRoutes.profile);
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
        child: !provider.isLoading
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
