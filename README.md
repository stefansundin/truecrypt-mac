# Patches for Mac version of TrueCrypt 7.1a

You can either download the installer directly from [the releases](https://github.com/stefansundin/truecrypt-mac/releases/latest) or patch it yourself.

The TrueCrypt binary has not changed or recompiled.

## Install patch

The installer contains a bug that prevents installing it on Mac OS X 10.10 or higher.

```bash
hdiutil convert 'TrueCrypt 7.1a Mac OS X.dmg' -format UDRW -o 'TrueCrypt 7.1a Mac OS X writable.dmg'
hdiutil attach 'TrueCrypt 7.1a Mac OS X writable.dmg'
patch '/Volumes/TrueCrypt 7.1a/TrueCrypt 7.1a.mpkg/Contents/distribution.dist' distribution.dist.patch
hdiutil detach '/Volumes/TrueCrypt 7.1a'
hdiutil convert 'TrueCrypt 7.1a Mac OS X writable.dmg' -format UDBZ -o 'TrueCrypt 7.1a Mac OS X (patched).dmg'
```
