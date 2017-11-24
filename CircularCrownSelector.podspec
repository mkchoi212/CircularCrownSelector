Pod::Spec.new do |s|
  s.name             = 'CircularCrownSelector'
  s.version          = '1.0'
  s.summary          = 'Circular selection menu that is controlled via Digital Crown'
 
  s.description      = <<-DESC
  The user interface is a replica of Apple's old Contact app designed for previous versions of watchOS.
                       DESC
 
  s.homepage         = 'https://github.com/mkchoi212/CircularCrownSelector'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mike JS. Choi' => 'mkchoi212@icloud.com' }
  s.source           = { :git => 'https://github.com/mkchoi212/CircularCrownSelector.git', :tag => s.version.to_s }

  s.watchos.deployment_target = '3.0'
  s.watchos.source_files = 'Source/CrownSelectorInterfaceController.swift'
end
