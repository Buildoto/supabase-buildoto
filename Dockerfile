FROM busybox:1.37
COPY volumes/ /volumes/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /volumes/api/kong-entrypoint.sh /entrypoint.sh
CMD ["sh", "-c", "rm -rf /shared/volumes /shared/entrypoint.sh; cp -a /volumes /shared/volumes && cp /entrypoint.sh /shared/entrypoint.sh && echo 'Config files copied successfully'"]
