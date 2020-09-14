# Pre-work - Tip Calculator

Tips is a tip calculator application for iOS.

Submitted by: Yanni Speron

Time spent: 6 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] User can select between tip percentages by tapping different values on the segmented control and the tip value is updated accordingly

The following **optional** features are implemented:

* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

* [x] Quick custom tip amount feature without having to change the tip settings

## Video Walkthrough

Here's a walkthrough of the app:

<img src='https://media3.giphy.com/media/chcNYdS4n7P89EQoGS/giphy.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Notes

The main issue that I had, was being able to pass data and send updates between the settings view controller and the main view controller. I ended up solving this problem with UserDefaults, and the NotificationCenter.

## License

    Copyright 2020 Yanni Speron

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
