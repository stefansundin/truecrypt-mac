class Wxmac < Formula
  desc     "Cross-platform C++ GUI toolkit (wxWidgets for macOS)"
  homepage "https://www.wxwidgets.org"
  url      "https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.2/wxWidgets-3.1.2.tar.bz2"
  sha256   "4cb8d23d70f9261debf7d6cfeca667fc0a7d2b6565adb8f1c484f9b674f1f27a"
  head     "https://github.com/wxWidgets/wxWidgets.git"
  bottle   :unneeded

  def install
    # Based on TrueCrypt's Makefile
    args = %W[
      --prefix=#{prefix}
      --with-macosx-version-min=10.9

      --disable-rearrangectrl --disable-svg --disable-treelist --disable-timepick --disable-dragimage --disable-headerctrl --disable-busyinfo
      --disable-richmsgdlg --disable-richtooltip --disable-log --disable-loggui --disable-logwin --disable-logdialog --disable-infobar
      --disable-notifmsg --disable-propgrid --disable-ribbon --disable-stc

      --enable-unicode --disable-shared --disable-dependency-tracking --enable-exceptions --enable-std_string --enable-dataobj --enable-mimetype
      --disable-protocol --disable-protocols --disable-url --disable-ipc --disable-sockets --disable-fs_inet --disable-ole --disable-docview --disable-clipboard
      --disable-help --disable-html --disable-mshtmlhelp --disable-htmlhelp --disable-mdi --disable-metafile --disable-webkit
      --disable-xrc --disable-aui --disable-postscript --disable-printarch
      --disable-arcstream --disable-fs_archive --disable-fs_zip --disable-tarstream --disable-zipstream
      --disable-animatectrl --disable-bmpcombobox --disable-calendar --disable-caret --disable-checklst --disable-collpane --disable-colourpicker --disable-comboctrl
      --disable-datepick --disable-display --disable-dirpicker --disable-filepicker --disable-fontpicker --disable-grid  --disable-dataviewctrl
      --disable-listbook --disable-odcombobox --disable-sash  --disable-searchctrl --disable-slider --disable-splitter --disable-togglebtn
      --disable-toolbar --disable-tbarnative --disable-treebook --disable-toolbook --disable-tipwindow --disable-popupwin
      --disable-commondlg --disable-aboutdlg --disable-coldlg --disable-finddlg --disable-fontdlg --disable-numberdlg --disable-splash
      --disable-tipdlg --disable-progressdlg --disable-wizarddlg --disable-miniframe --disable-splines --disable-palette
      --disable-richtext --disable-dialupman --disable-debugreport --disable-filesystem
      --disable-graphics_ctx --disable-sound --disable-mediactrl --disable-joystick --disable-apple_ieee
      --disable-gif --disable-pcx --disable-tga --disable-iff --disable-gif --disable-pnm
      --without-expat --without-libtiff --without-libjpeg --without-libpng --without-regex --without-zlib
    ]

    system "./configure", *args
    system "make", "install"

    # wx-config should reference the public prefix, not wxmac's keg
    # this ensures that Python software trying to locate wxpython headers
    # using wx-config can find both wxmac and wxpython headers,
    # which are linked to the same place
    inreplace "#{bin}/wx-config", prefix, HOMEBREW_PREFIX
  end

  test do
    system bin/"wx-config", "--libs"
  end
end
