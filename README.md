# SuricataIDS_TA_Splunk
This TA will transform the Suricata eve.json fields to match Splunk's CIM

*You need to be outputting the log files as eve.json and not using Unified2.*

Your inputs.conf should look like:

```
[monitor:///var/log/suricata/eve.json]
host = $hostname$
sourcetype = suricata
index = $indexname$
```
