import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      if (provider.usersData == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: provider.countUsers,
        itemBuilder: (context, index) {
          return ListTile(
            leading: provider.usersData != null &&
                    provider.usersData![index]['imgUrl'] != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      provider.usersData![index]['imgUrl'],
                    ),
                  )
                : Image.asset('assets/images/User.png'),
            title: Text(
              provider.usersData![index]['name'],
            ),
          );
        },
      );
    });
  }
}
