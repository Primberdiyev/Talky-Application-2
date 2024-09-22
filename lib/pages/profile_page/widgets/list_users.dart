import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/providers/profile_page_provider.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});
  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(builder: (context, provider, child) {
      if (provider.usersData == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: provider.countUsers,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                provider.usersData != null &&
                        provider.usersData![index]['imgUrl'] != null
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          provider.usersData![index]['imgUrl'],
                        ),
                      )
                    : Image.asset(
                        'assets/images/User.png',
                        width: 30,
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.usersData![index]['name'],
                      style: const TextStyle(
                        color: Color(0xFF243443),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    provider.usersData![index]['description'] != null
                        ? Text(
                            provider.usersData![index]!['description'],
                          )
                        : const Text(''),
                  ],
                ),
                const SizedBox.shrink(),
                provider.usersData![index]['closingTime'] != null
                    ? Text(provider
                        .timeAgo(provider.usersData![index]['closingTime']))
                    : const Text('Unknown registration time'),
                Image.asset('assets/images/Chevron.png'),
              ],
            ),
          );
        },
      );
    });
  }
}
