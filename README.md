# Plangrid
Plangrid is an iOS/iPadOS app for organising your life into a grid, built for Hack Club's Siege Week 10.
It supports iPhone and iPad, as well as Mac and Apple Vision Pro using *Designed for iPad*!

# Demos
## Screenshots
TODO: actually put the damn things into the readme
## Video
[YouTube link (unlisted)](https://example.com)
takes you to example.com for now :/

# How to get Plangrid
As per usual for all my Siege projects, this is the way I recommend but there are other ways to sideload apps onto iOS/iPadOS devices such as AltStore or SideStore which *should* work, there's no reason for them not to!
1. Install [Sideloadly](https://sideloadly.io) and its dependencies; iirc there are none on macOS but on Windows you need iTunes and iCloud **not from the Microsoft Store!** The Sideloadly website will link you to everything you need for your OS.
2. From the [Releases](https://github.com/ConsciousBone/Plangrid/releases/tag/stable) tab, find the latest release - it should be at the top - and download the attached `Plangrid.ipa` file.
3. Using a cable that supports both charge *and* data transfer, connect your device (iPhone or iPad, the sideloading process for Macs and AVPs is weird and I don't feel like figuring it out, you're on your own) to your computer, and if prompted, select `Trust` and enter your password, then open Sideloadly.
4. In Sideloadly, click the file icon with the `IPA` text and select the previously downloaded `Plangrid.ipa` file.
5. Select your device in the `iDevice` dropdown, and make sure the name matches with the device you wish to sideload Plangrid to.
6. In the `Apple ID` text field, enter your Apple Account/ID's email. If your account does not have a paid and active Apple Developer subscription, you will have to reinstall/resign the app every 7 days, but if you have a Developer subscription this goes to a pretty decent 365 days!
7. Click the `Start` button, and enter your Apple Account/ID's password when prompted to. **This password goes straight to Apple; no one apart from you and Apple will ever see this password. Not the developers of Sideloadly, and not me.**
8. Wait for the app to install, and then launch it! *If you are prompted to enable Developer Mode or trust the app/developer, then do so.*

# Inspiration
From using apps like Microsoft Teams, every calendar app ever, etc, their implementation of grids and tables has always been the same - scrolling horizontally, with rectangular cells showing all the information about each event.  
I wanted to make something different, with Plangrid all of your events (called *cells*) are shown at once, in a grid containing perfect squares with icons and colours to represent them - not tons of information that could end up being unneccesary. You can still get the more detailed info like the event name and notes of said event by tapping into a cell, and while you're there you can also easily edit all information about said cell; the colour, icon, name, and notes are all easily tweakable!  
This ensures you get the best of both worlds: a clean, easily glanceable grid of events, and, when you need it, all the information you would typically get.  
With Plangrid being a Siege project, it of course had to fit with the week's theme, this week being `Grid`, hence the grid layout of the schedule tab!

# Tech stack
- Swift (what basically every modern app for Apple platforms is written in)
- SwiftUI (for the whole of the app's UI, goated library btw apple tyvm)
- SwiftData (to store information about cells, i.e. name, notes, colour, etc)
