class Rai < Formula
  desc "Extensible personal CLI"
  homepage "https://github.com/masseater/rai"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.0/rai-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "d99477223d626b335e09d6135bb9a87406275542612d8f00a512251028d8800b"
    else
      url "https://github.com/masseater/rai/releases/download/v0.1.0/rai-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "c01d0451cbe4af4e76a802675d1a49772cf9c27fb4dc8b27a4d116597c8c0f0d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.0/rai-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08de916b022620f8410933990b7b85232f7193f257864547b39322915a47165e"
    else
      url "https://github.com/masseater/rai/releases/download/v0.1.0/rai-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0ed383e2c421c625663f78ad10382a8479a3078a4522e440859ed9f09235f8ea"
    end
  end

  def install
    bin.install "rai"
  end

  test do
    assert_match "hello, world!", shell_output("#{bin}/rai hello")
  end
end
