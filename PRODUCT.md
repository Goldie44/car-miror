# Product

## Platform

iOS (iPhone), personal use only, sideloaded. Not published on the App Store.

## Users

The author, in their car, phone in a mount, on their own iPhone.

## Product Purpose

A "car mode" for the iPhone: one screen of big buttons that open the author's streaming, music and navigation apps, easy to hit in a car mount, which stays awake while open. Later, video buttons hide while the car is moving.

The original idea (mirror streaming apps to CarPlay) is not feasible: Apple forbids screen mirroring on CarPlay, DRM apps capture as black, and CarPlay cannot be tested without a Mac and an Apple entitlement.

## Capabilities and Constraints

- Opens other apps through their URL scheme; shows only the ones installed (`LSApplicationQueriesSchemes`).
- No brand logos (trademarks): SF Symbols per category, the app name as text.
- Portrait and landscape, since car mounts are often landscape.
- Watching video while driving is illegal in France: video must only be reachable while parked (slice 2).

## Decisions

- 2026-11-21: native iOS app built on GitHub Actions and installed from Windows, chosen by the author over a PWA or a rented Mac.
- 2026-11-22: car mode chosen as the product; split into a launcher (slice 1) and driving detection (slice 2).
- For in-car video while parked, the recommended non-code answer stays a CarPlay "AI box" or AirPlay to CarPlay when parked, if the car supports it.

## Slices

0. Toolchain: a minimal screen built on CI and installed on the iPhone. _(validated 2026-11-22)_
1. Launcher: big tiles by category (Vidéo, Musique, Navigation) for installed apps; screen stays awake. _(in progress)_
2. Driving detection: hide video tiles while the car moves (Core Motion).
