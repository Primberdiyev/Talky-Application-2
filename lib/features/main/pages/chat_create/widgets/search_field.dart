import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/main/providers/profile_page_provider.dart';
import 'package:talky_aplication_2/unilities/app_icons.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Search',
              labelStyle: const TextStyle(
                color: Color(0xFFAAB0B7),
                fontSize: 14,
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.search.icon),
              ),
            ),
            onChanged: (value) => provider.onSearchChanged(value),
          ),
        );
      },
    );
  }
}
