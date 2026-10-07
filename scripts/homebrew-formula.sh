#!/usr/bin/env bash
set -euo pipefail
VERSION="$1"; SHA_X64_MAC="$2"; SHA_ARM_MAC="$3"; SHA_X64_LINUX="$4"; SHA_ARM_LINUX="$5"
cat <<EOF
class Orgchart < Formula
  desc "Render ASCII org charts from an indentation-based DSL"
  homepage "https://github.com/igbanam/orgchart"
  version "$VERSION"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/igbanam/orgchart/releases/download/v$VERSION/orgchart-v$VERSION-x86_64-apple-darwin.tar.gz"
      sha256 "$SHA_X64_MAC"
    end
    if Hardware::CPU.arm?
      url "https://github.com/igbanam/orgchart/releases/download/v$VERSION/orgchart-v$VERSION-aarch64-apple-darwin.tar.gz"
      sha256 "$SHA_ARM_MAC"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/igbanam/orgchart/releases/download/v$VERSION/orgchart-v$VERSION-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "$SHA_X64_LINUX"
    end
    if Hardware::CPU.arm?
      url "https://github.com/igbanam/orgchart/releases/download/v$VERSION/orgchart-v$VERSION-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "$SHA_ARM_LINUX"
    end
  end

  def install
    bin.install "orgchart"
  end

  test do
    assert_match "orgchart", shell_output("#{bin}/orgchart --version")
  end
end
EOF