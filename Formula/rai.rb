class Rai < Formula
  desc "rai — an extensible personal CLI."
  homepage "https://github.com/masseater/rai"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.8/rai-aarch64-apple-darwin.tar.xz"
      sha256 "11266625ad1f8f949fd33fb8e27f8af79109851ad71978e7d66cc01b960d342a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.8/rai-x86_64-apple-darwin.tar.xz"
      sha256 "71f017eb9c23420f918018db6b3c19dd368fa5240e07189a5d266ce1cb6e18d3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/masseater/rai/releases/download/v0.1.8/rai-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "24199d6935d2693e460b19302e9b481b40060dc17fe9db8d7d9fb9f4b15faa85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/masseater/rai/releases/download/v0.1.8/rai-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef3df9fdb6f55d2b8d1ba65be19f7868b195c663d26428cb85fc921327948bb5"
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
