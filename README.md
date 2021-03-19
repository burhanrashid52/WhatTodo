# WhatTodo

[![Codemagic build status](https://api.codemagic.io/apps/5d43b6fe9585dc25b92df7d2/5d43b6fe9585dc25b92df7d1/status_badge.svg)](https://codemagic.io/apps/5d43b6fe9585dc25b92df7d2/5d43b6fe9585dc25b92df7d1/latest_build) ![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg) ![API](https://img.shields.io/badge/API-16%2B-brightgreen.svg) [![Uplabs](https://img.shields.io/badge/Uplabs-WhatTodo-orange.svg)](https://www.uplabs.com/posts/whattodo) [![FlutterWeekly](https://img.shields.io/badge/Flutter%20Weekly-%2319-pink.svg)](https://mailchi.mp/193f2a7fe907/flutter-weekly-257173) [![AwesomeAndroid](https://img.shields.io/badge/Awesome%20Android-%23101-yellow.svg)](https://android.libhunt.com/newsletter/101)
<a href="https://www.buymeacoffee.com/burhanrashid52" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

![logo](/assets/Logo/horizontal.png)

Life can feel overwhelming. But it doesn’t have to. 

A Simple To-do app design in flutter to keep track of your task on daily basis. You can add project, labels and due-date to your tasks

[<img src="https://raw.githubusercontent.com/steverichey/google-play-badge-svg/master/img/en_get.svg" width="300">](https://play.google.com/store/apps/details?id=ja.burhanrashid52.whattodo)

## Features

- Build on [**BLoC**](#bloc-diagram) Architecture Pattern
- Add [**Projects**](#project) by specifying a unique color to it
- Add [**Labels**](#labels) by specifying a unique color to it
- Add [**Task**](#task) by defining its priority
- [**Swipe**](#swipe-the-task) to delete or complete the task
- [**Sorting**](#sorting) Task
- Works offline using [**Sqflite**](https://github.com/tekartik/sqflite "Flutter Database") database

## BLoC Diagram
This diagram show case the dependencies to create a feature specific BLoCs.The HomeBloc is independent and used as communication channel between its child widgets.

![](https://i.imgur.com/byajGE7.png)

## Widget-BLoC Relationship
This diagram shows that how each widget uses BLoCs.

![](https://i.imgur.com/fHGTASw.png)

## Project
The app already has a preloaded **_Inbox_** project. You can add more projects by clicking add project button on SideDrawer. From material color list you can specify any single color to the project

![](https://i.imgur.com/f01IjGz.gif)

> You can assign only one project to a single task

## Labels
You can add multiple labels by clicking add Labels button on SideDrawer. From material color list you can specify any single color to the label

![](https://i.imgur.com/tZQgEwW.gif)

> You can assign multiple labels to a single task

## Task
You can add task with multiple attributes. You must assign a project to task if not than by default it will be added in _Inbox_ project.
Task can have zero or more to label assing to it

![](https://i.imgur.com/mNs0D3B.gif)

## Swipe the Task
You can delete a task by swiping left-to-right or your can mark task as completed by swiping right-to-left. You can also undo a completed task by clicking on options menu where  it shows the list of all completed tasks there you can swipe right-to-left to undo the completed task

![](https://i.imgur.com/yU0gP1t.gif)

## Sorting
You can sort your task with date i.e today and next 7 days and also acoording to project and labels

![](https://i.imgur.com/wzou22S.gif)


## How to contribute?
* Check out contribution guidelines 👉[CONTRIBUTING.md](https://github.com/burhanrashid52/WhatTodo/blob/master/CONTRIBUTING.md)


## What's next?

 - Editiable Project,label and Task
 - Deletable Project and Label
 - Comment/Description in Task
 - Reminder with notification


## Questions?🤔
Hit me on twitter [![Twitter](https://img.shields.io/badge/Twitter-%40burhanrashid52-blue.svg)](https://twitter.com/burhanrashid52)
[![Medium](https://img.shields.io/badge/Medium-%40burhanrashid52-brightgreen.svg)](https://medium.com/@burhanrashid52)
[![Facebook](https://img.shields.io/badge/Facebook-Burhanuddin%20Rashid-blue.svg)](https://www.facebook.com/Bursid)


## Credits
  - UI/UX inspired from [**Todoist**](https://play.google.com/store/apps/details?id=com.todoist&hl=en) app
  - Flutter [**Documentation**](https://flutter.io/docs/)
  - [**Collin Jackson**](https://stackoverflow.com/users/1463116/collin-jackson) answer's on stackoverflow :laughing:

## License
Copyright 2020 Burhanuddin Rashid

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
