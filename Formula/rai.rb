class Rai < Formula
  desc "Extensible personal CLI"
  homepage "https://github.com/masseater/rai"
  version "0.1.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.3/rai-v0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "fe26c3ba0459da6ae9818541d033e4233f8e21d3e6df9c4cce16a4c03b96bcaa"
    else
      url "https://github.com/masseater/rai/releases/download/v0.1.3/rai-v0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "38f0e6386ec79b23c424c0e5b874b495417d630344ae5f5b6a544c47e005e063"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.3/rai-v0.1.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2ac3a1e391c64123209133e34f6b19e5c2e338aaec904b5713b4966e1bf39bba"
    else
      url "https://github.com/masseater/rai/releases/download/v0.1.3/rai-v0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae10b26034fe00cb80e43983c7497eb77ac59d61f877e937245f2023d21cb030"
    end
  end

  def install
    bin.install "rai"
  end

  test do
    assert_match "hello, world!", shell_output("#{bin}/rai hello")
  end
end
