#!/bin/sh

docker exec bitcoin bash -c "tail -f /opt/graphsense/data/debug.log"
