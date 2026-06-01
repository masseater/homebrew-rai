class Rai < Formula
  desc "rai — an extensible personal CLI."
  homepage "https://github.com/masseater/rai"
  version "0.1.31"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.31/rai-aarch64-apple-darwin.tar.xz"
      sha256 "a4f5d0a2ce4e90fc75aa3b8f179819a95ee0564bdda80682532e69d7afd1b675"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.31/rai-x86_64-apple-darwin.tar.xz"
      sha256 "4cdb20828f413e2393c6ebe65f68170ee29c030fc16cd3e897f94ca5144ab4f3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.31/rai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "815a23b51c7433ac6cfb983292676dd91d11b6babcc928c393d36bbac04c9d55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.31/rai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ad1d1d2ae6f7b306ff8e3afc071aeaf88c228637949d7c003a81f424d26dd6d"
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
