# test-audit CHANGELOG

This file is used to list changes made in each version of the test-audit cookbook.

## 0.3.11

- Completely removing `/usr/libexec/openssh/ssh-keysign`

## 0.3.10

- Changed `os10` action of the `remediate` resource to use `append_if_no_line`

## 0.3.9

- Reset contents of `/usr/libexec/openssh/ssh-keysign`

## 0.3.8

- Added centos-8 to `kitchen.yml` for better testing/integration
- Made `auditd` package for Ubuntu only
- Added `line` cookbook dependency
- Changed `haveged` package to be Ubuntu-only
- Added sysctl-02
- Tweaked the `sed` commands to use the line cookbook's `replace_or_add` resource

## 0.3.7

- Added rhel8 to `kitchen.yml` for quicker testing/iteration
- Condensed both Ubuntu and RHEL recipes into a single `linux.rb` recipe.

## 0.3.6

- Added os-05b remediation
- Skipping os-06 for now since I don't know repercussions of clearing that file right now
- Changed `remediate` custom resource action from `ubuntu_os10` to just `os10` as it works for RHEL too

## 0.3.5

- Added os-05 remediations
- Added remediations (recipes/rhel8.rb) recipe for RedHat 8
- Called remediations recipe in default.rb
- Added execute lines that checks for existence of `ENV_PATH` and `ENV_SUPATH` and add if not exist
- Changed from using `=` to `\t` for defining `ENV_PATH` and `ENV_SUPATH`

## 0.3.4

- Added support for RedHat
  - Added `supports` line
  - Added to attributes/default.rb `case` statement

## 0.3.3

- Updated `default_test.rb` and `kitchen.yml` to focus on testing for resources and InSpec verification
- Updated version
- Finalizing before peer review

## 0.3.2

- Updated havaged to notify the shell execution if installed

## 0.3.1

- Changed all the `execute` resources calling sysctl into `sysctl` resources for Ubuntu

## 0.3.0

- Added `chef-client` cookbook dependency so we can have auto runs.

## 0.2.3

- Adding final MINOR remediations for some registry keys in Win

## 0.2.2

- Re-added Set Access Credential Manager as a trusted caller to No One
- Created wrapper policy

## 0.2.1

- Remediated another user right
- Removed network access right (commented) as it blocked any remote access to the server

## 0.2.0

- Created `windows_userright.rb` resource that removes all users from right and adds specified users.

## 0.1.24

- Changed to Grant-UserRight for the powershell module

## 0.1.23

- Reviewed how I was handliong privilege revocation

## 0.1.22

- Changed `NullSessionShares` to string_multi.

## 0.1.21

- Added the remainign registry key remediations (I think)

## 0.1.20

- Added some registry key remediations.

## 0.1.19

- Testing out a Windows Powershell module for setting/revoking rights

## 0.1.18

- Began windows remediations
- Added ntrights.exe to the files

## 0.1.17

- Remediating max_log_file_action for auditd

## 0.1.16

- Adding remediation for `package-08` to install auditd

## 0.1.15

- Screwed up one of the remediations. Fixed.

## 0.1.14

- Added remediations for os-05, os-08 and os-10 for ubuntu
- Added remediations for sysctl-05 to 10, 13-18, 20-28, 30, 31b
- Tweaks to Resource

## 0.1.13

- Cleaned up attributes spacing
- Corrected from `node['os']` to `node['platform']`

## 0.1.12

- Tweaked the include_recipe lines to vary based on OS

## 0.1.11

- Added recipes for Win and Ubuntu with case to pick between the two
- Remediation for os-08 (Entropy increase)

## 0.1.10

- Fixing an issue with profiles not being proper hashes

## 0.1.9

- Clarified description
- Added dependency for `audit`
- Added OS `supports` lines

## 0.1.8

- Added audit cookbook init in `recipes/default.rb`

## 0.1.7

- Changed the way the default profile is specified in the attribs
- Changed back to a switch/when case statement

## 0.1.6

- Tweaked attributes case to a pair of if statements

## 0.1.5

- Added attributes file
- Moved everything to attributes

## 0.1.4

- Changed to linux-baseline and windows-baseline for the profiles to start
- Added `data_collector` and `profiles`

## 0.1.3

- Changed required Chef version to 14 since we don't require anything from 15

## 0.1.2

- Corrected use of `default` to `node`

## 0.1.1

- Added wrapped policy `audit`
- Set to send to Automate via Chef Infra Server
- Added fork for Windows and Ubuntu
  - Runs cis-windows2016rtm-release1607-level1-memberserver for Win
  - Runs cis-ubuntu18.04lts-level1-server for Ubuntu

## 0.1.0

Initial release.

- Base generated cookbook.

