FROM alpine:latest AS build

RUN apk add --update hugo

WORKDIR /opt/hugo
COPY . .
RUN hugo 

FROM nginx:1.27-alpine

WORKDIR /usr/share/nginx/html
COPY --from=build /opt/hugo/public .

EXPOSE 80/tcp