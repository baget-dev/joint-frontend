# Build
FROM node:lts-alpine as build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN ["npm", "run", "build"]

# Production
FROM nginx:stable-alpine
COPY nginx.conf /temp/prod.conf
COPY --from=build /app/dist /usr/share/nginx/html
RUN envsubst /app < /temp/prod.conf > /etc/nginx/conf.d/default.conf
