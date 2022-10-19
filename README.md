# Adding a Video Backgroun to your SliverAppBar (or any other widget)

SliverAppBar struncture
```dart
SliverAppBar(
            ...
            flexibleSpace: Stack(
              children: [
                const FlexibleSpaceBar(
                  // video component
                  background: Video()),
                Container(
                  decoration: const BoxDecoration(
                      // to change gradient angle https://stackoverflow.com/a/65811244
                      gradient: LinearGradient(
                    begin: Alignment(-0, -1),
                    end: Alignment(-1.0, 1),
                    colors: [Colors.black12, Colors.black87],
                  )),
                ),

                // add here all your over video components 
                Container(
                    child: ...
                    ),
                  ),
                )
              ],
            ),
          ),
```


### Change Video 
```dart
class _VideoState extends State<Video> {
  // change video here
  final VideoPlayerController _controller =
      VideoPlayerController.asset('videos/clouds.mp4');
...
}
```