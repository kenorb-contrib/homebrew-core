require "language/node"

class Joplin < Formula
  desc "Note taking and to-do application with synchronisation capabilities"
  homepage "https://joplin.cozic.net/"
  url "https://registry.npmjs.org/joplin/-/joplin-1.0.104.tgz"
  sha256 "7217367c61ff3626b68f76a1d46ec7a3c1d5d174668b67110cd45e47d52838fd"

  bottle do
    sha256 "495883e6ab9215d34af1943ada3cc98a6002681c97670c3d2d010714d3a1f91c" => :high_sierra
    sha256 "b7aa58ce4f7dfc16d04962c509983eea9659a3d11c0cae7b498edeae6664bc8a" => :sierra
    sha256 "204fc084b02f00a1d9be0b7e58dc20e791a4be2334658e2d0ff1533d06395b71" => :el_capitan
  end

  depends_on "node"
  depends_on "python@2" => :build if MacOS.version <= :snow_leopard

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"joplin", "config", "editor", "subl"
    assert_match "editor = subl", shell_output("#{bin}/joplin config")
  end
end
