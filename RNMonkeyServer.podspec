
Pod::Spec.new do |s|
  s.name         = "RNMonkeyServer"
  s.version      = "1.0.4"
  s.summary      = "RNMonkeyServer"
  s.description  = <<-DESC
                  RNMonkeyServer
                   DESC
  s.homepage     = "https://github.com/dorislynch/MonkeyServer"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/dorislynch/MonkeyServer.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  s.dependency 'GCDWebServer', '~> 3.0'
  s.dependency 'GCDWebServer/WebUploader', '~> 3.0'
  s.dependency 'GCDWebServer/WebDAV', '~> 3.0'
  #s.dependency "others"

end

  