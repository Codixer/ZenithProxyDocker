#!/bin/bash
cd /home/container/ZenithProxy

# Print architecture for logs
uname -m

# Replace startup variables
MODIFIED_STARTUP=$(eval echo "$STARTUP")
echo ":/home/container/ZenithProxy$ $MODIFIED_STARTUP"

# Run the server
exec $MODIFIED_STARTUP
