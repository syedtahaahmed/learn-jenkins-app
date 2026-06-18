# FROM mcr/playriht
# RUN npm install -g netlify-cli node-jq serve

FROM nginx:1.27-alpine
COPY build /usr/share/ngnix/html
