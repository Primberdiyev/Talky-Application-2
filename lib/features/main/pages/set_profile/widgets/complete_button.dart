import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/main/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/routes/name_routes.dart';

class CompleteButton extends StatefulWidget {
  const CompleteButton({
    required this.nameController,
    required this.descriptionController,
    super.key,
  });
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  @override
  State<CompleteButton> createState() => _CompleteButtonState();
}

class _CompleteButtonState extends State<CompleteButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (
      context,
      provider,
      child,
    ) {
      if (provider.state.isCompleted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            if (widget.nameController.text.isNotEmpty) {
              Navigator.pushNamed(context, NameRoutes.main);
            }
          }
        });
      }
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
          onPressed: () {
            provider.saveUserProfile(
              name: widget.nameController.text,
              description: widget.descriptionController.text,
            );
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
    });
  }
}
