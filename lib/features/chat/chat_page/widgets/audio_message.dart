import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioMessage extends StatefulWidget {
  final bool isMine;
 final  String link;

 const  AudioMessage({super.key, required this.isMine, required this.link});

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Align(
        alignment: widget.isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          height: 100,
          width: 275,
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () async {

                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      try {
                    
                            await audioPlayer.play(UrlSource(widget.link));
                      } catch (e) {
                        print('xato $e');
                      }
                    }
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: 30,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Slider(
                      min: 0,
                      activeColor: Colors.red,
                      max: duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        final newPosition = Duration(seconds: value.toInt());
                        setState(() {
                          position = newPosition;
                        });
                        audioPlayer.seek(newPosition);
                      },
                      value: position.inSeconds.toDouble(),
                    ),
                    Text(
                      '${position.inMinutes}:${(position.inSeconds.remainder(60)).toString().padLeft(2, '0')} / ${duration.inMinutes}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
