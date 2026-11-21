# Build on GitHub, install from Windows

One-time setup, then a short routine for every new build.

## One-time setup

1. **GitHub repository.** Create a GitHub account if needed, then a new repository named `car-miror`. Make it **public**: macOS build minutes are free and unlimited on public repositories, while private ones only get about 200 macOS minutes a month. The repo holds no secrets.
2. **Push the code** from this folder:
   ```bash
   git init -b main
   git add .
   git commit -m "🎉 start Car Miror with a CI-built iOS app"
   git remote add origin https://github.com/<your-username>/car-miror.git
   git push -u origin main
   ```
3. **Apple tools for Windows.** Install iTunes and iCloud from apple.com, **not** the Microsoft Store versions (Sideloadly cannot see the phone with those).
4. **Sideloadly.** Install it from sideloadly.io.
5. **Apple ID.** Sideloadly signs the app with an Apple ID. A free one works. A secondary Apple ID is safer than your main one, since you type it into a third-party tool.
6. **iPhone.** Settings → Privacy & Security → **Developer Mode** → on (the phone restarts).

## Every new build

1. Push to `main` (or run the workflow by hand: GitHub → Actions → Build → Run workflow).
2. Wait for the green tick (about 5 to 10 minutes).
3. Open the run, download the **CarMiror-ipa** artifact, unzip it to get `CarMiror.ipa`.
4. Plug the iPhone in with a cable, unlock it, accept "Trust this computer".
5. In Sideloadly: drag `CarMiror.ipa` in, type the Apple ID, click **Start**.
6. First time only, on the iPhone: Settings → General → VPN & Device Management → your Apple ID → **Trust**.
7. Open Car Miror. The version at the bottom (`v0.1.0 (N)`) shows the build number N of the GitHub run.

With a free Apple ID, the app stops opening after 7 days: install it again with Sideloadly.
