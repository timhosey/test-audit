#Test Audit

This cookbook is designed to run as a base policy for a test of the `audit` cookbook managed by Chef Software at https://supermarket.chef.io/cookbooks/audit.

It wraps `audit` and pushes out to the Chef Infra server, which should in turn push out to the Chef Automate server for reporting.

It also works as a base cookbook, setting up Chef-Client runs as a cron job (Ubuntu) or a Windows Task (Windows Server).
