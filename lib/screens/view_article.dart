import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_app/commons/article_states.dart';
import 'package:training_app/models/article.dart';
import 'package:training_app/commons/http_requests.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';
// body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.title);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.pushReplacement('/');
      },
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.publish),
      onPressed: () {
        String currentLocation = GoRouterState.of(context).location;
        var uploadLocation = "$currentLocation/upload";
        context.go(uploadLocation);
      },
    );
  }
}

class ViewArticleAppBar extends StatefulWidget with PreferredSizeWidget {
  final ArticleModel article;
  const ViewArticleAppBar({Key? key, required this.article}) : super(key: key);

  @override
  State<ViewArticleAppBar> createState() => _ViewArticleAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ViewArticleAppBarState extends State<ViewArticleAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.article.title),
      leading: const GoBackButton(),
      actions: const [UploadButton()],
    );
  }
}

class ArticlePlayer extends StatefulWidget {
  final ArticleModel article;
  const ArticlePlayer({super.key, required this.article});

  @override
  State<ArticlePlayer> createState() => _ArticlePlayerState();
}

class _ArticlePlayerState extends State<ArticlePlayer> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Text("Player"),
            Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {}),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   ),
            // )
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    // await audioPlayer.play(widget.article.audioUrl!);
                    await audioPlayer.play(
                        "https://file-examples.com/storage/feefe3d0dd63b5a899e4775/2017/11/file_example_WAV_1MG.wav");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ArticleViewPage extends StatefulWidget {
  final int articleIndex;
  const ArticleViewPage({super.key, required this.articleIndex});

  @override
  State<ArticleViewPage> createState() => _ArticleViewPageState();
}

class _ArticleViewPageState extends State<ArticleViewPage> {
  @override
  Widget build(BuildContext context) {
    final articleList = Provider.of<ArticleListModel>(context);

    final article = articleList.getItems()[widget.articleIndex];
    final appBar = ViewArticleAppBar(article: article);

    if (article.state == ArticleState.completed) {
      return Scaffold(
          appBar: appBar,
          body: ArticlePlayer(
            article: article,
          ));
    }

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Text(
          article.textContent, // default text style
          textAlign: TextAlign.center,
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
