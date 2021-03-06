import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:myapp/api_functions.dart';
import 'package:myapp/global_variables.dart';

class Wasabia {
  Wasabia({
    required this.id,
    required this.name,
    required this.image,
    required this.votes,
    required this.songs,
  });

  final int id;
  final String name;
  final String image;
  final int votes;
  final int songs;
}

class Song {
  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.votes,
    required this.user_vote,
    required this.image_url,
  });

  final String id;
  final String name;
  final String artist;
  final int votes;
  final int user_vote;
  final String image_url;
}

class WasabiaListing extends StatefulWidget {
  const WasabiaListing({Key? key}) : super(key: key);

  @override
  _WasabiaListingState createState() => _WasabiaListingState();
}

class _WasabiaListingState extends State<WasabiaListing> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class WasabiaSong extends StatefulWidget {
  const WasabiaSong(
      {Key? key,
      required this.value,
      required this.init_change,
      required this.wasabia_id,
      required this.song_id,
      required this.song_name,
      required this.artist,
      required this.index,
      required this.image_url})
      : super(key: key);
  final int value;
  final int init_change;
  final int index;
  final int wasabia_id;
  final String song_id;
  final String song_name;
  final String artist;
  final String image_url;

  @override
  _WasabiaSongState createState() => _WasabiaSongState();
}

class _WasabiaSongState extends State<WasabiaSong> {
  int? change = null;
  Color button_color = color_1;

  get song => null;

  @override
  initState() {
    print(change);
    change = change ?? widget.init_change;
    print(change);
    super.initState();
  }

  _update_vote(int vote_value) async {
    change = (change == vote_value) ? 0 : vote_value;
    bool result =
        await vote_on_song(widget.song_id, widget.wasabia_id, change ?? 0);
    if (!result) {
      change = (change == vote_value) ? 0 : vote_value;
    }
  }

  Color _return_color(int vote_value) {
    if (change == vote_value) {
      return (vote_value == 1) ? Colors.green : Colors.red;
    } else {
      return color_1;
    }
  }

  Widget VoteButton(String logo, int vote_value) {
    return IconButton(
      splashRadius: 12,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      onPressed: () {
        setState(() {
          _update_vote(vote_value);
        });
      },
      icon: SvgPicture.asset(
        "assets/icons/buttons/${logo}.svg",
        semanticsLabel: 'Upvote',
        color: _return_color(vote_value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(0, 0, 0, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 700,
          ),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${widget.index}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: ImageNetwork(
                              image: widget.image_url,
                              height: 100.0,
                              width: 100.0,
                              fitWeb: BoxFitWeb.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.song_name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  widget.artist,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: <Widget>[
                        VoteButton("upvote", 1),
                        Text(
                          "${widget.value + (change ?? 0)}",
                          style: TextStyle(
                            height: 1,
                          ),
                        ),
                        VoteButton("downvote", -1),
                        SizedBox(width: 50),
                      ],
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
