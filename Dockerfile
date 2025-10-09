FROM nginx:1.27-alpine AS web
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html   
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]