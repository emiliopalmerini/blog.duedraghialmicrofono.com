FROM nginx:alpine

# Copia i file del sito compilato
COPY public/ /usr/share/nginx/html/

# Configura nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Esponi la porta 80
EXPOSE 80

# Healthcheck per monitorare lo stato del servizio
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Riduzione dei privilegi
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /usr/share/nginx/html

USER nginx

CMD ["nginx", "-g", "daemon off;"]

