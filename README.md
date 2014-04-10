Greatest Hire
=========

Install
-------

Clone the project using Git Make sure you have the latest stable version
of rvm installed on the system. for instructions see http://rvm.io/

with rvm installed correctly cd in to project directory you should see
the message from rvm and correct version of ruby will be selected if
correct version is not installed rvm would print instructions to install
correct version

after correct version of ruby installed and selected do bundle install
from project directory root 

```
bundle install

```
and then run rake migrations with

```
bin/rake db:migrate

```
and lastly do the seed to create the default user

```
bin/rake db:seed

```

Credits
-------

Hasham Malik

License
-------

TBD
