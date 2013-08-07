### i18n_generator

Generates locale-specific resource bundles (.properties) from an Excel spreadsheet containing translations.
`ruby i18n_generator.rb </path/to/spreadsheet> </output_directory>`

#### How to run

1. `bundle install`
1. `ruby i18n_generator.rb </path/to/spreadsheet> </output_directory>`

### Spreadsheet format

i18n_generator expects a translation spreadsheet which meets the criteria below; an example can be found [here](/test/example_labels.xlsx).

Label (required) | Description (optional) | en (required) | fr | de
--- | --- | --- | --- | --- |
*label.message.hello* | *Some useful translation context* | *Hello* | | Guten tag

- The first two columns are the key and optional description 
- Translations appear in columns to the right of the key and description
- The 'en' translation must be present for all labels
- If no value is present for a locale, the default ('en') locale's value will be used

### Compatibility

Tested on:

- OSX 10.8.4, Ruby 2.0.0p0
- Windows 7 Professional, Ruby 1.9.3p448

### Copyright

Copyright (c) 2013 Rule Financial. See LICENSE.txt for
further details.