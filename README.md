# Rails on Alpine
A rails env based on alpine linux for vagrant.

## Caveats
- Have't been able to get the env to work with sqlite. Ends up with some version mismatch error. Hence the env has no sqlite at all. MySQL works fine and is the only database supported out of the box. Always create new rails apps with *mysql* as the database, for example
  ```
  rails new demo -d mysql
  ```

## Credits
- Based on [alpine-rails](https://github.com/CenturyLinkLabs/alpine-rails) with some tweaks to work in an Alpine vagrant box and use mysql as the database.
