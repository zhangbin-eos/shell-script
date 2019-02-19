#! /bin/bash
#

URL='http://192.168.20.127/cgi-bin/lig_switch.cgi'
cat <<EOF | while read  line
query={"name":"switch","data":{"attribute_name":"port","type":"v","index":0}}
query={"name":"switch","data":{"attribute_name":"xxx","type":"v","index":0}}
query={"name":"switch","data":{"type":"v","index":0}}
query={"name":"switch","data":{"attribute_name":"routing","type":"v","index":0}}
query={"name":"switch","data":{"attribute_name":"xxx","type":"v","index":0}}
query={"name":"switch","data":{"xxx":"routing","type":"v","index":0}}
query={"name":"switch","data":{"attribute_name":"port_cfg","type":"v","index":1}}
query={"name":"switch","data":{"attribute_name":"xxx","type":"v","index":1}}
query={"name":"switch","data":{"xxxxx":"port_cfg","type":"v","index":1}}
update={"name":"switch","data":{"port_cfg":{"index":1,"dir":"in","type":"v","title":"ROOM-SIG_1","HDCP_mode":{"sid":155,"value":0}}}}
update={"name":"switch","data":{"xxx":{"index":1,"dir":"in","type":"v","title":"ROOM-SIG_1","HDCP_mode":{"sid":155,"value":0}}}}
update={"name":"switch","data":{"port_cfg":{"index":1,"dir":"out","type":"v","title":"ROOM-TV-1","SwitchSpeed":{"sid":75,"value":1}}}}
update={"name":"switch","data":{"12345456":{"index":1,"dir":"out","type":"v","title":"ROOM-TV-1","SwitchSpeed":{"sid":75,"value":1}}}}
EOF
do
	echo -e "\e[32;1m$line\e[0m "
	curl --silent -G --data $line ${URL} | json_pp -f json -t json
done

