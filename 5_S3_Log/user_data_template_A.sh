#!/bin/bash
echo "Response coming from server A" > index.html
python3 -m http.server 80 &
