class Rai < Formula
  desc "rai — an extensible personal CLI."
  homepage "https://github.com/masseater/rai"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.11/rai-aarch64-apple-darwin.tar.xz"
      sha256 "6a5de42ef35e57885ab07bdc4c8697479b16b867046cac517f1e7d4d3da703ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.11/rai-x86_64-apple-darwin.tar.xz"
      sha256 "9ae3861158866c4b7c8d5011202f652a283ae2648606b35bd97cdca5cd72e952"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.11/rai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dd3d99e632faae2fb7e66932592bb01a7e094dce82e838f32f421d5f29c1fd19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.11/rai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0f0fecd17947e4389f5ee0ac26a872672f3ec872e057a597cdff4917fd4da12b"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "rai" if OS.mac? && Hardware::CPU.arm?
    bin.install "rai" if OS.mac? && Hardware::CPU.intel?
    bin.install "rai" if OS.linux? && Hardware::CPU.arm?
    bin.install "rai" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
