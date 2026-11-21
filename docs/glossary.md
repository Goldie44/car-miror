# Glossary

Running glossary of the technical terms used while building Car Miror. Each entry: what it is, and an example from the app.

## Apple platform

### CarPlay

Apple's system that shows a simplified iPhone interface on the car screen. Apps only appear there through Apple's ready-made templates (lists, grids, now playing), and only in approved categories (audio, navigation, messaging…).
_Example:_ Car Miror cannot copy Netflix onto CarPlay; Apple does not allow it.

### Entitlement

A special permission written into an app's signature, that Apple must grant to your developer account. Without it, iOS refuses the feature.
_Example:_ `com.apple.developer.carplay-audio` is the entitlement an app needs to show up in CarPlay as an audio app.

### DRM (Digital Rights Management)

An anti-copy lock on paid videos and music. On iPhone, protected videos turn black in screenshots and screen recordings.
_Example:_ recording a Netflix film with the iPhone screen recorder gives a black video with sound.

### SwiftUI

Apple's framework for building screens in Swift: you describe what the screen shows, and it redraws itself when data changes. The iOS equivalent of React components.
_Example:_ `HomeView` is a SwiftUI view with an icon, a title and the version.

### IPA

The file that contains an iPhone app, ready to install: a zip with a `Payload/` folder holding the `.app`.
_Example:_ the GitHub workflow produces `CarMiror.ipa`.

### Code signing

A digital signature Apple requires on every app, proving who made it. An iPhone refuses to run an unsigned app.
_Example:_ GitHub builds the IPA unsigned; Sideloadly signs it with your Apple ID just before installing it.

### Sideloading

Installing an app on the iPhone without going through the App Store.
_Example:_ Sideloadly sideloads Car Miror from your Windows PC through the USB cable.

### Developer Mode

An iPhone setting that allows apps installed outside the App Store to run.
_Example:_ without it, Car Miror refuses to open after Sideloadly installs it.

### Localizable.xcstrings (String Catalog)

The file that holds every user-facing text, by key and by language. The iOS equivalent of the i18next translation files in Ravitail.
_Example:_ `Text("home.title")` shows "Car Miror", read from the catalog.

## Tooling

### Xcode

Apple's development app, used to build iPhone apps. It only runs on macOS.
_Example:_ GitHub's Mac runs Xcode's command-line tool `xcodebuild` for us.

### XcodeGen

A tool that generates the Xcode project file (`.xcodeproj`) from a short readable file, `project.yml`. It means we never have to open Xcode to add a file or a setting.
_Example:_ adding a new Swift file in `CarMiror/` is enough; XcodeGen picks it up on the next build.

### GitHub Actions (CI)

Computers run by GitHub that execute a script on every push. *CI* (continuous integration) means checking and building the code automatically each time it changes.
_Example:_ `.github/workflows/build.yml` runs the tests and builds the IPA on a GitHub Mac.

### Artifact (GitHub Actions)

A file produced by a GitHub Actions run that you can download from the run's page, kept for a limited time.
_Example:_ `CarMiror-ipa`, kept 14 days.

### Simulator

A fake iPhone running on a Mac, used to run the app and its tests without a real phone.
_Example:_ the unit tests run on an iPhone simulator on GitHub's Mac.

### XCTest

Apple's unit testing framework, the Swift equivalent of Vitest.
_Example:_ `AppVersionTests` checks that the version label reads `v0.1.0 (42)`.
