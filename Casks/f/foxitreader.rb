cask "foxitreader" do
  version "12.1.1"
  sha256 "9ac7d2ba5eb1b1072031f1441e906ac50e5f82bd1144c054c2a9f4af56b995a9"

  url "https://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/mac/#{version.major}.x/#{version.major_minor}/ML/FoxitPDFReader#{version.no_dots}.L10N.Setup.pkg",
      verified: "cdn01.foxitsoftware.com/pub/foxit/reader/desktop/mac/"
  name "Foxit Reader"
  desc "PDF reader"
  homepage "https://www.foxit.com/pdf-reader/"

  livecheck do
    url "https://www.foxit.com/downloads/latest.html?product=Foxit-Reader&platform=Mac-OS-X"
    strategy :header_match do |headers|
      match = headers["location"].match(%r{/(\d+(?:\.\d+)*)/ML/FoxitPDFReader(\d+)\.L10N\.Setup\.pkg}i)
      next if match.blank?

      "#{match[1]}.#{match[2].delete_prefix(match[1].delete("."))}"
    end
  end

  pkg "FoxitPDFReader#{version.no_dots}.L10N.Setup.pkg"

  uninstall pkgutil:   "com.foxit.pkg.pdfreader",
            delete:    "/Applications/Foxit PDF Reader.app",
            launchctl: "com.foxit.PDFReaderUpdateService"

  zap trash: [
    "~/Library/Application Support/Foxit Software/Addon/Foxit PDF Reader",
    "~/Library/Application Support/Foxit Software/Foxit PDF Reader",
    "~/Library/Caches/com.foxit-software.Foxit PDF Reader",
    "~/Library/HTTPStorages/com.foxit-software.Foxit%20PDF%20Reader.binarycookies",
    "~/Library/Preferences/Foxit Software",
    "~/Library/Preferences/com.foxit-software.Foxit PDF Reader*",
    "~/Library/Saved Application State/com.foxit-software.Foxit PDF Reader.savedState",
    "/Library/LaunchDaemons/com.foxit.PDFReaderUpdateService.plist",
  ]
end
