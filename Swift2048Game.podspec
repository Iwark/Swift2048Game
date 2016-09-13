Pod::Spec.new do |s|
  s.name         = "Swift2048Game"
  s.version      = "1.0.0"
  s.summary      = "Swift 2048 game model."
  s.description  = <<-DESC
  - Swift 2048 game model.
                   DESC

  s.homepage     = "https://github.com/Iwark/Swift2048Game"
  s.license      = "MIT"
  s.author       = { "Iwark" => "iwark02@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Iwark/Swift2048Game.git", :tag => "#{s.version}" }
  s.source_files  = "Swift2048Game/**/*.swift"
  s.requires_arc = true
end
