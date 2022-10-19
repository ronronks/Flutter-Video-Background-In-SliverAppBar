import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ).copyWith(textTheme: GoogleFonts.ubuntuTextTheme()),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // add your leading and actions here
            leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu_outlined)),
            pinned: true,
            floating: true,
            // backgroundColor: Colors.black,
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: Stack(
              children: [
                const FlexibleSpaceBar(
                  
                  // video component
                  background: Video()),
                
                // add here all your overvideo components 
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(bottom: 50, left: 50),
                  child: const Text(
                    'Text Here',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),

          // your widgets here
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                margin: const EdgeInsets.all(0),
                height: 400,
                color: index % 2 == 0
                    ? const Color.fromARGB(112, 203, 198, 198)
                    : Colors.white,
              ),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  // change video here
  final VideoPlayerController _controller =
      VideoPlayerController.asset('videos/clouds.mp4');

  @override
  void initState() {
    _controller.initialize().then((_) {
      setState(() {
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoScreen(
      controller: _controller,
    );
  }
}

class VideoScreen extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Container(
          
            alignment: Alignment.topCenter,
            child: Stack(
              fit: StackFit.expand,
              children: [
                (({
                  required Widget child,
                }) {
                  final size = controller.value.size;
                  final width = size.width;
                  final height = size.height;

                  return FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(width: width, height: height, child: child),
                  );
                }(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                )),
                Container(decoration: const BoxDecoration(
                      // to change gradient angle https://stackoverflow.com/a/65811244
                      gradient: LinearGradient(
                    begin: Alignment(-0, -1),
                    end: Alignment(-1.0, 1),
                    colors: [Colors.black12, Colors.black87],
                  )),)
              ],
            ))
        : const Center(child: CircularProgressIndicator());
  }
}
