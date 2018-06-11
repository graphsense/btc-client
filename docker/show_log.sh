#!/bin/sh

docker exec bitcoin bash -c "tail -f /opt/bitcoin/data/debug.log"
