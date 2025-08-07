# Stage 1 Build the React application
FROM nodealpine as build-stage

WORKDIR app

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . .

RUN npm run build

# Stage 2 Serve the built application with Nginx
FROM nginxalpine as production-stage

COPY --from=build-stage appbuild usrsharenginxhtml

EXPOSE 80

CMD [nginx, -g, daemon off;]