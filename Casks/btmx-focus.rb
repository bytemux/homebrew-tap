cask "btmx-focus" do
  version "1.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/bytemux/btmx-focus/releases/download/v#{version}/btmx-focus-#{version}.dmg"
  name "btmx-focus"
  desc "Menu-bar focus timer"
  homepage "https://github.com/bytemux/btmx-focus"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "btmx-focus.app"

  # Not notarized (see the repo's ADR 0016): clear the quarantine flag so
  # Gatekeeper doesn't block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/btmx-focus.app"]
  end

  uninstall quit: "com.btmx.focus"

  zap trash: "~/Library/Containers/com.btmx.focus"

  caveats <<~EOS
    btmx-focus is not notarized by Apple. This cask removes the quarantine
    flag from btmx-focus.app so macOS opens it without asking.
  EOS
end
