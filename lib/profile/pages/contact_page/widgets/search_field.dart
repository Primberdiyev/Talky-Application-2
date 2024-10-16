import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/profile/providers/profile_page_provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      return SizedBox(
        height: 40,
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search',
            labelStyle: TextStyle(
              color: Color(0xFFAAB0B7),
              fontSize: 14,
            ),
            suffixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => provider.onSearchChanged(value),
        ),
      );
    });
  }
}
