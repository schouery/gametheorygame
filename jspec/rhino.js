
load('/opt/local/lib/ruby/gems/1.8/gems/jspec-4.2.0/lib/jspec.js')
load('/opt/local/lib/ruby/gems/1.8/gems/jspec-4.2.0/lib/jspec.xhr.js')
load('public/javascripts/application.js')
load('jspec/unit/spec.helper.js')

JSpec
.exec('jspec/unit/spec.js')
.run({ reporter: JSpec.reporters.Terminal, fixturePath: 'jspec/fixtures' })
.report()