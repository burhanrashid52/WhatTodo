import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_constant.dart';
import 'package:flutter_app/utils/app_util.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading:
                            Icon(Icons.bug_report, color: Colors.black),
                        title: Text("Rpeort an Issue"),
                        subtitle: Text("Having an issue ? Report it here"),
                        onTap: () => launchURL(ISSUE_URL)),
                    ListTile(
                      leading: Icon(Icons.update, color: Colors.black),
                      title: Text("Version"),
                      subtitle: Text("0.0.1"),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("Author",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.perm_identity, color: Colors.black),
                      title: Text("Burhanuddin Rashid"),
                      subtitle: Text("burhanrashid52"),
                      onTap: () => launchURL(GITHUB_URL),
                    ),
                    ListTile(
                        leading:
                            Icon(Icons.bug_report, color: Colors.black),
                        title: Text("Fork on Github"),
                        onTap: () => launchURL(PROJECT_URL)),
                    ListTile(
                        leading: Icon(Icons.email, color: Colors.black),
                        title: Text("Send an Email"),
                        subtitle: Text("burhanrashid5253@gmail.com"),
                        onTap: () => launchURL(EMAIL_URL)),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("Ask Question ?",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Image.asset("assets/twitter_logo.png",scale: 8.75,),
                            onPressed: () => launchURL(TWITTER_URL),
                          ),
                          IconButton(
                            icon: Image.asset("assets/facebook_logo.png"),
                            onPressed: () => launchURL(FACEBOOK_URL),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("Apache Licenese",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        subtitle: Text("Copyright 2018 Burhanuddin Rashid"
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
