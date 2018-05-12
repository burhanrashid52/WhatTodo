import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_constant.dart';
import 'package:flutter_app/utils/app_util.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About"),
      ),
      body: new Container(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new ListView(
            children: <Widget>[
              new Card(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                        leading:
                            new Icon(Icons.bug_report, color: Colors.black),
                        title: new Text("Rpeort an Issue"),
                        subtitle: new Text("Having an issue ? Report it here"),
                        onTap: () => launchURL(ISSUE_URL)),
                    new ListTile(
                      leading: new Icon(Icons.update, color: Colors.black),
                      title: new Text("Version"),
                      subtitle: new Text("0.0.1"),
                    )
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: new Text("Author",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    new ListTile(
                      leading:
                          new Icon(Icons.perm_identity, color: Colors.black),
                      title: new Text("Burhanuddin Rashid"),
                      subtitle: new Text("burhanrashid52"),
                      onTap: () => launchURL(GITHUB_URL),
                    ),
                    new ListTile(
                        leading:
                            new Icon(Icons.bug_report, color: Colors.black),
                        title: new Text("Fork on Github"),
                        onTap: () => launchURL(PROJECT_URL)),
                    new ListTile(
                        leading: new Icon(Icons.email, color: Colors.black),
                        title: new Text("Send an Email"),
                        subtitle: new Text("burhanrashid5253@gmail.com"),
                        onTap: () => launchURL(EMAIL_URL)),
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: new Text("Ask Question ?",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new IconButton(
                            icon: new Image.asset("assets/twitter_logo.png",scale: 8.75,),
                            onPressed: () => launchURL(TWITTER_URL),
                          ),
                          new IconButton(
                            icon: new Image.asset("assets/facebook_logo.png"),
                            onPressed: () => launchURL(FACEBOOK_URL),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: new Text("Apache Licenese",
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new ListTile(
                        subtitle: new Text("Copyright 2018 Burhanuddin Rashid"
                            '\n\nLicensed under the Apache License, Version 2.0 (the "License") you may not use this file except in compliance with the License. You may obtain a copy of the License at'
                            "\n\n\nhttp://www.apache.org/licenses/LICENSE-2.0"
                            '\n\nUnless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
