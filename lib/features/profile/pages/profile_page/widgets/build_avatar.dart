import 'package:flutter/material.dart';

class BuildAvatar extends StatelessWidget {
  final String? imgUrl;
  final bool isWithOnline;
  final bool isOnline;
  const BuildAvatar(
      {super.key,
      required this.imgUrl,
      required this.isWithOnline,
      required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return imgUrl != null
        ? Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(imgUrl!),
              ),
              if (isWithOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOnline
                          ? const Color(0xFF2DCA8C)
                          : const Color(0xFFFF715B),
                    ),
                  ),
                ),
            ],
          )
        : Image.asset(
            'assets/images/User.png',
            width: 30,
          );
  }
}
