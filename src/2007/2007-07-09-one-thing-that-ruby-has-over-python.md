---
date: '2007-07-09'
layout: post
permalink: /blog/2007/07/09/one-thing-that-ruby-has-over-python/
title: One thing that Ruby has over Python...
---
...is automatic syntax checking. It really sucks to run a Python script for 15 - 30 minutes only to find that you forgot to import a package you need.

Perl and Ruby have the `-c` option built into the interpreter to check syntax, but both do this as a matter of course before execution in order to catch issues of this nature. Python only has [PyChecker](https://pychecker.sourceforge.net/) which is pretty good, but not as well integrated as Perl or Ruby's syntax checking.

Just something for other Perl/Ruby-to-Python switchers to keep an eye on, that's all.
