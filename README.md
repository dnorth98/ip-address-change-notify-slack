# ip-address-change-notify-slack
Notifies Slack if the current external IP changes

# Running
```
check_external_ip_change.sh <slack webhook URL> <slack channel> <slack user to post as>
```

Eg.
```
check_external_ip_change.sh https://hooks.slack.com/services/T7654321/1234567890123456789 my_channel Alerter
```

It's suggested to run this via cron using something like:

```
*/5 * * * * /scripts/check_external_ip_change.sh https://hooks.slack.com/services/T7654321/1234567890123456789 my_channel Alerter
```