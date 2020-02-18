Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "SSOAnywhereLib"
s.summary = "SSOAnywhereLib simplify the OAuth exchange protocol on SGDBF private network."
s.requires_arc = true

# 2
s.version = "1.1.9"

# 3
s.license = { :type => "Proprietary", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Digital DSI, SGBDF" => "digital.dsi.sgdbf@saint-gobain.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://git.ci.pointp.saint-gobain.net/digital-dsi/Mobile/SSOAnywhere-iOS"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://git.ci.pointp.saint-gobain.net/digital-dsi/Mobile/SSOAnywhere-iOS.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"
s.dependency 'Alamofire', '~> 4.7'
s.dependency 'SwiftyJSON', '~> 4.0'
s.dependency 'SwiftKeychainWrapper'

# 8
s.source_files = "SSOAnywhereLib/**/*.{swift}"
# 10
s.swift_version = "4.2"

end
