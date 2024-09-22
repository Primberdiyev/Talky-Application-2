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
          String? imgUrl =
              provider.imgUrls[provider.usersData?[index]['imgUrl']];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: MediaQuery.of(context).size.width - 56,
            child: Row(
              children: [
                provider.usersData != null && imgUrl != null
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          imgUrl,
                        ),
                      )
                    : Image.asset(
                        'assets/images/User.png',
                        width: 30,
                      ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.usersData![index]['name'],
                            style: const TextStyle(
                              color: Color(0xFF243443),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          provider.usersData![index]['closingTime'] != null
                              ? Text(provider.timeAgo(
                                  provider.usersData![index]['closingTime']))
                              : const Text('Unknown registration time'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    provider.usersData![index]['description'] != null
                        ? Text(
                            provider.usersData![index]!['description'],
                          )
                        : const Text(''),
                  ],
                ),
                const Spacer(),
                Image.asset('assets/images/Chevron.png'),
              ],
            ),
          );
        },
      );
    });
  }
}
