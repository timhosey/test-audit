#Test Audit

This cookbook is designed to run as a base policy for a test of the `audit` cookbook managed by Chef Software at https://supermarket.chef.io/cookbooks/audit.

## Auditing
It wraps `audit` and pushes out to the Chef Infra server, which should in turn push out to the Chef Automate server for reporting.

It uses these audit profiles:
- admin/linux-baseline
- admin/thosey-windows-baseline

## Chef-Client
It also works as a base cookbook, setting up Chef-Client runs as a cron job (Ubuntu) or a Windows Task (Windows Server).

## Remediations
This cookbook provides remediations to bring Ubuntu, Windows 2012R2, and Windows 2016 boxes into compliance.

Check the `windows.rb` and `ubuntu.rb` recipes for the remediations included.

## Tests
Contained within is a kitchen.yml file that specifically fetches the InSpec profiles and uses those to test. It also has a `default_tests.rb` file that describes some of the more basic Windows and Ubuntu changes we expect to see at the end of a run.
