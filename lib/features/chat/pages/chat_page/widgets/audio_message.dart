import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talky_aplication_2/features/chat/providers/audio_provider.dart';

class AudioMessage extends StatefulWidget {
  const AudioMessage({
    required this.isMine,
    required this.link,
    super.key,
  });
  final bool isMine;
  final String link;

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  late AudioProvider audioProvider;
  @override
  void initState() {
    super.initState();
    final audioProvider = context.read<AudioProvider>();
    audioProvider.initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final audioProvider = context.read<AudioProvider>();
        audioProvider.audioPlayer.dispose();
        super.dispose();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final audioMaxSecond = audioProvider.duration.inSeconds.toDouble();
    final audioMaxPosition = audioProvider.position.inSeconds.toDouble();
    return ChangeNotifierProvider(
      create: (_) => AudioProvider(),
      child: ListTile(
        title: Align(
          alignment:
              widget.isMine ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            height: 100,
            width: 275,
            child: Consumer<AudioProvider>(
              builder: (
                context,
                audioProvider,
                child,
              ) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () async {
                          if (audioProvider.isPlaying) {
                            await audioProvider.audioPlayer.pause();
                          } else {
                            try {
                              await audioProvider.audioPlayer.play(
                                UrlSource(widget.link),
                              );
                            } catch (e) {
                              log('xato $e');
                            }
                          }
                        },
                        icon: Icon(
                          audioProvider.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        iconSize: 30,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Slider(
                            activeColor: Colors.red,
                            max: audioMaxSecond,
                            onChanged: (value) {
                              final newPosition = Duration(
                                seconds: value.toInt(),
                              );
                              audioProvider.changePosition(newPosition);
                              audioProvider.audioPlayer.seek(newPosition);
                            },
                            value: audioMaxPosition,
                          ),
                          Text(
                            '${audioProvider.position.inMinutes}:${audioProvider.position.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${audioProvider.duration.inMinutes}:${audioProvider.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
