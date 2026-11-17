cask "lenotch" do
  version "2.15.2"
  sha256 "16d98988f8a1e458e55d35435cfe809416d0f0366e94eb93f08c4a79fad7007b"

  url "https://github.com/lephorx/lenotch/releases/download/v#{version}/Lenotch.dmg"
  name "Lenotch"
  desc "Notch app with Now Playing, calendar, file shelf and AI usage"
  homepage "https://github.com/lephorx/lenotch"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Lenotch updates itself with Sparkle.
  auto_updates true
  depends_on macos: :sonoma

  app "Lenotch.app"

  # Lenotch isn't notarized, so Gatekeeper would block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Lenotch.app"]
  end

  uninstall quit: "com.lephorx.Lenotch"

  zap trash: [
    "~/Library/Application Support/Lenotch",
    "~/Library/Caches/com.lephorx.Lenotch",
    "~/Library/HTTPStorages/com.lephorx.Lenotch",
    "~/Library/HTTPStorages/com.lephorx.Lenotch.binarycookies",
    "~/Library/Preferences/com.lephorx.Lenotch.plist",
  ]
end
