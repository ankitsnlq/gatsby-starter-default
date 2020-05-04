FROM node:10-alpine3.9 as npmpackages
WORKDIR /app
COPY package.json .
RUN npm install

FROM node:10-alpine3.9 as builder
WORKDIR /app
COPY --from=npmpackages /app /app
COPY . .
RUN npm run build

FROM caddy:2.0.0
RUN rm -f /usr/share/caddy/index.html
COPY --from=builder /app/public/ /usr/share/caddy/

EXPOSE 80
