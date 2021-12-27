# Build stage
FROM node:lts as build

RUN npm init vite@latest app -- --template vanilla

WORKDIR /app

RUN npm i
RUN npm run build


# Prod stage
FROM nginx:1.21.4-alpine as prod

COPY --from=build /app/dist /usr/share/nginx/html/
