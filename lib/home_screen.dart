import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'rss_service.dart';
import 'webview_container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSS News'),
      ),
      body: FutureBuilder(
        future: RssService().getFeed(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final feed = snapshot.data;
                  return ListView.builder(
                      itemCount: feed.items.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        final item = feed.items[index];
                        return ListTile(
                          title: Text(item.title),
                          subtitle: Text('Published at ' + item.pubDate),
                          //subtitle: Text('Published at ' +
                          //                              DateFormat.yMd()
                          //                                  .format(DateTime.parse(item.pubDate))),
                          contentPadding: EdgeInsets.all(16.0),
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewContainer(item
                                        .link
                                        .replaceFirst('http', 'https'))));
                          },
                        );
                      });
                }
              }
              //else {return Text("No data");}
              return Text("No data");
              // ignore: missing_return
              //break;
            case ConnectionState.none:
              return Text("Waiting");
            case ConnectionState.active:
              return Text("Waiting");
            case ConnectionState.waiting:
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            default:
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}