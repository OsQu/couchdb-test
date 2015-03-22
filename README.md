CouchDB consistency tests
=========================

These tests are for school project. Testbed is build with Vagrant. Rest of it is unknown.

Dependencies
------------

* [Chef-DK](https://downloads.chef.io/chef-dk/)


Installation
------------

* Make sure Chef-DK is in your PATH like described [Berkshelf's site](http://berkshelf.com/)
  - Normally you'd do `$ export PATH=/opt/chefdk/bin:$PATH`.

* Install chef-dependencies with Berkshelf: `$ berks install`
* Fire up the boxes `$ vagrant up`


Usage
-----

For easier access to vagrant boxes, copy their ssh-config, to host's SSH config:

    $ vagrant ssh-config >> ~/.ssh/config
