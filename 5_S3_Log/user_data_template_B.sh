#!/bin/bash
echo "Response coming from server B" > index.html
python3 -m http.server 80 &
