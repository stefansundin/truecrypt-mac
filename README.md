# 64-bit TrueCrypt for macOS

- Compiled for 64-bit and wxWidgets 3.1. Based on https://github.com/neurodroid/TrueCrypt.
- The file extension `.tc` has been associated with TrueCrypt.

Download [the latest release](https://github.com/stefansundin/truecrypt-mac/releases/latest).

To build, you need:
```
brew install nasm pkg-config
brew cask install osxfuse
```

You need to replace your wxmac Formula with [this one](Build/Resources/MacOSX/wxmac.rb).
```
brew edit wxmac
brew reinstall wxmac
```

Get wxFormBuilder for macOS here: https://github.com/wxFormBuilder/wxFormBuilder/releases

For the old 32-bit version, see [this branch](https://github.com/stefansundin/truecrypt-mac/tree/old) and [this release](https://github.com/stefansundin/truecrypt-mac/releases/tag/v3).
