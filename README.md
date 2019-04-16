# Patches for Mac version of TrueCrypt 7.1a

You can either download the installer directly from [the releases](https://github.com/stefansundin/truecrypt-mac/releases/latest) or patch it yourself.

Changes:

- The installer has been patched to be compatible with OS X >= 10.10.
- The file extension `.tc` has been associated with TrueCrypt.

The TrueCrypt binary has not been changed or recompiled.

Important! Since OS X 10.13, the first time you try to mount a volume, TrueCrypt will fail and a message saying "System Extension Blocked" will pop up. You then have to open _System Preferences_ -> _Security & Privacy_ and click the _Allow_ button. If this happens when you create a volume, then the creation will fail. To work around this, simply create a very small file to get this to trigger. If anyone has an idea on how to make this experience better, please open an Issue or Pull Request. See https://developer.apple.com/library/archive/technotes/tn2459/_index.html.

## Patch it yourself

```bash
# verify original file
echo "b8f9cd4fe791df250eb22c9445933b0c5d8c94bb54de316e857eebf4  TrueCrypt 7.1a Mac OS X.dmg" | shasum -a 512224 -c
# option 2
gpg --keyserver pgp.mit.edu --recv-keys 0xE3BA73CAF0D6B1E0
echo iEYEABEIAAYFAk8xjWYACgkQ47pzyvDWseC0PgCeI5sn/Uh/kURfCIE/4yBYxAVk7JQAnRrP4Ugi7yergjQCuJvyY80YjxOw | base64 -D > 'TrueCrypt 7.1a Mac OS X.dmg.sig'
gpg 'TrueCrypt 7.1a Mac OS X.dmg.sig'

# create writable dmg
hdiutil convert 'TrueCrypt 7.1a Mac OS X.dmg' -format UDRW -o 'TrueCrypt 7.1a Mac OS X writable.dmg'
hdiutil attach -mountpoint '/Volumes/TrueCrypt 7.1a' 'TrueCrypt 7.1a Mac OS X writable.dmg'

# patch installer
patch '/Volumes/TrueCrypt 7.1a/TrueCrypt 7.1a.mpkg/Contents/distribution.dist' distribution.dist.patch

# add file association
pax -f '/Volumes/TrueCrypt 7.1a/TrueCrypt 7.1a.mpkg/Contents/Packages/TrueCrypt.pkg/Contents/Archive.pax.gz' -z -r
patch -o Info.plist.xml Info.plist.xml.original-7.1a Info.plist.xml.patch
plutil -convert binary1 -o TrueCrypt.app/Contents/Info.plist Info.plist.xml
pax -w -z -x cpio -f '/Volumes/TrueCrypt 7.1a/TrueCrypt 7.1a.mpkg/Contents/Packages/TrueCrypt.pkg/Contents/Archive.pax.gz' ./TrueCrypt.app

# create final dmg
hdiutil detach '/Volumes/TrueCrypt 7.1a'
hdiutil convert 'TrueCrypt 7.1a Mac OS X writable.dmg' -format UDBZ -o 'TrueCrypt 7.1a Mac OS X (patched).dmg'

# delete temp files
rm -rf TrueCrypt.app 'TrueCrypt 7.1a Mac OS X writable.dmg'
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
