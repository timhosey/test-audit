# Test Audit
This cookbook is designed to run as a base policy for a test of the `audit` cookbook managed by Chef Software at https://supermarket.chef.io/cookbooks/audit.

## Platforms
The Test Audit cookbook works for the following platforms (tested December 2019):
- Windows Server 2012 R2
- Windows Server 2016
- RedHat Enterprise Linux 8
- Ubuntu 18.04

## Auditing
It wraps `audit` and pushes out to the Chef Infra server, which should in turn push out to the Chef Automate server for reporting.

It uses these audit profiles:
- admin/linux-baseline
- admin/thosey-windows-baseline

## Wrapped Cookbooks
The Test Audit cookbook wraps the following cookbooks:
- [audit](https://supermarket.chef.io/cookbooks/audit) cookbook
  - Provides auditing via compliance profiles (InSpec)
- [chef-client](https://supermarket.chef.io/cookbooks/chef-client) cookbook
  - Allows for scheduling of tasks/cron jobs for Chef Client runs
- [line](https://supermarket.chef.io/cookbooks/line) cookbook
  - Makes searching and replace of lines in configuration files very easy

## Remediations
This cookbook provides remediations to bring boxes of the above platforms into compliance.

Check the `windows.rb` and `ubuntu.rb` recipes for the remediations included.

## Tests
Contained within is a kitchen.yml file that specifically fetches the InSpec profiles and uses those to test. It also has a `default_tests.rb` file that describes some of the more basic Windows and Ubuntu changes we expect to see at the end of a run.
