import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 18),
      child: SizedBox(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search',
            labelStyle: TextStyle(
              color: Color(0xFFAAB0B7),
              fontSize: 14,
            ),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
