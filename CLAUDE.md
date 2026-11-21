# Car Miror

Native iPhone app (Swift + SwiftUI) for the author's personal use in the car. Built without a Mac: the Xcode project is generated and compiled on GitHub Actions, then installed from Windows with Sideloadly. Product truth: `PRODUCT.md`. Install steps: `docs/setup-windows.md`. Glossary for the author: `docs/glossary.md`.

## Working with the author

- The author is a beginner. Talk to them in **French**. Explain every concept you introduce (short, concrete, with an example from Car Miror). Add every new term to `docs/glossary.md`.
- Point out problems, contradictions and bad ideas immediately, with the reason and an alternative.
- When asking a question, give your recommended answer and why, so "ok" is a valid reply.
- **Language split:** code, comments, docs and commit messages in English. User-facing text in French, in `Localizable.xcstrings` only.
- **Vertical slices:** build one slice, check it yourself (CI green: tests + IPA build), then hand it to the author to install on their iPhone. Do not start the next slice before they validate.
- Do not commit unless asked. Commits: gitmoji + short imperative English message (`✨ add the home screen`).

## Known platform limits (do not promise these)

- No screen mirroring to CarPlay: Apple forbids it, and DRM streaming apps (Netflix, Disney+, Prime…) capture as a black screen.
- CarPlay needs an Apple-granted entitlement and a Mac to test in the CarPlay simulator; neither is available, so CarPlay code cannot be verified.
- Free Apple ID signing: the app expires after 7 days and must be reinstalled; max 3 sideloaded apps.

## Stack

Swift 5 · SwiftUI · iOS 17+ · XcodeGen (`project.yml` is the source of truth; `.xcodeproj` is git-ignored) · XCTest · GitHub Actions `macos-15` runner · Sideloadly on Windows. Change a default only with a stated reason.

## Architecture (feature-based)

```
CarMiror/
  App/            # @main entry point
  Features/
    <Feature>/    # views, view models, services of one feature
  Shared/         # code used by two or more features
  Resources/      # Localizable.xcstrings, assets
CarMirorTests/    # XCTest unit tests
```

- Code starts in its feature; it moves to `Shared/` only when a second feature needs it.
- One type per file, file named after the type (PascalCase).
- No magic strings: user-facing text through localization keys (`home.title`), other constants in enums.
- Accessibility: Dynamic Type fonts (`.body`, `.title`…), decorative images `accessibilityHidden`, touch targets ≥ 44×44pt, states never by colour alone.
- Comments explain a non-obvious why; no comments that narrate code.
- Tests: XCTest for logic and formatting; views stay thin.

## Build and install

There is no local build on Windows. Every push to `main` runs `.github/workflows/build.yml`: XcodeGen → unit tests on a simulator → unsigned `CarMiror.ipa` uploaded as the `CarMiror-ipa` artifact. The author downloads it and installs it with Sideloadly (`docs/setup-windows.md`).

A slice is done when the workflow is green and the author has seen it on their iPhone.
