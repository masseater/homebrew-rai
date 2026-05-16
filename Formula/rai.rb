class Rai < Formula
  desc "rai — an extensible personal CLI."
  homepage "https://github.com/masseater/rai"
  version "0.1.20"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.20/rai-aarch64-apple-darwin.tar.xz"
      sha256 "f5f1aebe7356ba1c80ceb2a2e3ca9be30a3841bf344c427137087915da420376"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.20/rai-x86_64-apple-darwin.tar.xz"
      sha256 "0241e83f213a7d75e2de18a65cd6c041ae07140c29931864cba7c9f203b46ac6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.20/rai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e2dd1ebd9ceb19bfaf8d2634037b2dde1fab7fe3c6f6e1c17fd43d278908ab8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.20/rai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "897a3df056214fcc656b04b6582443e03a78fb2df995a40707526ef8bde1a050"
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
