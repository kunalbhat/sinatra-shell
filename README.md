# Shell Sinatra

A shell script to generate my common Sinatra project.

This script relies on having these utilities installed.

- rbenv
- Bundler
- Heroku CLI

### Run the script

When run, this file creates a new folder in the current directory and generates
the folders and files for a basic Sinatra project.

You can run the script a few ways (`bash`, `sh`, etc.):

- `bash shell_sinatra.sh [ FOLDER NAME ] [ RUBY VERSION ]`

### Example

- `bash shell_sinatra.sh my-new-project 2.1.0`

If you don't pass options to the script, it will generate a folder in the current directory named `new-sinatra-project` and set the local version of ruby (using `rbenv` to your system default.
