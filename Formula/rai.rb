class Rai < Formula
  desc "rai — an extensible personal CLI."
  homepage "https://github.com/masseater/rai"
  version "0.1.23"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.23/rai-aarch64-apple-darwin.tar.xz"
      sha256 "4b1dfdc1cfad31fe21e5a35e31765a90adf0e4fab467b4cfcb8edfd1b1da3259"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.23/rai-x86_64-apple-darwin.tar.xz"
      sha256 "67a6704d061983acefc6da66341b96ab07fbddc67de15ee05605eab5c672ef24"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.23/rai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e452460e0610d2e6ba165bc49125cbb64a15cda156925101e318942e0720fbac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.23/rai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "408e3796c9e48a5c9001bb7c148f7822ae33fdd993a58934421f3ae1081ac615"
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
