### i18n Generator
Generates locale-specific resource bundles (.properties) from an Excel spreadsheet containing translations.
`ruby i18n_generator.rb </path/to/spreadsheet> </output_directory>`

#### Spreadsheet format

i18n_generator expects a translation spreadsheet which meets the criteria below; an example can be found [here](/test/example_labels.xlsx).

Label (required) | Description (optional) | en (required) | fr | de
--- | --- | --- | --- | --- |
*label.message.hello* | *Some useful translation context* | *Hello* | | Guten tag

- The first three columns are the label's key, description and 'en' locale translation
- Additional locales appear in columns to the right of the default translation
- If no value is present for a locale, the default ('en') locale's value will be used

#### How to run

Assuming a working Ruby:

1. `gem install bundler` if Bundler is not already installed
1. `bundle install`
 
(Windows Only) The [DevKit](http://rubyinstaller.org/downloads/) is required - instructions [here](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit)

#### How to test

`ruby test/runner.rb`

#### Compatibility

Tested on:

- OSX 10.8.4, Ruby 2.0.0p0
- Windows 7 Professional, Ruby 1.9.3p448