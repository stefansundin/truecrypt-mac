# 64-bit TrueCrypt for macOS

- Compiled for 64-bit and wxWidgets 3.1. Based on https://github.com/neurodroid/TrueCrypt.
- The file extension `.tc` has been associated with TrueCrypt.

Download [the latest release](https://github.com/stefansundin/truecrypt-mac/releases/latest).

## Build instructions

See [this issue](https://github.com/stefansundin/truecrypt-mac/issues/2) for more help.

Download and extract wxWidgets 3.1.2: https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.2/wxWidgets-3.1.2.tar.bz2

wxWidgets 3.1.3 and 3.1.4 causes TrueCrypt to crash and probably require code changes to fix.

### Preparation if you use Homebrew

```
brew install nasm pkg-config
brew cask install osxfuse
```

### Preparation if you do not use Homebrew

To build, you will need the following: (the versions here are what I used for the latest release)
- Xcode Command Line Tools (simply run `make` in a Terminal and you should receive a prompt that offers to install it)
- osxfuse: https://github.com/osxfuse/osxfuse/releases/download/osxfuse-3.11.0/osxfuse-3.11.0.dmg
- nasm: https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/macosx/nasm-2.15.05-macosx.zip
- pkg-config: https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz

Download and install osxfuse. Download and extract the other files.

```
# nasm provides binaries but you have to build pkg-config:
cd path/to/pkg-config-0.29.2
./configure --disable-debug --disable-host-tool --with-internal-glib
make

# set up your PATH:
export PATH=/absolute/path/to/nasm-2.15.05:/absolute/path/to/pkg-config-0.29.2:$PATH
```

### Build

```
git clone https://github.com/stefansundin/truecrypt-mac.git
cd truecrypt-mac
export WX_ROOT=/absolute/path/to/wxWidgets-3.1.2
make wxbuild
make WXSTATIC=1
(cd Main && zip -r ../TrueCrypt.app.zip TrueCrypt.app)
```

## Extra

Get wxFormBuilder for macOS here: https://github.com/wxFormBuilder/wxFormBuilder/releases

For the old 32-bit version, see [this branch](https://github.com/stefansundin/truecrypt-mac/tree/old) and [this release](https://github.com/stefansundin/truecrypt-mac/releases/tag/v3).
