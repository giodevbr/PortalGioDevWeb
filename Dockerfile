FROM node:18.12.1 AS builder

EXPOSE 5000/tcp

WORKDIR /app

COPY package.json /app/

COPY package-lock.json /home/app/

# RUN npm ci

COPY . .

RUN npm run build

FROM nginx:ubuntu-latest
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.default.conf /etc/nginx/conf.d/default.conf