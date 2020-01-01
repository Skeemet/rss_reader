import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class RssService {
  final _targetUrl = 'https://www.raspberrypi.org/feed/';

  Future<RssFeed> getFeed() =>
      http.read(_targetUrl).then((xmlString) => RssFeed.parse(xmlString));
}