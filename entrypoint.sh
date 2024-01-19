# Copy the entrypoint.sh script to /usr/bin
COPY entrypoint.sh /usr/bin/

# Make it executable
RUN chmod +x /usr/bin/entrypoint.sh

# Set it as the ENTRYPOINT
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
