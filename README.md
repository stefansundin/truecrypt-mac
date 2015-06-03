# Patches for Mac version of TrueCrypt 7.1a

You can either download the installer directly from [the releases](https://github.com/stefansundin/truecrypt-mac/releases/latest) or patch it yourself.

Changes:

- The installer has been patched to be compatible with OS X 10.10.
- The file extension `.tc` is associated with TrueCrypt.

The TrueCrypt binary has not been changed or recompiled.

## Patch it yourself

```bash
hdiutil convert 'TrueCrypt 7.1a Mac OS X.dmg' -format UDRW -o 'TrueCrypt 7.1a Mac OS X writable.dmg'
hdiutil attach 'TrueCrypt 7.1a Mac OS X writable.dmg'

# patch installer
patch '/Volumes/TrueCrypt 7.1a/TrueCrypt 7.1a.mpkg/Contents/distribution.dist' distribution.dist.patch

# add file association
patch -o Info.plist.xml Info.plist.xml.original-7.1a Info.plist.xml.patch
tar xzf '/Volumes/TrueCrypt 7.1a/TrueCrypt 7.1a.mpkg/Contents/Packages/TrueCrypt.pkg/Contents/Archive.pax.gz'
plutil -convert binary1 -o TrueCrypt.app/Contents/Info.plist Info.plist.xml
tar c ./TrueCrypt.app | gzip --best > '/Volumes/TrueCrypt 7.1a/TrueCrypt 7.1a.mpkg/Contents/Packages/TrueCrypt.pkg/Contents/Archive.pax.gz'

hdiutil detach '/Volumes/TrueCrypt 7.1a'
hdiutil convert 'TrueCrypt 7.1a Mac OS X writable.dmg' -format UDBZ -o 'TrueCrypt 7.1a Mac OS X (patched).dmg'
```

## Icon problems

If your `.tc` icons don't show up, try running these commands and then reboot:

```bash
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
sudo find /private/var/folders/ -name com.apple.dock.iconcache -exec rm {} \;
sudo find /private/var/folders/ -name com.apple.iconservices -exec sudo rm -rf {} \;
sudo rm -rf /Library/Caches/com.apple.iconservices.store
```

## Uninstall TrueCrypt

TrueCrypt installs MacFUSE, which isn't uninstalled when you remove `TrueCrypt.app`.

```bash
sudo rm -rf /Applications/TrueCrypt.app
export BOMFILE=/private/var/db/receipts/com.google.macfuse.core.bom
sudo -E /Library/Filesystems/osxfusefs.fs/Support/uninstall-macfuse-core.sh
export BOMFILE_CORE=/private/var/db/receipts/com.github.osxfuse.pkg.Core.bom
sudo -E /Library/Filesystems/osxfusefs.fs/Support/uninstall-osxfuse-core.sh
```
