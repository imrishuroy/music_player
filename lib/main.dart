import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Music Player',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  Duration duration = Duration();
  Duration position = Duration();
  String status = '';
  @override
  void initState() {
    super.initState();
    initialisize();
  }

  void initialisize() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  void slider(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 20, 0, 5),
                child: Text(
                  'Harmony',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90.0, 2, 0, 10),
                child: Text(
                  'PLay whatever you want',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              SizedBox(height: 70.0),
              Center(
                child: Container(
                  height: 250.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/cover.jpg'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Slider(
                  activeColor: Colors.blue,
                  inactiveColor: Colors.deepOrange,
                  min: 0.0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      slider(value.toInt());
                      value = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 35),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                height: 80.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      iconSize: 50.0,
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () {
                        audioCache.play('perfect.mp3');
                        setState(() {
                          status = 'Playing';
                        });
                      },
                    ),
                    IconButton(
                      iconSize: 50.0,
                      icon: Icon(
                        Icons.pause,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () {
                        audioPlayer.pause();
                        setState(() {
                          status = 'Paused';
                        });
                      },
                    ),
                    IconButton(
                      iconSize: 50.0,
                      icon: Icon(
                        Icons.not_started,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () {
                        audioPlayer.resume();
                        setState(() {
                          status = 'Playing';
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
