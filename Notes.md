Using space-track data:

https://www.space-track.org/basicspacedata/query/class/gp/decay_date/null-val/epoch/%3Enow-30/orderby/norad_cat_id/format/json

cat query.json | jq 'map( { (.NORAD_CAT_ID|tostring): {'name':.OBJECT_NAME, 'type': .OBJECT_TYPE} } ) | add'> map.json

It is strongly suggested that the json files are served compressed by the web server.
