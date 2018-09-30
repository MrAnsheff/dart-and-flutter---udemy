import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';

class ItemModel {
  //The item's unique id.
  final int id;

  //	true if the item is deleted.
  final bool deleted;

  //The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  final String type;

  //The username of the item's author.
  final String by;

  //Creation date of the item, in Unix Time.
  final int time;

  //The comment, story or poll text. HTML.
  final String text;

  //true if the item is dead.
  final bool dead;

  //The comment's parent: either another comment or the relevant story.
  final int parent;

  //The ids of the item's comments, in ranked display order.
  final List<dynamic> kids;

  //The URL of the story.
  final String url;

  //The story's score, or the votes for a pollopt.
  final int score;

  //The title of the story, poll or job.
  final String title;

  //In the case of stories or polls, the total comment count.
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        deleted = parsedJson["deleted"] == 0 ? false : true,
        type = parsedJson["type"],
        by = parsedJson["by"],
        time = parsedJson["time"],
        text = parsedJson["text"],
        dead = parsedJson["dead"] == 0 ? false : true,
        parent = parsedJson["parent"],
        kids = parsedJson["kids"] == null ? [] : jsonDecode(parsedJson["kids"]),
        url = parsedJson["url"],
        score = parsedJson["score"],
        title = parsedJson["title"],
        descendants = parsedJson["descendants"] ?? 0;

  ItemModel.fromAPI(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        deleted = parsedJson["deleted"] ?? false,
        type = parsedJson["type"],
        by = parsedJson["by"],
        time = parsedJson["time"],
        text = _cleanText(parsedJson["text"]),
        dead = parsedJson["dead"] ?? false,
        parent = parsedJson["parent"],
        kids = parsedJson["kids"] ?? [],
        url = parsedJson["url"],
        score = parsedJson["score"],
        title = parsedJson["title"],
        descendants = parsedJson["descendants"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "deleted": deleted ? 0 : 1,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "dead": dead ? 0 : 1,
      "parent": parent,
      "kids": jsonEncode(kids),
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
    };
  }

  static _cleanText(parsedJson) {
    if (parsedJson == null) return null;

    var unescape = HtmlUnescape();
    return unescape.convert(parsedJson);
  }
}
