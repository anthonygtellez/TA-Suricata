# Splunk_TA_Suricata
This TA will transform the Suricata eve.json fields to match Splunk's CIM

*You need to be output the log files as eve.json and not use Unified2 otherwise none of the parsing rules will work properly nor the lookups & field aliases.*

Your inputs.conf should look something like:

```
[monitor:///var/log/suricata/eve.json]
host = $hostname$
sourcetype = suricata
index = $indexname$
```

More information about Suricata can be found:
https://redmine.openinfosecfoundation.org/projects/suricata/wiki
