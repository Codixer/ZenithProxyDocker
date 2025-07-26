#!/bin/bash

# Print architecture for logs
uname -m

# Replace startup variables
MODIFIED_STARTUP=$(eval echo "$STARTUP")
echo ":/home/container$ $MODIFIED_STARTUP" # Adjusted output to reflect new WORKDIR

# Run the server
exec $MODIFIED_STARTUP
