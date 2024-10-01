import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String name;
  final String imgUrl;
  const ChatPage({super.key, required this.name, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(name),
            leading: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Circle.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Image.asset('assets/images/Back.png'),
                ),
              ],
            )),
      ),
    );
  }
}
