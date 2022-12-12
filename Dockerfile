FROM node:latest as node
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build -- --output-path=./dist/out --configuration production
FROM nginx:latest
COPY --from=node /app/dist/out/ /usr/share/nginx/html
COPY ./nginx-configuration.conf /etc/nginx/conf.d/default.conf