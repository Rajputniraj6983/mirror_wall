import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall/provider/Google_provider.dart';
import 'package:mirror_wall/view/screen/Homepage.dart';
import 'package:provider/provider.dart';


 PullToRefreshController pullToRefreshController = PullToRefreshController(
   onRefresh: () {
     inAppWebViewController.reload();
   },
 );



class GoogleScreen extends StatelessWidget {
  const GoogleScreen ({super.key, required this.url});

  final String url;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.home_outlined,
            size: 32,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 50,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Text(
              "Google",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 35),
            ),

            const Spacer()
          ],
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Text(
              "1",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          InkWell(onTap: () {
            PopupMenuButton<dynamic> MenuBox() {
              return PopupMenuButton(itemBuilder: (context) => [
                PopupMenuItem(child: Column(
                  children: [
                     Row(
                       children: [
                         Icon(Icons.bookmarks_rounded),
                         BookMark(context),
                       ],
                     ),
                    Row(
                      children: [
                        Icon(Icons.search),
                        InkWell(
                          onTap: () {
                            showDialog(context: context, builder: (context) => AlertDialog(
                              backgroundColor: Colors.grey,
                              title:  Center(
                                  child: Text('Search Browser',style: TextStyle(fontWeight: FontWeight.bold)),
                                  actions: [
                                    radiobutton(context,'https://www.google.com','Google'),
                                    radiobutton(context,'https://www.bing.com/','Bing'),
                                    radiobutton(context,'https://in.search.yahoo.com/','Yahoo'),
                                    radiobutton(context,'https://duckduckgo.com/','Duck Duck Go'),
                                  ]
                              ),
                            );
                          },
                          child: Text('Search Browser'),
                        ),SizedBox(height: 10),
                        Icon(Icons.history),
                        SizedBox(width: 10,),
                        Text("History")
                      ],
                    )
                  ],
                )
                )
              ]
              );
            }
          },child: Icon(Icons.more_vert,size: 30,color: Colors.white,))
        ],
        backgroundColor: const Color(0xff353739),
        automaticallyImplyLeading: false,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(
              "https://www.google.com/webhp?hl=en&ictx=2&sa=X&ved=0ahUKEwjii6O6vKmGAxWsZfUHHbPsJksQPQgK"),
        ),
        onWebViewCreated: (controller) {
          var inAppWebView = controller;
        },
        onProgressChanged: (controller, progress) {
          Provider.of<googleprovider>(context, listen: false).progress;
        },
        onLoadStop: (controller,url){
          Provider.of<googleprovider>(context, listen: false).addurl(url.toString());
          pullToRefreshController.endRefreshing();
        },
        pullToRefreshController: pullToRefreshController,
      ),
      // (Provider.of<googleprovider>(context,listen: true).progress < 1)? Align(
      //   alignment: Alignment.bottomCenter,
      //   child: LinearProgressIndicator(
      //     value: Provider.of<googleprovider>(context,listen: true).progress,
      //   ),
      // )
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  inAppWebViewController.goBack();
                },
                icon: Icon(Icons.arrow_back)),
            IconButton(
                onPressed: () {
                  inAppWebViewController.reload();
                },
                icon: Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  inAppWebViewController.goForward();
                },
                icon: Icon(Icons.arrow_forward)),
            IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.home)),
            IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.more_horiz_outlined)),
          ],
        )

    );
  }
}

Widget myListTile(String t1, IconData i1) {
  return SizedBox(
    height: 40,
    child: Row(
      children: [
        Icon(
          i1,
          color: Colors.white,
        ),
        const Text("    "),
        Text(
          t1,
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}

late InAppWebViewController inAppWebViewController;
TextEditingController txtSearch = TextEditingController();

