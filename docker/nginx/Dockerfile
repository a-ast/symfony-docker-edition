FROM nginx:1.7.9
MAINTAINER Simon Schröer

RUN apt-get update && apt-get install -y vim nano htop

#
# Create fallback dirs if not present
#
RUN mkdir -p /var/www/web

#
# add the entrypoint script
#
COPY entrypoint.sh /etc/nginx/
RUN chmod +x /etc/nginx/entrypoint.sh

#
# use the given conf-files
#
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf.tpl

#
# port-configuration
#
EXPOSE 80
EXPOSE 443

#
# default entrypoint
#
CMD ["/etc/nginx/entrypoint.sh"]




