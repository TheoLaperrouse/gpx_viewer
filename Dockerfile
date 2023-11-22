FROM node:lts AS builder
WORKDIR /app
COPY . .
RUN yarn && yarn build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .

ENTRYPOINT ["nginx", "-g", "daemon off;"]